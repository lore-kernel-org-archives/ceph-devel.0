From: Sage Weil <sage@newdream.net>
Subject: Re: rbd
Date: Thu, 12 May 2011 09:08:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105120833410.19492@cobra.newdream.net>
References: <201105121353.44166.ufm@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42732 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308Ab1ELQHq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 12:07:46 -0400
In-Reply-To: <201105121353.44166.ufm@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi Fyodor,

> Hi!
> 
> Latest (git pulled) version of 2.6 kernel. Ceph - 0.27.1
> 
> Still troubles with rbd. Now with ocfs2 no messages in syslog, but iozone 
> still return error:
> 
> #df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda1             237G   15G  210G   7% /
> none                  2.0G  164K  2.0G   1% /dev
> none                  2.0G     0  2.0G   0% /dev/shm
> none                  2.0G   52K  2.0G   1% /var/run
> none                  2.0G     0  2.0G   0% /var/lock
> /dev/rbd0            1000G  3.2G  997G   1% /mnt
> 
> # cd /mnt/
> root@stb1:/mnt# ls
> lost+found
> root@stb1:/mnt# iozone -a -n4g -g20g
>         Iozone: Performance Test of File I/O
>                 Version $Revision: 3.373 $
>                 Compiled for 64 bit mode.
>                 Build: linux-AMD64
> 
> [...]
> 
>         Run began: Thu May 12 13:42:45 2011
> 
>         Auto Mode
>         Using minimum file size of 4194304 kilobytes.
>         Using maximum file size of 20971520 kilobytes.
>         Command line used: iozone -a -n4g -g20g
>         Output is in Kbytes/sec
>         Time Resolution = 0.000001 seconds.
>         Processor cache size set to 1024 Kbytes.
>         Processor cache line size set to 32 bytes.
>         File stride size set to 17 * record size.
>                                                             random  random    
> bkwd   record   stride
>               KB  reclen   write rewrite    read    reread    read   write    
> read  rewrite     read   fwrite frewrite   fread  freread
>          4194304      64  146906  150779
> 
> Error in file: Found ?7f24fb70a210? Expecting ?3a3a3a3a3a3a3a3a? addr 
> 7fe5b720e000
> Error in file: Position 2481971200
> Record # 37871 Record size 64 kb
> where 7fe5b720e000 loop 57344
> root@stb1:/mnt#           
> 
> Can I help to catch this error?

This one is going to be a bit difficult because there are several layers 
(ocfs2, rbd client, osd) involved.  It's presumably not ocfs2's fault, but 
trying the same thing with ext4 or something would remove that from the 
equation.  I'm running iozone on ext3 now and not having any problems.

Assuming the problem is in rbd, the question is whether it's the client or 
server side.  That will be harder to diagnose, and will probably involve 
careful use of fiemap/bmap to map the file offset to a block device 
offset, which we can then translate into a rados block.  That can be 
pulled directly out of the object store to confirm it has the right 
content...

sage

