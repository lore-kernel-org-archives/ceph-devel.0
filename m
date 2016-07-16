From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: bluestore bug#15724: bluefs _replay file with link count 0:
Date: Sat, 16 Jul 2016 07:23:33 +0000
Message-ID: <BLUPR0201MB19080519FE7AA5404334B652E2340@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <D3AEB014.B72CE%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:23744
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751017AbcGPHis convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jul 2016 03:38:48 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevan Rehm <krehm@cray.com>, "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

On Saturday 16 July 2016 01:52 AM, Kevan Rehm wrote:
> Greetings,
>
> I have made a bit of progress.  Still looking for ideas/advise while I
> keep digging.
>
> First, the ceph version I forgot to mention last time.
>
> # ceph -v
> ceph version 11.0.0-196-g85bb43e (85bb43e111692989d2296a389ce45377d2297d6f)
>
>
>
> As a refresher, here is the beginning of the problem transaction which
> will result in an inode with 0 links.   There are actually three inodes in
> this transaction which will all end up having 0 links, inodes 109, 102,
> and 113.
>
> 2016-07-13 16:03:03.929679 7fb6617c1800 10 bluefs _replay 0x5be000:
> txn(seq 77752 len 35269 crc 1796157826)
> 2016-07-13 16:03:03.929681 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_dir_unlink  db/000154.log
> 2016-07-13 16:03:03.929683 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_remove 109
> 2016-07-13 16:03:03.929684 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_dir_unlink  db/000153.log
> 2016-07-13 16:03:03.929685 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_remove 102
> 2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_dir_unlink  db/000151.log
> 2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_remove 113
> 2016-07-13 16:03:03.929687 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_dir_unlink  db/000150.log
> 2016-07-13 16:03:03.929688 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_remove 111
> 2016-07-13 16:03:03.929689 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_update  file(ino 113 size 71354938 mtime 2016-07-12
> 17:05:53.738683 bdev 1 extents
> [1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:931135488+20
> 97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:9604956
> 16+58720256])
> 2016-07-13 16:03:03.929693 7fb6617c1800 30 bluefs _get_file ino 113 =
> 0x7fb66aafc880 (new)
When _get_file() is called with a inode number, if the file is not found
in file_map
a new file is created and returned, hence that (new) in the log file.
These set of events
can happen in case of rename. You can see the same BlueFS::rename(). In
that case, we use the
same inode number.

