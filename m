Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B71DD0EF
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 02:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787712852; cv=pass; b=q5EYbxIS16yQbRcvkiJ+Pd6VWkJOKoOgAUvAoiPqQJ5JCtG2Zu7MfzoX0Gj3UQeBfLGxF/tu8O9vznpHCo19JnMGFSgcYirpT34sJdhofubyJZuF/V1MlD4ufy8LTd0akq1ref/4TQaI7jNNN4ynJ6kJf+DnP8GDMrixMdZIJOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787712852; c=relaxed/simple;
	bh=6vNfvq9Y5dq7MzNv/vH5sMjXHSmVuBBMN16OuBEzyPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kvttv5zdSmzafnBOFuyTkB9QB8BOZtx4SRfDXCd6wPeLkft7lwWY8WKYA33D+IRvuyHwqeS+L2J927vAEuvr2+awxg4HQEvUz/TAotbe5yaSPTl+QEEURpbCBYZy4fZKimDvDZsGSgYvbzvHcg05XIMdwKGjV+rYzAx0aOk0hBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=MtdnjSDe; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="MtdnjSDe"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c247f6687dcso48412266b.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 19:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787712846; cv=none;
        d=google.com; s=arc-20260327;
        b=mj1B0aDhPN7hTh/10dkoB4uuRIQzB49IjgGDFWdfiwoJXrXoOVBFs3iBTg/wMPstxw
         a6oFWj7OniJzKs6hIC8QA4vlnJugL3EiXQtT6EZA2oAIjgp/DVOIpGs3qnh3Y0Aoyyg0
         oxfxyeB5FWhbvkXz+4MoJE70qAffcg9prerZXb4a115qDe22SUvJ9zEqb8wqy4tV4uuD
         lvvAjTgDavCSxlnQVuqltGXkcOWNLFPtt4EnINg+pxgW/Gt2Bsm5SI+Rm55wci80jBgP
         uRW9hMy2V6vSqWpfTdfq02jm+72+VVu/Lu0tDtOOThBIiQKwdZVQK/ece8Ajifnc8VQf
         sGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SToxf08jI80OIC6P0SV6k1dBFJIToQfHtVLcrEPQn1I=;
        fh=pIciOk8RuDbzuQBffBFO3/k/5aI/2oI+afLOzVHN3y0=;
        b=szKzrkB+9XyEh6M1VeraMXxnwIdaf8KaVKO5QCVCwk0kYCXtaR4vvOpuRS0cL85O2Q
         cZ5dq8zuzSLu4ODSIvKRXMyjydAMdUSoR8V3etFaNl+k6Pn2T8/AYnCF6vj+AowJPkQ9
         oMNI+O97ObZeJ9jhql1Lv2VrwLP0YQS2ofIYkai9glUHeT7aqYUCB8uGjRWBGuk+EKtV
         UI6U8LZo02wQN5Daf3e3+0Nv3WVq7JiesQ8oye/jSE5xduepKUZgorHAPRbmiMtZ1uxx
         aEbyJxe4rq3XhrVJA8Iws1rK1abFOu1MVPTqr7wI9urprgzSdbjfUE6hjw3tfSYVq94+
         0Hrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787712846; x=1788317646; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SToxf08jI80OIC6P0SV6k1dBFJIToQfHtVLcrEPQn1I=;
        b=MtdnjSDet+DO4QnUv62Kd6s7Wm5onthEeAKZI9nkklKz8LKarYscSb14tXkdfFNPEJ
         UPgkDp35kzk6C3eUS6EXRCv9f7TtPge4rwqwgABJLVXS9jtV0VqNR7P51Q+4D5IbeGI9
         gbMAZ3mY+rcs2O9DvEreIvPdiRWnzMTZyN/0E0DqiKUltrTaRFrAtWycUYk8blRWzBWf
         Tr2SGJn28wxVdGLZp6HSEVJHTYb7nQJpZkaM7CkO9uR4/WL9A4eKiZK0k2lEkHVogoE2
         m/RjttJ8WWQx/DmJiu5l6C6V9YDmEH4KEsqXVdvAl/hbHPu//7GDWKWNJZSrUfgkYhfr
         mECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787712846; x=1788317646;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SToxf08jI80OIC6P0SV6k1dBFJIToQfHtVLcrEPQn1I=;
        b=YxgQ0GElifMkXKXvMHQA9iD3HqDwyx+Tgb3ZKA+Br4gzUuS/ezQ7VtLv/kZOYK6BJ5
         7WIxDKy9oR6kxSbyha4kZ4Gt6b1YV7gExCdYJsyE64nEq/WuJI0XnHCHx8jmwNl4kh9e
         amNTyHdZDQDojhrnJEx+FDpjRK+yXGxCm6MYMy0f65Fv5EiGaGXUm+01vFTMxhrT268o
         wgA6H85D+rM6PNlpOKMlA0UcXs1C/pmbnr/hxc8sEbYK/iYb/3TO7w7vct54JcnVoqAD
         RB3lJ52e4gIh/RRmpLr5u9dpkIbxj4hNig7VP/TgkHbyLk4pV/+K3X4nlB7vaRFtztDd
         EyOQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrb7UpEq7TaeIjopnS7k3IXU0xClpptCLGT1rfCqi80H8nT72MQ2MgjJtKl8aMwoEb2t9makff7/NFt@vger.kernel.org
