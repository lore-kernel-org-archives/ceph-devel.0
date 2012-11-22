From: Sage Weil <sage@inktank.com>
Subject: Re: Problem with SGID and new inode
Date: Thu, 22 Nov 2012 13:57:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211221356350.9963@cobra.newdream.net>
References: <CAHcbcZcM1r93ybgSEC4fiCvF8FSm=XVsRp7fLmp9FzdxDjTSHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45222 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955Ab2KVV5Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 16:57:24 -0500
In-Reply-To: <CAHcbcZcM1r93ybgSEC4fiCvF8FSm=XVsRp7fLmp9FzdxDjTSHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giorgos Kappes <geokapp@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 22 Nov 2012, Giorgos Kappes wrote:
> ??,
> 
> I was looking at the source code of the ceph MDS and in particular at
> the function
> CInode* Server::prepare_new_inode(...) in the mds/Server.cc file which
> creates a new inode.
> At lines 1739-1747 the code checks if the parent directory has the
> set-group-ID bit set. If
> this bit is set and the new inode refers to a directory then the new
> inode should also have
> the set-group-ID bit set. However, as I understand, at line 1744 the
> set-group-ID bit is set
> at the local variable [mode |= S_ISGID] and not on the inode.
> Shouldn't this line be
> [in->inode.mode |= S_ISGID;]?
> 
> To illustrate the above problem I tried to create a new directory
> inside a directory that has
> the set-group-ID bit set:
> 
> root@client-admin:/mnt/admin# mkdir mydir
> root@client-admin:/mnt/admin# chmod +s mydir
> root@client-admin:/mnt/admin# ls -l
> total 1
> drwsr-sr-x 1 root root  0 Nov 22  2012 mydir
> -rw-r--r-- 1 root root 13 Oct 19 08:05 myfile.txt
> root@client-admin:/mnt/admin# cd mydir
> root@client-admin:/mnt/admin/mydir# mkdir newdir
> root@client-admin:/mnt/admin/mydir# ls -l
> total 1
> drwxr-xr-x 1 root root 0 Nov 22  2012 newdir
> 
> Finally, I would like to note that I am using Ceph 0.48.2 but the
> above problem also seems
> to exist in the v0.54 development release.

Thanks, this is indeed a bug.  I pushed a fix to the next branch, commit 
1c715a11f70788d987c16aa67ce2b6f32c04a673.

Thanks!
sage
