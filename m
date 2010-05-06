From: Andreas Grimm <agrimm61@gmail.com>
Subject: Re: Error creating filesystem
Date: Thu, 6 May 2010 14:50:32 +0200
Message-ID: <j2pcf40c6a91005060550k66d714f6ub6e3dc0b59a1803d@mail.gmail.com>
References: <4BE2B8C6.6050006@embl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:15470 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012Ab0EFMue convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 May 2010 08:50:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so348116fga.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 May 2010 05:50:32 -0700 (PDT)
In-Reply-To: <4BE2B8C6.6050006@embl.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Cc: ceph-devel@vger.kernel.org

Hi,

your journal file should either be a block device, or you have to set
the journal size in the [osd] section in ceph.conf:

	osd journal size =3D 100

Creation sould run flawlessly then.

Andreas

2010/5/6 Micka=EBl Can=E9vet <canevet@embl.fr>:
> Hi,
>
> I have an error creating filesystem with ceph 0.20 installed in 2 nod=
es in
> 64bits Debian squeeze:
>
> ~# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
> /usr/bin/monmaptool --create --clobber --add 172.26.15.234:6789 --pri=
nt
> /tmp/monmap.1644
> /usr/bin/monmaptool: monmap file /tmp/monmap.1644
> /usr/bin/monmaptool: generated fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65deb=
ea1
> epoch 1
> fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65debea1
> last_changed 10.05.06 14:34:27.663460
> created 10.05.06 14:34:27.663460
> =A0 =A0mon0 172.26.15.234:6789/0
> /usr/bin/monmaptool: writing epoch 1 to /tmp/monmap.1644 (1 monitors)
> max osd in /etc/ceph/ceph.conf is 1, num osd is 2
> /usr/bin/osdmaptool: osdmap file '/tmp/osdmap.1644'
> /usr/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.1644
> Building admin keyring at /tmp/admin.keyring.1644
> creating /tmp/admin.keyring.1644
> Building monitor keyring with all service keys
> creating /tmp/monkeyring.1644
> importing contents of /tmp/admin.keyring.1644 into /tmp/monkeyring.16=
44
> creating /tmp/keyring.mds.pc234
> importing contents of /tmp/keyring.mds.pc234 into /tmp/monkeyring.164=
4
> creating /tmp/keyring.mds.pc238
> importing contents of /tmp/keyring.mds.pc238 into /tmp/monkeyring.164=
4
> creating /tmp/keyring.osd.0
> importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.1644
> creating /tmp/keyring.osd.1
> importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.1644
> =3D=3D=3D mon0 =3D=3D=3D
> The authenticity of host 'pc234 (172.26.15.234)' can't be established=
=2E
> RSA key fingerprint is 38:4b:fe:76:3e:fb:9a:07:a8:2b:77:c5:78:57:e6:f=
1.
> Are you sure you want to continue connecting (yes/no)? yes
> 10.05.06 14:34:30.220850 7f55fbcaa710 store(/data/mon0) mkfs
> 10.05.06 14:34:30.220994 7f55fbcaa710 store(/data/mon0) test -d /data=
/mon0
> && /bin/rm -rf /data/mon0 ; mkdir -p /data/mon0
> 10.05.06 14:34:30.234028 7f55fbcaa710 mon0(starting).class v0 create_=
initial
> -- creating initial map
> 10.05.06 14:34:30.237482 7f55fbcaa710 mon0(starting).auth v0 create_i=
nitial
> -- creating initial map
> 10.05.06 14:34:30.237496 7f55fbcaa710 mon0(starting).auth v0 reading =
initial
> keyring
> /usr/bin/mkmonfs: created monfs at /data/mon0 for mon0
> admin.keyring.1644
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 100% =A0123 =A0 =A0 0.1KB/s =A0=
 00:00
> =3D=3D=3D mds.pc234 =3D=3D=3D
> keyring.mds.pc234
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0100% =A0125 =A0 =A0 0.1KB/=
s =A0 00:00
> =3D=3D=3D mds.pc238 =3D=3D=3D
> `/tmp/keyring.mds.pc238' -> `/data/keyring.mds.pc238'
> =3D=3D=3D osd0 =3D=3D=3D
> umount: /data/osd0: not mounted
> umount: /dev/sdb: not mounted
>
> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
> WARNING! - see http://btrfs.wiki.kernel.org before using
>
> fs created label (null) on /dev/sdb
> =A0 =A0nodesize 4096 leafsize 4096 sectorsize 4096 size 149.05GB
> Btrfs Btrfs v0.19
> Scanning for Btrfs filesystems
> failed to read /dev/hda
> monmap.1644
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0100% =A0187 =A0 =A0 0.2KB/=
s =A0 00:00
> =A0** WARNING: Ceph is still under heavy development, and is only sui=
table for
> **
> =A0** =A0 =A0 =A0 =A0 =A0testing and review. =A0Do not trust it with =
important data.
> **
> os/FileJournal.cc: In function 'int FileJournal::_open(bool, bool)':
> os/FileJournal.cc:74: FAILED assert(r =3D=3D 0)
> =A01: (FileJournal::create()+0x7e) [0x553f9e]
> =A02: (FileStore::mkjournal()+0x74) [0x53f9e4]
> =A03: (FileStore::mkfs()+0x64c) [0x53b67c]
> =A04: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x40) [0x4=
c25a0]
> =A05: (main()+0x3a9) [0x455af9]
> =A06: (__libc_start_main()+0xfd) [0x7f6be70e4abd]
> =A07: /usr/bin/cosd [0x455579]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to
> interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion=
*'
> bash: line 1: =A02924 Aborted =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (core d=
umped) /usr/bin/cosd -c
> /etc/ceph/ceph.conf --monmap /tmp/monmap.1644 -i 0 --mkfs --osd-data
> /data/osd0
> failed: 'ssh pc234 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
> /tmp/monmap.1644 -i 0 --mkfs --osd-data /data/osd0'
>
>
> FYI my ceph.conf:
>
> [global]
> =A0 =A0auth supported =3D cephx
>
> [mon]
> =A0 =A0mon data =3D /data/mon$id
> =A0 =A0debug ms =3D 1
>
> [mon0]
> =A0 =A0host =3D pc234
> =A0 =A0mon addr =3D 172.26.15.234:6789
>
> [mds]
> =A0 =A0keyring =3D /data/keyring.$name
>
> [mds.pc234]
> =A0 =A0host =3D pc234
>
> [mds.pc238]
> =A0 =A0host =3D pc238
>
> [osd]
> =A0 =A0osd data =3D /data/osd$id
> =A0 =A0osd journal =3D /data/osd$id/journal
>
> [osd0]
> =A0 =A0host =3D pc234
> =A0 =A0btrfs devs =3D /dev/sdb
>
> [osd1]
> =A0 =A0host =3D pc238
> =A0 =A0btrfs devs =3D /dev/sdb
>
>
>
>
>
> Did I make something wrong ?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
