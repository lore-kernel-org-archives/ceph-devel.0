From: Loic Dachary <loic@dachary.org>
Subject: Re: udev events on a disk, at boot time
Date: Tue, 21 Jun 2016 18:39:29 +0200
Message-ID: <57696DC1.3090803@dachary.org>
References: <57695098.50403@dachary.org>
 <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60631 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbcFUQka (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 12:40:30 -0400
In-Reply-To: <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 21/06/2016 17:30, Ruben Kerkhof wrote:
> Dear Loic,
>=20
> On Tue, Jun 21, 2016 at 4:35 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Ilya,
>>
>> On Debian Jessie 8.5 which has
>>
>> root@000000000000:/home/ubuntu# uname -a
>> Linux 000000000000.teuthology 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ck=
t25-2 (2016-04-08) x86_64 GNU/Linux
>> root@000000000000:/home/ubuntu# udevadm --version
>> 215
>>
>> it looks like there are no udev ADD events at boot time and the OSD =
do not activate. After booting, if the disk is removed and re-added (vi=
a openstack server volume add / remove for instance), the OSD comes up =
as expected, which confirms the udev rules and the OSD are good.
>>
>> This can be worked around by running ceph-disk activate-all which sc=
ans all disks when run from /etc/init/ceph-osd-all-starter.conf at boot=
 time. The workaround requires that /dev/disk/by-parttypeuuid is popula=
ted[1] and this can be done by installing the 60-ceph-partuuid-workarou=
nd.rules [2] file.
>>
>> Before trying to workaround the problem, I'd like to understand what=
 is the difference with CentOS 7.2 which has
>>
>> # uname -a
>> Linux target167114254243.teuthology 3.10.0-327.el7.x86_64 #1 SMP Thu=
 Nov 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
>> # udevadm --version
>> 219
>>
>> and correctly fires the ADD events at boot time.
>>
>> A CentOS 7(minor version unknown) user reported the same problem as =
Debian Jessie 8.5 but I don't have information about the udev version n=
or the kernel version. I suspect this behavior has more to do with the =
udev + kernel version combination than with the distribution.
>>
>> I've not actually traced the udev events at boot time because I'm no=
t sure how to do that. Hopefully you have an idea about why this is hap=
pening. Otherwise I'll try to collect hard evidence.
>=20
> I think I'm seeing the exact same issue as you describe on CentOS 7.2=
,
> so this might not be limited to Debian Jessie.
> After a reboot the OSDs do not activate.
> With udev_log=3D"debug" in /etc/udev/udev.conf, the journal doesn't s=
how
> any sign that /usr/lib/udev/rules.d/95-ceph-osd.rules is executed.
>=20
> ruben@hlm1-pod12-ceph03: ~$ udevadm --version
> 219
>=20
> ruben@hlm1-pod12-ceph03: ~$ uname -a
> Linux hlm1-pod12-ceph03 3.10.0-327.18.2.el7.x86_64 #1 SMP Thu May 12
> 11:03:55 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
>=20
> Let me know if there's anything I can do to help debug this.

I wonder how my CentOS 7.2 setup is different. I'll try to reproduce th=
e problem on CentOS 7.2 as well.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
