From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: cloud-init resolv.conf updates
Date: Fri, 12 Jun 2015 07:57:58 +0200 (CEST)
Message-ID: <772082321.966971.1434088678294.JavaMail.zimbra@oxygem.tv>
References: <5579FFA3.2060903@dachary.org> <1985953708.961395.1434085304287.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:56327 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbFLF6A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 01:58:00 -0400
In-Reply-To: <1985953708.961395.1434085304287.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Mehdi Abaakouk <sileht@sileht.net>, ceph-devel <ceph-devel@vger.kernel.org>

Looking at resolvconf cloud-init src:

https://github.com/number5/cloud-init/blob/74e61ab27addbfcceac4eba254f7=
39ef9964b0ed/cloudinit/config/cc_resolv_conf.py

" As Debian/Ubuntu will, by default, utilize
#    resovlconf, and similarly RedHat will use sysconfig, this module i=
s
#    likely to be of little use unless those are configured correctly.
"
=2E..
"distros =3D ['fedora', 'rhel', 'sles']"

=2E..

"def handle(name, cfg, cloud, log, _args):
    """
    Handler for resolv.conf
    @param name: The module name "resolv-conf" from cloud.cfg
"

I have check inside debian /etc/cloud/cloud.cfg, resolv-conf is not in =
the list of the modules.

I think that because ubuntu use resolvconf by default (which create a s=
ymlink /etc/resolv.conf),
the resolv-conf module is not used




----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Loic Dachary" <loic@dachary.org>
Cc: "Mehdi Abaakouk" <sileht@sileht.net>, "ceph-devel" <ceph-devel@vger=
=2Ekernel.org>
Envoy=C3=A9: Vendredi 12 Juin 2015 07:01:44
Objet: Re: cloud-init resolv.conf updates

Hi Loic,=20

I'm always playing with cloudinit currently,=20
and I never can get working resolv_conf module too (with configdrive da=
tasource)=20


=46inaly, I manage it with this configdrive:=20

/latest/meta_data.json=20
{=20
"uuid": "c5240fed-76a8-48d9-b417-45b46599d999",=20
"network_config" :{ "content_path": "/content/0000"}=20
}=20

/content/0000=20

auto eth0=20
iface eth0 inet static=20
address x.X.X.X=20
netmask 255.255.255.0=20
gateway X.X.X.X=20
dns-nameservers X.X.X.X=20
dns-search mydomain=20


The config is at debian format, but each cloud-init agent on different =
os parse it,=20
and transform it to correct distro format. (/sysconfig/.. for redhat).=20



----- Mail original -----=20
De: "Loic Dachary" <loic@dachary.org>=20
=C3=80: "Mehdi Abaakouk" <sileht@sileht.net>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Jeudi 11 Juin 2015 23:37:39=20
Objet: cloud-init resolv.conf updates=20

Hi Mehdi,=20

I tried to=20

manage_resolv_conf: true=20

resolv_conf:=20
nameservers: ['8.8.4.4', '8.8.8.8']=20

but did not get any result and according to /var/log/cloud-init.log it =
does not seem to be taken into account.=20

It looks like this is still an open issue according to=20

https://answers.launchpad.net/ubuntu/+source/cloud-init/+question/23404=
1=20
https://bugs.launchpad.net/cloud-init/+bug/1394061=20

even when you get past the misleading example that spells manage-resolv=
-conf instead of manag_resolv_conf at=20

http://cloudinit.readthedocs.org/en/stable/topics/examples.html#configu=
re-an-instances-resolv-conf=20

It looks like there would be a need to add=20

cloud_config_modules:=20
- resolv_conf=20

according to http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/tru=
nk/view/head:/doc/examples/cloud-config.txt#L300 but I don't know which=
 modules I need and which are optional and if the list is going to be m=
erged with the default or override.=20

so I ended up doing:=20

#cloud-config=20
bootcmd:=20
- echo "nameserver 10.0.3.31" | sudo tee -a /etc/resolvconf/resolv.conf=
=2Ed/head=20
- sudo resolvconf -u=20

Which works for Ubuntu 14.04 but isn't going to work for every operatin=
g system ;-)=20

I'm sure you faced something similar in the past and I'd very much appr=
eciate a pointer in the right direction.=20

Cheers=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
