#!/bin/bash

################################################
#                                              #
#           REGLES FIREWALL  V4                #
#                  PAR                         #
#            CLEMENT MOULINE                   #
#                                              #
#              Version 1.0                     #
#                                              #
################################################


##################### RAZ FIREWALL
iptables -t filter -F
iptables -t filter -X

###################### POLITIQUE PAR DEFAUT (DROP - SAUF LoopBack)
iptables -t filter -P INPUT DROP
iptables -t filter -P OUTPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT

###################### CONNNEXION ACTIVES et RELATED
iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT


####################### AUTORISATION DES PORTS EN ENTREE ET SORTIE

#ICMP - E/S
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

#SSH - E/S
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

#DNS - S ONLY
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT

#NTP - S ONLY
iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 123 -j ACCEPT

#HTTP - E/S
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT

#HTTPS - E/S
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

#INTERFACE DE GESTION (HTTP) PEER 2 PEER - E ONLY
iptables -t filter -A INPUT -p tcp --dport 9000 -j ACCEPT

#PEER 2 PEER GESTION - E/S
iptables -t filter -A INPUT -p tcp --dport 51413 -j ACCEPT
iptables -t filter -A INPUT -p udp --dport 51413  -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 51413 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 51413 -j ACCEPT

#PEER 2 PEER PORT ALEATOIRES - S ONLY
iptables -t filter -A OUTPUT -p udp  --dport 55535:65535  -j ACCEPT
iptables -t filter -A OUTPUT -p tcp  --dport 55535:65535  -j ACCEPT

############################### FIN
iptables -L -v -n
