# ~/ethical-hacking-journal/PyRecon/vulnmapper.py

class VulnerabilityMapper:
    # Simulated vulnerability database for demonstration
    VULN_DB = {
        'Apache': ['CVE-2021-41773', 'CVE-2021-42013'],
        'OpenSSH': ['CVE-2018-15473'],
        'nginx': ['CVE-2019-20372'],
    }

    def __init__(self, services):
        self.services = services

    def map(self):
        vulnerabilities = {}
        for target, ports in self.services.items():
            vulnerabilities[target] = []
            for port, banner in ports.items():
                for product in self.VULN_DB.keys():
                    if product.lower() in banner.lower():
                        vulnerabilities[target].append(f"{product} vulnerabilities: {', '.join(self.VULN_DB[product])}")
        return vulnerabilities
