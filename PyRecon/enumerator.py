# ~/ethical-hacking-journal/PyRecon/enumerator.py

import socket

class ServiceEnumerator:
    def __init__(self, targets, open_ports):
        self.targets = targets
        self.open_ports = open_ports
        self.services = {}

    def _grab_banner(self, target, port):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.settimeout(2)
                sock.connect((target, port))
                sock.sendall(b'HEAD / HTTP/1.0\r\n\r\n')
                banner = sock.recv(1024).decode(errors='ignore')
                return banner.strip()
        except Exception:
            return "No banner"

    def enumerate(self):
        for target in self.targets:
            self.services[target] = {}
            ports = self.open_ports.get(target, [])
            for port in ports:
                banner = self._grab_banner(target, port)
                self.services[target][port] = banner
        return self.services
