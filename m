From: John Wright <jcwright@MIT.EDU>
Subject: Re: MPI applications on ceph fs
Date: Sun, 2 Sep 2012 10:42:59 -0400
Message-ID: <9501626D-E1A9-4DE8-965F-100897AD2246@mit.edu>
References: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu> <alpine.DEB.2.00.1208262104360.11218@cobra.newdream.net> <8202724F-E1FF-4914-A474-A6449FA596F0@psfc.mit.edu> <E4BE0886-9463-4332-994E-C59AFE756EE4@mit.edu> <alpine.DEB.2.00.1208311259090.2525@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:64680 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752212Ab2IBOsF convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 2 Sep 2012 10:48:05 -0400
In-Reply-To: <alpine.DEB.2.00.1208311259090.2525@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
fortunately I've been running with those debug settings. Below I have quotes some parts of the mds log from the lock up I mentioned.

I also reset ceph and rebooted clients with stuck mounts. I ran the mpi process again to reproduce the error and get the info from /proc and /var/kernel/debug/ceph that you wanted. This time the initial files from the mpi processes were not created, instead the mpi processes went into an unkillable state with no cpu usage right away which has been the more common failure mode. It took several minutes before ceph volume froze up on clients. Up till that time, I could list the volume while the mpi processes were stuck. Trying to cat the kernel debug ceph mdsc resulted in a locked unkillable process.

I've uploaded the mds log to dropbox here: https://dl.dropbox.com/u/9688196/mds.alpha.log
The log starts shortly before I ran the mpi processes at 8:52am.   At 10:23 I stopped ceph.

 I wasn't entirely clear on which writer processes you were referring to, I assume you mean the hung mpi processes that were trying to access the volume. Here is one of them:

[root@eaps-80-35e ~]# stat /proc/6399/fd/*
  File: `/proc/6399/fd/0' -> `socket:[10971]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12608       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/1' -> `pipe:[44543]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12609       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/10' -> `pipe:[10973]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12617       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/11' -> `pipe:[44544]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12618       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/12' -> `pipe:[10974]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12619       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/13' -> `pipe:[10978]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12620       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/14' -> `pipe:[10975]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12621       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/15' -> `socket:[10984]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12622       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/16' -> `pipe:[10979]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12623       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/17' -> `pipe:[10982]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12624       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/18' -> `socket:[10988]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12625       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/19' -> `pipe:[10983]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12626       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/2' -> `pipe:[44544]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 44616       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:52:57.603686714 -0400
Change: 2012-09-02 08:52:57.603686714 -0400
 Birth: -
  File: `/proc/6399/fd/20' -> `pipe:[10986]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12627       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/21' -> `socket:[10992]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12628       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/22' -> `pipe:[10987]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12629       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/23' -> `pipe:[10990]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12630       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/24' -> `socket:[10996]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12631       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/25' -> `pipe:[10991]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12632       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/26' -> `pipe:[10994]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12633       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/28' -> `pipe:[10995]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12634       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/29' -> `pipe:[10998]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12635       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/3' -> `pipe:[18747]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12610       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/31' -> `pipe:[10999]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12636       Links: 1
