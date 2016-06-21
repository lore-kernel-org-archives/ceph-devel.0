From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: udev events on a disk, at boot time
Date: Tue, 21 Jun 2016 21:41:32 +0200 (CEST)
Message-ID: <1446893212.28488652.1466538092651.JavaMail.zimbra@oxygem.tv>
References: <57695098.50403@dachary.org> <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com> <57696DC1.3090803@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:48756 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbcFUTuC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 15:50:02 -0400
In-Reply-To: <57696DC1.3090803@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ruben Kerkhof <ruben@rubenkerkhof.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Loic,

I'll try to debug on my side.

(others proxmox users have also reported the problem with debian jessie=
 too, so it's not related to my hardware)

----- Mail original -----
De: "Loic Dachary" <loic@dachary.org>
=C3=80: "Ruben Kerkhof" <ruben@rubenkerkhof.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 21 Juin 2016 18:39:29
Objet: Re: udev events on a disk, at boot time

On 21/06/2016 17:30, Ruben Kerkhof wrote:=20
> Dear Loic,=20
>=20
> On Tue, Jun 21, 2016 at 4:35 PM, Loic Dachary <loic@dachary.org> wrot=
e:=20
>> Hi Ilya,=20
>>=20
>> On Debian Jessie 8.5 which has=20
>>=20
>> root@000000000000:/home/ubuntu# uname -a=20
>> Linux 000000000000.teuthology 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ck=
t25-2 (2016-04-08) x86_64 GNU/Linux=20
>> root@000000000000:/home/ubuntu# udevadm --version=20
>> 215=20
>>=20
>> it looks like there are no udev ADD events at boot time and the OSD =
do not activate. After booting, if the disk is removed and re-added (vi=
a openstack server volume add / remove for instance), the OSD comes up =
as expected, which confirms the udev rules and the OSD are good.=20
>>=20
>> This can be worked around by running ceph-disk activate-all which sc=
ans all disks when run from /etc/init/ceph-osd-all-starter.conf at boot=
 time. The workaround requires that /dev/disk/by-parttypeuuid is popula=
ted[1] and this can be done by installing the 60-ceph-partuuid-workarou=
nd.rules [2] file.=20
>>=20
>> Before trying to workaround the problem, I'd like to understand what=
 is the difference with CentOS 7.2 which has=20
>>=20
>> # uname -a=20
>> Linux target167114254243.teuthology 3.10.0-327.el7.x86_64 #1 SMP Thu=
 Nov 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux=20
>> # udevadm --version=20
>> 219=20
>>=20
>> and correctly fires the ADD events at boot time.=20
>>=20
>> A CentOS 7(minor version unknown) user reported the same problem as =
Debian Jessie 8.5 but I don't have information about the udev version n=
or the kernel version. I suspect this behavior has more to do with the =
udev + kernel version combination than with the distribution.=20
>>=20
>> I've not actually traced the udev events at boot time because I'm no=
t sure how to do that. Hopefully you have an idea about why this is hap=
pening. Otherwise I'll try to collect hard evidence.=20
>=20
> I think I'm seeing the exact same issue as you describe on CentOS 7.2=
,=20
> so this might not be limited to Debian Jessie.=20
> After a reboot the OSDs do not activate.=20
> With udev_log=3D"debug" in /etc/udev/udev.conf, the journal doesn't s=
how=20
> any sign that /usr/lib/udev/rules.d/95-ceph-osd.rules is executed.=20
>=20
> ruben@hlm1-pod12-ceph03: ~$ udevadm --version=20
> 219=20
>=20
> ruben@hlm1-pod12-ceph03: ~$ uname -a=20
> Linux hlm1-pod12-ceph03 3.10.0-327.18.2.el7.x86_64 #1 SMP Thu May 12=20
> 11:03:55 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux=20
>=20
> Let me know if there's anything I can do to help debug this.=20

I wonder how my CentOS 7.2 setup is different. I'll try to reproduce th=
e problem on CentOS 7.2 as well.=20

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
