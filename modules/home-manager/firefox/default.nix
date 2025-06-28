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
        # "browser.download.useDownloadDir" = false;

        # bookmarks management
        "browser.bookmarks.file" = ./bookmarks.html;
        "browser.places.importBookmarksHTML" = true;
        "browser.bookmarks.addedImportButton" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.places.importDefaults" = false;

        # homepage
        "browser.search.defaultenginename" = defaultSearchEngine;
        "browser.search.order.1" = defaultSearchEngine;

        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.startup.page" = 3; # show previous tabs
        "browser.sessionstore.resume_session_once" = false;
        "browser.sessionstore.resume_from_crash" = true;

        # newtab config
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # stop forcing default browser
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;

        # topbar customisation
        "browser.uiCustomization.state" = lib.importJSON ./firefox-ui.json;

        # Auto allow extensions
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15; # Enable all install locations (0b1111)

        # Force dark mode
        "ui.systemUsesDarkTheme" = 1;
        # "layout.css.prefers-color-scheme.content-override" = 2;

        # privacy & security settings
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "signon.rememberSignons" = false;

        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;

        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.cookie.cookieBehavior" = 1; # block third-party (or use 5 for Total Cookie Protection)
        "privacy.firstparty.isolate" = true;
        "privacy.resistFingerprinting" = true;
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