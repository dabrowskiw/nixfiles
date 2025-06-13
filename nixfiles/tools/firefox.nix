{ pkgs-unstable, lib, specialArgs, firefox-add, ... }:

let

  extensions = { 
    packages = with firefox-add; [
      darkreader
      i-dont-care-about-cookies
      link-cleaner
      privacy-badger
      ublacklist
      ublock-origin
      unpaywall
      keepassxc-browser
      tridactyl
    ];
  };

  # disable the annoying floating icon with camera and mic when on a call
  disableWebRtcIndicator = ''
    #webrtcIndicator {
      display: none;
    }
  '';

  userChrome = disableWebRtcIndicator;

  # ~/.mozilla/firefox/PROFILE_NAME/prefs.js | user.js
  settings = {
    # Disable translation
    "browser.translations.automaticallyPopup" = false;
    "browser.translations.panelShown" = false;

    # Disable everything pocket-related
    "browser.newtabpage.activity-stream.discoverystream.saveToPocketCard.enabled" = false;
    "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
    "browser.urlbar.suggest.pocket" = false;
    "extensions.pocket.enabled" = false;
    "extensions.pocket.showHome" = false;
    "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" = false;

    # Disable password manager in Firefox
    "services.sync.prefs.sync.signon.autofillForms" = false;
    "services.sync.prefs.sync.signon.generation.enabled" = false;
    "services.sync.prefs.sync.signon.rememberSignons" = false;
    "services.sync.prefs.sync.signon.management.page.breach-alerts.enabled" = false;
    "signon.autofillForms" = false;
    "signon.backup.enabled" = false;
    "signon.rememberSignons" = false;
    "signon.signupDetection.enabled" = false;

    "app.normandy.first_run" = false;
    "app.shield.optoutstudies.enabled" = false;

    # disable updates (pretty pointless with nix)
    "app.update.channel" = "default";

    "browser.contentblocking.category" = "standard"; # "strict"
    "browser.ctrlTab.recentlyUsedOrder" = false;

    "browser.download.useDownloadDir" = false;
    "browser.download.viewableInternally.typeWasRegistered.svg" = true;
    "browser.download.viewableInternally.typeWasRegistered.webp" = true;
    "browser.download.viewableInternally.typeWasRegistered.xml" = true;

    "browser.link.open_newwindow" = true;

    "browser.search.region" = "PL";
    "browser.search.widget.inNavBar" = true;

    "browser.shell.checkDefaultBrowser" = false;
    "browser.startup.homepage" = "https://nixos.org";
    "browser.tabs.loadInBackground" = true;
    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.showSearchSuggestionsFirst" = false;

    # disable all the annoying quick actions
    "browser.urlbar.quickactions.enabled" = false;
    "browser.urlbar.quickactions.showPrefs" = false;
    "browser.urlbar.shortcuts.quickactions" = false;
    "browser.urlbar.suggest.quickactions" = false;

    "distribution.searchplugins.defaultLocale" = "en-US";

    "doh-rollout.balrog-migration-done" = true;
    "doh-rollout.doneFirstRun" = true;

    "dom.forms.autocomplete.formautofill" = false;

    "general.autoScroll" = true;
    "general.useragent.locale" = "en-US";

    "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";

    "extensions.extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";
    "extensions.update.enabled" = false;
    "extensions.webcompat.enable_picture_in_picture_overrides" = true;
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "extensions.webcompat.perform_ua_overrides" = true;

    "print.print_footerleft" = "";
    "print.print_footerright" = "";
    "print.print_headerleft" = "";
    "print.print_headerright" = "";

    "privacy.donottrackheader.enabled" = true;

    # Yubikey
    "security.webauth.u2f" = true;
    "security.webauth.webauthn" = true;
    "security.webauth.webauthn_enable_softtoken" = true;
    "security.webauth.webauthn_enable_usbtoken" = true;

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    # disable Studies
    # disable Normandy/Shield [FF60+]
    # Shield is a telemetry system that can push and test "recipes"
    "app.normandy.api_url" = "";
    "app.normandy.enabled" = false;

    "browser.aboutConfig.showWarning" = false;

    # personalized Extension Recommendations in about:addons and AMO [FF65+]
    # https://support.mozilla.org/kb/personalized-extension-recommendations 
    "browser.discovery.enabled" = false;
    "browser.helperApps.deleteTempFileOnExit" = true;

    "browser.newtabpage.activity-stream.default.sites" = "";
    "browser.newtabpage.activity-stream.feeds.topsites" = false;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.uitour.enabled" = false;

    # use Mozilla geolocation service instead of Google.
    #"geo.provider.network.url"= "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
    # disable using the OS's geolocation service
    "geo.provider.use_gpsd" = false;
    "geo.provider.use_geoclue" = false;

    # HIDDEN PREF: disable recommendation pane in about:addons (uses Google Analytics)
    "extensions.getAddons.showPane" = false;
    # recommendations in about:addons' Extensions and Themes panes [FF68+]
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    # disable Network Connectivity checks
    # [1] https://bugzilla.mozilla.org/1460537
    "network.connectivity-service.enabled" = false;

    # integrated calculator
    "browser.urlbar.suggest.calculator" = true;

    # TELEMETRY

    # disable new data submission
    "datareporting.policy.dataSubmissionEnabled" = false;
    # disable Health Reports
    "datareporting.healthreport.uploadEnabled" = false;
    # 0332: disable telemetry
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.server" = "data:,";
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.updatePing.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    # disable Telemetry Coverage
    "toolkit.telemetry.coverage.opt-out" = true; # [HIDDEN PREF]
    "toolkit.coverage.opt-out" = true; # [FF64+] [HIDDEN PREF]
    "toolkit.coverage.endpoint.base" = "";
    # disable PingCentre telemetry (used in several System Add-ons) [FF57+]
    "browser.ping-centre.telemetry" = false;
    # disable Firefox Home (Activity Stream) telemetry
    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
    "browser.vpn_promo.enabled" = false;
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        id = 0;
        inherit extensions settings userChrome;
      };
    };
    package = pkgs-unstable.firefox;
  };
  
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
