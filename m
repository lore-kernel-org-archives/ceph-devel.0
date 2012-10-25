From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] libceph: avoid NULL kref_put when osd reset races with
 alloc_msg
Date: Thu, 25 Oct 2012 09:28:46 -0500
Message-ID: <50894C9E.1090705@inktank.com>
References: <1351120829-12219-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:40397 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759595Ab2JYO2y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 10:28:54 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1325189iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 07:28:53 -0700 (PDT)
In-Reply-To: <1351120829-12219-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/24/2012 06:20 PM, Sage Weil wrote:
> The ceph_on_in_msg_alloc() method drops con->mutex while it allocates a
> message.  If that races with a timeout that resends a zillion messages and
> resets the connection, and the ->alloc_msg() method returns a NULL message,
> it will call ceph_msg_put(NULL) and BUG.

The fix is the right thing to do, but your explanation is wrong.
If msg is null at that point, it's because con->ops->alloc_msg()
failed, and has nothing to do with the mutex state.

So yes, the returned pointer should be checked for null before
dropping a reference, but that's all there is to it...

Perhaps it's the zillion messages that are leading to the
message allocation failure somehow.

> Fix by only calling put if msg is non-NULL.
> 
> Fixes http://tracker.newdream.net/issues/3142

Is that the right bug number?

> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Please fix the explanation, but otherwise this looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

>  net/ceph/messenger.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 66f6f56..1041114 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2742,7 +2742,8 @@ static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
>  		msg = con->ops->alloc_msg(con, hdr, skip);
>  		mutex_lock(&con->mutex);
>  		if (con->state != CON_STATE_OPEN) {
> -			ceph_msg_put(msg);
> +			if (msg)
> +				ceph_msg_put(msg);
>  			return -EAGAIN;
>  		}
>  		con->in_msg = msg;
> 

