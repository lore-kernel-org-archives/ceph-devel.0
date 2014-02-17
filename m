From: Guangliang Zhao <lucienchao@gmail.com>
Subject: Re: [PATCH 2/3] ceph: add acl, noacl options for cephfs mount
Date: Mon, 17 Feb 2014 22:27:04 +0800
Message-ID: <20140217142704.GA7383@x230>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
 <1392355784-10422-3-git-send-email-lucienchao@gmail.com>
 <52FE135E.2070704@ieee.org>
 <alpine.DEB.2.00.1402161001310.17892@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:51291 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaBQO1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2014 09:27:15 -0500
Received: by mail-pa0-f48.google.com with SMTP id kx10so15389018pab.35
        for <ceph-devel@vger.kernel.org>; Mon, 17 Feb 2014 06:27:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1402161001310.17892@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@ieee.org>, ceph-devel@vger.kernel.org

On Sun, Feb 16, 2014 at 10:26:54AM -0800, Sage Weil wrote:
> Hi Alex, Guangliang,
> 
> On Fri, 14 Feb 2014, Alex Elder wrote:
> > On 02/13/2014 11:29 PM, Guangliang Zhao wrote:
> > > Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> > 
> > If CONFIG_CEPH_FS_POSIX_ACL is defined, the default is to
> > have them enabled; if it is not, the default is to have it
> > disabled.  But now, whether enabled or not is possible to
> > enable/disable them using a mount option.
> > 
> > Well, it appears that way.  However fs/ceph/acl.o is not
> > built unless CONFIG_CEP_FS_POSIX_ACL is enabled.  So the
> > mount options will appear to be supported but will be
> > silently ignored.
> > 
> > I don't think you want to require CEPH_FS_POSIX_ACL,
> > because that requires the inclusion of FS_POSIX_ACL
> > which may not be desired.
> > 
> > So you should probably make all the code related to
> > the the acl options (or at least the acl enabled option)
> > be conditional on CEPH_FS_POSIX_ACL, even though I think
> > that won't look all that nice.
> 
> I've gone ahead and done this.  Please see the patch below...

It looks good to me.

> 
> sage
> 
> From bc199dc7a5e891fe7d95bf9cd583a9e222a8e1fd Mon Sep 17 00:00:00 2001
> From: Sage Weil <sage@inktank.com>
> Date: Sun, 16 Feb 2014 10:05:29 -0800
> Subject: [PATCH] ceph: add acl, noacl options for cephfs mount
> 
> Make the 'acl' option dependent on having ACL support compiled in.  Make
> the 'noacl' option work even without it so that one can always ask it to
> be off and not error out on mount when it is not supported.
> 
> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  fs/ceph/super.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2df963f..10a4ccb 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -144,7 +144,11 @@ enum {
>  	Opt_ino32,
>  	Opt_noino32,
>  	Opt_fscache,
> -	Opt_nofscache
> +	Opt_nofscache,
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	Opt_acl,
> +#endif
> +	Opt_noacl
>  };
>  
>  static match_table_t fsopt_tokens = {
> @@ -172,6 +176,10 @@ static match_table_t fsopt_tokens = {
>  	{Opt_noino32, "noino32"},
>  	{Opt_fscache, "fsc"},
>  	{Opt_nofscache, "nofsc"},
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	{Opt_acl, "acl"},
> +#endif
> +	{Opt_noacl, "noacl"},
>  	{-1, NULL}
>  };
>  
> @@ -271,6 +279,14 @@ static int parse_fsopt_token(char *c, void *private)
>  	case Opt_nofscache:
>  		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
>  		break;
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	case Opt_acl:
> +		fsopt->sb_flags |= MS_POSIXACL;
> +		break;
> +#endif
> +	case Opt_noacl:
> +		fsopt->sb_flags &= ~MS_POSIXACL;
> +		break;
>  	default:
>  		BUG_ON(token);
>  	}
> @@ -438,6 +454,13 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  	else
>  		seq_puts(m, ",nofsc");
>  
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	if (fsopt->sb_flags & MS_POSIXACL)
> +		seq_puts(m, ",acl");
> +	else
> +		seq_puts(m, ",noacl");
> +#endif
> +
>  	if (fsopt->wsize)
>  		seq_printf(m, ",wsize=%d", fsopt->wsize);
>  	if (fsopt->rsize != CEPH_RSIZE_DEFAULT)
> @@ -819,9 +842,6 @@ static int ceph_set_super(struct super_block *s, void *data)
>  
>  	s->s_flags = fsc->mount_options->sb_flags;
>  	s->s_maxbytes = 1ULL << 40;  /* temp value until we get mdsmap */
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -	s->s_flags |= MS_POSIXACL;
> -#endif
>  
>  	s->s_xattr = ceph_xattr_handlers;
>  	s->s_fs_info = fsc;
> @@ -911,6 +931,10 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
>  	struct ceph_options *opt = NULL;
>  
>  	dout("ceph_mount\n");
> +
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +	flags |= MS_POSIXACL;
> +#endif
>  	err = parse_mount_options(&fsopt, &opt, flags, data, dev_name, &path);
>  	if (err < 0) {
>  		res = ERR_PTR(err);
> -- 
> 1.8.5.1
> 

-- 
Best regards,
Guangliang
