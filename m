From: Alex Elder <elder@inktank.com>
Subject: Re: krbd + format=2 ?
Date: Fri, 07 Jun 2013 11:54:20 -0500
Message-ID: <51B2103C.7040402@inktank.com>
References: <20130603092428.GB28293@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:47696 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3FGQyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Jun 2013 12:54:22 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so11132371iet.22
        for <ceph-devel@vger.kernel.org>; Fri, 07 Jun 2013 09:54:22 -0700 (PDT)
In-Reply-To: <20130603092428.GB28293@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On 06/03/2013 04:24 AM, Chris Dunlop wrote:
> G'day,
> 
> Sage's recent pull message to Linus said:
> 
> ----
> Please pull the following Ceph patches from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-linus
> 
> This is a big pull.  Most of it is culmination of Alex's work to implement
> RBD image layering, which is now complete (yay!).
> ----
> 
> Am I correct in thinking "RBD image layering... is now complete"
> implies there should be full(?) support for format=2?
> 
> I pulled the for-linus branch (@ 3abef3b) on top of 3.10.0-rc4, and it's
> letting me map a format=2 image (created under bobtail), however reading
> from the block device returns zeros rather than the data. The same image
> correctly shows data (NTFS filesystem) when mounted into kvm using librbd.

Have you tried using a format 2 image that you created using
the Linux rbd environment?  It would be good to know whether
that works for you.

Can you also send me the result of running each of these commands:

foo=$(rados get --pool=rbd rbd_id.xxx - | strings)
rados ls --pool=rbd | grep rbd_data | grep "${foo}"
unset foo

Thanks.

					-Alex

> 
> ----
> # uname -r
> 3.10.0-rc4-00010-g0326739
> # rbd ls -l
> NAME                   SIZE PARENT                       FMT PROT LOCK 
> xxx                   1536G                                2
> # rbd map rbd/xxx
> # rbd showmapped
> id pool image   snap device    
> 1  rbd  xxx     -    /dev/rbd1 
> # dd if=/dev/rbd1 of=/tmp/xxx count=20480
> 20480+0 records in
> 20480+0 records out
> 10485760 bytes (10 MB) copied, 0.757754 s, 13.8 MB/s
> # od -c /tmp/xxx | less
> 0000000  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
> *
> 50000000
> ----
> 
> 
> Cheers,
> 
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

