From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 6/8] libceph: avoid dropping con mutex before fault
Date: Mon, 30 Jul 2012 19:12:16 -0500
Message-ID: <501722E0.1080203@inktank.com>
References: <1343663971-3221-1-git-send-email-sage@inktank.com> <1343663971-3221-7-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:45013 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2GaAMR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 20:12:17 -0400
Received: by ghrr11 with SMTP id r11so5492088ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 17:12:16 -0700 (PDT)
In-Reply-To: <1343663971-3221-7-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 10:59 AM, Sage Weil wrote:
> The ceph_fault() function takes the con mutex, so we should avoid
> dropping it before calling it.  This fixes a potential race with
> another thread calling ceph_con_close(), or _open(), or similar (we
> don't reverify con->state after retaking the lock).
> 
> Add annotation so that lockdep realizes we will drop the mutex before
> returning.
> 
> Signed-off-by: Sage Weil <sage@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/messenger.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index feb5a2a..c3b628c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2336,7 +2336,6 @@ done_unlocked:
>  	return;
>  
>  fault:
> -	mutex_unlock(&con->mutex);
>  	ceph_fault(con);     /* error/fault path */
>  	goto done_unlocked;
>  }
> @@ -2347,9 +2346,8 @@ fault:
>   * exponential backoff
>   */
>  static void ceph_fault(struct ceph_connection *con)
> +	__releases(con->mutex)
>  {
> -	mutex_lock(&con->mutex);
> -
>  	pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
>  	       ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg);
>  	dout("fault %p state %lu to peer %s\n",
> 

