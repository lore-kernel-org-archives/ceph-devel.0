From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Problem with Ceph installation inside Amazon EC2
Date: Tue, 20 Apr 2010 16:21:34 +0200
Message-ID: <1271773294.1905.75.camel@wido-desktop>
References: <201004201538.34232.cray@unix-ag.uni-kl.de>
Reply-To: wido@pcextreme.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:54472 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab0DTOVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Apr 2010 10:21:33 -0400
In-Reply-To: <201004201538.34232.cray@unix-ag.uni-kl.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Baun <cray@unix-ag.uni-kl.de>
Cc: ceph-devel@vger.kernel.org

Hi,

What does "ceph -w" show?

Do you get some "xauth" messages in your mon0 logfiles?

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Tue, 2010-04-20 at 13:38 +0000, Christian Baun wrote:
> Hi,
>=20
> I want to test Ceph inside Amazon EC2. Therefore I compiled and insta=
lled ceph-0.19.1.tar.gz and ceph-kclient-0.19.1.tar.gz
>=20
> Two Ubuntu instances are running inside EC2.=20
> One server with cmon, cmds, and cosd and one client.
>=20
> # cat /etc/ceph/ceph.conf
> [global]
>        pid file =3D /var/run/ceph/$name.pid
>        debug ms =3D 1
>=20
> [mon]
>        mon data =3D /srv/ceph/mon
>=20
> [mon0]
>        host =3D ceph01
>        mon addr =3D 10.194.145.203:6789
>=20
> [mds]
>=20
> [mds0]
>        host =3D ceph01
>=20
> [osd]
>        sudo =3D true
>        osd data =3D /srv/ceph/osd
>=20
> [osd1]
>        host =3D ceph01
>        btrfs devs =3D /dev/sdc
>=20
>=20
> # cat /etc/hosts
> 127.0.0.1 localhost
> 10.194.145.203   ceph01
>=20
>=20
> # mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k ~/admin.key=
ring
> .conf --allhosts --mkbtrfs -k ~/admin.keyring
> /usr/local/bin/monmaptool --create --clobber --add 10.194.145.203:678=
9 --print /tmp/monmap.9681
> /usr/local/bin/monmaptool: monmap file /tmp/monmap.9681
> /usr/local/bin/monmaptool: generated fsid 7a008165-58df-733f-deca-90f=
aecaef60a
> epoch 1
> fsid 7a008165-58df-733f-deca-90faecaef60a
> last_changed 10.04.20 13:34:52.518583
> created 10.04.20 13:34:52.518583
> 	mon0 10.194.145.203:6789/0
> /usr/local/bin/monmaptool: writing epoch 1 to /tmp/monmap.9681 (1 mon=
itors)
> max osd in /etc/ceph/ceph.conf is 1, num osd is 2
> /usr/local/bin/osdmaptool: osdmap file '/tmp/osdmap.9681'
> /usr/local/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.9681
> Building admin keyring at /root/admin.keyring
> creating /root/admin.keyring
> Building monitor keyring with all service keys
> creating /tmp/monkeyring.9681
> importing contents of /root/admin.keyring into /tmp/monkeyring.9681
> creating /tmp/keyring.mds.0
> importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.9681
> creating /tmp/keyring.osd.1
> importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.9681
> =3D=3D=3D mon0 =3D=3D=3D=20
> 10.04.20 13:34:54.805739 store(/srv/ceph/mon) mkfs
> 10.04.20 13:34:54.805853 store(/srv/ceph/mon) test -d /srv/ceph/mon &=
& /bin/rm -rf /srv/ceph/mon ; mkdir -p /srv/ceph/mon
> 10.04.20 13:34:54.831017 mon0(starting).class v0 create_initial -- cr=
eating initial map
> 10.04.20 13:34:54.832277 mon0(starting).auth v0 create_initial -- cre=
ating initial map
> 10.04.20 13:34:54.832308 mon0(starting).auth v0 reading initial keyri=
ng=20
> /usr/local/bin/mkmonfs: created monfs at /srv/ceph/mon for mon0
> admin.keyring                                    100%  119     0.1KB/=
s   00:00   =20
> =3D=3D=3D mds0 =3D=3D=3D=20
> WARNING: no keyring specified for mds0
> =3D=3D=3D osd1 =3D=3D=3D=20
> umount: /srv/ceph/osd: not mounted
> umount: /dev/sdc: not mounted
>=20
> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
> WARNING! - see http://btrfs.wiki.kernel.org before using
>=20
> fs created label (null) on /dev/sdc
> 	nodesize 4096 leafsize 4096 sectorsize 4096 size 419.97GB
> Btrfs Btrfs v0.19
> Scanning for Btrfs filesystems
> monmap.9681                                      100%  187     0.2KB/=
s   00:00   =20
>  ** WARNING: Ceph is still under heavy development, and is only suita=
ble for **
>  **          testing and review.  Do not trust it with important data=
=2E       **
> created object store for osd1 fsid 7a008165-58df-733f-deca-90faecaef6=
0a on /srv/ceph/osd
> WARNING: no keyring specified for osd1
>=20
>=20
>=20
> # df
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda1             10403128   4038372   5945328  41% /
> none                   3804316       112   3804204   1% /dev
> none                   3941904         0   3941904   0% /dev/shm
> none                   3941904        60   3941844   1% /var/run
> none                   3941904         0   3941904   0% /var/lock
> none                   3941904         0   3941904   0% /lib/init/rw
> /dev/sdb             433455904    203016 411234584   1% /mnt
> /dev/sdc             440366080        32 440366048   1% /srv/ceph/osd
>=20
>=20
> # mount | grep ceph
> /dev/sdc on /srv/ceph/osd type btrfs (rw,flushoncommit)
>=20
>=20
> At the server:
> # ./ceph start
> 10.04.20 13:35:39.757563 7f6485c32720 -- :/10726 messenger.start
> 10.04.20 13:35:39.757808 7f6485c32720 -- :/10726 --> mon0 10.194.145.=
203:6789/0 -- auth(proto 0 30 bytes) -- ?+0 0x1e46910
> 10.04.20 13:35:39.757990 7f6482eb3710 -- :/10726 >> 10.194.145.203:67=
89/0 pipe(0x1e426a0 sd=3D-1 pgs=3D0 cs=3D0 l=3D0).fault first fault
>=20
>=20
> At the client:
> # mount -t ceph 10.194.145.203:/ /mnt/ceph/
> mount: 10.194.145.203:/: can't read superblock
>=20
>=20
> What can I do at this point?
>=20
> Thanks in advance
>     Christian=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
