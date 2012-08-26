From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Sun, 26 Aug 2012 08:14:42 -0500
Message-ID: <503A2142.2000505@inktank.com>
References: <loom.20120826T033818-148@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51908 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab2HZNOq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 09:14:46 -0400
Received: by ialo24 with SMTP id o24so6386815ial.19
        for <ceph-devel@vger.kernel.org>; Sun, 26 Aug 2012 06:14:45 -0700 (PDT)
In-Reply-To: <loom.20120826T033818-148@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Ramu,

You'll probably want to use the zfs on linux sources from here:

http://zfsonlinux.org

Testing this has been on my list but keeps getting pushed back.  Someone 
else on the list may have given it a try already though.  Keep in mind 
that Ceph won't be using any special tricks that ZFS supports as we 
haven't really been targeting it.  I think the xattr support for the 
linux port is pretty good so hopefully that should all work fine.  If 
you have problems you may want to try with:

filestore xattr use omap = true

Mark

On 08/25/2012 08:39 PM, ramu wrote:
> Hi all,
>
>    I want build ceph upon zfs file system,now iam installed ceph upon btrfs
> filesystem.
> Please help me to ceph builds upon zfs filesystem.
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

