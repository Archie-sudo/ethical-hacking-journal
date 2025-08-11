# ~/ethical-hacking-journal/PyRecon/scanner.py

import socket
import threading

class PortScanner:
    def __init__(self, targets, ports=None, timeout=1):
        self.targets = targets if isinstance(targets, list) else [targets]
        self.ports = ports if ports else [22, 80, 443, 8080]  # Default common ports
        self.timeout = timeout
        self.open_ports = {}

    def _scan_port(self, target, port):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.settimeout(self.timeout)
                result = sock.connect_ex((target, port))
                if result == 0:
                    self.open_ports.setdefault(target, []).append(port)
        except Exception:
            pass

    def scan(self):
        threads = []
        for target in self.targets:
            for port in self.ports:
                thread = threading.Thread(target=self._scan_port, args=(target, port))
                thread.start()
                threads.append(thread)
        for thread in threads:
            thread.join()
        return self.open_ports