Access: (0500/lr-x------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/4' -> `pipe:[18747]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12611       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/5' -> `socket:[44538]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12612       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/6' -> `socket:[10976]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12613       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/7' -> `socket:[44542]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12614       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/8' -> `socket:[10980]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12615       Links: 1
Access: (0700/lrwx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -
  File: `/proc/6399/fd/9' -> `pipe:[44543]'
  Size: 64        	Blocks: 0          IO Block: 1024   symbolic link
Device: 3h/3d	Inode: 12616       Links: 1
Access: (0300/l-wx------)  Uid: (50329/jcwright)   Gid: (  101/     mit)
Access: 2012-09-02 08:56:58.822667831 -0400
Modify: 2012-09-02 08:56:57.720669539 -0400
Change: 2012-09-02 08:56:57.720669539 -0400
 Birth: -



Here's the mds log from this last crash. I just removed a few sections showing access to the STDOUT files still wedged about 40 min after the processes were started.:

STDOUT.0011 stuck:

2012-08-30 16:25:18.026688 7f565b7fe700 10 mds.0.locker  already auth_pinned [inode 100000003ea [...2,head] /runtemplate/ auth v6314 pv6318 ap=7+1 f(v1 m2012-08-30 15:34:32.18
0586 129=127+2) n(v5 rc2012-08-30 15:34:32.180586 b41565468 266=168+98)/n(v4 rc2012-08-30 15:34:32.180586 b41565468 266=168+98) (isnap sync r=4) (inest lock->sync w=1 flushing
) (iversion lock) caps={4204=pAsLsXsFs/p@10,4206=pAsLsXs/-@1,4207=pAsLsXsFs/p@2} | dirtyscattered lock dirfrag caps dirtyrstat dirty authpin 0x7f564c00e2b0]
2012-08-30 16:25:18.026711 7f565b7fe700 10 mds.0.locker  already rdlocked (isnap sync r=5) [inode 1 [...2,head] / auth v2751 pv2752 ap=6+0 snaprealm=0x7f564c01e880 f(v1 m2012-
08-30 15:43:15.353296 8=5+3) n(v12 rc2012-08-30 15:43:15.353296 b25642762694 273=173+100)/n(v0 1=0+1) (isnap sync r=5) (inest lock->sync w=1 dirty flushing) (iversion lock) ca
ps={4204=pAsLsXsFs/p@8,4206=pAsLsXs/-@1,4207=pAsLsXs/-@1} | dirtyscattered lock dirfrag caps dirty authpin 0x7f564c00c990]
2012-08-30 16:25:18.026731 7f565b7fe700 10 mds.0.locker  already rdlocked (isnap sync r=1) [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0
 b612445 1=1+0) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 | request lock c
aps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026748 7f565b7fe700 10 mds.0.locker  already rdlocked (ifile xsyn r=1) [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0
 b612445 1=1+0) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 | request lock c
aps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026767 7f565b7fe700  7 mds.0.locker rdlock_start  on (iauth sync) on [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b
612445 1=1+0) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 | request lock cap
s dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026785 7f565b7fe700 10 mds.0.locker  got rdlock on (iauth sync r=1) [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b6
12445 1=1+0) (iauth sync r=1) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 | 
request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026804 7f565b7fe700  7 mds.0.locker rdlock_start  on (ilink sync) on [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b
612445 1=1+0) (iauth sync r=1) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 |
 request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026830 7f565b7fe700 10 mds.0.locker  got rdlock on (ilink sync r=1) [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b6
12445 1=1+0) (iauth sync r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=p
Ls/-@0},l=4206 | request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026849 7f565b7fe700  7 mds.0.locker rdlock_start  on (ixattr excl) on [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 
b612445 1=1+0) (iauth sync r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207
=pLs/-@0},l=4206 | request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026868 7f565b7fe700  7 mds.0.locker simple_sync on (ixattr excl) on [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b6
12445 1=1+0) (iauth sync r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=p
Ls/-@0},l=4206 | request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026885 7f565b7fe700  7 mds.0.locker issue_caps loner client.4206 allowed=pAsLsXsFcb, xlocker allowed=pAsLsXsFcb, others allowed=pAsLs on [inode 1000000000b
 [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth sync r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr excl->sync) (iversion lock) cr={42
06=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsxFcb/pAsxXsxFsxcrwb@3,4207=pLs/-@0},l=4206 | request lock caps dirty authpin 0x7f562c665c20]
2012-08-30 16:25:18.026908 7f565b7fe700 20 mds.0.locker  client.4204 pending pLs allowed pAsLs wanted -
2012-08-30 16:25:18.026912 7f565b7fe700 20 mds.0.locker  client.4206 pending pAsLsXsxFcb allowed pAsLsXsFcb wanted pAsxXsxFsxcrwb
2012-08-30 16:25:18.026919 7f565b7fe700  7 mds.0.locker    sending MClientCaps to client.4206 seq 4 new pending pAsLsXsFcb was pAsLsXsxFcb
2012-08-30 16:25:18.026925 7f565b7fe700 20 mds.0.cache.ino(1000000000b) encode_cap_message pfile 0 pauth 0 plink 0 pxattr 0 ctime 2012-08-30 15:34:24.698616
2012-08-30 16:25:18.026930 7f565b7fe700 10 mds.0.3 send_message_client_counted client.4206 seq 190 client_caps(revoke ino 1000000000b 421 seq 4 caps=pAsLsXsFcb dirty=- wanted=
pAsxXsxFsxcrwb follows 0 size 612445/4194304 ts 1 mtime 2012-08-30 15:34:24.698616) v2
2012-08-30 16:25:18.026940 7f565b7fe700  1 -- 10.0.0.17:6801/18725 --> 10.0.0.61:0/542758398 -- client_caps(revoke ino 1000000000b 421 seq 4 caps=pAsLsXsFcb dirty=- wanted=pAs
xXsxFsxcrwb follows 0 size 612445/4194304 ts 1 mtime 2012-08-30 15:34:24.698616) v2 -- ?+0 0x7f564c2d5b80 con 0x7f562c5171e0
2012-08-30 16:25:18.026958 7f565b7fe700 20 mds.0.locker  client.4207 pending pLs allowed pAsLs wanted -
2012-08-30 16:25:18.026962 7f565b7fe700 10 mds.0.cache.ino(1000000000b) auth_pin by 0x7f562c6663a0 on [inode 1000000000b [2,head] /runtemplate/STDOUT.0011 auth v1038 ap=2+0 s=
612445 n(v0 b612445 1=1+0) (iauth sync r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr excl->sync) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@1,4206=pAsLsXsFcb/pAsL
sXsxFcb/pAsxXsxFsxcrwb@4,4207=pLs/-@0},l=4206 | request lock caps dirty authpin 0x7f562c665c20] now 2+0

 

