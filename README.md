[![Azure Traffic Manager Linker](http://www.nopdynamics.com/media/17082/windows-logo.png)](../../../azure)
## Azure Traffic Manager Linker for Jelastic

This repository provides [Azure Traffic Manager Linker](https://github.com/jelastic/azure/) add-on for Jelastic Platform.

**Azure Traffic Manager Linker**  is an addon that is for linking any Jelastic backend to Azure Traffic Manager.

**Type of nodes this add-on can be applied to**: ANY

### What it can be used for?
This addons link Jelastic environment to Azure Traffic Manager.
Geo-route incoming traffic to your app for better performance and availability:
- Improve app availability with automatic failover;
- Increase your app’s responsiveness;
- Enable smooth cloud migration;
- Distribute your app traffic equally or with weighted values;
- A/B test new deployments;
- Seamlessly combine on-premises and cloud systems.

These initial options can be selected:
- Azure login (is Azure user email by default);
- Password (is Azure user password by default);
- Resource Group (is "Default" by default);
- Location (is a pointer to either another name or the IP address of a specific location on the Internet);
- Profile name (is "Default" by default);
- Relative DNS name (is an unique DNS prefix name. You can specify only the prefix for a domain name. DNS record on your authoritative DNS server to point your company domain name to the Traffic Manager domain name.);
- Monitoring path (In order to monitor endpoints, you must specify a path and filename. Note that a forward slash “/“ is a valid entry for the relative path and implies that the file is in the root directory (default))<br/>

### Deployment

In order to get this solution instantly deployed, click the "Get It Hosted Now" button, specify your email address within the widget, choose one of the [Jelastic Public Cloud providers](https://jelastic.cloud) and press Install.

[![GET IT HOSTED](https://raw.githubusercontent.com/jelastic-jps/jpswiki/master/images/getithosted.png)](https://jelastic.com/install-application/?manifest=https%3A%2F%2Fgithub.com%2Fjelastic%2Fazure%2Fraw%2Fmaster%2Fmanifest.jps)

To deploy this package to Jelastic Private Cloud, import [this JPS manifest](../../raw/master/manifest.jps) within your dashboard ([detailed instruction](https://docs.jelastic.com/environment-export-import#import)).

For more information on what Jelastic add-on is and how to apply it, follow the [Jelastic Add-ons](https://github.com/jelastic-jps/jpswiki/wiki/Jelastic-Addons) reference.
