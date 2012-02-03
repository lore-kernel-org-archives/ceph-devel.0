From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH RESEND] ceph: avoid panic with mismatched symlink sizes
 in fill_inode()
Date: Fri, 03 Feb 2012 15:04:30 -0600
Message-ID: <1328303070.21405.91.camel@doink>
References: <1328280936-2688-1-git-send-email-xi.wang@gmail.com>
	 <1328300672.21405.90.camel@doink>
	 <972F971B-171E-467D-8E64-C1C49CB94622@gmail.com>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33094 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab2BCVEg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 16:04:36 -0500
In-Reply-To: <972F971B-171E-467D-8E64-C1C49CB94622@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-02-03 at 15:49 -0500, Xi Wang wrote:
> On Feb 3, 2012, at 3:24 PM, Alex Elder wrote:
> > Looks good, though it might good to at least call
> > WARN_ON().  What do you think?
> 
> Sounds good to me.  I will send a v2.  Thanks.

No need.  I can do it for you.	-Alex

> - xi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



