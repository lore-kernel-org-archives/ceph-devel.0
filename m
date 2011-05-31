From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 18:05:59 +0300
Message-ID: <4DE503D7.8080703@ufm.su>
References: <4DE41F34.8020504@ufm.su>	<4DE4BC76.1080906@ufm.su> <BANLkTimPzWufFvxQ_AiyHoJrE7b-+3an3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:39835 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055Ab1EaPGB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2011 11:06:01 -0400
In-Reply-To: <BANLkTimPzWufFvxQ_AiyHoJrE7b-+3an3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/31/2011 05:51 PM, Gregory Farnum wrote:
> Sage created an issue to track this:
> http://tracker.newdream.net/issues/1122
>
> Based on the differences between the FUSE and kernel clients, it's
> probably just readahead settings. :)
> -Greg
I'm not sure.

rsize 10 times more than the default:

root@gate0:~# mount -t ceph -o rsize=5242880 10.5.51.230:/ /mnt
root@gate0:~# cd /mnt/
root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 126.168 s, 81.2 MB/s
root@gate0:/mnt# cd
root@gate0:~# umount /mnt

rsize 100 times more

root@gate0:~# mount -t ceph -o rsize=52428800 10.5.51.230:/ /mnt
root@gate0:~# cd /mnt/
root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 123.432 s, 83.0 MB/s
root@gate0:/mnt# cd
root@gate0:~# umount /mnt

cfuse

root@gate0:~# cfuse -m 10.5.51.230:/ /mnt
  ** WARNING: Ceph is still under development.  Any feedback can be 
directed  **
  **          at ceph-devel@vger.kernel.org or 
http://ceph.newdream.net/.     **
cfuse[1686]: starting ceph client
cfuse[1686]: starting fuse
root@gate0:~# cd /mnt
root@gate0:/mnt# dd if=bbb of=/dev/null bs=1024000
10000+0 records in
10000+0 records out
10240000000 bytes (10 GB) copied, 93.3285 s, 110 MB/s
root@gate0:/mnt#

WBR,
     Fyodor.
