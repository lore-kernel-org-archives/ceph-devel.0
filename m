From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/2] rbd: fix read-only option name
Date: Wed, 24 Oct 2012 10:02:13 -0700
Message-ID: <50881F15.6040207@inktank.com>
References: <508577B6.2020708@inktank.com> <50857809.2010303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:48414 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756980Ab2JXRCP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 13:02:15 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so335762dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 10:02:15 -0700 (PDT)
In-Reply-To: <50857809.2010303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/22/2012 09:44 AM, Alex Elder wrote:
> The name of the "read-only" mapping option was inadvertently changed
> in this commit:
>
>      f84344f3 rbd: separate mapping info in rbd_dev
>
> Revert that hunk to return it to what it should be.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 65e9f1f..d032883 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -397,7 +397,7 @@ enum {
>   static match_table_t rbd_opts_tokens = {
>   	/* int args above */
>   	/* string args above */
> -	{Opt_read_only, "mapping.read_only"},
> +	{Opt_read_only, "read_only"},
>   	{Opt_read_only, "ro"},		/* Alternate spelling */
>   	{Opt_read_write, "read_write"},
>   	{Opt_read_write, "rw"},		/* Alternate spelling */
>

