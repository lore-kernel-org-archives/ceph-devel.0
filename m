From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 13:01:26 +0300
Message-ID: <4DE4BC76.1080906@ufm.su>
References: <4DE41F34.8020504@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:50068 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab1EaKBa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2011 06:01:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id A739C600485
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 13:01:28 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCAzwcsEzNrR for <ceph-devel@vger.kernel.org>;
	Tue, 31 May 2011 13:01:28 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 80589600484
	for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 13:01:28 +0300 (EEST)
In-Reply-To: <4DE41F34.8020504@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 05/31/2011 01:50 AM, Fyodor Ustinov wrote:
> Hi!
>
> Fresh 0.28.2 cluster.
>
> Why reading two times slower than the writing by dd, but rados show 
> different.
> (Second question - why rados bench crash on read test?)
>
>
> root@gate0:/mnt# dd if=/dev/zero of=aaa bs=1024000 count=10000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 64.5598 s, 159 MB/s
>
> root@gate0:/mnt# dd if=aaa of=/dev/null bs=1024000
> 10000+0 records in
> 10000+0 records out
> 10240000000 bytes (10 GB) copied, 122.513 s, 83.6 MB/s
> root@gate0:/mnt#
Additional. fuse vs kernel mount

fuse:

root@gate0:/mnt# dd if=/dev/zero of=bbb bs=1024000 count=10000 
conv=fdatasync
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 75.7654 s, 135 MB/s

root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 101.613 s, 101 MB/s


kernel:

root@gate0:/mnt# rm bbb
root@gate0:/mnt# dd if=/dev/zero of=bbb bs=1024000 count=10000 
conv=fdatasync
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 73.143 s, 140 MB/s

root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 150.84 s, 67.9 MB/s
root@gate0:/mnt#

What? Ok. reboot. After reboot:

root@gate0:/mnt# rm bbb
root@gate0:/mnt# dd if=/dev/zero of=bbb bs=1024000 count=10000 
conv=fdatasync
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 68.9618 s, 148 MB/s

root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 165.564 s, 61.8 MB/s
root@gate0:/mnt#


Hmm...  unmount kernel and mount fuse...

root@gate0:/mnt# cd
root@gate0:~# umount /mnt
root@gate0:~# cfuse -m 10.5.51.230:/ /mnt
  ** WARNING: Ceph is still under development.  Any feedback can be 
directed  **
  **          at ceph-devel@vger.kernel.org or 
http://ceph.newdream.net/.     **
cfuse[1102]: starting ceph client
cfuse[1102]: starting fuse
root@gate0:~# cd /mnt/
root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 93.076 s, 110 MB/s
root@gate0:/mnt#


What the hell?



WBR,
     Fyodor.

