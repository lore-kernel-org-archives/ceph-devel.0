From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH RESEND] ceph: avoid panic with mismatched symlink sizes
 in fill_inode()
Date: Fri, 03 Feb 2012 14:24:32 -0600
Message-ID: <1328300672.21405.90.camel@doink>
References: <1328280936-2688-1-git-send-email-xi.wang@gmail.com>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43698 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432Ab2BCUYi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 15:24:38 -0500
In-Reply-To: <1328280936-2688-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xi Wang <xi.wang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-02-03 at 09:55 -0500, Xi Wang wrote:
> Return -EINVAL rather than panic if iinfo->symlink_len and
> inode->i_size do not match.
> 
> Also use kstrndup rather than kmalloc/memcpy.
> 
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Looks good, though it might good to at least call
WARN_ON().  What do you think?

I will commit this (either with or without the
WARN_ON()).

Reviewed-by: Alex Elder <elder@dreamhost.com>


