From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Anybody else hitting this panic in latest master with bluestore?
Date: Sun, 10 Jul 2016 14:52:20 +0000
Message-ID: <BL2PR02MB211585B97DE77391D9FCC7C7F43E0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB1820F45DA0E891966F2CBC42855D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
 <alpine.DEB.2.11.1606070903500.6221@cpach.fuggernut.com>
 <BL2PR02MB2115DE873C6CC9FCC0C3454CF45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3c72bdf4-cdfc-42f6-e73f-e0100958b103@redhat.com>
 <BL2PR02MB2115E130DCA950ED976C4C47F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB211574EA5B952C1141E06A81F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <CY1PR0201MB1820E102714DC4B1CF3CF4F6855E0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115099D5A4ADB0D84C0510CF45E0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <D3A7BBBD.B42A5%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0080.outbound.protection.outlook.com ([104.47.33.80]:24640
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752012AbcGJPIZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Jul 2016 11:08:25 -0400
In-Reply-To: <D3A7BBBD.B42A5%krehm@cray.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevan Rehm <krehm@cray.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Kevan for confirming this.
After I properly reformatted the drives, I didn't hit the issue, so, di=
dn't bother chasing it.
Ramesh,
Could you please look into this ?

Regards
Somnath

-----Original Message-----
=46rom: Kevan Rehm [mailto:krehm@cray.com]
Sent: Sunday, July 10, 2016 6:53 AM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Anybody else hitting this panic in latest master with blue=
store?

Somnath,

I hit this same bug while testing bluestore with a PMEM device, ceph-de=
ploy created a partition whose size did not fall on a 4096-byte
boundary.

I opened ceph issue 16644 to document the problem, see the issue for a =
3-line patch I proposed that fixes it.

Kevan


On 6/8/16, 2:14 AM, "ceph-devel-owner@vger.kernel.org on behalf of Somn=
ath Roy" <ceph-devel-owner@vger.kernel.org on behalf of Somnath.Roy@san=
disk.com> wrote:

>Try to format a device with 512 sector size. I will revert back the
>same device to 512 sector tomorrow and see if I can still reproduce.
>Here is the verbose log I collected, see if that helps.
>
>2016-06-07 13:32:25.431373 7fce0cee28c0 10 stupidalloc commit_start
>releasing 0 in extents 0
>2016-06-07 13:32:25.431580 7fce0cee28c0 10 stupidalloc commit_finish
>released 0 in extents 0
>2016-06-07 13:32:25.431733 7fce0cee28c0 10 stupidalloc reserve need
>1048576 num_free 306824863744 num_reserved 0
>2016-06-07 13:32:25.431743 7fce0cee28c0 10 stupidalloc allocate
>want_size
>1048576 alloc_unit 1048576 hint 0
>2016-06-07 13:32:25.435021 7fce0cee28c0  4 rocksdb: DB pointer
>0x7fce08909200
>2016-06-07 13:32:25.435049 7fce0cee28c0  1
>bluestore(/var/lib/ceph/osd/ceph-15) _open_db opened rocksdb path db
>options
>compression=3DkNoCompression,max_write_buffer_number=3D16,min_write_bu=
ffer_
>num
>ber_to_merge=3D3,recycle_log_file_num=3D16
>2016-06-07 13:32:25.435057 7fce0cee28c0 20
>bluestore(/var/lib/ceph/osd/ceph-15) _open_fm initializing freespace
>2016-06-07 13:32:25.435066 7fce0cee28c0 10 freelist _init_misc
>bytes_per_key 0x80000, key_mask 0xfffffffffff80000
>2016-06-07 13:32:25.435074 7fce0cee28c0 10 freelist create rounding
>blocks up from 0x6f9fd151e00 to 0x6f9fd180000 (0x6f9fd180 blocks)
>2016-06-07 13:32:25.438853 7fce0cee28c0 -1
>os/bluestore/BitmapFreelistManager.cc: In function 'void
>BitmapFreelistManager::_xor(uint64_t, uint64_t, KeyValueDB::Transactio=
n)'
>thread 7fce0cee28c0 time 2016-06-07 13:32:25.435087
>os/bluestore/BitmapFreelistManager.cc: 477: FAILED assert((offset &
>block_mask) =3D=3D offset)
>
> ceph version 10.2.0-2021-g55cb608
>(55cb608f63787f7969514ad0d7222da68ab84d88)
> 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>const*)+0x80) [0x562bdda880a0]
> 2: (BitmapFreelistManager::_xor(unsigned long, unsigned long,
>std::shared_ptr<KeyValueDB::TransactionImpl>)+0x12ed) [0x562bdd75a96d]
> 3: (BitmapFreelistManager::create(unsigned long,
>std::shared_ptr<KeyValueDB::TransactionImpl>)+0x33f) [0x562bdd75b34f]
> 4: (BlueStore::_open_fm(bool)+0xcd3) [0x562bdd641683]
> 5: (BlueStore::mkfs()+0x8b9) [0x562bdd6839b9]
> 6: (OSD::mkfs(CephContext*, ObjectStore*,
>std::__cxx11::basic_string<char, std::char_traits<char>,
>std::allocator<char> > const&, uuid_d, int)+0x117) [0x562bdd3226c7]
> 7: (main()+0x1003) [0x562bdd2b4533]
> 8: (__libc_start_main()+0xf0) [0x7fce09946830]
> 9: (_start()+0x29) [0x562bdd3038b9]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>needed to interpret this.
>
>Thanks & Regards
>Somnath
>
>
>-----Original Message-----
>From: Ramesh Chander
>Sent: Tuesday, June 07, 2016 11:01 PM
>To: Somnath Roy; Mark Nelson; Sage Weil
>Cc: ceph-devel
>Subject: RE: Anybody else hitting this panic in latest master with
>bluestore?
>
>Hi Somnath,
>
>I think setting 4k block size is done intentionally.
>
>127
>128   // Operate as though the block size is 4 KB.  The backing file
>129   // blksize doesn't strictly matter except that some file systems=
 may
