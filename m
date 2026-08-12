Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9322E3A1684
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520721; cv=none; b=fs0SLbgX+9mDTwgyV3xz86W7WDFZEp7Dr+if5SCGd6FIQ+1QxRryB02rfkFjttYqq8rTGx0Bh49bfBmOOkenSrH4t3wgQXyp/XkZgfngb6IgsHOT6VlcLBKdIs2jqQQ1xYJcqrn/BjtruhEkwhHCuQF10nWAh2+h/Bgyrj1Hmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520721; c=relaxed/simple;
	bh=0s6ElZ0ADmhw+cj0QguvAi55vrfhHcqnEQ0pSDQeh8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZM86vW516+bFMJ59yk4qjPPXjdtYeO3vKnUAfNReFAi7q6pVvD3vQXlOnTgjJxjm8Ei034fZB9AN+U+Ke/U4/zMx9Brd2EkzkGGYIj438CyEREXqBpzdx6YxM2H22suj1igg7WjUkC9xJfIvY7PB5mb1P5Sm7aMHof97FQtVFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqBX2mJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqBX2mJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A601F00A3F
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786520719;
	bh=rX7Q4WvGDV5OJJu1UE+ZXUg8PLOCz7ttRV0A5aPdUbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UqBX2mJMbuVnvIZJlpMqifH9W5SVb/eTyznRCZfZIkFg9tKDSwHkYrTgFRctwWkpT
	 SXSVYVQND6cdB9Hy2edKlY0fjUA5fBpyz9pGuPCX6vV9nPWUAwxY85F9AaRJ9HlJOQ
	 Itaoj7vaz9cM7KbwOm/mSQ2btFVnvYcOs7KWseWsXB2XxIzcMxIIEyyXvxkBTbXAum
	 bMR2jIRGibHYfExr73Gt1kNt+CW63W1y9vYDcNf390nxYzaViuK+BVPoOVxsFhsr9B
	 AH9heJaRPuwUXfPHFcSWNOT9Anf78qOIAkTGWvzt/Rc4arVRGuKSuLByOu5sZfluz2
	 9Xe03bBKZ7tQg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a0faa764beso4183851fa.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 00:45:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0jpQ4hmnurDuvP5L7C145jQU/+qbPtzCETN+aVpvBX6H0VD20
	zoCym7GoDoqtNOP6NfETeqyr2KtezWg+xJmlV8qXaVB7231LYYzB72RgqsouBYDgjDHiutVufe5
	Pa/A1ebO46sDQlPQY44r2sBakPgGh0zQ=
X-Received: by 2002:a05:6512:1053:b0:5b2:a339:b422 with SMTP id
 2adb3069b0e04-5b44e2e2690mr507974e87.14.1786520717974; Wed, 12 Aug 2026
 00:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706140309.1907928-1-amarkuze@redhat.com>
