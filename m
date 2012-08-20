From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] doc: mkcephfs man page, -c ceph.conf is not optional
Date: Mon, 20 Aug 2012 13:14:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208201314110.26904@cobra.newdream.net>
References: <CACkq2mpfk+Toccayvp6fJ7Hry6CEuceipLJxujq1SQUFXv9STQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35862 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab2HTUOP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 16:14:15 -0400
In-Reply-To: <CACkq2mpfk+Toccayvp6fJ7Hry6CEuceipLJxujq1SQUFXv9STQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Fri, 17 Aug 2012, Travis Rhoden wrote:

> The man page for mkcephfs and the output of mkcephfs --help
> do not agree with each other.  the man page says -c ceph.conf
> is optional, while mkcephfs --help says it is required.
> 
> Through empirical evidence, I believe it is required.  Update
> the man page to make it so.
> 
> Signed-off-by: Travis Rhoden <trhoden@gmail.com>
> ---
>  doc/man/8/mkcephfs.rst |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/doc/man/8/mkcephfs.rst b/doc/man/8/mkcephfs.rst
> index ddc378a..5d0c995 100644
> --- a/doc/man/8/mkcephfs.rst
> +++ b/doc/man/8/mkcephfs.rst
> @@ -7,7 +7,7 @@
>  Synopsis
>  ========
> 
> -| **mkcephfs** [ -c *ceph.conf* ] [ --mkbtrfs ] [ -a, --all-hosts [ -k
> +| **mkcephfs** -c *ceph.conf* [ --mkbtrfs ] [ -a, --all-hosts [ -k
>    */path/to/admin.keyring* ] ]
> 
> 
> --
> 1.7.4.4
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
