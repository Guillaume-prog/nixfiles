parse_dconf () {
    # reads dconf list, removes commas, and replaces single quotes with doubles (nix format)
    dconf read $1 | sed "s/'/\"/g" | sed "s/, / /g"
}






# Update favorite apps
# =============================================================================

favorite_apps=$(parse_dconf /org/gnome/shell/favorite-apps)





# Update app-tray
# =============================================================================

app_tray=$(parse_dconf /org/gnome/shell/app-picker-layout |
    sed "s/: <[^}]*}>//g"   | # Removes everything between ': <' and '}>', which removes the contents of dictionary-like values, keeping only the keys.
    sed "s/{/[/g"           | # Replaces opening curly braces '{' with square brackets '[', converting dictionaries into Nix list format.
    sed "s/}/]/g")          # Replaces closing curly braces '}' with square brackets ']', to complete the Nix list format.





# Update folders
# =============================================================================

app_folders=$(parse_dconf /org/gnome/desktop/app-folders/folder-children)

# Define a regular expression for different types of newlines (CRLF, CR, LF)
nl="(\r\n|\r|\n)"

# Set the base path for the folder settings in the GNOME dconf
folder_root="org/gnome/desktop/app-folders/folders"

# Dump the current dconf settings for the specified folder root and format the output
folders=$(dconf dump /$folder_root/           |
    echo -e "$(cat)\n"              | # Append an extra newline to ensure proper parsing of the last entry
    sed "s|'|\"|g"                  | # Replace all single quotes with double quotes for valid JSON-like formatting
    sed "s|, | |g"                  | # Remove commas followed by a space (convert lists into space-separated items)
    sed -E "s|(^[a-z])|\t\1|g"      | # Add a tab before any line starting with a lowercase letter (for indentation)
    sed -E "s|(\t[^$nl]+)|\1;|g"    | # Add a semicolon at the end of any indented line (inserting after key-value pairs)
    sed -E "s|^\[([^]]+)]$|\"$folder_root/\1\" = {|g" | # Convert section headers [section] into the format: "folder_root/section" = {
    sed "s|^$|};\n|g"               | # Replace empty lines with closing braces and a newline (closing blocks)
    sed "s|^|\t|g"                  | # Add a tab at the beginning of every line for indentation
    echo -e "{\n\n$(cat)\n}")         # Wrap the entire output in opening and closing braces, adding a new line for structure





# Push to file
# =============================================================================

text=$(cat << BLOCK
{

favorite-apps = $favorite_apps;
app-folders = $app_folders;
app-tray = $app_tray;

folders = $folders;

}
BLOCK
) 
echo "$text" > $(dirname "$0")/settings.nix