STDOUT.0012 stuck:

2012-08-30 16:25:18.034320 7f565b7fe700 20 mds.0.server set_trace_dist added in   [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl r=1) (ilink sync r=1) (ifile xsyn r=1) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034338 7f565b7fe700  1 -- 10.0.0.17:6801/18725 --> 10.0.0.17:0/77864862 -- client_reply(???:268 = 0 Success) v1 -- ?+0 0x7f564c3500e0 con 0x7f562c2fbea0
2012-08-30 16:25:18.034349 7f565b7fe700  7 mds.0.cache request_finish request(client.4204:268 cr=0x7f5628000920)
2012-08-30 16:25:18.034352 7f565b7fe700 15 mds.0.cache request_cleanup request(client.4204:268 cr=0x7f5628000920)
2012-08-30 16:25:18.034356 7f565b7fe700  7 mds.0.locker rdlock_finish on (iauth excl) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ilink sync r=1) (ifile xsyn r=1) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034374 7f565b7fe700 10 mds.0.locker simple_eval (iauth excl) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ilink sync r=1) (ifile xsyn r=1) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034391 7f565b7fe700  7 mds.0.locker rdlock_finish on (ilink sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn r=1) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034406 7f565b7fe700 10 mds.0.locker simple_eval (ilink sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn r=1) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034421 7f565b7fe700  7 mds.0.locker rdlock_finish on (ifile xsyn) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034440 7f565b7fe700  7 mds.0.locker file_eval wanted=sxcrwb loner_wanted=sxcrwb other_wanted=  filelock=(ifile xsyn) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034459 7f565b7fe700  7 mds.0.locker file_eval stable, bump to loner (ifile xsyn) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034477 7f565b7fe700  7 mds.0.locker file_excl (ifile xsyn) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile xsyn) (ixattr sync r=1) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034496 7f565b7fe700  7 mds.0.locker rdlock_finish on (ixattr sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034514 7f565b7fe700 10 mds.0.locker simple_eval (ixattr sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034530 7f565b7fe700  7 mds.0.locker simple_eval stable, going to excl (ixattr sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034546 7f565b7fe700  7 mds.0.locker simple_excl on (ixattr sync) on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=1+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540]
2012-08-30 16:25:18.034564 7f565b7fe700 10 mds.0.cache.ino(100000004cd) auth_pin by 0x7f562c667cc0 on [inode 100000004cd [2,head] /runtemplate/STDOUT.0012 auth v1057 ap=2+0 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (ixattr sync->excl) (iversion lock) cr={4207=0-4194304@1} caps={4204=pLsXs/-@2,4207=pAsxLsXsFcb/pAsxXsxFsxcrwb@5},l=4207 | request lock caps dirty authpin 0x7f562c667540] now 2+0


STDOUT.0013 stuck:

2012-08-30 16:25:18.041838 7f565b7fe700 10 mds.0.locker simple_eval (ixattr excl) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) (ia
uth excl) (ifile excl) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667da0]
2012-08-30 16:25:18.041857 7f565b7fe700  7 mds.0.locker simple_eval stable, syncing (ixattr excl) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b6
12445 1=1+0) (iauth excl) (ifile excl) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty
 0x7f562c667da0]