In-Reply-To: <20260706140309.1907928-1-amarkuze@redhat.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Wed, 12 Aug 2026 15:45:06 +0800
X-Gmail-Original-Message-ID: <CAOuZWzxM3PBvKxDz+e7EpWaPOetpEzeSXVDNfsPcb6Fy778V_w@mail.gmail.com>
X-Gm-Features: AUfX_myoLTRjlwGfRD9_1bmtTe4oQgOYWVjd-XBROCa2YZ4UjzjdKMZ_q4PGTeo
Message-ID: <CAOuZWzxM3PBvKxDz+e7EpWaPOetpEzeSXVDNfsPcb6Fy778V_w@mail.gmail.com>
Subject: Re: [PATCH] ceph: make nearfull sync writes opt-in
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, xiubli@redhat.com, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Alex Markuze <amarkuze@redhat.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80 07:03=E5=86=99=E9=81=93=EF=BC=9A
>
> The kernel CephFS client has historically treated a cluster or pool
> NEARFULL condition as a request to force successful writes through
> generic_write_sync().  That effectively turns otherwise buffered writes
> into synchronous writes and can cause a severe throughput drop as soon
> as a single OSD or the file data pool crosses the nearfull threshold.
>
> On modern large clusters, NEARFULL is primarily an operator health
> signal rather than an immediate client-side capacity failure.  Operators
> can still have substantial usable capacity while a cluster is
> rebalancing, splitting PGs, or expanding onto new devices.  RBD, RGW and
> the userspace CephFS client do not impose this extra client-side
> sync-write throttle, so the kernel client behavior is surprising and
> operationally painful.
>
> Change the default behavior so NEARFULL no longer changes normal
> write-sync semantics.  FULL and pool FULL still fail with -ENOSPC, and
> explicitly synchronous writes continue to be synced by
> generic_write_sync().
>
> Add a nearfull_sync mount option for deployments that want the legacy
> backpressure behavior.  When this option is set, successful writes are
> promoted to IOCB_DSYNC if the cluster or file data pool is marked
> NEARFULL, preserving the old behavior for conservative deployments.
>
> Link: https://tracker.ceph.com/issues/74849
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  Documentation/filesystems/ceph.rst |  6 ++++++
>  fs/ceph/file.c                     |  8 +++++---
>  fs/ceph/super.c                    | 10 ++++++++++
>  fs/ceph/super.h                    |  1 +
>  4 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesyste=
ms/ceph.rst
> index 6d2276a87a5a..ee2ca0c0c654 100644
> --- a/Documentation/filesystems/ceph.rst
> +++ b/Documentation/filesystems/ceph.rst
> @@ -194,6 +194,12 @@ Mount Options
>          copies.  Currently, it's only used in copy_file_range, which wil=
l revert
>          to the default VFS implementation if this option is used.
>
> +  nearfull_sync
> +       Force written data to stable storage when the cluster or file dat=
a pool is
> +       marked NEARFULL. This restores the legacy client-side backpressur=
e
> +       behavior. By default, CephFS writes are not forced synchronous so=
lely
> +       because of NEARFULL.
> +
>    recover_session=3D<no|clean>
>         Set auto reconnect mode in the case where the client is blocklist=
ed. The
>         available modes are "no" and "clean". The default is "no".
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3823671ab95a..0ae9f09aa233 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2400,7 +2400,8 @@ static ssize_t ceph_splice_read(struct file *in, lo=
ff_t *ppos,
>   * dropping our cap refs and allowing the pending snap to logically
>   * complete _before_ this write occurs.
>   *
> - * If we are near ENOSPC, write synchronously.
> + * If requested, nearfull writes are synced to preserve the legacy
> + * client-side backpressure behavior.
>   */
>  static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from=
)
>  {
> @@ -2568,8 +2569,9 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
>         }
>
>         if (written >=3D 0) {
> -               if ((map_flags & CEPH_OSDMAP_NEARFULL) ||
> -                   (pool_flags & CEPH_POOL_FLAG_NEARFULL))
> +               if (ceph_test_mount_opt(fsc, NEARFULL_SYNC) &&
> +                   ((map_flags & CEPH_OSDMAP_NEARFULL) ||
> +                    (pool_flags & CEPH_POOL_FLAG_NEARFULL)))
>                         iocb->ki_flags |=3D IOCB_DSYNC;
>                 written =3D generic_write_sync(iocb, written);
>         }
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 0bbd38933f0e..4d129483e345 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -178,6 +178,7 @@ enum {
>         Opt_pagecache,
>         Opt_sparseread,
>         Opt_lazyio,
> +       Opt_nearfull_sync,
>  };
>
>  enum ceph_recover_session_mode {
> @@ -207,6 +208,7 @@ static const struct fs_parameter_spec ceph_mount_para=
meters[] =3D {
>         fsparam_flag_no ("lazyio",                      Opt_lazyio),
>         fsparam_string  ("mds_namespace",               Opt_mds_namespace=
),
>         fsparam_string  ("mon_addr",                    Opt_mon_addr),
> +       fsparam_flag_no ("nearfull_sync",               Opt_nearfull_sync=
),
>         fsparam_flag_no ("poolperm",                    Opt_poolperm),
>         fsparam_flag_no ("quotadf",                     Opt_quotadf),
>         fsparam_u32     ("rasize",                      Opt_rasize),
> @@ -601,6 +603,12 @@ static int ceph_parse_mount_param(struct fs_context =
*fc,
>                 else
>                         fsopt->flags |=3D CEPH_MOUNT_OPT_LAZYIO;
>                 break;
> +       case Opt_nearfull_sync:
> +               if (result.negated)
> +                       fsopt->flags &=3D ~CEPH_MOUNT_OPT_NEARFULL_SYNC;
> +               else
> +                       fsopt->flags |=3D CEPH_MOUNT_OPT_NEARFULL_SYNC;
> +               break;
>         case Opt_test_dummy_encryption:
>  #ifdef CONFIG_FS_ENCRYPTION
>                 fscrypt_free_dummy_policy(&fsopt->dummy_enc_policy);
> @@ -759,6 +767,8 @@ static int ceph_show_options(struct seq_file *m, stru=
ct dentry *root)
>                 seq_puts(m, ",sparseread");
>         if (fsopt->flags & CEPH_MOUNT_OPT_LAZYIO)
>                 seq_puts(m, ",lazyio");
> +       if (fsopt->flags & CEPH_MOUNT_OPT_NEARFULL_SYNC)
> +               seq_puts(m, ",nearfull_sync");
>
>         fscrypt_show_test_dummy_encryption(m, ',', root->d_sb);
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 3737ea7ed88b..632ffb1b401e 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -46,6 +46,7 @@
>  #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altog=
ether */
>  #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads=
 */
>  #define CEPH_MOUNT_OPT_LAZYIO          (1<<18) /* force lazyio for all f=
ile opens */
> +#define CEPH_MOUNT_OPT_NEARFULL_SYNC   (1<<19) /* sync writes when nearf=
ull */
>
>  #define CEPH_MOUNT_OPT_DEFAULT                 \
>         (CEPH_MOUNT_OPT_DCACHE |                \
> --
> 2.34.1
>
>
