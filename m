From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] rbd: allow escaping in config string
Date: Mon, 19 Sep 2011 16:06:17 +0200
Message-ID: <4E774C59.3070401@redhat.com>
References: <1316121071-7690-1-git-send-email-sage@newdream.net> <1316121071-7690-3-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6630 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab1ISODU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Sep 2011 10:03:20 -0400
In-Reply-To: <1316121071-7690-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

Am 15.09.2011 23:11, schrieb Sage Weil:
> The config string is variously delimited by =, @, and /, depending on the
> field.  Allow these characters to be escaped by preceeding them with \.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  block/rbd.c |   29 +++++++++++++++++++++++++++--
>  1 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index f64b2e0..43f0e63 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -104,8 +104,15 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
>      *p = NULL;
>  
>      if (delim != '\0') {
> -        end = strchr(src, delim);
> -        if (end) {
> +        for (end = src; *end; ++end) {
> +            if (*end == delim) {
> +                break;
> +            }
> +            if (*end == '\\') {
> +                end++;
> +            }
> +        }

If src ends with a backslash, you read beyond the end of the string.

> +        if (*end == delim) {
>              *p = end + 1;
>              *end = '\0';
>          }
> @@ -124,6 +131,19 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
>      return 0;
>  }
>  
> +static void qemu_rbd_unescape(char *src)
> +{
> +    char *p;
> +
> +    for (p = src; *src; ++src, ++p) {
> +        if (*src == '\\') {
> +            src++;
> +        }
> +        *p = *src;
> +    }
> +    *p = '\0';
> +}

This has the same problem.

Wouldn't it make sense to have the unescape integrated in
qemu_rbd_next_tok? Or are there any places where you would want to call
it without doing a qemu_rbd_unescape() afterwards?

Kevin
