# Linux Certificate Manager (LinuxCertMan)

Author: Samuel Regelbrugge

LinuxCertMan is a Bash script that simplifies SSL/TLS certificate management on Linux servers with Apache2 and BIND9 DNS. It offers modular functionality, including options for selecting certificate management tasks and configuring necessary services.

## Features:

- **Modular Operation:** LinuxCertMan operates through modular scripts, allowing users to select specific tasks for certificate management.

- **Error and Informational Logging:** The script maintains a log file (`/var/log/lincertman.log`) for tracking script activities and potential issues.

## Getting Started:
Use git to clone the repo to your machine:
```sh
git clone git@github.com:Packerbacker111/LinuxCertMan.git
```
You can start by running the main script once you have services that need cert management:
```sh
./LinuxCertMan.sh
```
This will launch the TUI to direct you to which service you want to work on.

Select a module to perform specific certificate-related tasks.

## Modules:

### 1. Apache2 Setup Module:

- Installs Apache2 and OpenSSL.
- Configures Apache2 for SSL and URL rewriting.
- Generates a self-signed certificate.

### 2. DNSSEC Setup Module:

- Adds DNSSEC rules to BIND9 configuration.
- Modifies zone configurations to support DNSSEC.
- Enables DNSSEC validation in `named.conf.options`.

## Notes:

- Run the script with root permissions (`sudo` or as root user).
- Review the log file (`/var/log/LinuxCertMan.log`) for detailed information.
- LinuxCertMan is configured specifically for Debian-based systems; results may vary on other Linux distributions.
- Ensure that your service applications match supported services!
  - Apache for web
  - Bind9 for DNS
- We plan on adding more wide support at a later date!

## Testing
Here is a quick way to verify the successful run of LinuxCertManager

### Apache2/HTTPS
Go to https://<yoursite>, and you should see a warning about trust. This means the self-signed certificate successfully works! To remove the error, you will need to investigate Certificate Authorities and how trust on the internet works.

### Bind9/DNSSEC
You can use the dig command to see DNSSEC proof. Use the following syntax:
```sh
dig +dnssec @<dnsIP> <DNS record>
```
+dnssec will show additional information with the query that pertains to DNSSEC. @<dnsIP> will make sure you query from your server. And the DNS record should be something like example.com, which you have a record for in your server. Here's an example:
```sh
dig +dnssec @10.60.90.101 scripting.com
```
You are looking for an RRSIG entry, which DNSSEC uses to validate zones and entries.

## Contributing:

Contributions, bug reports, feature requests, and pull requests are welcome.

## License:

This project is licensed under the [GNU GENERAL PUBLIC LICENSE Version 3](LICENSE.md).
