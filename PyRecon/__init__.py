"""
PyRecon

PyRecon is a modular Python package designed to automate key penetration testing workflows including reconnaissance, scanning, vulnerability mapping, and exploit development.

Usage Example:
    from pyrecon.scanner import PortScanner
    from pyrecon.enumerator import ServiceEnumerator
    from pyrecon.vulnmapper import VulnerabilityMapper

    targets = ['192.168.1.10', '192.168.1.20']

    scanner = PortScanner(targets)
    open_ports = scanner.scan()

    enumerator = ServiceEnumerator(targets, open_ports)
    services = enumerator.enumerate()

    vuln_mapper = VulnerabilityMapper(services)
    vulnerabilities = vuln_mapper.map()

    for target, vulns in vulnerabilities.items():
        print(f"Target: {target}")
        for vuln in vulns:
            print(f" - {vuln}")

Modules Overview:
    - scanner: Implements multi-threaded port scanning and service detection with configurable profiles.
    - enumerator: Performs banner grabbing, fingerprinting, and OS detection.
    - vulnmapper: Maps services to known vulnerabilities using curated databases.
    - payloads: Contains payload templates and generators compatible with common exploit frameworks.
    - reporting: Formats scan results into structured reports for documentation and compliance.

For detailed documentation, refer to the README.md file included in this package.
"""
