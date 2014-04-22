#!/bin/bash

################################################
#                                              #
#           REGLES FIREWALL  V6                #
#                  PAR                         #
#            CLEMENT MOULINE                   #
#                                              #
#              Version 1.0                     #
#                                              #
################################################

##################### RAZ FIREWALL
ip6tables -F
ip6tables -X

###################### POLITIQUE PAR DEFAUT
ip6tables -t filter -P INPUT DROP
ip6tables -t filter -P OUTPUT DROP
ip6tables -t filter -P FORWARD DROP
ip6tables -t filter -A INPUT -i lo -j ACCEPT
ip6tables -t filter -A OUTPUT -o lo -j ACCEPT

###################### CONNEXIONS ACTIVES ET RELATED
ip6tables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT



####################### AUTORISATION DES PORTS EN ENTREE ET SORTIE

#ICMP - E/S
ip6tables -t filter -A INPUT -p icmpv6 -j ACCEPT
ip6tables -t filter -A OUTPUT -p icmpv6 -j ACCEPT

#SSH - E/S
ip6tables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT

#DNS - S ONLY
ip6tables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT

#NTP - S ONLY
ip6tables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 123 -j ACCEPT

#HTTP - E/S
ip6tables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT

#HTTPS - E/S
ip6tables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

#INTERFACE DE GESTION (HTTP) PEER 2 PEER - E ONLY
ip6tables -t filter -A INPUT -p tcp --dport 9000 -j ACCEPT

#PEER 2 PEER GESTION - E/S
ip6tables -t filter -A INPUT -p tcp --dport 51413 -j ACCEPT
ip6tables -t filter -A INPUT -p udp --dport 51413  -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp --dport 51413 -j ACCEPT
ip6tables -t filter -A OUTPUT -p udp --dport 51413 -j ACCEPT

#PEER 2 PEER PORT ALEATOIRES - S ONLY
ip6tables -t filter -A OUTPUT -p udp  --dport 55535:65535  -j ACCEPT
ip6tables -t filter -A OUTPUT -p tcp  --dport 55535:65535  -j ACCEPT

###############################FIN
ip6tables -L -n -v
