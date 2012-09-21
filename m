From: Alex Elder <elder@inktank.com>
Subject: Re: Machine hangs while writing to ceph filesystem
Date: Fri, 21 Sep 2012 17:45:22 -0500
Message-ID: <505CEE02.1030507@inktank.com>
References: <201209212023.q8LKNm45003481@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45773 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab2IUWpZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Sep 2012 18:45:25 -0400
Received: by ieak13 with SMTP id k13so6777290iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 21 Sep 2012 15:45:24 -0700 (PDT)
In-Reply-To: <201209212023.q8LKNm45003481@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>, ceph-devel@vger.kernel.org

On 09/21/2012 03:23 PM, Bryan K. Wright wrote:
> Hi folks,
> 
> 	I've just started working with ceph, and I'm finding that
> whenever a 32-bit client mounts the ceph filesystem and tries
> to copy something into it, the client host hangs after some
> random, small, amount of data has been copied.  The last error
> messages displayed are:
> 
>  kernel:Process kworker/0:0 (pid: 4913, ti=f6042000 task=f6008a90 task.ti=f6042000)
>  kernel:Stack:
>  kernel:Call Trace:
>  kernel:Code: 15 48 95 70 c1 81 ea 00 c0 5c 00 81 e2 00 00 e0 ff 29 d0 c1 e8 0c 8b 14 85 a0 82 8e c1 83 ea 01 85 d2 89 14 85 a0 82 8e c1 75 04 <0f> 0b eb fe 31 c0 83 fa 01 75 0f 31 c0 81 3d f0 cc 71 c1 f0 cc
>  kernel:EIP: [<c1116fff>] kunmap_high+0x4f/0xa0 SS:ESP 0068:f6043e6c
> 
> The client host is running 32-bit Centos 6.3, with the elrepo 3.5.4
> kernel.  The osd, mon and mds machines are all 64-bit Centos 6.3, with
> the stock Centos 2.6.32 kernel.  The ceph version in all cases is
> 0.48.2.  The OSDS are using XFS for their data stores.


If you are able to and are comfortable with it, could you please
try to mount your file system with the "nocrc" mount option?

I believe I have found the cause of this problem, but it would
be useful to have you verify that it goes away when this option
is used.

					-Alex


> 	There are no error messages in the ceph logs.
> 
> 	After rebooting the client machine and re-mounting the
> ceph filesystem, I can see that some files were, indeed, copied,
> but "du" gives an error message indicating that there are circular
> directory references, and that the filesystem is probably corrupt.
> 
> 	After wiping out the osds and re-creating the ceph cluster,
> the same thing happens.
> 
> 	Any advice about how to debug this would be appreciated.
> 
> 					Thanks,
> 					Bryan
> 
> 

