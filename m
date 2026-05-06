Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DC43C055
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067315; cv=pass; b=lPgq9U3Zaj/wTYlYF5jlploFPl/YvZDFjrHjP+sdJNWmFvr6C+RTPmLDIryY/Jpsz7PX/eI4n5OLwb5M24arNNMOnnCfz5XiLuREqAidtb8SZ97+4ZUBUZd9CpAGjxk2j8iISsQb0aCj+gO8ns2NtyjTIksGZCDJXPLDptiDKAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067315; c=relaxed/simple;
	bh=TDUg3foHcSAEnnAvp7oThQuP+MqRkWxAbZfPUrUWjDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbu49f/TtLSgyZd8ct4PegQMhh35jlH/oNPyVj5Pg4B4c7Yc56EKhXK6slPp/cDttn2WeMKYK+BeiMj/hCKHbETrpwcFekP6qNRvxsnpGODTguWOvZ4R7LIU2IFK9mTZkDzxpDgLjKxCUPAcdYxt1akKJKGSsBmvdsuHcSNZFzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tqs8f4Ti; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuA5fKay; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tqs8f4Ti";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuA5fKay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778067312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiMifYXN4WAkxN+WIkeCbFv1ZV0tMX56dTopdH7EBmE=;
	b=Tqs8f4Ti5qZwhTYxZ+gQgluwyCSvboyf2noTikUxtwkw0Wp9EJc1tFZBUH6Eqw+ksqfpCW
	aCEokhF7FHx+ExmXWBf7tLt+tV2ukXPyAGgSJatmAohGLONrcO23DAaRmk1IxIZMirsYCo
	lTRgm44hRhaRzoUOu4OPTaty0npgRjI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-SGWekPiUPfOoyzL8qOpSaw-1; Wed, 06 May 2026 07:35:09 -0400
X-MC-Unique: SGWekPiUPfOoyzL8qOpSaw-1
X-Mimecast-MFC-AGG-ID: SGWekPiUPfOoyzL8qOpSaw_1778067309
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-611af0d600bso4029856137.2
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2026 04:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778067308; cv=none;
        d=google.com; s=arc-20240605;
        b=dpC9MPC9VSHdICFTs2QqxK+W8Aa0U1kJwUeY/XNe3nZ2LzpBFsA6yctZe9HY4fWDqg
         XXcSBzj8RBpbam4Ejc1AT/Xz3GSjXqvmO473xPHunBOsb9w30Ctm2PnJe/IKUr0MnzLS
         RGg3j5f1Cm4Nzxo4COMO2tD4NZa1vjlqANU0muqFQdCvLPipe0TurrOOr1m0K3GD5EA7
         4Jjg2YA39OVNbbesN1RA9ZScBJ0ELVK4QqGsws6MXlhcX3r/nBNOe0dYSPAPKJVDQGTn
         ubkNJFshUbDwUA+nRYkcNhyk2mOu+/7/eLYJbxCkVUEmMDuhMNyWSywFT/0qlMeaS1CE
         Z9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZiMifYXN4WAkxN+WIkeCbFv1ZV0tMX56dTopdH7EBmE=;
        fh=xMFqqtn3nOTgdN7AQgUPD8+FjUga8wgyYxyudv/dmC0=;
        b=S1RordHUIZUmsjsnZmKIEJdDrraMyGNMPEou0JhTC5BnltFUNWMHdIFnmg6a6aTbVY
         COGYiihxZ4p3TInL1cTaifqMxjRBjMBANmVk1nVsFcUaKJm942xdb1U/fFy72nL96XAV
         uuNZ6Gwy9WHSvc0iq2Lfnm/AUnE1mbTnJxMLidov+th12SilSGtS1pP3Itv4kHhnmKBr
         EevwNPeTJImxToXZEHbRt1VnwPeTkbVmBr4lpJfT+Xl+q7g5mzaUm0ZKGKQ7r60fdYB5
         FuV/lxEO163oTXhpcsTrkAWJRfTaw8Hr1iqjSUgqofD7ShJ78x7EQRKlPp7tYLVKTmvk
         Ea8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778067308; x=1778672108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiMifYXN4WAkxN+WIkeCbFv1ZV0tMX56dTopdH7EBmE=;
        b=XuA5fKay0YkllPdoweZPZHX9AGk8qy0+7mp0pVCpplT1Jyho0dxfhX9Cl/GaJNae/4
         cYm/BJm+XQMKaj5tWQdxJUgncMBWVOMgRpKDsqtQBPaQ6uVakIXOxKiAgTtof6kjqe/J
         n2PzXur4tFgU5gjUIBKlw595XVlUQbic1CqXfz2/27lSFcEfAMcVUcRpnN7KeH7BrhFe
         YxuSD6bX6U1zJx3R79/w0Ng48NM5NWlo79vvANMyfAktjefgTju6Cr+EerFuQn9+PQas
         TxB+QwOapnxaAKEvDsOIMFGNABlID+XwBDwAj0GfqDjoOrIkPdHRtCyBpunZSpqhdIlP
         OaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778067308; x=1778672108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZiMifYXN4WAkxN+WIkeCbFv1ZV0tMX56dTopdH7EBmE=;
        b=f6uIHxKc4SGejDf+swv1VVNMvRhxc3qlHv6jh3Pb1NFXXmpLNoqLmM/QfeHKQlk+cD
         hQTfKJ2grSvfqC3p1uWX60suu99wBbMcYhLQzxG1+5lVcdIEr7/ygfbtkVWF6Sr59BLP
         kgv6lMCfjHnkRq9AesTiGUa+VG1nOK2O2Z/uqLtMCAVrk7+efe6Bkm+28KblZOXG4F74
         nVixGgA4bGQ/3Zrul774RTVdt6LPOmN3E2SqNxs+8v+D+J6/DdddG5mckkoYor/2vaf1
         YPB16ik17ITddON0iOMcQCq6yg6rLBHLgecpXEJaXA4+0RflYujXc0O9SeRzhLIRlclw
         GpRA==
