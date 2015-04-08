From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] OSD auto-mount after server reboot
Date: Wed, 08 Apr 2015 10:57:35 +0200
Message-ID: <5524ED7F.8010907@dachary.org>
References: <CAPntomBscGHp-oTqRJmG7by-OVsJ7O=WSu0G_TbYKAmN4qNE0Q@mail.gmail.com>	<5521614D.8090600@dachary.org>	<CAPntomCu4dtC-Zq7JaBrXFs+pLt=ToMdCyH5f7jc6bHTBQrLrg@mail.gmail.com>	<5522D9FD.3000502@dachary.org>	<CAPntomDDTF6=dNnZnkybfE-5Us_uDTSRoWupRnk42tabb2P+vQ@mail.gmail.com>	<CAPntomBdNp=eqdXYytojVF=2GTccX3c+MY9nf4Gh-c71_mYKnA@mail.gmail.com>	<55242DEE.5030907@dachary.org>	<CAPntomByauf=ep7iDaL0qCRoWm1qL1xrOvGCrn1dv-zdkTgU5Q@mail.gmail.com>	<55244C9E.2080502@dachary.org> <CAPntomCz9KdoGNcOgkqZ6p12k=vrq=bFKTV__kaB26fZLdDmnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oPFrkdOuJjoAr0aA3qbNQVXoVPKotwmMN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43256 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751348AbbDHI5o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 04:57:44 -0400
In-Reply-To: <CAPntomCz9KdoGNcOgkqZ6p12k=vrq=bFKTV__kaB26fZLdDmnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shiva rkreddy <shiva.rkreddy@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPFrkdOuJjoAr0aA3qbNQVXoVPKotwmMN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/04/2015 02:16, shiva rkreddy wrote:
> We didn't do a upgrade from 0.80.7 to 0.80.9. It was a fresh install wi=
th ceph 0.80.9 with ceph-deploy version 1.15.12.
>=20
> May be  should have used ceph-deploy version 1.15.16  https://github.co=
m/ceph/ceph-deploy/pull/240/files

