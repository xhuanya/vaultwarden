#!/bin/sh
echo "替换配置1"
sed -i "s#ENV_PORT_HUAN#$PORT#" /.env
sed -i "s#ENV_SQL_HUAN#$DATABASE_URL#" /.env
sed -i "s#ENV_ADMIN_TOKEN_HUAN#$ADMIN_TOKEN#" /.env
echo "配置替换完毕"
if [ -r /etc/vaultwarden.sh ]; then
    . /etc/vaultwarden.sh
elif [ -r /etc/bitwarden_rs.sh ]; then
    echo "### You are using the old /etc/bitwarden_rs.sh script, please migrate to /etc/vaultwarden.sh ###"
    . /etc/bitwarden_rs.sh
fi

if [ -d /etc/vaultwarden.d ]; then
    for f in /etc/vaultwarden.d/*.sh; do
        if [ -r $f ]; then
            . $f
        fi
    done
elif [ -d /etc/bitwarden_rs.d ]; then
    echo "### You are using the old /etc/bitwarden_rs.d script directory, please migrate to /etc/vaultwarden.d ###"
    for f in /etc/bitwarden_rs.d/*.sh; do
        if [ -r $f ]; then
            . $f
        fi
    done
fi
exec /vaultwarden "${@}"

