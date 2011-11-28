From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] debian init: Do not stop or start daemons when installing
 or upgrading
Date: Mon, 28 Nov 2011 09:06:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111280906410.11288@cobra.newdream.net>
References: <1321472475-19115-1-git-send-email-wido@widodh.nl>
 <1321472475-19115-2-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53071 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab1K1RGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 12:06:43 -0500
In-Reply-To: <1321472475-19115-2-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Applied.

On Wed, 16 Nov 2011, Wido den Hollander wrote:

> 
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
>  debian/rules |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/debian/rules b/debian/rules
> index a20258d..4f3fe62 100755
> --- a/debian/rules
> +++ b/debian/rules
> @@ -98,7 +98,7 @@ binary-arch: build install
>  	dh_installexamples
>  	dh_install --sourcedir=$(DESTDIR) --list-missing
>  	dh_installlogrotate
> -	dh_installinit
> +	dh_installinit --no-start
>  	dh_installman
>  	dh_lintian
>  	dh_link
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
