FROM debian:12

# --- Instalacion de servicios base ---
RUN apt-get update && apt-get install -y \
    openssh-server \
    apache2 \
    php \
    net-tools \
    steghide \
    gcc \
    cron \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# --- Instalar croc (para exfiltracion de archivos) ---
RUN curl https://getcroc.schollz.com | bash

# --- Configuracion insegura de SSH (a proposito) ---
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# --- Usuario con contrasena debil ---
RUN useradd -m -s /bin/bash juan && \
    echo "juan:1234" | chpasswd

# --- Vulnerabilidad web: RCE ---
COPY web/index.php /var/www/html/index.php
COPY web/assets/notas_boxes.txt /var/www/html/assets/notas_boxes.txt

# --- Archivos reales del reto (Cesar, XOR, ingenieria inversa) ---
COPY juan/monaco/ /home/juan/monaco/
COPY juan/Downloads/ /home/juan/Downloads/
COPY juan/ingenieria/ /home/juan/ingenieria/
COPY juan/reto_final/ /home/juan/reto_final/

# --- Carpetas y archivos senuelo (distraccion) ---
COPY juan/Documents/ /home/juan/Documents/
COPY juan/Pictures/ /home/juan/Pictures/
COPY juan/Trabajo/ /home/juan/Trabajo/
COPY juan/Facturas/ /home/juan/Facturas/
COPY juan/Recetas/ /home/juan/Recetas/
COPY juan/scripts/ /home/juan/scripts/
COPY juan/.config/ /home/juan/.config/
COPY juan/bash_history /home/juan/.bash_history
COPY juan/notas.txt /home/juan/notas.txt
RUN mkdir -p /home/juan/Music /home/juan/Videos /home/juan/Public /home/juan/Templates

# --- Compilar binario de ingenieria inversa (sin dejar el .c a la vista) ---
RUN cd /home/juan/reto_final && \
    gcc -O0 -no-pie -o verifica verifica.c && \
    chmod +x verifica && \
    rm verifica.c

# --- Analisis forense: log con actividad sospechosa previa ---
RUN mkdir -p /var/log/apache2
COPY forensics/access_backup.log /var/log/apache2/access_backup.log

# --- Escalada de privilegios: cron mal configurado ---
COPY privesc/backup_paddock.sh /opt/backup_paddock.sh
COPY privesc/cron_backup_paddock /etc/cron.d/backup_paddock
RUN chmod 777 /opt/backup_paddock.sh && \
    chown root:root /opt/backup_paddock.sh && \
    chmod 644 /etc/cron.d/backup_paddock

# --- Flag final de root ---
RUN mkdir -p /var/backups && \
    echo "FLAG{root_del_paddock_conseguido}" > /root/root.txt && \
    chmod 600 /root/root.txt

# --- Permisos finales del home de juan ---
RUN chown -R juan:juan /home/juan

EXPOSE 22 80

CMD ["/bin/sh", "-c", "service ssh start && service apache2 start && cron && tail -f /dev/null"]
