From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Anybody else hitting this panic in latest master with bluestore?
Date: Tue, 7 Jun 2016 20:12:24 +0000
Message-ID: <BL2PR02MB2115E130DCA950ED976C4C47F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB1820F45DA0E891966F2CBC42855D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
 <alpine.DEB.2.11.1606070903500.6221@cpach.fuggernut.com>
 <BL2PR02MB2115DE873C6CC9FCC0C3454CF45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3c72bdf4-cdfc-42f6-e73f-e0100958b103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0099.outbound.protection.outlook.com ([207.46.100.99]:53472
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1162053AbcFGUM2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 16:12:28 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Mark/Sage,
That problem seems to be gone. BTW, rocksdb folder is not cleaned with =
'make clean'. I took latest master and manually clean rocksdb folder as=
 you suggested..
But, now I am hitting the following crash in some of my drives. It seem=
s to be related to block alignment.

     0> 2016-06-07 11:50:12.353375 7f5c0fe938c0 -1 os/bluestore/BitmapF=
reelistManager.cc: In function 'void BitmapFreelistManager::_xor(uint64=
_t, uint64_t, KeyValueDB::Transaction)' thread 7f5c0fe938c0 time 2016-0=
6-07 11:50:12.349722
os/bluestore/BitmapFreelistManager.cc: 477: FAILED assert((offset & blo=
ck_mask) =3D=3D offset)

 ceph version 10.2.0-2021-g55cb608 (55cb608f63787f7969514ad0d7222da68ab=
84d88)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const=
*)+0x80) [0x5652219dd0a0]
 2: (BitmapFreelistManager::_xor(unsigned long, unsigned long, std::sha=
red_ptr<KeyValueDB::TransactionImpl>)+0x12ed) [0x5652216af96d]
 3: (BitmapFreelistManager::create(unsigned long, std::shared_ptr<KeyVa=
lueDB::TransactionImpl>)+0x33f) [0x5652216b034f]
 4: (BlueStore::_open_fm(bool)+0xcd3) [0x565221596683]
 5: (BlueStore::mkfs()+0x8b9) [0x5652215d89b9]
 6: (OSD::mkfs(CephContext*, ObjectStore*, std::__cxx11::basic_string<c=
har, std::char_traits<char>, std::allocator<char> > const&, uuid_d, int=
)+0x117) [0x5652212776c7]
 7: (main()+0x1003) [0x565221209533]
 8: (__libc_start_main()+0xf0) [0x7f5c0c8f7830]
 9: (_start()+0x29) [0x5652212588b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is need=
ed to interpret this.

Here is my disk partitions..

Osd.15 on /dev/sdi crashed..


sdi       8:128  0     7T  0 disk
=86=80sdi1    8:129  0    10G  0 part /var/lib/ceph/osd/ceph-15
=84=80sdi2    8:130  0     7T  0 part
nvme0n1 259:0    0  15.4G  0 disk
root@emsnode11:~/ceph-master/src# fdisk /dev/sdi

Welcome to fdisk (util-linux 2.27.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sdi: 7 TiB, 7681501126656 bytes, 15002931888 sectors
Units: sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 16384 bytes
I/O size (minimum/optimal): 16384 bytes / 16384 bytes
Disklabel type: gpt
Disk identifier: 4A3182B9-23EA-441A-A113-FE904E81BF3E

Device        Start         End     Sectors Size Type
/dev/sdi1      2048    20973567    20971520  10G Linux filesystem
/dev/sdi2  20973568 15002931854 14981958287   7T Linux filesystem

Seems to be aligned properly , what alignment bitmap allocator is looki=
ng for (Ramesh ?).
I will debug further and update.

Thanks & Regards
Somnath

-----Original Message-----
=46rom: Somnath Roy=20
Sent: Tuesday, June 07, 2016 11:06 AM
To: 'Mark Nelson'; Sage Weil
Cc: Ramesh Chander; ceph-devel
Subject: RE: Anybody else hitting this panic in latest master with blue=
store?

I will try now and let you know.

Thanks & Regards
Somnath

-----Original Message-----
=46rom: Mark Nelson [mailto:mnelson@redhat.com]=20
Sent: Tuesday, June 07, 2016 10:57 AM
To: Somnath Roy; Sage Weil
Cc: Ramesh Chander; ceph-devel
Subject: Re: Anybody else hitting this panic in latest master with blue=
store?

Hi Somnath,

Did Sage's suggestion fix it for you?  In my tests rocksdb wasn't build=
ing properly after an upstream commit to detect when jemalloc isn't
present:

https://github.com/facebook/rocksdb/commit/0850bc514737a64dc8ca13de8510=
fcad4756616a

I've submitted a fix that is now in master.  If you clean the rocksdb f=
older and try again with current master I believe it should work for yo=
u.

Thanks,
Mark

On 06/07/2016 09:23 AM, Somnath Roy wrote:
> Sage,
> I did a global 'make clean' before build, isn't that sufficient ? Sti=
ll need to go to rocksdb folder and clean ?
>
>
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Tuesday, June 07, 2016 6:06 AM
> To: Mark Nelson
> Cc: Somnath Roy; Ramesh Chander; ceph-devel
> Subject: Re: Anybody else hitting this panic in latest master with bl=
uestore?
>
> On Tue, 7 Jun 2016, Mark Nelson wrote:
>> I believe this is due to the rocksdb submodule update in PR #9466.
>> I'm working on tracking down the commit in rocksdb that's causing it=
=2E
>
> Is it possible that the problem is that your build *didn't* update ro=
cksdb?
>
> The ceph makefile isn't smart enough to notice changes in the rocksdb=
/ dir and rebuild.  You have to 'cd rocksdb ; make clean ; cd ..' after=
 the submodule updates to get a fresh build.
>
> Maybe you didn't do that, and some of the ceph code is build using th=
e new headers and data structures that don't match the previously compi=
led rocksdb code?
>
> sage
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
