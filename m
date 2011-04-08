From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] cfuse recognizing same xattr subset as kernel client
Date: Fri, 8 Apr 2011 16:23:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104081623030.15928@cobra.newdream.net>
References: <BANLkTikZKszEiZqUNygTx+BxbAy8j3b_LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51933 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757355Ab1DHXUh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 19:20:37 -0400
In-Reply-To: <BANLkTikZKszEiZqUNygTx+BxbAy8j3b_LQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 8 Apr 2011, Brian Chrisman wrote:
> Hopefully this patch is formatted/signed off correctly.

Applied, thanks!

I did have to fix the word wrapping.  Depending on your mailer you should 
be able to inline the message without reformatting (^R in pine, if you're 
old like me).

sage


> 
> Signed-off-by: Brian Chrisman <brchrisman@gmail.com>
> ---
>  src/client/Client.cc |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index aa50452..95f102a 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -5715,8 +5715,8 @@ int Client::ll_setxattr(vinodeno_t vino, const
> char *name, const void *value, si
>    tout << vino.ino.val << std::endl;
>    tout << name << std::endl;
> 
> -  // only user xattrs, for now
> -  if (strncmp(name, "user.", 5))
> +  // same xattrs supported by kernel client
> +  if (strncmp(name, "user.", 5) && strncmp(name, "security.", 9) &&
> strncmp(name, "trusted.", 8))
>      return -EOPNOTSUPP;
> 
>    Inode *in = _ll_get_inode(vino);
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