> 2016-07-13 16:03:03.929695 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_update  file(ino 102 size 68557043 mtime 2016-07-12
> 17:05:54.615190 bdev 1 extents
> [1:78643200+1048576,1:191889408+1048576,1:197132288+1048576,1:202375168+209
> 7152,1:208666624+2097152,1:214958080+2097152,1:221249536+2097152,1:22754099
> 2+1048576,1:232783872+2097152,1:239075328+2097152,1:245366784+2097152,1:251
> 658240+2097152,1:257949696+1048576,1:263192576+2097152,1:269484032+2097152,
> 1:275775488+2097152,1:282066944+2097152,1:288358400+2097152,1:294649856+104
> 8576,1:299892736+2097152,1:306184192+2097152,1:312475648+2097152,1:31876710
> 4+1048576,1:324009984+2097152,1:330301440+2097152,1:336592896+2097152,1:342
> 884352+2097152,1:349175808+1048576,1:354418688+2097152,1:360710144+2097152,
> 1:367001600+1048576,1:372244480+1048576,1:377487360+2097152,1:383778816+104
> 8576,1:389021696+1048576,1:394264576+2097152,1:400556032+1048576,1:40579891
> 2+3145728,1:507510784+5242880])
> 2016-07-13 16:03:03.929702 7fb6617c1800 30 bluefs _get_file ino 102 =
> 0x7fb66aafbb90 (new)
> 2016-07-13 16:03:03.929703 7fb6617c1800 20 bluefs _replay 0x5be000:
> op_file_update  file(ino 109 size 64421913 mtime 2016-07-12
> 22:41:33.028030 bdev 1 extents
> [1:512753664+31457280,1:545259520+4194304,1:550502400+36700160])
> 2016-07-13 16:03:03.929705 7fb6617c1800 30 bluefs _get_file ino 109 =
> 0x7fb66aafbe60 (new)
> ...
>
>
> The prior transaction log entry for each of the three inodes was another
> op_file_update() call.  The only difference between the two updates for
> ino 133 was file size went from 71359362 -> 71354938, 4424 less bytes, all
> other fields are identical.
Are the extents same for both the events?
> 2016-07-13 16:03:03.925186 7fb6617c1800 20 bluefs _replay 0x5b4000:
> op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
> 17:05:53.738683 bdev 1 extents
> [1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:931135488+20
> 97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:9604956
> 16+58720256])
> 2016-07-13 16:03:03.925197 7fb6617c1800 30 bluefs _get_file ino 113 =
> 0x7fb66aafbb90
>
>
> Same story for inode 109, the file size changed from 71354939 -> 64421913,
> 6933026 less bytes, all other fields are identical.
>
> 2016-07-13 16:03:03.926101 7fb6617c1800 20 bluefs _replay 0x5ba000:
> op_file_update  file(ino 109 size 71354939 mtime 2016-07-12
> 22:41:33.028030 bdev 1 extents
> [1:512753664+31457280,1:545259520+4194304,1:550502400+36700160])
> 2016-07-13 16:03:03.926103 7fb6617c1800 30 bluefs _get_file ino 109 =
> 0x7fb66aafc910
>
>
>
>
>
> Same story for inode 102, the file size changed from 71359405 -> 68557043,
> 2802362 less bytes, all other fields are identical.
>
> 2016-07-13 16:03:03.926040 7fb6617c1800 20 bluefs _replay 0x5b9000:
> op_file_update  file(ino 102 size 71359405 mtime 2016-07-12
> 17:05:54.615190 bdev 1 extents
> [1:78643200+1048576,1:191889408+1048576,1:197132288+1048576,1:202375168+209
> 7152,1:208666624+2097152,1:214958080+2097152,1:221249536+2097152,1:22754099
> 2+1048576,1:232783872+2097152,1:239075328+2097152,1:245366784+2097152,1:251
> 658240+2097152,1:257949696+1048576,1:263192576+2097152,1:269484032+2097152,
> 1:275775488+2097152,1:282066944+2097152,1:288358400+2097152,1:294649856+104
> 8576,1:299892736+2097152,1:306184192+2097152,1:312475648+2097152,1:31876710
> 4+1048576,1:324009984+2097152,1:330301440+2097152,1:336592896+2097152,1:342
> 884352+2097152,1:349175808+1048576,1:354418688+2097152,1:360710144+2097152,
> 1:367001600+1048576,1:372244480+1048576,1:377487360+2097152,1:383778816+104
> 8576,1:389021696+1048576,1:394264576+2097152,1:400556032+1048576,1:40579891
> 2+3145728,1:507510784+5242880])
> 2016-07-13 16:03:03.926048 7fb6617c1800 30 bluefs _get_file ino 102 =
> 0x7fb66aafbe60
>
>
>
>
> There is only one caller of op_file_update() in which the size of the file
> is reduced but all other fields stay the same, that is
> BlueFS::_truncate(), which in turn is only called by BlueFS::truncate(),
> which is only called by BlueRocksWritableFile::Close().
>
> The op_dir_unlink() and op_file_remove() calls for each of the three
> inodes seem to be coming from BlueRocksEnv::DeleteFile(), but I'm having
> difficulty finding where the call is coming from.
Any syscall making dir rename or file remove or directory remove will
result in BlueFS::rename or unlink
or corresponding calls and results in op_dir_* or op_file_* operations.
rocksdb wal_manager or compaction
can trigger these calls during that process. Will take a closer look at
the logs, if i can get something from them.
>
> So the problem appears to be that the file is first deleted, then it is
> closed, and a byproduct of the close operation  on a stale fnode is that
> another op_file_update() entry gets logged, recreating the deleted inode
> with a stale fnode, resulting in the 0 links failure.
Once the file is deleted, all the underlying extents will be cleared.
Until and unless there is race in handling on
the files from application level, Bluefs doesn't have any control over
them. If the a file(handle) is been reused after
deletion, that seems to be a bug. Will take a look at the logs to
confirm your theory.
But here, this seems to be more of rename use case. one more thing to
verify is the extents owned by the inodes mentioned.

Varada
>
> Kevan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
