From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH] ceph: fix buffer pointer advance in ceph_sync_write
Date: Tue, 19 Mar 2013 09:10:58 -0700
Message-ID: <6A2261C6833F4C81AA57A874D841B937@inktank.com>
References: <1363657586-9116-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42579 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436Ab3CSQLC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 12:11:02 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so399036dan.33
        for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 09:11:01 -0700 (PDT)
In-Reply-To: <1363657586-9116-1-git-send-email-henry.cy.chang@gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Sage beat me to it and merged this in last night. Thanks much! 
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Monday, March 18, 2013 at 6:46 PM, Henry C Chang wrote:

> We should advance the user data pointer by _len_ instead of _written_.
> _len_ is the data length written in each iteration while _written_ is the
> accumulated data length we have writtent out.
> 
> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> ---
> fs/ceph/file.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e51558f..4bcbcb6 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -608,7 +608,7 @@ out:
> pos += len;
> written += len;
> left -= len;
> - data += written;
> + data += len;
> if (left)
> goto more;
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html