>130   // require a read/modify/write if we write something smaller tha=
n
>131   // it.
>132   block_size =3D g_conf->bdev_block_size;
>133   if (block_size !=3D (unsigned)st.st_blksize) {
>134     dout(1) << __func__ << " backing device/file reports st_blksiz=
e "
>135       << st.st_blksize << ", using bdev_block_size "
>136       << block_size << " anyway" << dendl;
>137   }
>138
>
>Other than more fragmentation we should not see any issue by taking
>block size as 4k instead of 512. At least I am not aware of.
>
>How to reproduce it? I can have a look.
>
>-Ramesh
>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Wednesday, June 08, 2016 5:04 AM
>> To: Somnath Roy; Mark Nelson; Sage Weil
>> Cc: Ramesh Chander; ceph-devel
>> Subject: RE: Anybody else hitting this panic in latest master with
>>bluestore?
>>
>> Ok , I think I found out what is happening in my environment. This
>>drive is formatted with 512 logical block size.
>> BitMap allocator is by default is working with 4K block size and the
>>calculation is breaking (?). I have reformatted the device with 4K an=
d
>>it worked fine.
>> I don't think taking this logical block size parameter as user input
>>may not be *wise*.
>> Since OS needs that all devices is advertising the correct logical
>>block size here.
>>
>> /sys/block/sdb/queue/logical_block_size
>>
>> Allocator needs to read the correct size from the above location.
>> Sage/Ramesh ?
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Tuesday, June 07, 2016 1:12 PM
>> To: Mark Nelson; Sage Weil
>> Cc: Ramesh Chander; ceph-devel
>> Subject: RE: Anybody else hitting this panic in latest master with
>>bluestore?
>>
>> Mark/Sage,
>> That problem seems to be gone. BTW, rocksdb folder is not cleaned
>> with 'make clean'. I took latest master and manually clean rocksdb
>> folder as you suggested..
>> But, now I am hitting the following crash in some of my drives. It
>> seems to be related to block alignment.
>>
>>      0> 2016-06-07 11:50:12.353375 7f5c0fe938c0 -1
>> os/bluestore/BitmapFreelistManager.cc: In function 'void
>>BitmapFreelistManager::_xor(uint64_t, uint64_t,
>>KeyValueDB::Transaction)'
>> thread 7f5c0fe938c0 time 2016-06-07 11:50:12.349722
>> os/bluestore/BitmapFreelistManager.cc: 477: FAILED assert((offset &
>> block_mask) =3D=3D offset)
>>
>>  ceph version 10.2.0-2021-g55cb608
>> (55cb608f63787f7969514ad0d7222da68ab84d88)
>>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x80) [0x5652219dd0a0]
>>  2: (BitmapFreelistManager::_xor(unsigned long, unsigned long,
>> std::shared_ptr<KeyValueDB::TransactionImpl>)+0x12ed)
>> [0x5652216af96d]
>>  3: (BitmapFreelistManager::create(unsigned long,
>> std::shared_ptr<KeyValueDB::TransactionImpl>)+0x33f) [0x5652216b034f=
]
>>  4: (BlueStore::_open_fm(bool)+0xcd3) [0x565221596683]
>>  5: (BlueStore::mkfs()+0x8b9) [0x5652215d89b9]
>>  6: (OSD::mkfs(CephContext*, ObjectStore*,
>> std::__cxx11::basic_string<char, std::char_traits<char>,
>> std::allocator<char>
>> > const&, uuid_d, int)+0x117) [0x5652212776c7]
>>  7: (main()+0x1003) [0x565221209533]
>>  8: (__libc_start_main()+0xf0) [0x7f5c0c8f7830]
>>  9: (_start()+0x29) [0x5652212588b9]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> Here is my disk partitions..
>>
>> Osd.15 on /dev/sdi crashed..
>>
>>
>> sdi       8:128  0     7T  0 disk
>> =86=80sdi1    8:129  0    10G  0 part /var/lib/ceph/osd/ceph-15
>> =84=80sdi2    8:130  0     7T  0 part
>> nvme0n1 259:0    0  15.4G  0 disk
>> root@emsnode11:~/ceph-master/src# fdisk /dev/sdi
>>
>> Welcome to fdisk (util-linux 2.27.1).
>> Changes will remain in memory only, until you decide to write them.
>> Be careful before using the write command.
>>
>>
>> Command (m for help): p
>> Disk /dev/sdi: 7 TiB, 7681501126656 bytes, 15002931888 sectors
>> Units: sectors of 1 * 512 =3D 512 bytes Sector size (logical/physica=
l):
>> 512 bytes / 16384 bytes I/O size
>> (minimum/optimal): 16384 bytes / 16384 bytes Disklabel type: gpt Dis=
k
>> identifier: 4A3182B9-23EA-441A-A113-FE904E81BF3E
>>
>> Device        Start         End     Sectors Size Type
>> /dev/sdi1      2048    20973567    20971520  10G Linux filesystem
>> /dev/sdi2  20973568 15002931854 14981958287   7T Linux filesystem
>>
>> Seems to be aligned properly , what alignment bitmap allocator is
>> looking for (Ramesh ?).
>> I will debug further and update.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Tuesday, June 07, 2016 11:06 AM
>> To: 'Mark Nelson'; Sage Weil
>> Cc: Ramesh Chander; ceph-devel
>> Subject: RE: Anybody else hitting this panic in latest master with
>>bluestore?
>>
>> I will try now and let you know.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, June 07, 2016 10:57 AM
>> To: Somnath Roy; Sage Weil
>> Cc: Ramesh Chander; ceph-devel
>> Subject: Re: Anybody else hitting this panic in latest master with
>>bluestore?
>>
>> Hi Somnath,
>>
>> Did Sage's suggestion fix it for you?  In my tests rocksdb wasn't
>> building properly after an upstream commit to detect when jemalloc
>> isn't
>> present:
>>
>> https://github.com/facebook/rocksdb/commit/0850bc514737a64dc8ca13de8
>> 510fcad4756616a
>>
>> I've submitted a fix that is now in master.  If you clean the rocksd=
b
>>folder and try again with current master I believe it should work for
>>you.
>>
>> Thanks,
>> Mark
>>
>> On 06/07/2016 09:23 AM, Somnath Roy wrote:
>> > Sage,
>> > I did a global 'make clean' before build, isn't that sufficient ?
>> > Still need to go
>> to rocksdb folder and clean ?
>> >
>> >
>> > -----Original Message-----
>> > From: Sage Weil [mailto:sage@newdream.net]
>> > Sent: Tuesday, June 07, 2016 6:06 AM
>> > To: Mark Nelson
>> > Cc: Somnath Roy; Ramesh Chander; ceph-devel
>> > Subject: Re: Anybody else hitting this panic in latest master with
>>bluestore?
>> >
>> > On Tue, 7 Jun 2016, Mark Nelson wrote:
>> >> I believe this is due to the rocksdb submodule update in PR #9466=
=2E
>> >> I'm working on tracking down the commit in rocksdb that's causing=
 it.
