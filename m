From: Sage Weil <sage@newdream.net>
Subject: Re: sparse file support
Date: Thu, 20 Jan 2011 13:28:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101201325570.25905@cobra.newdream.net>
References: <AANLkTik231Dz019ztWhJsMX0tnVKL-EdmkY8ROCSWLnV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60209 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152Ab1ATV2G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jan 2011 16:28:06 -0500
In-Reply-To: <AANLkTik231Dz019ztWhJsMX0tnVKL-EdmkY8ROCSWLnV@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 20 Jan 2011, Brian Chrisman wrote:
> I've performed some simple testing of sparse files on ceph.  Summary,
> ceph reports full file size to 'du' and 'ls', where it should return
> actual storage usage to 'du'.  Creating a sparse file on ceph does not
> actually use the full file size in storage (which is correct
> behavior).  Is this a known issue, or should I submit a bug?

This is a design choice.  The MDS doesn't know how many blocks are 
allocated because, with the exception of reporting st_blocks to du, it 
doesn't need to.  This makes metadata smaller and the protocols simpler.

sage


> 
> dd if=/dev/urandom of=random.data bs=1024 count=1024
> dd if=random.data of=sparse_file.data
> dd if=random.data of=sparse_file.data bs=1024k seek=1024
> ls -l sparse_file.data
> du -sh sparse_file.data
> 
> A reference output: ext3
> [root@test11 tmp]# ls -l sparse_file.data
> -rw-r-r- 1 root root 1074790400 Jan 19 18:43 sparse_file.data
> [root@test11 tmp]#
> [root@test11 tmp]# du -sh sparse_file.data
> 2.1M sparse_file.data
> [root@test11 tmp]#
> 
> Output from: ceph
> [root@test11 fs0]# ls -l sparse_file.data
> -rw-r-r- 1 root root 1074790400 Jan 19 18:45 sparse_file.data
> [root@test11 fs0]# du -sh sparse_file.data
> 1.1Gsparse_file.data
> [root@test11 fs0]#
> 
> However, df shows that 1GB of space is not actually used in the filesytem:
> 
> [root@test11 fs0]# df -h
> Filesystem            Size  Used Avail Use% Mounted on
> ...
> 10.200.98.111:/        11T   30M   11T   1% /fs0
> [root@test11 fs0]#
> 
> -Brian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
