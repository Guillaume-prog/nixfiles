{pkgs, lib, inputs, ...}: 
let
  ff-addons = inputs.firefox-addons.packages.${pkgs.system};
in
{

  programs.firefox = {
    enable = true;
    profiles.guillaume = {

      extensions = with ff-addons; [
        simple-tab-groups
        # languagetool
        
        bitwarden

        ublock-origin
        i-dont-care-about-cookies
        youtube-shorts-block
        # cookie-autodelete
      ];
      
      bookmarks = {};

      settings = {
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;

        # bookmarks management
        "browser.bookmarks.file" = ./bookmarks.html;
        "browser.places.importBookmarksHTML" = true;
        "browser.bookmarks.addedImportButton" = false;

        # homepage
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