X-Gm-Message-State: AOJu0YxB2iUlYI3+8bS7En6LqRKYU6ZlfncOCvsL2unA7+ecQvIvs+4i
	imwvgB3mjlxMzD4xFpHsL952kFsDnecdIddYzpXCAV7wMdpKHbSU6aIvfTTKFXmyk1S9ib3YQcs
	Pb5VymEV6zjB7J0agbdGrzctbgDNUjSqbtxmGPCRQIGTDD/JKVoHLivwQMct1MolXnVYUh1fwc3
	7TzCKEhc9ifkKcP8Dfsg6sSUDhdiCREC6/cBpRReWB80DK5Tr333c=
X-Gm-Gg: AeBDietvG3hzxcgDdLDFj/z4zFxy67osJq2xJs8qN7Y8koMBm8hu59R8l+43cBPz/mR
	bslFWghRUdV47h5AAEoMzCbJcNPcWySw8OoVcJNLQkfP6VI0Tg50CjHjO+Z3PVH2eEIrl5mOxTt
	Q7g8Ny+yRpkn1rwvyK0n+0APHIfLXVXscwpXtFGVk0BpVgRQ0UyCg3jniYfC+BXrLPT9J+Rx6KT
	sGrbLh4HgQIC2Ma
X-Received: by 2002:a05:6102:8095:b0:605:6650:465c with SMTP id ada2fe7eead31-630f8ef43aamr1145641137.13.1778067308338;
        Wed, 06 May 2026 04:35:08 -0700 (PDT)
X-Received: by 2002:a05:6102:8095:b0:605:6650:465c with SMTP id
 ada2fe7eead31-630f8ef43aamr1145625137.13.1778067307826; Wed, 06 May 2026
 04:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429125206.1512203-1-amarkuze@redhat.com> <20260429125206.1512203-5-amarkuze@redhat.com>
 <fbab16663ba7c8b0a1970de7301ae85ea8cb0ca4.camel@redhat.com>
