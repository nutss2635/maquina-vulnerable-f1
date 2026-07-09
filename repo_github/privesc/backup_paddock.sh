#!/bin/bash
# Respaldo automatico de telemetria del equipo
tar -czf /var/backups/paddock_$(date +%s).tar.gz /var/www/html/ 2>/dev/null
