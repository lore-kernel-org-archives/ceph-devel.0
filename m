From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: cloud-init resolv.conf updates
Date: Fri, 12 Jun 2015 10:02:51 +0200 (CEST)
Message-ID: <837938735.1041876.1434096171559.JavaMail.zimbra@oxygem.tv>
References: <5579FFA3.2060903@dachary.org> <1985953708.961395.1434085304287.JavaMail.zimbra@oxygem.tv> <557A879B.20301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:38678 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbFLICy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 04:02:54 -0400
In-Reply-To: <557A879B.20301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>> Would it also work with=20
>>
>>auto eth0=20
>>iface eth0 inet dhcp=20
>>dns-nameservers X.X.X.X=20

yes it should work

>>Where can I read more about this ?=20

Well, cloud-init doc is pretty poor.
I have digged inside cloud-init git ;)


https://github.com/number5/cloud-init/blob/74e61ab27addbfcceac4eba254f7=
39ef9964b0ed/cloudinit/sources/DataSourceConfigDrive.py

def on_first_boot(data, distro=3DNone):
    """Performs any first-boot actions using data read from a config-dr=
ive."""
    if not isinstance(data, dict):
        raise TypeError("Config-drive data expected to be a dict; not %=
s"
                        % (type(data)))
    net_conf =3D data.get("network_config", '')
    if net_conf and distro:
        LOG.debug("Updating network interfaces from config drive")
        distro.apply_network(net_conf)


then
https://github.com/number5/cloud-init/blob/74e61ab27addbfcceac4eba254f7=
39ef9964b0ed/cloudinit/distros/__init__.py

  def apply_network(self, settings, bring_up=3DTrue):
        # Write it out
        dev_names =3D self._write_network(settings)


debian (simply write the /etc/network/interfaces)
-------------------------------------------------
https://github.com/number5/cloud-init/blob/74e61ab27addbfcceac4eba254f7=
39ef9964b0ed/cloudinit/distros/debian.py

def _write_network(self, settings):
        util.write_file(self.network_conf_fn, settings)
        return ['all']



redhat (translate to redhat network conf file and  resolv.conf)
------------------------------------------------------------------
https://github.com/number5/cloud-init/blob/74e61ab27addbfcceac4eba254f7=
39ef9964b0ed/cloudinit/distros/rhel.py

def _write_network(self, settings):
        # TODO(harlowja) fix this... since this is the ubuntu format
        entries =3D net_util.translate_network(settings)
        LOG.debug("Translated ubuntu style network settings %s into %s"=
,
                  settings, entries)
        # Make the intermediate format as the rhel format...
        nameservers =3D []
        searchservers =3D []
        dev_names =3D entries.keys()
        use_ipv6 =3D False
        for (dev, info) in entries.items():
            net_fn =3D self.network_script_tpl % (dev)
            net_cfg =3D {
                'DEVICE': dev,
                'NETMASK': info.get('netmask'),
                'IPADDR': info.get('address'),
                'BOOTPROTO': info.get('bootproto'),
                'GATEWAY': info.get('gateway'),
                'BROADCAST': info.get('broadcast'),
                'MACADDR': info.get('hwaddress'),
                'ONBOOT': _make_sysconfig_bool(info.get('auto')),
            }
            if info.get('inet6'):
                use_ipv6 =3D True
                net_cfg.update({
                    'IPV6INIT': _make_sysconfig_bool(True),
                    'IPV6ADDR': info.get('ipv6').get('address'),
                    'IPV6_DEFAULTGW': info.get('ipv6').get('gateway'),
                })
            rhel_util.update_sysconfig_file(net_fn, net_cfg)
            if 'dns-nameservers' in info:
                nameservers.extend(info['dns-nameservers'])
            if 'dns-search' in info:
                searchservers.extend(info['dns-search'])
        if nameservers or searchservers:
            rhel_util.update_resolve_conf_file(self.resolve_conf_fn,
                                               nameservers, searchserve=
rs)
        if dev_names:
            net_cfg =3D {
                'NETWORKING': _make_sysconfig_bool(True),
            }
            # If IPv6 interface present, enable ipv6 networking
            if use_ipv6:
                net_cfg['NETWORKING_IPV6'] =3D _make_sysconfig_bool(Tru=
e)
                net_cfg['IPV6_AUTOCONF'] =3D _make_sysconfig_bool(False=
)
            rhel_util.update_sysconfig_file(self.network_conf_fn, net_c=
fg)
        return dev_names


