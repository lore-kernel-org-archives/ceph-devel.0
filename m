From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Generate URL-safe base64 strings for keys.
Date: Wed, 4 Jul 2012 08:16:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207040816350.6931@cobra.newdream.net>
References: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
 <1341405987-26469-1-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58045 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2GDPQv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 11:16:51 -0400
In-Reply-To: <1341405987-26469-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Wed, 4 Jul 2012, Wido den Hollander wrote:
> By using this we prevent scenarios where cephx keys are not accepted
> in various situations.
> 
> Replacing the + and / by - and _ we generate URL-safe base64 keys
> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>

Do already properly decode URL-sage base64 encoding?

sage

> ---
>  src/common/armor.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/common/armor.c b/src/common/armor.c
> index d1d5664..7f73da1 100644
> --- a/src/common/armor.c
> +++ b/src/common/armor.c
> @@ -9,7 +9,7 @@
>   * base64 encode/decode.
>   */
>  
> -const char *pem_key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> +const char *pem_key = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
>  
>  static int encode_bits(int c)
>  {
> @@ -24,9 +24,9 @@ static int decode_bits(char c)
>  		return c - 'a' + 26;
>  	if (c >= '0' && c <= '9')
>  		return c - '0' + 52;
> -	if (c == '+')
> +	if (c == '+' || c == '-')
>  		return 62;
> -	if (c == '/')
> +	if (c == '/' || c == '_')
>  		return 63;
>  	if (c == '=')
>  		return 0; /* just non-negative, please */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
