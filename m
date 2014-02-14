From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/3] ceph: add acl, noacl options for cephfs mount
Date: Fri, 14 Feb 2014 07:00:14 -0600
Message-ID: <52FE135E.2070704@ieee.org>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com> <1392355784-10422-3-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:57556 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbaBNNGm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 08:06:42 -0500
Received: by mail-ig0-f176.google.com with SMTP id j1so768910iga.3
        for <ceph-devel@vger.kernel.org>; Fri, 14 Feb 2014 05:06:42 -0800 (PST)
In-Reply-To: <1392355784-10422-3-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org
Cc: sage@inktank.com

On 02/13/2014 11:29 PM, Guangliang Zhao wrote:
> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>

If CONFIG_CEPH_FS_POSIX_ACL is defined, the default is to
have them enabled; if it is not, the default is to have it
disabled.  But now, whether enabled or not is possible to
enable/disable them using a mount option.

Well, it appears that way.  However fs/ceph/acl.o is not
built unless CONFIG_CEP_FS_POSIX_ACL is enabled.  So the
mount options will appear to be supported but will be
silently ignored.

I don't think you want to require CEPH_FS_POSIX_ACL,
because that requires the inclusion of FS_POSIX_ACL
which may not be desired.

So you should probably make all the code related to
the the acl options (or at least the acl enabled option)
be conditional on CEPH_FS_POSIX_ACL, even though I think
that won't look all that nice.

I have another question/suggestion for you to consider,
below, which is sort of separate from this particular
change.

> ---
>  fs/ceph/super.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 2df963f..9d65c08 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -144,7 +144,9 @@ enum {
>  	Opt_ino32,
>  	Opt_noino32,
>  	Opt_fscache,
> -	Opt_nofscache
> +	Opt_nofscache,
> +	Opt_acl,
> +	Opt_noacl
>  };
>  
>  static match_table_t fsopt_tokens = {
> @@ -172,6 +174,8 @@ static match_table_t fsopt_tokens = {
>  	{Opt_noino32, "noino32"},
>  	{Opt_fscache, "fsc"},
>  	{Opt_nofscache, "nofsc"},
> +	{Opt_acl, "acl"},
> +	{Opt_noacl, "noacl"},
>  	{-1, NULL}
>  };
>  
> @@ -271,6 +275,12 @@ static int parse_fsopt_token(char *c, void *private)
>  	case Opt_nofscache:
>  		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
>  		break;
> +	case Opt_acl:
> +		fsopt->sb_flags |= MS_POSIXACL;
> +		break;
> +	case Opt_noacl:
> +		fsopt->sb_flags &= ~MS_POSIXACL;

This hunk would be affected by my suggestion, below.

> +		break;
>  	default:
>  		BUG_ON(token);
>  	}
> @@ -438,6 +448,11 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
>  	else
>  		seq_puts(m, ",nofsc");
>  
> +	if (fsopt->sb_flags & MS_POSIXACL)
> +		seq_puts(m, ",acl");
> +	else
> +		seq_puts(m, ",noacl");
> +
>  	if (fsopt->wsize)
>  		seq_printf(m, ",wsize=%d", fsopt->wsize);
>  	if (fsopt->rsize != CEPH_RSIZE_DEFAULT)
> @@ -819,9 +834,6 @@ static int ceph_set_super(struct super_block *s, void *data)
>  
>  	s->s_flags = fsc->mount_options->sb_flags;
>  	s->s_maxbytes = 1ULL << 40;  /* temp value until we get mdsmap */
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -	s->s_flags |= MS_POSIXACL;
> -#endif
>  
>  	s->s_xattr = ceph_xattr_handlers;
>  	s->s_fs_info = fsc;
> @@ -911,6 +923,10 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
>  	struct ceph_options *opt = NULL;
>  
>  	dout("ceph_mount\n");
> +
> +#ifdef CONFIG_CEPH_FS_POSIX_ACL
> +       flags |= MS_POSIXACL;

(You appear to have spaces here instead of a tab.)

> +#endif
>  	err = parse_mount_options(&fsopt, &opt, flags, data, dev_name, &path);
>  	if (err < 0) {
>  		res = ERR_PTR(err);
> 

OK, here's my question/suggestion.  Why are superblock/mount options
not treated the same way as the rest?  I think there should be a
CEPH_MOUNT_OPT_FS_ACL flag added to the set available for
ceph_mount_options->flags, and just get rid of the fs_flags field
in that structure.  Then a new function like ceph_set_super_flags()
could be called from ceph_set_super() which would pick out superblock
related flags from the ceph_mount_option->flags field and set the
appropriate bits in super_block->flags.

					-Alex

