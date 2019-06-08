## Unifi Controller in Docker Container on Raspberry Pi

Build Docker Image
```
docker build -t unifi:latest .
```

```bash
docker run -P --restart unless-stopped -d unifi
```