----- Mail original -----
De: "Loic Dachary" <loic@dachary.org>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Vendredi 12 Juin 2015 09:17:47
Objet: Re: cloud-init resolv.conf updates

Hi Alexandre,=20

That's an interesting trick :-) Would it also work with=20

auto eth0=20
iface eth0 inet dhcp=20
dns-nameservers X.X.X.X=20

Where can I read more about this ?=20

Cheers=20

On 12/06/2015 07:01, Alexandre DERUMIER wrote:=20
> Hi Loic,=20
>=20
> I'm always playing with cloudinit currently,=20
> and I never can get working resolv_conf module too (with configdrive =
datasource)=20
>=20
>=20
> Finaly, I manage it with this configdrive:=20
>=20
> /latest/meta_data.json=20
> {=20
> "uuid": "c5240fed-76a8-48d9-b417-45b46599d999",=20
> "network_config" :{ "content_path": "/content/0000"}=20
> }=20
>=20
> /content/0000=20
>=20
> auto eth0=20
> iface eth0 inet static=20
> address x.X.X.X=20
> netmask 255.255.255.0=20
> gateway X.X.X.X=20
> dns-nameservers X.X.X.X=20
> dns-search mydomain=20
>=20
>=20
> The config is at debian format, but each cloud-init agent on differen=
t os parse it,=20
> and transform it to correct distro format. (/sysconfig/.. for redhat)=
=2E=20
>=20
>=20
>=20
> ----- Mail original -----=20
> De: "Loic Dachary" <loic@dachary.org>=20
> =C3=80: "Mehdi Abaakouk" <sileht@sileht.net>=20
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
> Envoy=C3=A9: Jeudi 11 Juin 2015 23:37:39=20
> Objet: cloud-init resolv.conf updates=20
>=20
> Hi Mehdi,=20
>=20
> I tried to=20
>=20
> manage_resolv_conf: true=20
>=20
> resolv_conf:=20
> nameservers: ['8.8.4.4', '8.8.8.8']=20
>=20
> but did not get any result and according to /var/log/cloud-init.log i=
t does not seem to be taken into account.=20
>=20
> It looks like this is still an open issue according to=20
>=20
> https://answers.launchpad.net/ubuntu/+source/cloud-init/+question/234=
041=20
> https://bugs.launchpad.net/cloud-init/+bug/1394061=20
>=20
> even when you get past the misleading example that spells manage-reso=
lv-conf instead of manag_resolv_conf at=20
>=20
> http://cloudinit.readthedocs.org/en/stable/topics/examples.html#confi=
gure-an-instances-resolv-conf=20
>=20
> It looks like there would be a need to add=20
>=20
> cloud_config_modules:=20
> - resolv_conf=20
>=20
> according to http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/t=
runk/view/head:/doc/examples/cloud-config.txt#L300 but I don't know whi=
ch modules I need and which are optional and if the list is going to be=
 merged with the default or override.=20
>=20
> so I ended up doing:=20
>=20
> #cloud-config=20
> bootcmd:=20
> - echo "nameserver 10.0.3.31" | sudo tee -a /etc/resolvconf/resolv.co=
nf.d/head=20
> - sudo resolvconf -u=20
>=20
> Which works for Ubuntu 14.04 but isn't going to work for every operat=
ing system ;-)=20
>=20
> I'm sure you faced something similar in the past and I'd very much ap=
preciate a pointer in the right direction.=20
>=20
> Cheers=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
