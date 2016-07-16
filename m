From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: bluestore bug#15724: bluefs _replay file with link count 0:
Date: Sat, 16 Jul 2016 12:16:08 +0000
Message-ID: <BLUPR0201MB19080FAACCC0068828401BCAE2340@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <D3AEB014.B72CE%krehm@cray.com>
 <BLUPR0201MB19080519FE7AA5404334B652E2340@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <D3AF7C2F.B79C3%krehm@cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:61152
	"EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751679AbcGPMQR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jul 2016 08:16:17 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevan Rehm <krehm@cray.com>, "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

On Saturday 16 July 2016 04:53 PM, Kevan Rehm wrote:
> Varada, see below.
>
> On 7/16/16, 2:23 AM, "Varada Kari" <Varada.Kari@sandisk.com> wrote:
>
>> On Saturday 16 July 2016 01:52 AM, Kevan Rehm wrote:
>>> Greetings,
>>>
>>> I have made a bit of progress.  Still looking for ideas/advise while I
>>> keep digging.
>>>
>>> First, the ceph version I forgot to mention last time.
>>>
>>> # ceph -v
>>> ceph version 11.0.0-196-g85bb43e
>>> (85bb43e111692989d2296a389ce45377d2297d6f)
>>>
>>>
>>>
>>> As a refresher, here is the beginning of the problem transaction which
>>> will result in an inode with 0 links.   There are actually three inodes
>>> in
>>> this transaction which will all end up having 0 links, inodes 109, 102,
>>> and 113.
>>>
>>> 2016-07-13 16:03:03.929679 7fb6617c1800 10 bluefs _replay 0x5be000:
>>> txn(seq 77752 len 35269 crc 1796157826)
>>> 2016-07-13 16:03:03.929681 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_dir_unlink  db/000154.log
>>> 2016-07-13 16:03:03.929683 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_remove 109
>>> 2016-07-13 16:03:03.929684 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_dir_unlink  db/000153.log
>>> 2016-07-13 16:03:03.929685 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_remove 102
>>> 2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_dir_unlink  db/000151.log
>>> 2016-07-13 16:03:03.929686 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_remove 113
>>> 2016-07-13 16:03:03.929687 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_dir_unlink  db/000150.log
>>> 2016-07-13 16:03:03.929688 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_remove 111
>>> 2016-07-13 16:03:03.929689 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_update  file(ino 113 size 71354938 mtime 2016-07-12
>>> 17:05:53.738683 bdev 1 extents
>>>
>>> [1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:931135488+
>>> 20
>>>
>>> 97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96049
>>> 56
>>> 16+58720256])
>>> 2016-07-13 16:03:03.929693 7fb6617c1800 30 bluefs _get_file ino 113 =
>>> 0x7fb66aafc880 (new)
>> When _get_file() is called with a inode number, if the file is not found
>> in file_map
>> a new file is created and returned, hence that (new) in the log file.
>> These set of events
>> can happen in case of rename. You can see the same BlueFS::rename(). In
>> that case, we use the
>> same inode number.
>
> I'm not sure I understand, I do not believe this is a rename case.  For
> this to be a rename, there would have to be at least one op_dir_link()
> call for each op_dir_unlink() call in the sequence above.   The only code
> sequence I can find where an op_dir_unlink() and an op_file_remove()
> appear together without a corresponding op_dir_link() is when a file is
> being deleted.
>
> The (new) above makes my point exactly.  The op_file_remove() call above
> freed the block allocation for the inode and released the inode from the
> filemap, showing that the file->refs had to be zero at that time (routine
> _drop_link).   Yet the following op_file_update() call is performing a
> truncate on that same inode, which is not in the filemap.   So the caller
> has to be holding a file structure whose refs field is greater than zero.
> Which implies that the caller's file structure has to be stale.  The fact
> that the op_file_update file contents for inode 113 is exactly the same as
> the previous op_file_update contents prior to the op_file_remove(), except
> for a reduction in file size, proves I believe that the file struct used
> by the op_file_update() caller is stale.
>
>
>>> 2016-07-13 16:03:03.929695 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_update  file(ino 102 size 68557043 mtime 2016-07-12
>>> 17:05:54.615190 bdev 1 extents
>>>
>>> [1:78643200+1048576,1:191889408+1048576,1:197132288+1048576,1:202375168+2
>>> 09
>>>
>>> 7152,1:208666624+2097152,1:214958080+2097152,1:221249536+2097152,1:227540
>>> 99
>>>
>>> 2+1048576,1:232783872+2097152,1:239075328+2097152,1:245366784+2097152,1:2
>>> 51
>>>
>>> 658240+2097152,1:257949696+1048576,1:263192576+2097152,1:269484032+209715
>>> 2,
>>>
>>> 1:275775488+2097152,1:282066944+2097152,1:288358400+2097152,1:294649856+1
>>> 04
>>>
>>> 8576,1:299892736+2097152,1:306184192+2097152,1:312475648+2097152,1:318767
>>> 10
>>>
>>> 4+1048576,1:324009984+2097152,1:330301440+2097152,1:336592896+2097152,1:3
>>> 42
>>>
>>> 884352+2097152,1:349175808+1048576,1:354418688+2097152,1:360710144+209715
>>> 2,
>>>
>>> 1:367001600+1048576,1:372244480+1048576,1:377487360+2097152,1:383778816+1
>>> 04
>>>
>>> 8576,1:389021696+1048576,1:394264576+2097152,1:400556032+1048576,1:405798
>>> 91
>>> 2+3145728,1:507510784+5242880])
>>> 2016-07-13 16:03:03.929702 7fb6617c1800 30 bluefs _get_file ino 102 =
>>> 0x7fb66aafbb90 (new)
>>> 2016-07-13 16:03:03.929703 7fb6617c1800 20 bluefs _replay 0x5be000:
>>> op_file_update  file(ino 109 size 64421913 mtime 2016-07-12
>>> 22:41:33.028030 bdev 1 extents
>>> [1:512753664+31457280,1:545259520+4194304,1:550502400+36700160])
>>> 2016-07-13 16:03:03.929705 7fb6617c1800 30 bluefs _get_file ino 109 =
>>> 0x7fb66aafbe60 (new)
>>> ...
>>>
>>>
>>> The prior transaction log entry for each of the three inodes was another
>>> op_file_update() call.  The only difference between the two updates for
>>> ino 133 was file size went from 71359362 -> 71354938, 4424 less bytes,
>>> all
>>> other fields are identical.
>> Are the extents same for both the events?
>
> Yes, please compare this line with the one higher above in this email, you
> can see that only the file size is different.   That is true for all three
> of these inodes.
>
>>> 2016-07-13 16:03:03.925186 7fb6617c1800 20 bluefs _replay 0x5b4000:
>>> op_file_update  file(ino 113 size 71359362 mtime 2016-07-12
>>> 17:05:53.738683 bdev 1 extents
>>>
>>> [1:904921088+1048576,1:910163968+2097152,1:916455424+2097152,1:931135488+
>>> 20
>>>
>>> 97152,1:937426944+2097152,1:943718400+2097152,1:950009856+2097152,1:96049
>>> 56
>>> 16+58720256])
>>> 2016-07-13 16:03:03.925197 7fb6617c1800 30 bluefs _get_file ino 113 =
>>> 0x7fb66aafbb90
>>>
>>>
>>> Same story for inode 109, the file size changed from 71354939 ->
>>> 64421913,
>>> 6933026 less bytes, all other fields are identical.
>>>
>>> 2016-07-13 16:03:03.926101 7fb6617c1800 20 bluefs _replay 0x5ba000:
>>> op_file_update  file(ino 109 size 71354939 mtime 2016-07-12
>>> 22:41:33.028030 bdev 1 extents
>>> [1:512753664+31457280,1:545259520+4194304,1:550502400+36700160])
>>> 2016-07-13 16:03:03.926103 7fb6617c1800 30 bluefs _get_file ino 109 =
>>> 0x7fb66aafc910
>>>
>>>
>>>
>>>
>>>
>>> Same story for inode 102, the file size changed from 71359405 ->
>>> 68557043,
>>> 2802362 less bytes, all other fields are identical.
>>>
>>> 2016-07-13 16:03:03.926040 7fb6617c1800 20 bluefs _replay 0x5b9000:
>>> op_file_update  file(ino 102 size 71359405 mtime 2016-07-12
>>> 17:05:54.615190 bdev 1 extents
>>>
>>> [1:78643200+1048576,1:191889408+1048576,1:197132288+1048576,1:202375168+2
>>> 09
>>>
>>> 7152,1:208666624+2097152,1:214958080+2097152,1:221249536+2097152,1:227540
>>> 99
>>>
>>> 2+1048576,1:232783872+2097152,1:239075328+2097152,1:245366784+2097152,1:2
>>> 51
>>>
>>> 658240+2097152,1:257949696+1048576,1:263192576+2097152,1:269484032+209715
>>> 2,
>>>
>>> 1:275775488+2097152,1:282066944+2097152,1:288358400+2097152,1:294649856+1
>>> 04
>>>
>>> 8576,1:299892736+2097152,1:306184192+2097152,1:312475648+2097152,1:318767
>>> 10
>>>
>>> 4+1048576,1:324009984+2097152,1:330301440+2097152,1:336592896+2097152,1:3
>>> 42
>>>
>>> 884352+2097152,1:349175808+1048576,1:354418688+2097152,1:360710144+209715
>>> 2,
>>>
>>> 1:367001600+1048576,1:372244480+1048576,1:377487360+2097152,1:383778816+1
>>> 04
>>>
>>> 8576,1:389021696+1048576,1:394264576+2097152,1:400556032+1048576,1:405798
>>> 91
>>> 2+3145728,1:507510784+5242880])
>>> 2016-07-13 16:03:03.926048 7fb6617c1800 30 bluefs _get_file ino 102 =
>>> 0x7fb66aafbe60
>>>
>>>
>>>
>>>
>>> There is only one caller of op_file_update() in which the size of the
>>> file
>>> is reduced but all other fields stay the same, that is
>>> BlueFS::_truncate(), which in turn is only called by BlueFS::truncate(),
>>> which is only called by BlueRocksWritableFile::Close().
>>>
>>> The op_dir_unlink() and op_file_remove() calls for each of the three
>>> inodes seem to be coming from BlueRocksEnv::DeleteFile(), but I'm having
>>> difficulty finding where the call is coming from.
>> Any syscall making dir rename or file remove or directory remove will
>> result in BlueFS::rename or unlink
>> or corresponding calls and results in op_dir_* or op_file_* operations.
>> rocksdb wal_manager or compaction
>> can trigger these calls during that process. Will take a closer look at
>> the logs, if i can get something from them.
>>> So the problem appears to be that the file is first deleted, then it is
>>> closed, and a byproduct of the close operation  on a stale fnode is that
>>> another op_file_update() entry gets logged, recreating the deleted inode
>>> with a stale fnode, resulting in the 0 links failure.
>> Once the file is deleted, all the underlying extents will be cleared.
>> Until and unless there is race in handling on
>> the files from application level, Bluefs doesn't have any control over
>> them. If the a file(handle) is been reused after
>> deletion, that seems to be a bug. Will take a look at the logs to
>> confirm your theory.
>> But here, this seems to be more of rename use case. one more thing to
>> verify is the extents owned by the inodes mentioned.
>
> No, I don't believe this is a rename, see above.
>
> I'll note that every occurrence of this problem has been preceded by an
> OSD segfault.  And this problem is racy, if I increase debug logging for
> bluefs or bluestore, then the problem goes away.  I have 50+ bluestore
> segfaults and asserts in my cluster logs; I suspect many could be due to
> this problem, because the same range of blocks is being freed more than
> once.   If some other file should perform an allocation between the
> block-freeing in op_file_remove() and the second freeing in
> op_file_update(), then we could easily have multiple files with the same
> block allocation at the same time.
>
> I think this problem can be caught fairly easily, an assert could be added
> to _truncate().   The _truncate() routine is only called for files which
> are open, which means that the inode has to be in the filemap.   Code
> could be added at the front of _truncate() to look up the inode in the
> filemap, and if it is not there, then assert.   That would provide a stack
> trace showing the caller using the file struct with the stale reference
> count.   (It may be a few days before I have a chance to try this myself.)
Sure. Could you please let me know the steps to hit issue?
i am doing only few min runs to check the performance and some unit test
cases.
I will add the necessary asserts if i can reproduce the issue and fix it.

Varada
> Regards, Kevan
>
>
>

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
