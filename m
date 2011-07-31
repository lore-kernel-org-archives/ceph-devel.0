From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sun, 31 Jul 2011 14:33:50 +0300
Message-ID: <4E353D9E.5080802@ufm.su>
References: <4E33D101.1050504@ufm.su>	<9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu> <4E3432FC.9030204@ufm.su>	<20110730165001.GI7361@thunk.org>	<Pine.LNX.4.64.1107301016120.23447@cobra.newdream.net>	<20110730221900.GK7361@thunk.org> <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:40492 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab1GaLdz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 31 Jul 2011 07:33:55 -0400
In-Reply-To: <Pine.LNX.4.64.1107302149430.23447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ted Ts'o <tytso@mit.edu>, ceph-devel@vger.kernel.org

On 07/31/2011 07:54 AM, Sage Weil wrote:
> On Sat, 30 Jul 2011, Ted Ts'o wrote:
>> On Sat, Jul 30, 2011 at 10:21:13AM -0700, Sage Weil wrote:
>>> We do use xattrs extensively, though; that was the last extN bug we
>>> uncovered.  That's where my money is.
>> Hmm, yes.  That could very well be.  How big are the xattrs, and are
>> there cases where you:
>>
>> a) start with a small xattr (where the total size is less than 128
>> bytes, so it can be stored in the inode table), and then increase it
>> something where it needs to be stored in an external block?
>>
>> b) start with enough xattrs so it's large, and then delete all or most
>> of them?
>>
>> I could easily believe we might have some bugs as we transition from
>> in-inode to external block storage, or vice versa.  I'll take a look
>> at the code and try to create some reproduction cases, but if you
>> could give me a handle on workload patterns of ceph around xattrs,
>> that would be interesting.
> I would guess a, but it could also be a+b.
>
> Fyodor, can you take some of the corrupt inos that fsck complained about
> and see what files/directories they are?  find /osd.0 -inum NNN.  (I'm
> guessing the largest xattrs are on the collection directories, like
> /osd.0/current/something_head/.)  Then grep that filename out of the log
> to see exactly which operations took place.  The setattr log normally
> includes xattr size.


/etc/init.d/ceph stop
umount /mnt/osd.0
mke2fs -t ext4 -I 128 /dev/sdc1
tune2fs -o journal_data_writeback /dev/sdc1
mount -a
mon getmap -o /tmp/monmap
cosd --mkfs -i 0 --monmap /tmp/monmap
/etc/init.d/ceph start
sleep 300
/etc/init.d/ceph stop
umount /osd.0
fsck.ext4 -f /dev/sdc1

Inode 99356878, i_blocks is 8208, should be 8200.

mount -a
root@osd0:~# find /osd.0 -inum 99356878

/osd.0/current/0.2a4_head/10000000468.0000007e_head

root@osd0:~# grep "10000000468\.0000007e" /var/log/ceph/osd.0.log
2011-07-31 09:57:20.859834 7f624c82a700 filestore(/osd.0) remove 
temp/10000000468.0000007e/head = -1
2011-07-31 09:57:20.861166 7f624c82a700 filestore(/osd.0) write 
temp/10000000468.0000007e/head 0~1048576 = 1048576
2011-07-31 09:57:20.990464 7f624c029700 filestore(/osd.0) write 
temp/10000000468.0000007e/head 1048576~1048576 = 1048576
2011-07-31 09:57:21.121648 7f624c029700 filestore(/osd.0) write 
temp/10000000468.0000007e/head 2097152~1048576 = 1048576
2011-07-31 09:57:21.265879 7f624c029700 filestore(/osd.0) write 
temp/10000000468.0000007e/head 3145728~1048576 = 1048576
2011-07-31 09:57:21.265952 7f624c029700 filestore(/osd.0) remove 
0.2a4_head/10000000468.0000007e/head = -1
2011-07-31 09:57:21.265995 7f624c029700 filestore(/osd.0) collection_add 
0.2a4_head/10000000468.0000007e/head temp/10000000468.0000007e/head = 0
2011-07-31 09:57:21.266025 7f624c029700 filestore(/osd.0) 
collection_remove temp/10000000468.0000007e/head = 0
2011-07-31 09:57:21.266134 7f624c029700 filestore(/osd.0) setattrs 
0.2a4_head/10000000468.0000007e/head = 26


WBR,
     Fyodor.