>> >
>> > Is it possible that the problem is that your build *didn't* update
>>rocksdb?
>> >
>> > The ceph makefile isn't smart enough to notice changes in the
>> > rocksdb/ dir
>> and rebuild.  You have to 'cd rocksdb ; make clean ; cd ..' after th=
e
>> submodule updates to get a fresh build.
>> >
>> > Maybe you didn't do that, and some of the ceph code is build using
>> > the
>> new headers and data structures that don't match the previously
>> compiled rocksdb code?
>> >
>> > sage
>> > PLEASE NOTE: The information contained in this electronic mail
>> > message is
>> intended only for the use of the designated recipient(s) named above=
=2E
>> If the reader of this message is not the intended recipient, you are
>> hereby notified that you have received this message in error and tha=
t
>> any review, dissemination, distribution, or copying of this message
>> is strictly prohibited. If you have received this communication in
>> error, please notify the sender by telephone or e-mail (as shown
>> above) immediately and destroy any and all copies of this message in
>> your possession (whether hard copies or electronically stored copies=
).
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
>PLEASE NOTE: The information contained in this electronic mail message
>is intended only for the use of the designated recipient(s) named
>above. If the reader of this message is not the intended recipient, yo=
u
>are hereby notified that you have received this message in error and
>that any review, dissemination, distribution, or copying of this
>message is strictly prohibited. If you have received this communicatio=
n
>in error, please notify the sender by telephone or e-mail (as shown
>above) immediately and destroy any and all copies of this message in
>your possession (whether hard copies or electronically stored copies).
>--
>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>in the body of a message to majordomo@vger.kernel.org More majordomo
>info at  http://vger.kernel.org/majordomo-info.html

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
