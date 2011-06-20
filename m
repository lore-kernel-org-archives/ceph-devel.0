From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: cfuse vs kernel mount. differences.
Date: Mon, 20 Jun 2011 11:09:10 -0700
Message-ID: <D213CC9E-2D79-44E7-BB49-C5BFD9192E4F@dreamhost.com>
References: <4DFCC7E4.70307@ufm.su>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46371 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1FTSJL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2011 14:09:11 -0400
In-Reply-To: <4DFCC7E4.70307@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org


On Jun 18, 2011, at 8:44 AM, Fyodor Ustinov wrote:

> Hi!
> 
> 1-st. Mount by kernel:
> 
> root@stb1:~# df /mnt
> Filesystem           1K-blocks      Used Available Use% Mounted on
> 10.5.51.230:/        51409168384 799601664 49637535744   2% /mnt
> 
> 2-nd. Mount by cfuse:
> 
> root@stb1:~# df /mnt
> Filesystem           1K-blocks      Used Available Use% Mounted on
> cfuse                51409169084 1771587996 49637581088   4% /mnt
> 
> Hmm... All different. It's correct? Who should I believe?
> 
> kernel 3.0.0-rc3
> ceph - 0.29.1
> 
> WBR,
>    Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

In this case, cfuse is probably more accurate -- the kernel client is doing some acrobatics with the page size
so it can handle larger filesystems, but it trades off in accuracy for it. The kernel client is also just using a roundabout method for calculating free space, which we can change. Now that you've pointed it out though, we should have the userspace client do the same tradeoff for supporting a larger FS!
-Greg