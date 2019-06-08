## Unifi Controller in Docker Container on Raspberry Pi

Build Docker Image
```
docker build -t unifi:latest .
```

```bash
docker run -p 3478:3478/udp -p 6789:6789/tcp -p 8080:8080/tcp -p 8443:8443/tcp -p 8880:8880/tcp -p 8843:8843/tcp -p 10001:10001/udp --restart unless-stopped -d unifi
```