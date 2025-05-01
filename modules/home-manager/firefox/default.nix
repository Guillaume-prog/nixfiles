{pkgs, lib, ...}: 
let
  defaultSearchEngine = "DuckDuckGo";
in
{

  programs.firefox = {
    enable = true;
    profiles.guillaume = {

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        simple-tab-groups
        auto-tab-discard
        
        bitwarden
        darkreader
        languagetool

        ublock-origin
        sponsorblock
        cookie-autodelete
        i-dont-care-about-cookies
        
        youtube-shorts-block
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;

        # bookmarks management
        "browser.bookmarks.file" = ./bookmarks.html;
        "browser.places.importBookmarksHTML" = true;
        "browser.bookmarks.addedImportButton" = false;

        # homepage
        "browser.search.defaultenginename" = defaultSearchEngine;
        "browser.search.order.1" = defaultSearchEngine;

        "browser.startup.homepage" = "https://start.duckduckgo.com";

        # newtab config
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # stop forcing default browser
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;

        # privacy & security settings
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;

        # topbar customisation
        "browser.uiCustomization.state" = lib.importJSON ./firefox-ui.json;

        # Auto allow extensions i think ???
        "extensions.InstallTriggerImpl.enabled" = true;
      };

      search = {
            force = true;
            default = defaultSearchEngine;
            order = [ defaultSearchEngine "Nix Packages" "Nix Options" "NixOS Wiki" ];
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };

              "Nix Options" = {
                urls = [{
                  template = "https://search.nixos.org/options";
                  params = [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
              };

              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };

              "Google".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
              "Wikipedia (en)".metaData.hidden = true;
            };
          };

    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}