From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] libceph: fix protocol feature mismatch failure path
Date: Thu, 27 Dec 2012 18:30:08 -0600
Message-ID: <50DCE810.2030405@inktank.com>
References: <1356653240-23146-1-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46176 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab2L1AaL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Dec 2012 19:30:11 -0500
Received: by mail-ie0-f177.google.com with SMTP id k13so12221878iea.22
        for <ceph-devel@vger.kernel.org>; Thu, 27 Dec 2012 16:30:11 -0800 (PST)
In-Reply-To: <1356653240-23146-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 12/27/2012 06:07 PM, Sage Weil wrote:
> We should not set con->state to CLOSED here; that happens in ceph_fault()
> in the caller, where it first asserts that the state is not yet CLOSED.

I'm not seeing the code path you're talking about.
Do you mean in the LOSSYTX case?

(I don't doubt you're right, I'm just trying to follow
along at home.)

> Avoids a BUG when the features don't match.

Is this related to the crashes reported here?
    http://tracker.newdream.net/issues/3657

> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 4d111fd..24a5c86 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1508,9 +1508,9 @@ static int process_banner(struct ceph_connection *con)
>  
>  static void fail_protocol(struct ceph_connection *con)
>  {
> +	dout("fail_protocol %p\n", con);
>  	reset_connection(con);
>  	BUG_ON(con->state != CON_STATE_NEGOTIATING);

Since fail_protocol becomes essentially a trivial wrapper
for reset_connection(), I think it should just go away
and call reset_connection() directly.  The assertion that
it's in NEGOTIATING state is not very useful at the moment;
fail_protocol() is only called from process_connect(),
and that's only called from try_read when the state
is NEGOTIATING.

					-Alex

> -	con->state = CON_STATE_CLOSED;
>  }
>  
>  static int process_connect(struct ceph_connection *con)
> 