Ok, mystery solved then, right ?
>=20
>=20
> On Tue, Apr 7, 2015 at 4:31 PM, Loic Dachary <loic@dachary.org <mailto:=
loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 07/04/2015 23:03, shiva rkreddy wrote:
>     > It turns out that ceph service is set ceph to off. Following defe=
ct talks about it..Once its set to on, everything worked fine after host =
reboot.
>     >
>     > http://tracker.ceph.com/issues/9090
>=20
>     Interesting :-) Does that mean that the ceph service was somehow tu=
rned off when upgrading from v0.80.7 to v0.80.9 ?
>=20
>     >
>     > On Tue, Apr 7, 2015 at 2:20 PM, Loic Dachary <loic@dachary.org <m=
ailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.org=
>>> wrote:
>     >
>     >     [cc'ing ceph-devel for archival purposes]
>     >
>     >     Hi,
>     >
>     >     On 07/04/2015 19:55, shiva rkreddy wrote:
>     >     > Hi Loic,
>     >     > I've looked at the way our cluster provisioning partition a=
nd label the journal device. Its done using /*parted*/ command with "gpt"=
 label.  Following is the parted output for /dev/sdr that we were looking=
 yesterday.
>     >     >
>     >     > # parted /dev/sdr
>     >     > GNU Parted 2.1
>     >     > Using /dev/sdr
>     >     > Welcome to GNU Parted! Type 'help' to view a list of comman=
ds.
>     >     > (parted) p
>     >     > Model: ASR7160 JBOD-R (scsi)
>     >     > Disk /dev/sdr: 960GB
>     >     > Sector size (logical/physical): 512B/512B
>     >     > Partition Table: *gpt*
>     >     >
>     >     > Number  Start   End    Size   File system  Name     Flags
>     >     >  1      9599MB  240GB  230GB               primary
>     >     >  2      250GB   480GB  230GB               primary
>     >     >  3      490GB   720GB  230GB               primary
>     >     >  4      730GB   960GB  230GB               primary
>     >     >
>     >     > (parted)
>     >     >
>     >     > *# sgdisk --info 1 /dev/sdr*
>     >     > Partition GUID code: 45B0969E-9B03-4F30-B4C6-B4B80CEFF106 (=
Microsoft basic data)
>     >     > Partition unique GUID: 0A45987B-DC77-4816-B506-DEE0DC60AE9E=

>     >     > First sector: 18747392 (at 8.9 GiB)
>     >     > Last sector: 468707327 (at 223.5 GiB)
>     >     > Partition size: 449959936 sectors (214.6 GiB)
>     >     > Attribute flags: 0000000000000000
>     >     > Partition name: 'primary'
>     >     >
>     >     >
>     >     > We stared to put label on the disk based on a blog at http:=
//blog.zhaw.ch/icclab/deploy-ceph-and-start-using-it-end-to-end-tutorial-=
installation-part-13/
>     >     >
>     >     > I'm not sure why sgdisk is getting  "Microsoft basics data"=
=2E
>     >
>     >     It's not a big deal as long as it's what ceph-disk expects:
>     >
>     >     https://github.com/ceph/ceph/blob/firefly/src/ceph-disk#L76
>     >
>     >     The more interesting question would be to figure out if ceph-=
disk-udev is called from
>     >
>     >     https://github.com/ceph/ceph/blob/firefly/udev/95-ceph-osd-al=
t.rules
>     >
>     >     We have tried udevadm trigger --sysname-match=3Dsd* yesterday=
 and verified it is called when a udev event is sent by the kernel. And y=
ou have added that to /etc/rc.local to make sure it is called at least on=
ce at boot time. Would you have time to experiment as described at https:=
//wiki.ubuntu.com/DebuggingUdev to get more information about what happen=
s during the boot phase of your machine ?
>     >
>     >     Cheers
>     >
>     >     >
>     >     > Thanks,
>     >     > Shiva
>     >     >
>     >     > On Mon, Apr 6, 2015 at 2:29 PM, shiva rkreddy <shiva.rkredd=
y@gmail.com <mailto:shiva.rkreddy@gmail.com> <mailto:shiva.rkreddy@gmail.=
com <mailto:shiva.rkreddy@gmail.com>> <mailto:shiva.rkreddy@gmail.com <ma=
ilto:shiva.rkreddy@gmail.com> <mailto:shiva.rkreddy@gmail.com <mailto:shi=
va.rkreddy@gmail.com>>>> wrote:
>     >     >
>     >     >     Hi,
>     >     >
>     >     >     I'm on IRC as *shivark*
>     >     >
>     >     >     # sgdisk --info 1 /dev/sdb
>     >     >     Partition GUID code: 4FBD7E29-9D25-41B8-AFD0-062C0CEFF0=
5D (Unknown)
>     >     >     Partition unique GUID: 1618223E-B8C9-4C4A-B5D2-EBFF6D64=
CB12
>     >     >     First sector: 2048 (at 1024.0 KiB)
>     >     >     Last sector: 7811870686 (at 3.6 TiB)
>     >     >     Partition size: 7811868639 sectors (3.6 TiB)
>     >     >     Attribute flags: 0000000000000000
>     >     >     Partition name: 'ceph data'
>     >     >     #
>     >     >
>     >     >
>     >     >     On Mon, Apr 6, 2015 at 2:09 PM, Loic Dachary <loic@dach=
ary.org <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@d=
achary.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:l=
oic@dachary.org <mailto:loic@dachary.org>>>> wrote:
>     >     >
>     >     >         Hi,
>     >     >
>     >     >         lrwxrwxrwx 1 root root 10 Apr  4 16:27 1618223e-b8c=
9-4c4a-b5d2-ebff6d64cb12 -> ../../sdb1
>     >     >
>     >     >         looks encouraging. Could you
>     >     >
>     >     >         sudo sgdisk --info 1 /dev/sdb
>     >     >
>     >     >         to check that it matches ? If you're on IRC feel fr=
ee to ping me (CEST France/Paris time) and we can have a debug session.
>     >     >
>     >     >         Cheers
>     >     >
>     >     >         On 06/04/2015 02:47, shiva rkreddy wrote:
>     >     >         > We have currently two  osds configured on this sy=
stem running  RHEL6.5, sharing a ssd drive as journal devices.
>     >     >         >
>     >     >         > udevadm trigger --sysname-match=3Dsdb or udevadm =
trigger --sysname-match=3D/dev/sdb, return without any output. Same thing=
 happens on ceph 0.80.7 where mount and services are started automaticall=
y.
>     >     >         >
>     >     >         > Output paste from ceph 0.80.9 is : http://pastebi=
n.com/1Yqntadi
>     >     >         >
>     >     >         >
>     >     >         > On Sun, Apr 5, 2015 at 11:22 AM, Loic Dachary <lo=
ic@dachary.org <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto=
:loic@dachary.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <m=
ailto:loic@dachary.org <mailto:loic@dachary.org>>> <mailto:loic@dachary.o=
rg <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachar=
y.org>> <mailto:loic@dachary.org <mailto:loic@dachary.org> <mailto:loic@d=
achary.org <mailto:loic@dachary.org>>>>> wrote:
>     >     >         >
>     >     >         >
>     >     >         >
>     >     >         >     On 04/04/2015 22:09, shiva rkreddy wrote:
>     >     >         >     > HI,
>     >     >         >     > I'm currently testing Firefly 0.80.9 and no=
ticed that OSD are not auto-mounted after server reboot.
>     >     >         >     > It used to mount auto with Firefly 0.80.7. =
 OS is RHEL 6.5.
>     >     >         >     >
>     >     >         >     > There was another thread earlier on this to=
pic with v0.80.8, suggestion was to add mount points to /etc/fstab.
>     >     >         >     >
>     >     >         >     > Question is whether the 0.80.7 behaviour co=
uld return or its needs to be done via /etc/fstab or something else?
>     >     >         >
>     >     >         >     It should work without adding lines in /etc/f=
stab. Could you give more details about your setup ? Could you try
>     >     >         >
>     >     >         >     udevadm trigger --sysname-match=3Dsdb
>     >     >         >
>     >     >         >     if an osd is managing /dev/sdb. Does that mou=
nt the osd ? It would also be useful to have the output of ls -l /dev/dis=
k/by-partuuid
>     >     >         >
>     >     >         >     Cheers
>     >     >         >
>     >     >         >     --
>     >     >         >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >     >         >
>     >     >         >
>     >     >
>     >     >         --
>     >     >         Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >     >
>     >     >
>     >     >
>     >
>     >     --
>     >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >
>     >
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--oPFrkdOuJjoAr0aA3qbNQVXoVPKotwmMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUk7X8ACgkQ8dLMyEl6F22cDQCgw8vpvpQA8dNz45tSE2ej93em
TKYAnRb6rl/P+uYePm5qRsDJMixBbff+
=XfBw
-----END PGP SIGNATURE-----

--oPFrkdOuJjoAr0aA3qbNQVXoVPKotwmMN--
