From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Add line break after add_key() failure message.
Date: Thu, 21 Jul 2011 08:49:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107210849180.5868@cobra.newdream.net>
References: <oraac882c5.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36430 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab1GUPpl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 11:45:41 -0400
In-Reply-To: <oraac882c5.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Thu, 21 Jul 2011, Alexandre Oliva wrote:

> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/common/secret.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/common/secret.c b/src/common/secret.c
> index f90f478..158343e 100644
> --- a/src/common/secret.c
> +++ b/src/common/secret.c
> @@ -66,7 +66,7 @@ static int add_secret_to_kernel(const char *secret, const char *key_name)
>    serial = add_key("ceph", key_name, payload, sizeof(payload), KEY_SPEC_USER_KEYRING);
>    if (serial < 0) {
>      ret = -errno;
> -    fprintf(stderr, "error adding secret to kernel, key name %s: %s", key_name, strerror(-ret));
> +    fprintf(stderr, "error adding secret to kernel, key name %s: %s.\n", key_name, strerror(-ret));
>    }
>  
>    return ret;
> -- 
> 1.7.4.4
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
