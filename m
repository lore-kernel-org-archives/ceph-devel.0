From: Sam Lang <sam.lang@inktank.com>
Subject: Re: OSDs don't actually delete files when two CephFS (or more) are
 in use
Date: Mon, 10 Dec 2012 10:23:57 -1000
Message-ID: <50C644DD.8060707@inktank.com>
References: <CAPU8t+pEuX2sP-gRqmCxGw-etrviOt1N7_18gv4=rDj+K6pkTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50542 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab2LJUYB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 15:24:01 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2291653pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 12:24:00 -0800 (PST)
In-Reply-To: <CAPU8t+pEuX2sP-gRqmCxGw-etrviOt1N7_18gv4=rDj+K6pkTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Geoffrey Hartz <hartz.geoffrey@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/10/2012 08:29 AM, Geoffrey Hartz wrote:
> Hi!
>
> I'm new to Ceph and I have a strange behavior with CephFS
>
> Config is :
>
> Ubuntu 12.04
> Kernel 3.6.9
> Ceph V0.55
>
> 2 OSD, 1 mon, 1 MDS, all on same host
> 2 clients, separate Hosts
>
> Ceph.conf:
>
> http://paste.ubuntu.com/1423712/
>
> To mount the share I use : sudo ceph-fuse -m 192.168.80.139:6789 /mnt
>
> When I create a file on one client, the other see the file, can be
> downloaded etc.
>
> But when I delete the file, both clients don't see the file anymore
> BUT the file is still there on OSD (using space disk).

Removing a file removes the directory entry (as you've seen), but the 
inode itself doesn't get removed until all references to it are dropped. 
  The clients may cache the capability for those inodes for a period of 
time, so you're not seeing the references drop until they get evicted 
from the cache.  Unmounting ensures that they get evicted from the 
client caches, so all references go to zero.

Also, removal of the underlying objects is done lazily, so you may not 
see the space get freed up right away.

-sam

>
> When I umount from BOTH clients, OSD are update and file is actually
> delete (same behavior with mount -t ceph)
>
> I'm missing something?
>
> Thanks!
>
> --
> Geoffrey HARTZ
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