X-Gm-Message-State: AFuF++mlvgEs1lCUZ3qez1uVo11n+frXiK8BF5toIw3oV5Q2sRB0Tfju
	TOnHpp9s6lRnxyWvV6+LfSmMsPvCErvSYm4auRE+Blq8Xni96M0da89/Rhc1pXrThm9QvMWJv3Q
	RbizxumZwcvIBZSy5p6sRBP1fC+tLNei0X3KZ/ZvFxQ==
X-Gm-Gg: AR+sD10SVKk3vg5alwPL42BT8htAnL4hre6GKtah8fOe2hDindVCgUfio1Xt0Hn7H61
	daFknKz38K9fi+/glwkLEy5vPfqcNedYeLeY9UIZtmDp1J+YBVecmHP9nYJ6ktINEE2EcsTwHD/
	nmEGB/3k0Ir/PkDL7oO+FNK83Johd8vvH94HqtxRfqyN7PYzU4m7UF1tkTvQgSlZBS5thAyOKn6
	S8zFLQFmJPCxjsnI4Tk7pcCfaZzsKQMNOc49whWNl/N+lKJvlZo/wphWK1MKxKIr0XtP04RnpnI
	pzXmvkUL5SH/L7J2Pgol0xrsg/vOovsW6BEgC1qzIlRbug==
X-Received: by 2002:a17:907:7b93:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c250c337ccemr355887866b.16.1787712846120; Tue, 25 Aug 2026
 19:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-b4-ceph-remove-inline-data-v2-1-db0c92dab8ee@clyso.com> <20d914756be4793b799de192fc0cc0b208c17655.camel@dubeyko.com>
In-Reply-To: <20d914756be4793b799de192fc0cc0b208c17655.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 25 Aug 2026 19:53:54 -0700
X-Gm-Features: AcwNN1VgmLgH9r7BJbuGpQ55TE1F7pvpIcpB6M1imfEpfE_1oQmxgKB8qwbsnYc
Message-ID: <CAOJNxRLYEpAG_9B8B1U+C9DfiTGgygnhGXTO+X=69dah=MaT8A@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: remove the inline data support
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Viacheslav,

Sorry for late reply. I just missed this email.

Thanks for your feedback and finding. I will fix it later.

BRs
Xiubo