In-Reply-To: <fbab16663ba7c8b0a1970de7301ae85ea8cb0ca4.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 6 May 2026 14:34:57 +0300
X-Gm-Features: AVHnY4KgX-X_gh6NF90vkPym0nMoUDO9fVTkJ_bkILL6yqQ1tuMC90nuf4MiNCo
Message-ID: <CAO8a2Siu0ukTOap9v19aotjm0fS_=KETttp=W49oh=5-MdzzVw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 04/11] ceph: add diagnostic timeout loop to wait_caps_flush()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	idryomov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi Slava,

  Integer type for loop counter i

  The counter i tracks the number of 60-second timeout iterations. To
overflow an int it would need roughly 4,000 years of continuous
waiting. In practice, after CEPH_CAP_FLUSH_MAX_DUMP_COUNT (5)
  iterations the diagnostics are suppressed and the counter just ticks
silently; nothing indexes on its value after that point.

  I could change it to unsigned int for cleanliness, but it wouldn't
change behavior. Would you prefer that, or do you have a different
concern about the counter?

  Thanks,
  Alex

On Thu, Apr 30, 2026 at 12:41=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-04-29 at 12:51 +0000, Alex Markuze wrote:
> > Convert wait_caps_flush() from a silent indefinite wait into a diagnost=
ic
> > wait loop that periodically dumps pending cap flush state.
> >
> > The underlying wait semantics remain intact: callers still wait until t=
he
> > requested cap flushes complete. The difference is that long stalls now
> > produce actionable diagnostics instead of looking like a silent hang.
> >
> > CEPH_CAP_FLUSH_MAX_DUMP_COUNT bounds the diagnostics in two ways:
> > it limits the number of entries emitted per diagnostic dump, and it
> > limits the number of timed diagnostic dumps before the wait continues
> > silently. When more entries exist than the per-dump limit, a truncation
> > count is reported. When the dump iteration limit is reached, a final
> > suppression message is emitted so the transition to silence is explicit=
.
> >
> > The diagnostic dump collects flush entry data under cap_dirty_lock into
> > a bounded on-stack array, then prints after releasing the lock.  This
> > avoids holding the spinlock across printk calls.
> >
> > A null cf->ci on the global flush list indicates a bug since all
> > cap_flush entries are initialized with a valid ci before being added.
> > Signal this with WARN_ON_ONCE while still printing enough context for
> > debugging.
> >
> > READ_ONCE is used for the i_last_cap_flush_ack field, which is read
> > outside the inode lock domain. Flush tids are monotonically increasing
> > and acks are processed in order under i_ceph_lock, so the latest ack
> > tid is always the most recently written value.
> >
> > Add a ci pointer to struct ceph_cap_flush so that the diagnostic
> > dump can identify which inode each pending flush belongs to.  The
> > new i_last_cap_flush_ack field tracks the latest acknowledged flush
> > tid per inode for diagnostic correlation.
> >
> > This improves reset-drain observability and is also useful for
> > existing sync and writeback troubleshooting paths.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/caps.c       | 10 +++++
> >  fs/ceph/inode.c      |  1 +
> >  fs/ceph/mds_client.c | 97 ++++++++++++++++++++++++++++++++++++++++++--
> >  fs/ceph/super.h      |  6 +++
> >  4 files changed, 110 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index cb9e78b713d9..4b37d9ffdf7f 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_=
info *ci,
> >
> >               spin_lock(&mdsc->cap_dirty_lock);
> >               capsnap->cap_flush.tid =3D ++mdsc->last_cap_flush_tid;
> > +             capsnap->cap_flush.ci =3D ci;
> >               list_add_tail(&capsnap->cap_flush.g_list,
> >                             &mdsc->cap_flush_list);
> >               if (oldest_flush_tid =3D=3D 0)
> > @@ -1846,6 +1847,7 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
> >               return NULL;
> >
> >       cf->is_capsnap =3D false;
> > +     cf->ci =3D NULL;
> >       return cf;
> >  }
> >
> > @@ -1931,6 +1933,7 @@ static u64 __mark_caps_flushing(struct inode *ino=
de,
> >       doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
> >
> >       swap(cf, ci->i_prealloc_cap_flush);
> > +     cf->ci =3D ci;
> >       cf->caps =3D flushing;
> >       cf->wake =3D wake;
> >
> > @@ -3826,6 +3829,13 @@ static void handle_cap_flush_ack(struct inode *i=
node, u64 flush_tid,
> >       bool wake_ci =3D false;
> >       bool wake_mdsc =3D false;
> >
> > +     /*
> > +      * Flush tids are monotonically increasing and acks arrive in
> > +      * order under i_ceph_lock, so this is always the latest tid.
> > +      * Diagnostic readers use READ_ONCE() without holding the lock.
> > +      */
> > +     WRITE_ONCE(ci->i_last_cap_flush_ack, flush_tid);
> > +
> >       list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_lis=
t) {
> >               /* Is this the one that was flushed? */
> >               if (cf->tid =3D=3D flush_tid)
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index f75d66760d54..de465c7e96e8 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -670,6 +670,7 @@ struct inode *ceph_alloc_inode(struct super_block *=
sb)
> >       INIT_LIST_HEAD(&ci->i_cap_snaps);
> >       ci->i_head_snapc =3D NULL;
> >       ci->i_snap_caps =3D 0;
> > +     ci->i_last_cap_flush_ack =3D 0;
> >
> >       ci->i_last_rd =3D ci->i_last_wr =3D jiffies - 3600 * HZ;
> >       for (i =3D 0; i < CEPH_FILE_MODE_BITS; i++)
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index b62abae72c4c..d83003acfb06 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -27,6 +27,8 @@
> >  #include <trace/events/ceph.h>
> >
> >  #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
> > +#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
> > +#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
>
> I see the point to collect all timeout declarations in one place. What ab=
out to
> place this declarations here [1]?
>
> The CEPH_CAP_FLUSH_MAX_DUMP_COUNT controls two unrelated limits: the numb=
er of
> entries printed per dump, and the number of timed diagnostic dumps before
> suppression. I think we need to have two separate constants with distinct=
 names.
>
> >
> >  /*
> >   * A cluster of MDS (metadata server) daemons is responsible for
> > @@ -2286,19 +2288,106 @@ static int check_caps_flush(struct ceph_mds_cl=
ient *mdsc,
> >  }
> >
> >  /*
> > - * flush all dirty inode data to disk.
> > + * Dump pending cap flushes for diagnostic purposes.
> >   *
> > - * returns true if we've flushed through want_flush_tid
> > + * cf->ci is safe to dereference here: cap_flush entries hold a
> > + * reference on the inode (via the cap), and entries are removed from
> > + * cap_flush_list under cap_dirty_lock before the cap (and thus the
> > + * inode reference) is released.  Holding cap_dirty_lock therefore
> > + * guarantees the inode remains valid for the lifetime of the scan.
> > + */
>
> This commenting looks very strange and confusing. I think we need to have
> comment for the function and comment for the structure. Especially, it's =
really
> important to have comment for all fields of the structure.
>
> > +struct flush_dump_entry {
> > +     u64 ino;
> > +     u64 snap;
> > +     int caps;
> > +     u64 tid;
> > +     u64 last_ack;
> > +     bool wake;
> > +     bool is_capsnap;
> > +     bool ci_null;
> > +};
> > +
> > +static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_ti=
d)
> > +{
> > +     struct ceph_client *cl =3D mdsc->fsc->client;
> > +     struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_COUNT];
> > +     struct ceph_cap_flush *cf;
> > +     int n =3D 0, remaining =3D 0;
> > +
> > +     spin_lock(&mdsc->cap_dirty_lock);
> > +     list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
> > +             if (cf->tid > want_tid)
> > +                     break;
> > +             if (n < CEPH_CAP_FLUSH_MAX_DUMP_COUNT) {
> > +                     struct flush_dump_entry *e =3D &entries[n++];
> > +
> > +                     e->ci_null =3D WARN_ON_ONCE(!cf->ci);
> > +                     if (!e->ci_null) {
> > +                             e->ino =3D ceph_ino(&cf->ci->netfs.inode)=
;
> > +                             e->snap =3D ceph_snap(&cf->ci->netfs.inod=
e);
> > +                             e->last_ack =3D READ_ONCE(cf->ci->i_last_=
cap_flush_ack);
> > +                     }
> > +                     e->caps =3D cf->caps;
> > +                     e->tid =3D cf->tid;
> > +                     e->wake =3D cf->wake;
> > +                     e->is_capsnap =3D cf->is_capsnap;
> > +             } else {
> > +                     remaining++;
> > +             }
> > +     }
> > +     spin_unlock(&mdsc->cap_dirty_lock);
> > +
> > +     pr_info_client(cl, "still waiting for cap flushes through %llu:\n=
",
> > +                    want_tid);
> > +     for (int i =3D 0; i < n; i++) {
> > +             struct flush_dump_entry *e =3D &entries[i];
> > +
> > +             if (e->ci_null)
> > +                     pr_info_client(cl,
> > +                                    "  (null ci) %s tid=3D%llu wake=3D=
%d%s\n",
> > +                                    ceph_cap_string(e->caps), e->tid,
> > +                                    e->wake,
> > +                                    e->is_capsnap ? " is_capsnap" : ""=
);
> > +             else
> > +                     pr_info_client(cl,
> > +                                    "  %llx.%llx %s tid=3D%llu last_ac=
k=3D%llu wake=3D%d%s\n",
> > +                                    e->ino, e->snap,
> > +                                    ceph_cap_string(e->caps), e->tid,
> > +                                    e->last_ack, e->wake,
> > +                                    e->is_capsnap ? " is_capsnap" : ""=
);
> > +     }
> > +     if (remaining)
> > +             pr_info_client(cl, "  ... and %d more pending flushes\n",
> > +                            remaining);
> > +}
> > +
> > +/*
> > + * Wait for all cap flushes through @want_flush_tid to complete.
> > + * Periodically dumps pending cap flush state for diagnostics.
> >   */
> >  static void wait_caps_flush(struct ceph_mds_client *mdsc,
> >                           u64 want_flush_tid)
> >  {
> >       struct ceph_client *cl =3D mdsc->fsc->client;
> > +     int i =3D 0;
>
> Is integer type could be enough here? Could we overflow the i value?
>
> Thanks,
> Slava.
>
> > +     long ret;
> >
> >       doutc(cl, "want %llu\n", want_flush_tid);
> >
> > -     wait_event(mdsc->cap_flushing_wq,
> > -                check_caps_flush(mdsc, want_flush_tid));
> > +     do {
> > +             /* 60 * HZ fits in a long on all supported architectures.=
 */
> > +             ret =3D wait_event_timeout(mdsc->cap_flushing_wq,
> > +                        check_caps_flush(mdsc, want_flush_tid),
> > +                        CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
> > +             if (ret =3D=3D 0) {
> > +                     if (i < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> > +                             dump_cap_flushes(mdsc, want_flush_tid);
> > +                     else if (i =3D=3D CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
> > +                             pr_info_client(cl,
> > +                                            "still waiting for cap flu=
shes; suppressing further dumps\n");
> > +                     i++;
> > +             }
> > +     } while (ret =3D=3D 0);
> >
> >       doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
> >  }
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 30911ccf961e..9aca42c89ea0 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -238,6 +238,7 @@ struct ceph_cap_flush {
> >       bool is_capsnap; /* true means capsnap */
> >       struct list_head g_list; // global
> >       struct list_head i_list; // per inode
> > +     struct ceph_inode_info *ci;
> >  };
> >
> >  /*
> > @@ -443,6 +444,11 @@ struct ceph_inode_info {
> >       struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head=
 > 0 or
> >                                                   dirty|flushing caps *=
/
> >       unsigned i_snap_caps;           /* cap bits for snapped files */
> > +     /*
> > +      * Written under i_ceph_lock, read via READ_ONCE()
> > +      * from diagnostic paths.
> > +      */
> > +     u64 i_last_cap_flush_ack;
> >
> >       unsigned long i_last_rd;
> >       unsigned long i_last_wr;
>
> [1]
> https://elixir.bootlin.com/linux/v7.0.1/source/include/linux/ceph/libceph=
.h#L72
>