2012-08-30 16:25:18.041876 7f565b7fe700  7 mds.0.locker simple_sync on (ixattr excl) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) 
(iauth excl) (ifile excl) (ixattr excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667d
a0]
2012-08-30 16:25:18.041894 7f565b7fe700 10 mds.0.locker scatter_eval (inest lock) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) (ia
uth excl) (ifile excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667da0]
2012-08-30 16:25:18.041912 7f565b7fe700 10 mds.0.locker simple_eval (iflock sync) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) (ia
uth excl) (ifile excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667da0]
2012-08-30 16:25:18.041930 7f565b7fe700 10 mds.0.locker simple_eval (ipolicy sync) on [inode 1000000000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) (i
auth excl) (ifile excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxcrwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667da0]
2012-08-30 16:25:18.041948 7f565b7fe700  7 mds.0.locker issue_caps loner client.4206 allowed=pAsxLsXsFsxcrwbl, xlocker allowed=pAsxLsXsFsxcrwbl, others allowed=pLsXs on [inode 10000
00000d [2,head] /runtemplate/STDOUT.0013 auth v1040 s=612445 n(v0 b612445 1=1+0) (iauth excl) (ifile excl) (iversion lock) cr={4206=0-4194304@1} caps={4204=pLs/-@3,4206=pAsxLsXsFsxc
rwb/pAsxXsxFsxcrwb@6,4207=pLs/-@0},l=4206 | caps dirty 0x7f562c667da0]

hopefully, all this helps. 
thanks,
-john


On Aug 31, 2012, at 4:03 PM, Sage Weil wrote:

