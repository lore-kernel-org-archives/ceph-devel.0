From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: ensure Boolean options support both senses
Date: Fri, 2 Mar 2012 13:44:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021342500.6413@cobra.newdream.net>
References: <4F4DADD0.2020707@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42550 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759Ab2CBVoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:44:30 -0500
In-Reply-To: <4F4DADD0.2020707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 28 Feb 2012, Alex Elder wrote:

> Many ceph-related Boolean options offer the ability to both enable
> and disable a feature.  For all those that don't offer this, add
> a new option so that they do.
> 
> Note that ceph_show_options()--which reports mount options currently
> in effect--only reports the option if it is different from the
> default value.

The general problem with these types of options is that the default may 
shift over time.. that's why the existing foo and nofoo options were 
there.  In those cases, I think it also makes sense to put either foo or 
nofoo in the show_options() function unconditionally so that it is 
unambiguous.  On the other hand, that tends to pollute that string with 
things like noino32, which no normal person would ever use.

Soo.. I guess in these cases, the default will never shift, so this is 
good as is.  :)

Reviewed-by: Sage Weil <sage@newdream.net>


> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  fs/ceph/super.c        |   10 ++++++++++
>  net/ceph/ceph_common.c |   10 ++++++++++
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 1d325bc..8e497a6 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -130,8 +130,10 @@ enum {
>  	Opt_nodirstat,
>  	Opt_rbytes,
>  	Opt_norbytes,
> +	Opt_asyncreaddir,
>  	Opt_noasyncreaddir,
>  	Opt_ino32,
> +	Opt_noino32,
>  };
> 
>  static match_table_t fsopt_tokens = {
> @@ -151,8 +153,10 @@ static match_table_t fsopt_tokens = {
>  	{Opt_nodirstat, "nodirstat"},
>  	{Opt_rbytes, "rbytes"},
>  	{Opt_norbytes, "norbytes"},
> +	{Opt_asyncreaddir, "asyncreaddir"},
>  	{Opt_noasyncreaddir, "noasyncreaddir"},
>  	{Opt_ino32, "ino32"},
> +	{Opt_noino32, "noino32"},
>  	{-1, NULL}
>  };
> 
> @@ -228,12 +232,18 @@ static int parse_fsopt_token(char *c, void *private)
>  	case Opt_norbytes:
>  		fsopt->flags &= ~CEPH_MOUNT_OPT_RBYTES;
>  		break;
> +	case Opt_asyncreaddir:
> +		fsopt->flags &= ~CEPH_MOUNT_OPT_NOASYNCREADDIR;
> +		break;
>  	case Opt_noasyncreaddir:
>  		fsopt->flags |= CEPH_MOUNT_OPT_NOASYNCREADDIR;
>  		break;
>  	case Opt_ino32:
>  		fsopt->flags |= CEPH_MOUNT_OPT_INO32;
>  		break;
> +	case Opt_noino32:
> +		fsopt->flags &= ~CEPH_MOUNT_OPT_INO32;
> +		break;
>  	default:
>  		BUG_ON(token);
>  	}
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 621c322..cc91319 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -201,7 +201,9 @@ enum {
>  	Opt_ip,
>  	Opt_last_string,
>  	/* string args above */
> +	Opt_share,
>  	Opt_noshare,
> +	Opt_crc,
>  	Opt_nocrc,
>  };
> 
> @@ -217,7 +219,9 @@ static match_table_t opt_tokens = {
>  	{Opt_key, "key=%s"},
>  	{Opt_ip, "ip=%s"},
>  	/* string args above */
> +	{Opt_share, "share"},
>  	{Opt_noshare, "noshare"},
> +	{Opt_crc, "crc"},
>  	{Opt_nocrc, "nocrc"},
>  	{-1, NULL}
>  };
> @@ -399,10 +403,16 @@ ceph_parse_options(char *options, const char *dev_name,
>  			opt->mount_timeout = intval;
>  			break;
> 
> +		case Opt_share:
> +			opt->flags &= ~CEPH_OPT_NOSHARE;
> +			break;
>  		case Opt_noshare:
>  			opt->flags |= CEPH_OPT_NOSHARE;
>  			break;
> 
> +		case Opt_crc:
> +			opt->flags &= ~CEPH_OPT_NOCRC;
> +			break;
>  		case Opt_nocrc:
>  			opt->flags |= CEPH_OPT_NOCRC;
>  			break;
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
