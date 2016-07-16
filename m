From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: BlueFS replay crash
Date: Sat, 16 Jul 2016 07:36:35 +0000
Message-ID: <BLUPR0201MB190866FB19721A9A4AAFDEB8E2340@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <BL2PR02MB21153CF4871AAA4853FD4519F4330@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0063.outbound.protection.outlook.com ([104.47.40.63]:30621
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751017AbcGPHwI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jul 2016 03:52:08 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Saturday 16 July 2016 12:34 AM, Somnath Roy wrote:
> Hi,
> I saw Kevan posted one BlueFS replay crash. I got the following  crashes as well.
>
> 1.
>
> 2016-07-13 19:56:59.337657 7f9129f4c8c0 10 bluefs _replay 0x3b5000: txn(seq 270930 len 747 crc 2840798231)
> 2016-07-13 19:56:59.337658 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_dir_link  db/002480.log to 209
> 2016-07-13 19:56:59.337660 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_dir_unlink  db/002463.log
> 2016-07-13 19:56:59.337662 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_file_update  file(ino 209 size 69631170 mtime 2016-07-13 19:21:10.878229 bdev 1 extents [1:873463808+1048576,1:878706688+6291456,1:889192448+7340032,1:900726784+7340032,1:912261120+6291456,1:922746880+6291456,1:933232640+6291456,1:943718400+6291456,1:954204160+7340032,1:965738496+7340032,1:977272832+6291456,1:565182464+1048576,1:852492288+1048576])
> 2016-07-13 19:56:59.337667 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_file_update  file(ino 326 size 0 mtime 2016-07-13 19:21:10.884038 bdev 1 extents [])
> 2016-07-13 19:56:59.337669 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_dir_link  db/002481.sst to 326
> 2016-07-13 19:56:59.337672 7f9129f4c8c0 20 bluefs _replay 0x3b5000:  op_file_update  file(ino 208 size 70553038 mtime 2016-07-13 19:21:10.894347 bdev 1 extents [1:759169024+2097152,1:765460480+6291456,1:775946240+5242880,1:785383424+5242880,1:794820608+5242880,1:804257792+6291456,1:814743552+6291456,1:825229312+6291456,1:835715072+6291456,1:846200832+6291456,1:856686592+6291456,1:867172352+6291456,1:1176502272+1048576,1:2151677952+1048576,1:1008730112+1048576])
> 2016-07-13 19:56:59.337677 7f9129f4c8c0 10 bluefs _read h 0x7f911c76f900 0x3b6000~1000 from file(ino 1 size 3891200 mtime 2016-07-13 18:33:55.376787 bdev 0 extents [1:1959788544+5242880])
> 2016-07-13 19:56:59.337679 7f9129f4c8c0 20 bluefs _read left 0xae000 len 0x1000
> 2016-07-13 19:56:59.337680 7f9129f4c8c0 20 bluefs _read got 4096
> 2016-07-13 19:56:59.337681 7f9129f4c8c0 20 bluefs _replay need 0x222000 more bytes
> 2016-07-13 19:56:59.337682 7f9129f4c8c0 10 bluefs _read h 0x7f911c76f900 0x3b7000~222000 from file(ino 1 size 3891200 mtime 2016-07-13 18:33:55.376787 bdev 0 extents [1:1959788544+5242880])
> 2016-07-13 19:56:59.337684 7f9129f4c8c0 20 bluefs _read left 0xad000 len 0x222000
> 2016-07-13 19:56:59.337685 7f9129f4c8c0 20 bluefs _read fetching 0x464000~9c000 of 1:1959788544+5242880
> 2016-07-13 19:56:59.340345 7f9129f4c8c0 20 bluefs _read left 0x9c000 len 0x175000
> 2016-07-13 19:56:59.340352 7f9129f4c8c0 20 bluefs _read fetching 0x0~100000 of 1:27262976+1048576
> 2016-07-13 19:56:59.344877 7f9129f4c8c0 20 bluefs _read left 0x100000 len 0xd9000
> 2016-07-13 19:56:59.344884 7f9129f4c8c0 20 bluefs _read got 2236416
> 2016-07-13 19:56:59.345114 7f9129f4c8c0 10 bluefs _replay 0x3b6000: stop: failed to decode: buffer::malformed_input: bad crc 4138539261 expected 1696071758
> 2016-07-13 19:56:59.345316 7f9129f4c8c0 -1 bluefs mount failed to replay log: (5) Input/output error
> 2016-07-13 19:56:59.345328 7f9129f4c8c0 20 bluefs _stop_alloc
> 2016-07-13 19:56:59.345329 7f9129f4c8c0 10 bitmapalloc:shutdown instance 140261373307904
> 2016-07-13 19:56:59.345365 7f9129f4c8c0 10 bitmapalloc:shutdown instance 140261375828352
> 2016-07-13 19:56:59.346760 7f9129f4c8c0 -1 bluestore(/var/lib/ceph/osd/ceph-0) _open_db failed bluefs mount: (5) Input/output error
Here it seems we are trying to read 2MB chunk and we got a bad buffer.
>
> It seems a CRC corruption.
>
> 2.
>
>    -11> 2016-07-15 14:38:02.970072 7ff1e97d28c0 10 bluefs _replay 0x7a6000: txn(seq 637318 len 196 crc 3042742039)
>    -10> 2016-07-15 14:38:02.970074 7ff1e97d28c0 20 bluefs _replay 0x7a6000:  op_file_update  file(ino 209 size 34845313 mtime 2016-07-14 21:25:16.439325 bdev 1 extents [1:401604608+2097152,1:411041792+4194304,1:425721856+4194304,1:430964736+4194304,1:443547648+4194304,1:449839104+4194304,1:462422016+3145728,1:2810183680+9437184])
>     -9> 2016-07-15 14:38:02.970078 7ff1e97d28c0 10 bluefs _read h 0x7ff1dbf6f980 0x7a7000~1000 from file(ino 1 size 8024064 mtime 0.000000 bdev 0 extents [1:2596274176+5242880,1:718274560+4194304])
>     -8> 2016-07-15 14:38:02.970080 7ff1e97d28c0 20 bluefs _read left 0x59000 len 0x1000
>     -7> 2016-07-15 14:38:02.970081 7ff1e97d28c0 20 bluefs _read got 4096
>     -6> 2016-07-15 14:38:02.970081 7ff1e97d28c0 20 bluefs _replay need 0x16b000 more bytes
>     -5> 2016-07-15 14:38:02.970082 7ff1e97d28c0 10 bluefs _read h 0x7ff1dbf6f980 0x7a8000~16b000 from file(ino 1 size 8024064 mtime 0.000000 bdev 0 extents [1:2596274176+5242880,1:718274560+4194304])
>     -4> 2016-07-15 14:38:02.970084 7ff1e97d28c0 20 bluefs _read left 0x58000 len 0x16b000
>     -3> 2016-07-15 14:38:02.970085 7ff1e97d28c0 20 bluefs _read fetching 0x300000~100000 of 1:718274560+4194304
>     -2> 2016-07-15 14:38:02.974516 7ff1e97d28c0 20 bluefs _read left 0x100000 len 0x113000
>     -1> 2016-07-15 14:38:02.974522 7ff1e97d28c0 20 bluefs _read fetching 0x0~100000 of 32767:140676754260320+166967120
>      0> 2016-07-15 14:38:02.976794 7ff1e97d28c0 -1 *** Caught signal (Segmentation fault) **
>  in thread 7ff1e97d28c0 thread_name:ceph-osd
This seems something wrong. we trying to read from -1 device? and extent
and offset values seems to be wrong. Is it the second retry of replay?
>
>  ceph version 11.0.0-536-g8df0c5b (8df0c5bcd90d80e9b309b2a9007b778f7b829edf)
>  1: (()+0x9d6bee) [0x558bcd107bee]
>  2: (()+0x113d0) [0x7ff1e82ad3d0]
>  3: (BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, unsigned long, unsigned long, ceph::buffer::list*, char*)+0xcb9) [0x558bccefd019]
>  4: (BlueFS::_replay()+0x493) [0x558bccf0c3d3]
>  5: (BlueFS::mount()+0x1df) [0x558bccf0f68f]
>  6: (BlueStore::_open_db(bool)+0xc2d) [0x558bccdf6c5d]
>  7: (BlueStore::mount()+0x37d) [0x558bcce1a30d]
>  8: (OSD::init()+0x266) [0x558bccae5986]
>  9: (main()+0x2fd8) [0x558bcca48d18]
>  10: (__libc_start_main()+0xf0) [0x7ff1e601d830]
>  11: (_start()+0x29) [0x558bcca96169]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> This is more likely bluefs_extent_t is getting corrupted.
>
> As of now, I don't have fixed reproducible steps but will try to find out.
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

