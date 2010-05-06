From: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Subject: Re: Error creating filesystem
Date: Thu, 06 May 2010 15:16:35 +0200
Message-ID: <4BE2C133.6050109@embl.fr>
References: <4BE2B8C6.6050006@embl.fr> <j2pcf40c6a91005060550k66d714f6ub6e3dc0b59a1803d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from emblmta1.embl.fr ([193.49.43.176]:2092 "EHLO emblmta1.embl.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab0EFNQf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 09:16:35 -0400
In-Reply-To: <j2pcf40c6a91005060550k66d714f6ub6e3dc0b59a1803d@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Grimm <agrimm61@gmail.com>
Cc: ceph-devel@vger.kernel.org

Thanks,

Now another question, is the ceph-kclient 0.19.1 compatible with ceph=20
0.20, or do I have to use latest 2.6.34rc kernel ?

ceph-kclient 0.19.1 completely froze my pc...

On 06/05/10 14:50, Andreas Grimm wrote:
> Hi,
>
> your journal file should either be a block device, or you have to set
> the journal size in the [osd] section in ceph.conf:
>
> 	osd journal size =3D 100
>
> Creation sould run flawlessly then.
>
> Andreas
>
> 2010/5/6 Micka=EBl Can=E9vet<canevet@embl.fr>:
>   =20
>> Hi,
>>
>> I have an error creating filesystem with ceph 0.20 installed in 2 no=
des in
>> 64bits Debian squeeze:
>>
>> ~# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
>> /usr/bin/monmaptool --create --clobber --add 172.26.15.234:6789 --pr=
int
>> /tmp/monmap.1644
>> /usr/bin/monmaptool: monmap file /tmp/monmap.1644
>> /usr/bin/monmaptool: generated fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65de=
bea1
>> epoch 1
>> fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65debea1
>> last_changed 10.05.06 14:34:27.663460
>> created 10.05.06 14:34:27.663460
>>     mon0 172.26.15.234:6789/0
>> /usr/bin/monmaptool: writing epoch 1 to /tmp/monmap.1644 (1 monitors=
)
>> max osd in /etc/ceph/ceph.conf is 1, num osd is 2
>> /usr/bin/osdmaptool: osdmap file '/tmp/osdmap.1644'
>> /usr/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.1644
>> Building admin keyring at /tmp/admin.keyring.1644
>> creating /tmp/admin.keyring.1644
>> Building monitor keyring with all service keys
>> creating /tmp/monkeyring.1644
>> importing contents of /tmp/admin.keyring.1644 into /tmp/monkeyring.1=
644
>> creating /tmp/keyring.mds.pc234
>> importing contents of /tmp/keyring.mds.pc234 into /tmp/monkeyring.16=
44
>> creating /tmp/keyring.mds.pc238
>> importing contents of /tmp/keyring.mds.pc238 into /tmp/monkeyring.16=
44
>> creating /tmp/keyring.osd.0
>> importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.1644
>> creating /tmp/keyring.osd.1
>> importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.1644
>> =3D=3D=3D mon0 =3D=3D=3D
>> The authenticity of host 'pc234 (172.26.15.234)' can't be establishe=
d.
>> RSA key fingerprint is 38:4b:fe:76:3e:fb:9a:07:a8:2b:77:c5:78:57:e6:=
f1.
>> Are you sure you want to continue connecting (yes/no)? yes
>> 10.05.06 14:34:30.220850 7f55fbcaa710 store(/data/mon0) mkfs
>> 10.05.06 14:34:30.220994 7f55fbcaa710 store(/data/mon0) test -d /dat=
a/mon0
>> &&  /bin/rm -rf /data/mon0 ; mkdir -p /data/mon0
>> 10.05.06 14:34:30.234028 7f55fbcaa710 mon0(starting).class v0 create=
_initial
>> -- creating initial map
>> 10.05.06 14:34:30.237482 7f55fbcaa710 mon0(starting).auth v0 create_=
initial
>> -- creating initial map
>> 10.05.06 14:34:30.237496 7f55fbcaa710 mon0(starting).auth v0 reading=
 initial
>> keyring
>> /usr/bin/mkmonfs: created monfs at /data/mon0 for mon0
>> admin.keyring.1644
>>
>>                      100%  123     0.1KB/s   00:00
>> =3D=3D=3D mds.pc234 =3D=3D=3D
>> keyring.mds.pc234
>>
>>                       100%  125     0.1KB/s   00:00
>> =3D=3D=3D mds.pc238 =3D=3D=3D
>> `/tmp/keyring.mds.pc238' ->  `/data/keyring.mds.pc238'
>> =3D=3D=3D osd0 =3D=3D=3D
>> umount: /data/osd0: not mounted
>> umount: /dev/sdb: not mounted
>>
>> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
>> WARNING! - see http://btrfs.wiki.kernel.org before using
>>
>> fs created label (null) on /dev/sdb
>>     nodesize 4096 leafsize 4096 sectorsize 4096 size 149.05GB
>> Btrfs Btrfs v0.19
>> Scanning for Btrfs filesystems
>> failed to read /dev/hda
>> monmap.1644
>>
>>                       100%  187     0.2KB/s   00:00
>>   ** WARNING: Ceph is still under heavy development, and is only sui=
table for
>> **
>>   **          testing and review.  Do not trust it with important da=
ta.
>> **
>> os/FileJournal.cc: In function 'int FileJournal::_open(bool, bool)':
>> os/FileJournal.cc:74: FAILED assert(r =3D=3D 0)
>>   1: (FileJournal::create()+0x7e) [0x553f9e]
>>   2: (FileStore::mkjournal()+0x74) [0x53f9e4]
>>   3: (FileStore::mkfs()+0x64c) [0x53b67c]
>>   4: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x40) [0x4=
c25a0]
>>   5: (main()+0x3a9) [0x455af9]
>>   6: (__libc_start_main()+0xfd) [0x7f6be70e4abd]
>>   7: /usr/bin/cosd [0x455579]
>>   NOTE: a copy of the executable, or `objdump -rdS<executable>` is n=
eeded to
>> interpret this.
>> terminate called after throwing an instance of 'ceph::FailedAssertio=
n*'
>> bash: line 1:  2924 Aborted                 (core dumped) /usr/bin/c=
osd -c
>> /etc/ceph/ceph.conf --monmap /tmp/monmap.1644 -i 0 --mkfs --osd-data
>> /data/osd0
>> failed: 'ssh pc234 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap
>> /tmp/monmap.1644 -i 0 --mkfs --osd-data /data/osd0'
>>
>>
>> FYI my ceph.conf:
>>
>> [global]
>>     auth supported =3D cephx
>>
>> [mon]
>>     mon data =3D /data/mon$id
>>     debug ms =3D 1
>>
>> [mon0]
>>     host =3D pc234
>>     mon addr =3D 172.26.15.234:6789
>>
>> [mds]
>>     keyring =3D /data/keyring.$name
>>
>> [mds.pc234]
>>     host =3D pc234
>>
>> [mds.pc238]
>>     host =3D pc238
>>
>> [osd]
>>     osd data =3D /data/osd$id
>>     osd journal =3D /data/osd$id/journal
>>
>> [osd0]
>>     host =3D pc234
>>     btrfs devs =3D /dev/sdb
>>
>> [osd1]
>>     host =3D pc238
>>     btrfs devs =3D /dev/sdb
>>
>>
>>
>>
>>
>> Did I make something wrong ?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     =20
>   =20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