On Wed, 29 Jul 2026 at 17:44, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-29 at 09:28 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > Inline data support has been deprecated in the CephFS MDS and is
> > being formally removed.  Existing inline data can be migrated to
> > data pool objects via MDS scrub (see PR #44359).
> >
> > Add CONFIG_CEPH_FS_INLINE_DATA (default n) to gate all inline data
> > code in the kclient.  When disabled, CEPH_FEATURE_MDS_INLINE_DATA
> > is defined as 0 so that the kclient no longer advertises the
> > feature to the MDS.  The MDS will then refuse to open files that
> > still have inline data, returning -EPERM, preventing silent data
> > corruption that would occur if the kclient tried to read inline
> > data from OSD objects that do not contain it.
> >
> > This config option will be kept for a transitional period to
> > allow existing CephFS deployments to migrate inline data via
> > MDS scrub.  Once the migration period ends, the option and all
> > inline data code will be permanently removed.
> >
> > Users upgrading from an older Ceph release should ensure all inline
> > data has been migrated before deploying a kclient with this option
> > disabled:
> >   1. Enable and run MDS scrub to uninline existing data
> >   2. Disable inline_data on the filesystem:
> >      ceph fs set <fs> inline_data false --yes-i-really-really-mean-it
> >
> > Link: https://tracker-origin.ceph.com/issues/67769
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > Changes in v2:
> > - keep CEPH_FEATURE_MDS_INLINE_DATA always defined as (1ULL << 40)
> >   so decode logic can still check MDS feature bits; gate the
> >   supported features set via CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT
> > - Link to v1:
> > https://patch.msgid.link/20260728-b4-ceph-remove-inline-data-v1-1-8ffa7e08459a@clyso.com
> > ---
> >  fs/ceph/Kconfig                    | 12 ++++++++++++
> >  fs/ceph/addr.c                     | 16 +++++++++++++++
> >  fs/ceph/caps.c                     | 40
> > +++++++++++++++++++++++++++++++++++++-
> >  fs/ceph/file.c                     | 20 +++++++++++++++++++
> >  fs/ceph/inode.c                    | 10 ++++++++++
> >  fs/ceph/mds_client.c               | 30 ++++++++++++++++++++++++++++
> >  fs/ceph/mds_client.h               |  2 ++
> >  fs/ceph/snap.c                     |  2 ++
> >  fs/ceph/super.h                    | 13 +++++++++++++
> >  include/linux/ceph/ceph_features.h |  7 ++++++-
> >  10 files changed, 150 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> > index 3d64a316ca31..be1c8ada5665 100644
> > --- a/fs/ceph/Kconfig
> > +++ b/fs/ceph/Kconfig
> > @@ -17,6 +17,18 @@ config CEPH_FS
> >         If unsure, say N.
> >
> >  if CEPH_FS
> > +config CEPH_FS_INLINE_DATA
> > +     bool "Enable CephFS inline data support (deprecated)"
> > +     depends on CEPH_FS
> > +     default n
> > +     help
> > +       Inline data support has been deprecated in the CephFS MDS
> > +       and is being formally removed.  Existing inline data can
> > be
> > +       migrated to data pool objects via MDS scrub.  Choose N
> > +       unless you have a legacy filesystem that requires it,
> > +       and ensure all inline data has been migrated (see
> > +       ceph fs set <fs> inline_data false) before enabling.
> > +
> >  config CEPH_FSCACHE
> >       bool "Enable Ceph client caching support"
> >       depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index e2da3ab9f808..5211320a50ac 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -274,6 +274,7 @@ static void finish_netfs_read(struct
> > ceph_osd_request *req)
> >       ceph_dec_osd_stopping_blocker(fsc->mdsc);
> >  }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest
> > *subreq)
> >  {
> >       struct netfs_io_request *rreq = subreq->rreq;
> > @@ -335,6 +336,7 @@ static bool ceph_netfs_issue_op_inline(struct
> > netfs_io_subrequest *subreq)
> >       netfs_read_subreq_terminated(subreq);
> >       return true;
> >  }
> > +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> >
> >  static int ceph_netfs_prepare_read(struct netfs_io_subrequest
> > *subreq)
> >  {
> > @@ -372,8 +374,10 @@ static void ceph_netfs_issue_read(struct
> > netfs_io_subrequest *subreq)
> >               goto out;
> >       }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (ceph_has_inline_data(ci) &&
> > ceph_netfs_issue_op_inline(subreq))
> >               return;
> > +#endif
> >
> >       // TODO: This rounding here is slightly dodgy.  It *should*
> > work, for
> >       // now, as the cache only deals in blocks that are a
> > multiple of
> > @@ -2006,7 +2010,11 @@ static vm_fault_t ceph_filemap_fault(struct
> > vm_fault *vmf)
> >             off, ceph_cap_string(got));
> >
> >       if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >           !ceph_has_inline_data(ci)) {
> > +#else
> > +         true) {
> > +#endif
>
> Maybe, some static inline function here?
>
> >               CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
> >               ceph_add_rw_context(fi, &rw_ctx);
> >               ret = filemap_fault(vmf);
> > @@ -2037,7 +2045,11 @@ static vm_fault_t ceph_filemap_fault(struct
> > vm_fault *vmf)
> >                       goto out_inline;
> >               }
> >               err = __ceph_do_getattr(inode, page,
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >                                        CEPH_STAT_CAP_INLINE_DATA,
> > true);
> > +#else
> > +                                      0, true);
> > +#endif
>
> Maybe some macro that can hide this?
>
> >               if (err < 0 || off >= i_size_read(inode)) {
> >                       unlock_page(page);
> >                       put_page(page);
> > @@ -2168,6 +2180,7 @@ static vm_fault_t ceph_page_mkwrite(struct
> > vm_fault *vmf)
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  void ceph_fill_inline_data(struct inode *inode, struct page
> > *locked_page,
> >                          char *data, size_t len)
> >  {
> > @@ -2214,7 +2227,9 @@ void ceph_fill_inline_data(struct inode *inode,
> > struct page *locked_page,
> >               put_page(page);
> >       }
> >  }
> > +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  int ceph_uninline_data(struct file *file)
> >  {
> >       struct inode *inode = file_inode(file);
> > @@ -2370,6 +2385,7 @@ int ceph_uninline_data(struct file *file)
> >             ceph_vinop(inode), inline_version, err);
> >       return err;
> >  }
> > +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> >
> >  static const struct vm_operations_struct ceph_vmops = {
> >       .fault          = ceph_filemap_fault,
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index f8d898ad091e..2fd2116a3308 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -1266,7 +1266,9 @@ struct cap_msg_args {
> >       kuid_t                  uid;
> >       kgid_t                  gid;
> >       umode_t                 mode;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       bool                    inline_data;
> > +#endif
> >       bool                    wake;
> >       bool                    encrypted;
> >       u32                     fscrypt_auth_len;
> > @@ -1336,8 +1338,16 @@ static void encode_cap_msg(struct ceph_msg
> > *msg, struct cap_msg_args *arg)
> >       p = fc + 1;
> >       /* flock buffer size (version 2) */
> >       ceph_encode_32(&p, 0);
> > -     /* inline version (version 4) */
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
> > +#else
> > +     /*
> > +      * Inline data support has been removed.  The field is still
> > +      * encoded for protocol compatibility; always advertise
> > +      * CEPH_INLINE_NONE to indicate no inline data is present.
> > +      */
> > +     ceph_encode_64(&p, CEPH_INLINE_NONE);
> > +#endif
> >       /* inline data size */
> >       ceph_encode_32(&p, 0);
> >       /*
> > @@ -1499,7 +1509,9 @@ static void __prep_cap(struct cap_msg_args
> > *arg, struct ceph_cap *cap,
> >       arg->gid = inode->i_gid;
> >       arg->mode = inode->i_mode;
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       arg->inline_data = ci->i_inline_version != CEPH_INLINE_NONE;
> > +#endif
> >       if (!(flags & CEPH_CLIENT_CAPS_PENDING_CAPSNAP) &&
> >           !list_empty(&ci->i_cap_snaps)) {
> >               struct ceph_cap_snap *capsnap;
> > @@ -1620,7 +1632,9 @@ static inline int __send_flush_snap(struct
> > inode *inode,
> >       arg.gid = capsnap->gid;
> >       arg.mode = capsnap->mode;
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       arg.inline_data = capsnap->inline_data;
> > +#endif
> >       arg.flags = 0;
> >       arg.wake = false;
> >       arg.encrypted = IS_ENCRYPTED(inode);
> > @@ -3192,6 +3206,7 @@ int __ceph_get_caps(struct inode *inode, struct
> > ceph_file_info *fi, int need,
> >                       return ret;
> >               }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >               if (S_ISREG(ci->netfs.inode.i_mode) &&
> >                   ceph_has_inline_data(ci) &&
> >                   (_got &
> > (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
> > @@ -3223,6 +3238,7 @@ int __ceph_get_caps(struct inode *inode, struct
> > ceph_file_info *fi, int need,
> >                               return ret;
> >                       continue;
> >               }
> > +#endif
>
> Ditto. Maybe, some static inline function?
>
> >               break;
> >       }
> >       *got = _got;
> > @@ -3518,10 +3534,12 @@ static void invalidate_aliases(struct inode
> > *inode)
> >
> >  struct cap_extra_info {
> >       struct ceph_string *pool_ns;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       /* inline data */
> >       u64 inline_version;
> >       void *inline_data;
> >       u32 inline_len;
> > +#endif
> >       /* dirstat */
> >       bool dirstat_valid;
> >       u64 nfiles;
> > @@ -3564,7 +3582,9 @@ static void handle_cap_grant(struct inode
> > *inode,
> >       bool queue_trunc = false;
> >       bool queue_invalidate = false;
> >       bool deleted_inode = false;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       bool fill_inline = false;
> > +#endif
> >       bool revoke_wait = false;
> >       int flags = 0;
> >
> > @@ -3830,6 +3850,7 @@ static void handle_cap_grant(struct inode
> > *inode,
> >                       check_caps = 2; /* check all caps */
> >       }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (extra_info->inline_version > 0 &&
> >           extra_info->inline_version >= ci->i_inline_version) {
> >               ci->i_inline_version = extra_info->inline_version;
> > @@ -3837,6 +3858,7 @@ static void handle_cap_grant(struct inode
> > *inode,
> >                   (newcaps &
> > (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
> >                       fill_inline = true;
> >       }
> > +#endif
>
> Ditto.
>
> >
> >       if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
> >               if (ci->i_auth_cap == cap) {
> > @@ -3856,9 +3878,11 @@ static void handle_cap_grant(struct inode
> > *inode,
> >       }
> >       spin_unlock(&ci->i_ceph_lock);
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (fill_inline)
> >               ceph_fill_inline_data(inode, NULL, extra_info-
> > >inline_data,
> >                                     extra_info->inline_len);
> > +#endif
> >
> >       if (queue_trunc)
> >               ceph_queue_vmtruncate(inode);
> > @@ -4476,12 +4500,26 @@ void ceph_handle_caps(struct ceph_mds_session
> > *session,
> >       }
> >
> >       if (msg_version >= 4) {
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >               ceph_decode_64_safe(&p, end,
> > extra_info.inline_version, bad);
> >               ceph_decode_32_safe(&p, end, extra_info.inline_len,
> > bad);
> >               if (p + extra_info.inline_len > end)
> >                       goto bad;
> >               extra_info.inline_data = p;
> >               p += extra_info.inline_len;
> > +#else
> > +             /*
> > +              * Inline data support has been removed, but cap
> > grant
> > +              * messages (msg_version >= 4) always carry
> > inline_version
> > +              * + inline_data.  We must consume the fields to
> > keep the
> > +              * decode pointer in sync.
> > +              */
> > +             u32 __len;
>
> The leading double-underscore is reserved namespace in C. Maybe, simply
> len?
>
> > +
> > +             ceph_decode_skip_64(&p, end, bad);
> > +             ceph_decode_32_safe(&p, end, __len, bad);
> > +             ceph_decode_skip_n(&p, end, __len, bad);
> > +#endif
> >       }
> >
> >       if (msg_version >= 5) {
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 3823671ab95a..901ed97b1963 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -224,7 +224,9 @@ static int ceph_init_file_info(struct inode
> > *inode, struct file *file,
> >               ceph_inode_to_fs_client(&ci->netfs.inode)-
> > >mount_options;
> >       struct ceph_client *cl = ceph_inode_to_client(inode);
> >       struct ceph_file_info *fi;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       int ret;
> > +#endif
> >
> >       doutc(cl, "%p %llx.%llx %p 0%o (%s)\n", inode,
> > ceph_vinop(inode),
> >             file, inode->i_mode, isdir ? "dir" : "regular");
> > @@ -258,14 +260,17 @@ static int ceph_init_file_info(struct inode
> > *inode, struct file *file,
> >       INIT_LIST_HEAD(&fi->rw_contexts);
> >       fi->filp_gen = READ_ONCE(ceph_inode_to_fs_client(inode)-
> > >filp_gen);
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if ((file->f_mode & FMODE_WRITE) &&
> > ceph_has_inline_data(ci)) {
> >               ret = ceph_uninline_data(file);
> >               if (ret < 0)
> >                       goto error;
> >       }
> > +#endif
>
> Maybe, static inline function?
>
> >
> >       return 0;
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  error:
> >       ceph_fscache_unuse_cookie(inode, file->f_mode &
> > FMODE_WRITE);
> >       ceph_put_fmode(ci, fi->fmode, 1);
> > @@ -273,6 +278,7 @@ static int ceph_init_file_info(struct inode
> > *inode, struct file *file,
> >       /* wake up anyone waiting for caps on this inode */
> >       wake_up_all(&ci->i_cap_wq);
> >       return ret;
> > +#endif
> >  }
> >
> >  /*
> > @@ -702,7 +708,9 @@ static int ceph_finish_async_create(struct inode
> > *dir, struct inode *inode,
> >
> >       ktime_get_real_ts64(&now);
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       iinfo.inline_version = CEPH_INLINE_NONE;
> > +#endif
> >       iinfo.change_attr = 1;
> >       ceph_encode_timespec64(&iinfo.btime, &now);
> >
> > @@ -2224,7 +2232,11 @@ static ssize_t ceph_read_iter(struct kiocb
> > *iocb, struct iov_iter *to)
> >                     inode, ceph_vinop(inode), iocb->ki_pos,
> > (unsigned)len,
> >                     ceph_cap_string(got));
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >               if (!ceph_has_inline_data(ci)) {
> > +#else
> > +             if (true) {
> > +#endif
>
> Ditto.
>
> >                       if (!retry_op &&
> >                           (iocb->ki_flags & IOCB_DIRECT) &&
> >                           !IS_ENCRYPTED(inode)) {
> > @@ -2267,7 +2279,11 @@ static ssize_t ceph_read_iter(struct kiocb
> > *iocb, struct iov_iter *to)
> >                       if (!page)
> >                               return -ENOMEM;
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >                       mask = CEPH_STAT_CAP_INLINE_DATA;
> > +#else
> > +                     mask = 0;
> > +#endif
>
> Ditto.
>
> >               }
> >
> >               statret = __ceph_do_getattr(inode, page, mask,
> > !!page);
> > @@ -2349,8 +2365,12 @@ static ssize_t ceph_splice_read(struct file
> > *in, loff_t *ppos,
> >       if (ceph_inode_is_shutdown(inode))
> >               return -ESTALE;
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (ceph_has_inline_data(ci) ||
> >           (fi->flags & CEPH_F_SYNC))
> > +#else
> > +     if (fi->flags & CEPH_F_SYNC)
> > +#endif
> >               return copy_splice_read(in, ppos, pipe, len, flags);
> >
> >       ret = ceph_start_io_read(inode);
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index 61d7c0b8161f..20abf7dc9c64 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -627,7 +627,9 @@ struct inode *ceph_alloc_inode(struct super_block
> > *sb)
> >       spin_lock_init(&ci->i_ceph_lock);
> >
> >       ci->i_version = 0;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       ci->i_inline_version = 0;
> > +#endif
> >       ci->i_time_warp_seq = 0;
> >       ci->i_ceph_flags = 0;
> >       atomic64_set(&ci->i_ordered_count, 1);
> > @@ -1030,7 +1032,9 @@ int ceph_fill_inode(struct inode *inode, struct
> > page *locked_page,
> >       bool wake = false;
> >       bool queue_trunc = false;
> >       bool new_version = false;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       bool fill_inline = false;
> > +#endif
> >       umode_t mode = le32_to_cpu(info->mode);
> >       dev_t rdev = le32_to_cpu(info->rdev);
> >
> > @@ -1362,6 +1366,7 @@ int ceph_fill_inode(struct inode *inode, struct
> > page *locked_page,
> >               }
> >       }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (iinfo->inline_version > 0 &&
> >           iinfo->inline_version >= ci->i_inline_version) {
> >               int cache_caps = CEPH_CAP_FILE_CACHE |
> > CEPH_CAP_FILE_LAZYIO;
> > @@ -1370,6 +1375,7 @@ int ceph_fill_inode(struct inode *inode, struct
> > page *locked_page,
> >                   (locked_page || (info_caps & cache_caps)))
> >                       fill_inline = true;
> >       }
> > +#endif
> >
> >       if (cap_fmode >= 0) {
> >               if (!info_caps)
> > @@ -1382,9 +1388,11 @@ int ceph_fill_inode(struct inode *inode,
> > struct page *locked_page,
> >
> >       ceph_fscache_register_inode_cookie(inode);
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (fill_inline)
> >               ceph_fill_inline_data(inode, locked_page,
> >                                     iinfo->inline_data, iinfo-
> > >inline_len);
> > +#endif
> >
> >       if (wake)
> >               wake_up_all(&ci->i_cap_wq);
> > @@ -3022,6 +3030,7 @@ int __ceph_do_getattr(struct inode *inode,
> > struct page *locked_page,
> >       req->r_args.getattr.mask = cpu_to_le32(mask);
> >       req->r_locked_page = locked_page;
> >       err = ceph_mdsc_do_request(mdsc, NULL, req);
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       if (locked_page && err == 0) {
> >               u64 inline_version = req-
> > >r_reply_info.targeti.inline_version;
> >               if (inline_version == 0) {
> > @@ -3034,6 +3043,7 @@ int __ceph_do_getattr(struct inode *inode,
> > struct page *locked_page,
> >                       err = req->r_reply_info.targeti.inline_len;
> >               }
> >       }
> > +#endif
>
> Ditto.
>
> >       ceph_mdsc_put_request(req);
> >       doutc(cl, "result=%d\n", err);
> >       return err;
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 18be36c2e9e8..6a439da76616 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -156,12 +156,26 @@ static int parse_reply_info_in(void **p, void
> > *end,
> >       *p += info->xattr_len;
> >
> >       if (features == (u64)-1) {
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >               /* inline data */
> >               ceph_decode_64_safe(p, end, info->inline_version,
> > bad);
> >               ceph_decode_32_safe(p, end, info->inline_len, bad);
> >               ceph_decode_need(p, end, info->inline_len, bad);
> >               info->inline_data = *p;
> >               *p += info->inline_len;
> > +#else
> > +             /*
> > +              * Inline data support has been removed, but the MDS
> > always
> > +              * encodes inline_version + inline_data in versioned
> > replies.
> > +              * We must consume these fields from the message to
> > keep the
> > +              * decode pointer in sync, even though we discard
> > them.
> > +              */
> > +             u32 __len;
>
> Ditto, Maybe, simply len?
>
> > +
> > +             ceph_decode_skip_64(p, end, bad);
> > +             ceph_decode_32_safe(p, end, __len, bad);
> > +             ceph_decode_skip_n(p, end, __len, bad);
> > +#endif
> >               /* quota */
> >               err = parse_reply_info_quota(p, end, info);
> >               if (err < 0)
> > @@ -276,6 +290,7 @@ static int parse_reply_info_in(void **p, void
> > *end,
> >               *p = end;
> >       } else {
> >               /* legacy (unversioned) struct */
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >               if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
> >                       ceph_decode_64_safe(p, end, info-
> > >inline_version, bad);
> >                       ceph_decode_32_safe(p, end, info-
> > >inline_len, bad);
> > @@ -284,6 +299,21 @@ static int parse_reply_info_in(void **p, void
> > *end,
> >                       *p += info->inline_len;
> >               } else
> >                       info->inline_version = CEPH_INLINE_NONE;
> > +#else
> > +             /*
> > +              * Inline data support has been removed.  When the
> > MDS
> > +              * advertises CEPH_FEATURE_MDS_INLINE_DATA it
> > includes
> > +              * inline_version + inline_data in legacy replies.
> > We
> > +              * must consume them to keep the decode pointer in
> > sync.
> > +              */
> > +             if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
> > +                     u32 __len;
>
> Ditto. Maybe, len?
>
> > +
> > +                     ceph_decode_skip_64(p, end, bad);
> > +                     ceph_decode_32_safe(p, end, __len, bad);
> > +                     ceph_decode_skip_n(p, end, __len, bad);
> > +             }
> > +#endif
>
> Ditto. Maybe, static inline function?
> >
> >               if (features & CEPH_FEATURE_MDS_QUOTA) {
> >                       err = parse_reply_info_quota(p, end, info);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 731d6ad04956..9bcf1a9d5ba8 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -149,9 +149,11 @@ struct ceph_mds_reply_info_in {
> >       char *symlink;
> >       u32 xattr_len;
> >       char *xattr_data;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       u64 inline_version;
> >       u32 inline_len;
> >       char *inline_data;
> > +#endif
> >       u32 pool_ns_len;
> >       char *pool_ns_data;
> >       u64 max_bytes;
> > diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> > index e5d8d59ffc17..3bc3a2ce72a2 100644
> > --- a/fs/ceph/snap.c
> > +++ b/fs/ceph/snap.c
> > @@ -613,7 +613,9 @@ static void ceph_queue_cap_snap(struct
> > ceph_inode_info *ci,
> >               capsnap->xattr_version = 0;
> >       }
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       capsnap->inline_data = ci->i_inline_version !=
> > CEPH_INLINE_NONE;
> > +#endif
> >
> >       /* dirty page count moved from _head to this cap_snap;
> >          all subsequent writes page dirties occur _after_ this
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 3737ea7ed88b..eced08f52b79 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -274,7 +274,9 @@ struct ceph_cap_snap {
> >       u32 truncate_seq;
> >       int writing;   /* a sync write is still in progress */
> >       int dirty_pages;     /* dirty pages awaiting writeback */
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       bool inline_data;
> > +#endif
> >       bool need_flush;
> >  };
> >
> > @@ -381,7 +383,9 @@ struct ceph_inode_info {
> >       spinlock_t i_ceph_lock;
> >
> >       u64 i_version;
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >       u64 i_inline_version;
> > +#endif
> >       u32 i_time_warp_seq;
> >
> >       unsigned long i_ceph_flags;
> > @@ -1335,11 +1339,14 @@ extern void __ceph_touch_fmode(struct
> > ceph_inode_info *ci,
> >  extern const struct address_space_operations ceph_aops;
> >  extern const struct netfs_request_ops ceph_netfs_ops;
> >  int ceph_mmap_prepare(struct vm_area_desc *desc);
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  extern int ceph_uninline_data(struct file *file);
> > +#endif
> >  extern int ceph_pool_perm_check(struct inode *inode, int need);
> >  extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
> >  int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap,
> > bool *invalidate);
> >
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> >  static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
> >  {
> >       if (ci->i_inline_version == CEPH_INLINE_NONE ||
> > @@ -1347,6 +1354,12 @@ static inline bool ceph_has_inline_data(struct
> > ceph_inode_info *ci)
> >               return false;
> >       return true;
> >  }
> > +#else
> > +static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
> > +{
> > +     return false;
> > +}
> > +#endif
> >
> >  /* file.c */
> >  extern const struct file_operations ceph_file_fops;
> > diff --git a/include/linux/ceph/ceph_features.h
> > b/include/linux/ceph/ceph_features.h
> > index 3a47acd9cc14..207b93787a4f 100644
> > --- a/include/linux/ceph/ceph_features.h
> > +++ b/include/linux/ceph/ceph_features.h
> > @@ -132,6 +132,11 @@ DEFINE_CEPH_FEATURE(38, 1, OSD_ERASURE_CODES)
> >  DEFINE_CEPH_FEATURE(38, 1, OSD_OSD_TMAP2OMAP) // overlap
> >  DEFINE_CEPH_FEATURE(39, 1, OSDMAP_ENC)
> >  DEFINE_CEPH_FEATURE(40, 1, MDS_INLINE_DATA)
> > +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> > +#define
> > CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT  CEPH_FEATURE_MDS_INLINE_DATA
> > +#else
> > +#define CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT 0
> > +#endif
> >  DEFINE_CEPH_FEATURE(41, 1, CRUSH_TUNABLES3)
> >  DEFINE_CEPH_FEATURE(41, 1, OSD_PRIMARY_AFFINITY) // overlap
> >  DEFINE_CEPH_FEATURE(42, 1, MSGR_KEEPALIVE2)
> > @@ -204,7 +209,7 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1,
> > RESERVED_BROKEN, LUMINOUS) // client-facin
> >        CEPH_FEATURE_CRUSH_V2 |                \
> >        CEPH_FEATURE_EXPORT_PEER |             \
> >        CEPH_FEATURE_OSDMAP_ENC |              \
> > -      CEPH_FEATURE_MDS_INLINE_DATA |         \
> > +      CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT | \
> >        CEPH_FEATURE_CRUSH_TUNABLES3 |         \
> >        CEPH_FEATURE_OSD_PRIMARY_AFFINITY |    \
> >        CEPH_FEATURE_MSGR_KEEPALIVE2 |         \
> >
> > ---
> > base-commit: 602bb4525c8146865b7f6e44c81d54bf97861aed
> > change-id: 20260728-b4-ceph-remove-inline-data-d55c6466dd7e
> >
> >
>
> git apply --check ./\[PATCH\ v2\]\ ceph\:\ remove\ the\ inline\ data\
> support.mbox
> error: patch failed: fs/ceph/Kconfig:17
> error: fs/ceph/Kconfig: patch does not apply
> error: patch failed: fs/ceph/addr.c:274
> error: fs/ceph/addr.c: patch does not apply
> error: patch failed: fs/ceph/caps.c:1266
> error: fs/ceph/caps.c: patch does not apply
> error: patch failed: fs/ceph/file.c:224
> error: fs/ceph/file.c: patch does not apply
> error: patch failed: fs/ceph/inode.c:627
> error: fs/ceph/inode.c: patch does not apply
> error: patch failed: fs/ceph/mds_client.c:156
> error: fs/ceph/mds_client.c: patch does not apply
> error: patch failed: fs/ceph/mds_client.h:149
> error: fs/ceph/mds_client.h: patch does not apply
> error: patch failed: fs/ceph/snap.c:613
> error: fs/ceph/snap.c: patch does not apply
> error: patch failed: fs/ceph/super.h:274
> error: fs/ceph/super.h: patch does not apply
> error: patch failed: include/linux/ceph/ceph_features.h:132
> error: include/linux/ceph/ceph_features.h: patch does not apply
> >
>
> ./scripts/checkpatch.pl --strict ./\[PATCH\ v2\]\ ceph\:\ remove\ the\
> inline\ data\ support.mbox
> ERROR: DOS line endings
> #145: FILE: fs/ceph/Kconfig:20:
> +config CEPH_FS_INLINE_DATA^M$
>
> ERROR: DOS line endings
> #146: FILE: fs/ceph/Kconfig:21:
> +^Ibool "Enable CephFS inline data support (deprecated)"^M$
>
> Every new line in this patch is indented with spaces, not tabs.
>
> Thanks,
> Slava.