> Hi John,
> 
> On Fri, 31 Aug 2012, John C. Wright wrote:
>> An update,
>> While looking into how to switch over to a different network on my ceph cluster - another question altogether, I discovered during my upgrade from 0.47.2 to 0.48 on the three nodes somehow my 'git checkout 0.48' wasn't done correctly on two nodes and wound up reinstalling 0.47.2 on those so somehow had a heterogenous cluster running 0.47.2 on the osds and 0.48 running on the mds (all three running monitors).
>> 
>> So wiped out and started fresh with 0.48 and still got the error, but with more info this time.
>> This MPI code is running on 14 processes on two client nodes. Each process writes to its own 'stdout' file and some other data files are created by process '0'. The program starts up and creates its initial files and begins to write to its stdout files. Normally this proceeds with writes to the stdout at periodic intervals during the run, but on the ceph volume, this freezes up after about one minute.
>> 
>> Symptoms: initially can still access ceph volume from other clients. Listing the working directory of the mpi code is very slow and soon is unresponsive but can still list other directories on the ceph volume. After another minute or so, ceph clients can no longer access the volume at all without locking up in a trace that ends in a 'fastpath' kernel call. If I CTRL-C out of the mpirun call within the first minute, everything recovers, but waiting longer than that requires a reboot of mounted nodes and a restart of ceph to clear things up.
>> 
>> Below are relevant (I hope) process traces from dmesg and ceph logs. Any help on diagnosing this would be greatly appreciated. We're hoping to use ceph as a parallel file system on a scientific workload beowulf cluster, initially with a buyer-beware policy an for only transient reproducible data and more general usage as ceph gets stable and reaches the 1.0 milestone.
> 
> It looks a bit like this is a problem on the MDS side of things, since you
> have both a hung request and a writer waiting for caps.  Can you generate 
> an MDS log that goes with this workload?  With
> 
> 	debug ms = 1
> 	debug mds = 20
> 
> in the [mds] section of your config?  Also, once it hangs, it would be 
> helpful to see what the hung request is (cat 
> /sys/kernel/debug/ceph/*/mdsc) and the inode number for the hung writer 
> (stat /proc/$pid/fd/NNN).  Hopefully the stat won't hang.. but if it does, 
> hopefully you can identify which file ino or filename it is some other 
> way.
> 
> Thanks!
> sage
> 
> 
>> 
>> Thanks very much.
>> 
>> -john wright
>> 
>> Log snips:
>> 
>> ceph.log on mds when code starts at 15:34
>> 2012-08-30 15:34:46.915165 mon.0 10.0.0.17:6789/0 414 : [INF] pgmap v396: 384 pgs: 384 active+clean; 37085 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:34:47.921910 mon.0 10.0.0.17:6789/0 415 : [INF] pgmap v397: 384 pgs: 384 active+clean; 37085 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:34:52.586958 mon.0 10.0.0.17:6789/0 416 : [INF] pgmap v398: 384 pgs: 384 active+clean; 37085 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:35:01.920783 mon.0 10.0.0.17:6789/0 417 : [INF] pgmap v399: 384 pgs: 384 active+clean; 37088 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:35:02.926615 mon.0 10.0.0.17:6789/0 418 : [INF] pgmap v400: 384 pgs: 384 active+clean; 37091 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:35:06.922546 mon.0 10.0.0.17:6789/0 419 : [INF] pgmap v401: 384 pgs: 384 active+clean; 37102 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:35:07.929265 mon.0 10.0.0.17:6789/0 420 : [INF] pgmap v402: 384 pgs: 384 active+clean; 37111 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 2012-08-30 15:35:17.594883 mon.0 10.0.0.17:6789/0 421 : [INF] pgmap v403: 384 pgs: 384 active+clean; 37111 MB data, 198 GB used, 21841 GB / 27939 GB avail
>> 
>> dmesg trace:
>> one of the mpi processes:
>> 85298.841748] hydra_pmi_proxy S ffffffff81808440     0  5441   5412 0x00000080
>> [85298.841752]  ffff8805d93e1968 0000000000000082 ffff8805d93e1978 ffffffffa02f588c
>> [85298.841758]  ffff88061803c590 ffff8805d93e1fd8 ffff8805d93e1fd8 ffff8805d93e1fd8
>> [85298.841764]  ffff88061e7a2e60 ffff88061803c590 ffff88063ffedc08 ffff88061803c590
>> [85298.841769] Call Trace:
>> [85298.841779]  [<ffffffffa02f588c>] ? try_get_cap_refs+0x10c/0x320 [ceph]
>> [85298.841783]  [<ffffffff815f323f>] schedule+0x3f/0x60
>> [85298.841794]  [<ffffffffa02f7ee5>] ceph_get_caps+0x135/0x1f0 [ceph]
>> [85298.841798]  [<ffffffff8107a7d0>] ? remove_wait_queue+0x50/0x50
>> [85298.841807]  [<ffffffffa02ed5ae>] ceph_aio_read+0xee/0x880 [ceph]
>> [85298.841812]  [<ffffffff81178c3e>] ? memcg_check_events+0x2e/0x1c0
>> [85298.841817]  [<ffffffff81179925>] ? __mem_cgroup_commit_charge+0x145/0x300
>> [85298.841821]  [<ffffffff8117b3aa>] ? mem_cgroup_charge_common+0xba/0x100
>> [85298.841825]  [<ffffffff81180ba2>] do_sync_read+0xd2/0x110
>> [85298.841830]  [<ffffffff81269773>] ? security_file_permission+0x93/0xb0
>> [85298.841834]  [<ffffffff81181011>] ? rw_verify_area+0x61/0xf0
>> [85298.841837]  [<ffffffff811814f0>] vfs_read+0xb0/0x180
>> [85298.841841]  [<ffffffff81186d36>] kernel_read+0x46/0x60
>> [85298.841845]  [<ffffffff811d1b6e>] load_elf_binary+0x1ae/0x1a10
>> [85298.841850]  [<ffffffff811477c2>] ? get_user_pages+0x52/0x60
>> [85298.841854]  [<ffffffff81186936>] ? get_arg_page+0xa6/0xe0
>> [85298.841858]  [<ffffffff8118760d>] search_binary_handler+0xed/0x370
>> [85298.841863]  [<ffffffff811d19c0>] ? do_mmap+0x40/0x40
>> [85298.841867]  [<ffffffff81188acf>] do_execve_common+0x36f/0x410
>> [85298.841871]  [<ffffffff81188baa>] do_execve+0x3a/0x40
>> [85298.841875]  [<ffffffff8101d737>] sys_execve+0x47/0x70
>> [85298.841879]  [<ffffffff815fc72c>] stub_execve+0x6c/0xc0
>> 
>> locked up ls:
>> [85298.842119] ls              D 000000000000000a     0  5451   4964 0x00000084
>> [85298.842124]  ffff88061733bc58 0000000000000086 0000000000000072 0000000000000287
>> [85298.842129]  ffff880617299730 ffff88061733bfd8 ffff88061733bfd8 ffff88061733bfd8
>> [85298.842135]  ffff880c1ac3dcc0 ffff880617299730 ffff880617247e00 7fffffffffffffff
>> [85298.842140] Call Trace:
>> [85298.842144]  [<ffffffff815f323f>] schedule+0x3f/0x60
>> [85298.842148]  [<ffffffff815f1945>] schedule_timeout+0x2a5/0x320
>> [85298.842158]  [<ffffffffa02a8d05>] ? ceph_con_send+0xf5/0x1c0 [libceph]
>> [85298.842162]  [<ffffffff815f30d7>] wait_for_common+0x127/0x170
>> [85298.842166]  [<ffffffff81088e30>] ? try_to_wake_up+0x2b0/0x2b0
>> [85298.842170]  [<ffffffff815f315d>] wait_for_completion_killable+0x1d/0x30
>> [85298.842182]  [<ffffffffa0301e3d>] ceph_mdsc_do_request+0x12d/0x2a0 [ceph]
>> [85298.842191]  [<ffffffffa02ea379>] ceph_do_getattr+0xe9/0x1c0 [ceph]
>> [85298.842199]  [<ffffffffa02ea474>] ceph_getattr+0x24/0x100 [ceph]
>> [85298.842204]  [<ffffffff8118c873>] ? putname+0x33/0x50
>> [85298.842208]  [<ffffffff81185fae>] vfs_getattr+0x4e/0x80
>> [85298.842212]  [<ffffffff8118602e>] vfs_fstatat+0x4e/0x70
>> [85298.842216]  [<ffffffff8118606e>] vfs_lstat+0x1e/0x20
>> [85298.842220]  [<ffffffff8118620a>] sys_newlstat+0x1a/0x40
>> [85298.842224]  [<ffffffff810d340c>] ? __audit_syscall_entry+0xcc/0x310
>> [85298.842228]  [<ffffffff810d3a26>] ? __audit_syscall_exit+0x3d6/0x410
>> [85298.842232]  [<ffffffff815fc2e9>] system_call_fastpath+0x16/0x1b
>> 
>> 
>> 
>> 
>> On Aug 28, 2012, at 11:54 AM, John Wright wrote:
>> 
>>> Hi Sage,
>>> Thanks for the suggestion.
>>> I've attached two files with the dump from dmesg with the trigger set to true. They are for two nodes running 7 parallel processes each. The parallel process was launched via mpirun on 35e and you can see each of the parallel processes in its trace ('mitgcm') along with one ceph processes.  On the second node (37w) you see lots of ceph messages but no mitgcm processes (though there are mitgcm processes listed by 'ps' with state 'D'). This is the node on which the mounted ceph filesystem locks up and any process accessing it goes into state 'D': uninterruptible sleep. So far, it has always been the second node on which ceph locks. The lock up happens as soon as the executable is started presumably when it tries to open several new files from the 14  processes. Of course, an identical te
 st under NFS mounted volumes works fine.
>>> 
>>> Interestingly, I did this after rebooting 37w from the last freeze up of the ceph volume and the first few times the application still froze with state 'D' on the second node and 'S' on the first but would terminate when mpirun was killed. But on the fourth try the ceph volume fully locked, requiring a reboot. In the past two tries the ceph lock up had occurred on the first mpirun test of mitgcm.
>>> 
>>> thanks for any feed back you give on this,
>>> 
>>> -John
>>> 
>>> The files are at
>>> https://dl.dropbox.com/u/9688196/80_35e_dmsesg_gcm.log.1.1.txt
>>> https://dl.dropbox.com/u/9688196/80_37w_dmesg.gcm.log.1.txt
>>> 
>>> (I tried to post yesterday, but it never made it to the list , maybe the files were too big?)
>>> 
>>> And because I forgot to CC the list, here's my reply to Mark's note:
>>>> Hi Mark,
>>>> the mpi application is attempting to open multiple files, one from each process, I believe it was at this step.  Several files are opened by process 0 for summary output. I cannot rule out that there is some concurrent opening or access going on since I am not the author of the code. That is one of my suspects and I'm writing some small programs to test that.  Not sure if the ceph osd's ever received a request or if things got locked up at the level of the kernel module for ceph on the node. 
>>>> 
>>>> I appreciate any suggestions. Does any one know if ceph has been tested in a parallel application environment where there often is a lot of file i/o concurrency?
>>>> thanks,
>>>> -john
>>> 
>>> 
>>> On Aug 27, 2012, at 12:06 AM, Sage Weil wrote:
>>> 
>>>> Hi John,
>>>> 
>>>> Can you dump running threads?  'echo t > /proc/sysrq-trigger' and then 
>>>> attach the output (from dmesg or kern.log).
>>>> 
>>>> Thanks!
>>>> sage
>>>> 
>>>> 
>>>> On Sun, 26 Aug 2012, John Wright wrote:
>>>> 
>>>>> Hi All,
>>>>> We're running ceph 0.48 on  small three node test cluster. We've had good stability with I/O using dd and iozone especially after upgrading to 0.48. However, we're running into a repeatable lockup of the linux ceph client ( 3.3.5-2.fc16.x86_64 ) when running an mpi program that has simple I/O on a ceph mount. This is an mpi program running processes on two nodes. It is the remote node on which the ceph client locks up. The cient becomes immediately unresponsive and any attempt to access the mounted volume produces a process with status 'D'. I can see no indication in the server logs that it is ever contacted. Regular serial processes run fine on the volume. MPI runs on the nodes work fine when not using the ceph volume.
>>>>> 
>>>>> So any suggestions on where to look? Any one have an experience testing parallel programs on ceph?
>>>>> 
>>>>> thanks,
>>>>> -john
>>>>> 
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>>> 
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 

