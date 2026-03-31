Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4B43CECE
	for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978495; cv=pass; b=T7RV2SLN3CPJMsSUY3+UrRArStjvNbAMW5bZW+a/5563dv5nwLZfHRJjLOCJrVbTTmw1RFeF0g7MhGn7e93bJ5I25cFlXxZKyDqdmcfKOsdpMHUs88sp6Kv52z+w/hwUY20r1cLOrGD4uPYJjwhmjzOQGiAdFtloyoad9tKNzQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978495; c=relaxed/simple;
	bh=JIgU5m8Pgc/Ag+ZnFaad7xYTJ+AsMSYhCypn35MXP/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqVDgmJScw8cwC97DlfzrBnrR/+acB7y6qgqUWYCHe9UEiOEWsesKci7alAtNDiu5cp5dGD+JxOAkC7YeMLZJ4qoY/jvB+aFqCeWUEOS7gk9cgZ2hLsiIs6YXfWEbSvNsYCUlIlqsPMDn0Uz7FD3El7c8eo5pOrlrLWOqMXpbIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt2EhDAH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpTxy7Hh; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt2EhDAH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpTxy7Hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774978492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amFo78u7ePqDECsHI2iRzAUPrcVFsZNh98z+uRwFyY8=;
	b=Qt2EhDAHzQhs4Xyy+Ds9MI9ODYmcIf1twyuw4n0k4jOnScv4s513aevGWuhms0GDPR+uIA
	Gw+TA0o6TB+EpEzu7mOkeHSuZnCul94MfqxXSiI9FKDg2wgsGmS38h6KJh4uzoBmiEkeoX
	mAJ0+dbQFTungYp911jhyA9tNjVmQLk=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237--vZ_YljpMP6SVWgDnfN38w-1; Tue, 31 Mar 2026 13:34:50 -0400
X-MC-Unique: -vZ_YljpMP6SVWgDnfN38w-1
X-Mimecast-MFC-AGG-ID: -vZ_YljpMP6SVWgDnfN38w_1774978490
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-605664a1046so89703137.0
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 10:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774978490; cv=none;
        d=google.com; s=arc-20240605;
        b=bTttTMRdq+gUNcvWjrZt/+Qkgr1qwk5QmjIiOEQwIyz81LOaJG6R/bZGPUqELnhEvK
         t+nqL+sP/OFaGqKdU9vm51GMBHc4k41p81yIjYtvb75fy1x+cokrR3XdHQrhOLVlDy2T
         G/x0N2dGBQ080zWXBUrAmD6jjtKrPCX6fVMPOfGvBkqc2U0jE7dqvQzPKYBu7pb+J2tu
         AUffS2KPPruqDw0GFqnsrFPW5jVNQ7qG5zwq8xtok4A53dOrWwtIXPiEJ7IyJqWM6uqd
         gQSrf+ohQ9eIm1Bz4Yqpq3mexyNSHgB+NFJdYCqxtxVB6Cb6E/+X0TegLe0axvO0/LJV
         3RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amFo78u7ePqDECsHI2iRzAUPrcVFsZNh98z+uRwFyY8=;
        fh=8l0u/IMevTe27ybXs5OlkEsvMOknoS1EIIe0cqMmo1Y=;
        b=fc5L8BhQ45thdId9Rg1+zgoHXWzEU9WQq1GEWyaumch8QIrjMoSpWycMojokYUhu9U
         YOpWmfwj42NGKJ2YYFU9x9lMtIkZjRO9SpWZqrcH6Ea2E7n0yg/bpDBXidiXPSlxrxG9
         dJFXgMNlnJQb7iUl/jJFxpk06wMqkRxgzGdJRuRhvQ5pE5E5whdOt+1c93Xop9JCrDc8
         Zb2pdgJi0dYLsCrywudiy9m1oriPgOp5crtGe28X6ie39DRqvPMKWM2/Y2jd9T05EysO
         NPFTHsIJOm7TRMCI6PedRenpz/oU0SvPniMxg4yLzVrlpJzvz+P+5IKedOh7t6z/M3yg
         sHpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774978490; x=1775583290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amFo78u7ePqDECsHI2iRzAUPrcVFsZNh98z+uRwFyY8=;
        b=WpTxy7Hhz04UmtNSGLLO0QkYVHGTWItO7WClBJAqpKFuyWh24UGjQzK8A24rpXveiI
         D7AwkRapFB0VglQZwaaSvtJR5zktbuUxRIGVF0s0LNabhDgBwXts03ChKSInVIXagUOu
         x8H2nK0rtxk6/YylLaroFsvac8h3a3Ri7r8uKPTcpgKY7AniNsjZqq4KvmyOB3njgM+T
         SPC87wRd3BPs1pzAJ8cmbbfkkJH7bX9wcEBTdOCT32OmjcW8yUXL/ezeU0s4naKGzUUo
         G0HEcDSYtcYY8ow42tnX1q3JMEg4Jy8+Vh1QpNQ39AtXKk7Ugqq76EoZe4aYMuHq443Y
         hfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978490; x=1775583290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amFo78u7ePqDECsHI2iRzAUPrcVFsZNh98z+uRwFyY8=;
        b=ZGJCCwM78up3obas5ExBN/U+ugTmNtxaXiSAtVYXl+wpPnxC3fNzOUoGmHomcO2XRI
         TYg6j1fe7VJA73aXa9BvhIWiud6wRl4+yorSKuEkNmEG+tQANBcB5TAvrGUSc7Y94H8h
         xAGEawDNZGolTq7CVQA/HnMfoVS91gNB+jsEDHS4zK3Ziuz3hjHLwEv4gCDamoyji2im
         7+M9FD02pVslxXN9XsyBdst6NOpyE9d+7gM4ZeiKw6j+rgWxQK0kA4qZ+CRHBEmtPOjp
         TZ4jh83bND8P0v+Hfg9JRVuBbz6bHVRR+Y3bTHQthfvgsawlbIa93nqQKLgXDXr5DAEj
         oMLA==
X-Gm-Message-State: AOJu0YwuKvsIe8bdN+xMaDcBJwhb5Bs6N+oiV80u7vgwZPjfnMCZgL8U
	NdiR2zx8NdLuQqN/YghJLY5H9nJPvVVtdI9yBOF9bpRJnls1WU3AY5xy1P7ijdyrJBDCLKALEc7
	JvUAFxj+iq10uklO+CcsjZJRqSRATngpyfwgGu9b+laXdMccdQfJ1yuyWCVCrsqticpVPMLub6N
	KJAgWcVpss5q4y328N+DuVvA/NL16iOWtLGZLCZg==
X-Gm-Gg: ATEYQzyjkkT0Cy5X60/AM4qqSiM/j6F1q2DVIgCJ6ffTHIpvWQ0GTottkn5YfGYj5kz
	atrkvDhrQUCUs4K31bqwocQG/St9N+TVGePMhwFCFukN0PVPdgLwq/DetI49yow9CpVesml3mPg
	SHcDDQuZMpa7in8Y9YRg/uVVh2evdXHFBlDYt4AbZ+0VKXAKvgy0UCOdfQ8ZEYJKsm6CKWVo6CR
	+9Abg==
X-Received: by 2002:a05:6102:4492:b0:5ff:fe0f:67a4 with SMTP id ada2fe7eead31-60567e9403bmr73951137.14.1774978490060;
        Tue, 31 Mar 2026 10:34:50 -0700 (PDT)
X-Received: by 2002:a05:6102:4492:b0:5ff:fe0f:67a4 with SMTP id
 ada2fe7eead31-60567e9403bmr73938137.14.1774978489496; Tue, 31 Mar 2026
 10:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327143045.1393612-1-amarkuze@redhat.com> <20260327143045.1393612-4-amarkuze@redhat.com>
 <64b7f622aa5f4839b9e1c4cd935223a6b2ec04c9.camel@redhat.com>
In-Reply-To: <64b7f622aa5f4839b9e1c4cd935223a6b2ec04c9.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 31 Mar 2026 20:34:37 +0300
X-Gm-Features: AQROBzDyIdiOUkK6g4_aSM690ieESu3qNnfek28aKn3aVQp0nABWKrYoGQmntxs
Message-ID: <CAO8a2SjjdFU7ys=PhxnAjtQXGfhCVJPuVfU2Y1VEAC8mpP81ug@mail.gmail.com>
Subject: Re: [PATCH 03/10] ceph: add client reset state and request gating
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll cleanup some of the dead code the patchset and send v2.

On Mon, Mar 30, 2026 at 8:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Fri, 2026-03-27 at 14:30 +0000, Alex Markuze wrote:
> > Add the client-side reset state tracking and the wait path used to bloc=
k
> > new metadata requests and new lock acquisitions while a reset is in
> > progress. This wires the reset state into client init and shutdown so
> > blocked callers are released cleanly when the mount is torn down.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/locks.c      | 14 ++++++++
> >  fs/ceph/mds_client.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/mds_client.h | 28 ++++++++++++++++
> >  3 files changed, 121 insertions(+)
> >
> > diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> > index 2f21574dfb99..e6f0c565e9d6 100644
> > --- a/fs/ceph/locks.c
> > +++ b/fs/ceph/locks.c
> > @@ -281,6 +281,13 @@ int ceph_lock(struct file *file, int cmd, struct f=
ile_lock *fl)
> >               return err;
> >       }
> >
> > +     /* Wait for reset to complete before acquiring new locks */
> > +     if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && !lock_is_unlock(fl)) {
> > +             err =3D ceph_mdsc_wait_for_reset(mdsc);
>
> Maybe, I am missing something. But I don't see where mdsc variable has be=
en
> declared and initialized in ceph_lock(). Is it my misunderstanding?
>
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       if (lock_is_read(fl))
> >               lock_cmd =3D CEPH_LOCK_SHARED;
> >       else if (lock_is_write(fl))
> > @@ -340,6 +347,13 @@ int ceph_flock(struct file *file, int cmd, struct =
file_lock *fl)
> >               return err;
> >       }
> >
> > +     /* Wait for reset to complete before acquiring new locks */
> > +     if (!lock_is_unlock(fl)) {
> > +             err =3D ceph_mdsc_wait_for_reset(mdsc);
>
> Ditto. The same misunderstanding here.
>
> Thanks,
> Slava.
>
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> >       if (IS_SETLKW(cmd))
> >               wait =3D 1;
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index d70c0b669b75..0dd9a529850a 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3742,12 +3742,69 @@ static void kick_requests(struct ceph_mds_clien=
t *mdsc, int mds)
> >       }
> >  }
> >
> > +/*
> > + * Wait for an active reset to complete.
> > + * Returns 0 if reset completed successfully or no reset was active.
> > + * Returns -ETIMEDOUT if we timed out waiting.
> > + * Returns -ERESTARTSYS if interrupted by signal.
> > + */
> > +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc)
> > +{
> > +     struct ceph_client_reset_state *st =3D &mdsc->reset_state;
> > +     struct ceph_client *cl =3D mdsc->fsc->client;
> > +     long timeout =3D CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC * HZ;
> > +     int blocked_count;
> > +     int ret;
> > +
> > +     if (READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE)
> > +             return 0;
> > +
> > +     blocked_count =3D atomic_inc_return(&st->blocked_requests);
> > +     doutc(cl, "request blocked during reset, %d total blocked\n",
> > +           blocked_count);
> > +
> > +     ret =3D wait_event_interruptible_timeout(st->blocked_wq,
> > +                                            READ_ONCE(st->phase) =3D=
=3D
> > +                                            CEPH_CLIENT_RESET_IDLE,
> > +                                            timeout);
> > +
> > +     atomic_dec(&st->blocked_requests);
> > +
> > +     if (ret =3D=3D 0) {
> > +             pr_warn_client(cl, "timed out waiting for reset to comple=
te\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     spin_lock(&st->lock);
> > +     ret =3D st->last_errno;
> > +     spin_unlock(&st->lock);
> > +     return ret;
> > +}
> > +
> >  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inod=
e *dir,
> >                             struct ceph_mds_request *req)
> >  {
> >       struct ceph_client *cl =3D mdsc->fsc->client;
> >       int err =3D 0;
> >
> > +     /*
> > +      * If a reset is in progress, wait for it to complete.
> > +      *
> > +      * This is best-effort: a request can pass this check just
> > +      * before the phase leaves IDLE and proceed concurrently with
> > +      * reset. That is acceptable because such requests will either
> > +      * complete normally or fail and be retried by the caller, and
> > +      * adding lock serialization here would penalize every request
> > +      * for a rare manual operation.
> > +      */
> > +     err =3D ceph_mdsc_wait_for_reset(mdsc);
> > +     if (err) {
> > +             doutc(cl, "wait_for_reset failed: %d\n", err);
> > +             return err;
> > +     }
> > +
> >       /* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
> >       if (req->r_inode)
> >               ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN)=
;
> > @@ -5628,6 +5685,19 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
> >       INIT_LIST_HEAD(&mdsc->dentry_leases);
> >       INIT_LIST_HEAD(&mdsc->dentry_dir_leases);
> >
> > +     spin_lock_init(&mdsc->reset_state.lock);
> > +     mdsc->reset_state.trigger_count =3D 0;
> > +     mdsc->reset_state.success_count =3D 0;
> > +     mdsc->reset_state.failure_count =3D 0;
> > +     mdsc->reset_state.last_start =3D 0;
> > +     mdsc->reset_state.last_finish =3D 0;
> > +     mdsc->reset_state.last_errno =3D 0;
> > +     mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> > +     mdsc->reset_state.inject_error =3D false;
> > +     mdsc->reset_state.last_reason[0] =3D '\0';
> > +     init_waitqueue_head(&mdsc->reset_state.blocked_wq);
> > +     atomic_set(&mdsc->reset_state.blocked_requests, 0);
> > +
> >       ceph_caps_init(mdsc);
> >       ceph_adjust_caps_max_min(mdsc, fsc->mount_options);
> >
> > @@ -6153,6 +6223,15 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fs=
c)
> >       /* flush out any connection work with references to us */
> >       ceph_msgr_flush();
> >
> > +     spin_lock(&mdsc->reset_state.lock);
> > +     if (mdsc->reset_state.phase !=3D CEPH_CLIENT_RESET_IDLE) {
> > +             mdsc->reset_state.phase =3D CEPH_CLIENT_RESET_IDLE;
> > +             mdsc->reset_state.last_errno =3D -ESHUTDOWN;
> > +             mdsc->reset_state.failure_count++;
> > +     }
> > +     spin_unlock(&mdsc->reset_state.lock);
> > +     wake_up_all(&mdsc->reset_state.blocked_wq);
> > +
> >       ceph_mdsc_stop(mdsc);
> >
> >       ceph_metric_destroy(&mdsc->metric);
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index e91a199d56fd..5cc22c109cfe 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -74,6 +74,32 @@ struct ceph_fs_client;
> >  struct ceph_cap;
> >
> >  #define MDS_AUTH_UID_ANY -1
> > +#define CEPH_CLIENT_RESET_REASON_LEN 64
> > +#define CEPH_CLIENT_RESET_WAIT_TIMEOUT_SEC 120
> > +
> > +enum ceph_client_reset_phase {
> > +     CEPH_CLIENT_RESET_IDLE =3D 0,
> > +     CEPH_CLIENT_RESET_QUIESCING,
> > +     CEPH_CLIENT_RESET_DRAINING,
> > +     CEPH_CLIENT_RESET_TEARDOWN,
> > +};
> > +
> > +struct ceph_client_reset_state {
> > +     spinlock_t lock;
> > +     u64 trigger_count;
> > +     u64 success_count;
> > +     u64 failure_count;
> > +     unsigned long last_start;
> > +     unsigned long last_finish;
> > +     int last_errno;
> > +     enum ceph_client_reset_phase phase;
> > +     bool inject_error;
> > +     char last_reason[CEPH_CLIENT_RESET_REASON_LEN];
> > +
> > +     /* Request blocking during reset */
> > +     wait_queue_head_t blocked_wq;
> > +     atomic_t blocked_requests;
> > +};
> >
> >  struct ceph_mds_cap_match {
> >       s64 uid;  /* default to MDS_AUTH_UID_ANY */
> > @@ -536,6 +562,7 @@ struct ceph_mds_client {
> >       struct list_head  dentry_dir_leases; /* lru list */
> >
> >       struct ceph_client_metric metric;
> > +     struct ceph_client_reset_state reset_state;
> >
> >       spinlock_t              snapid_map_lock;
> >       struct rb_root          snapid_map_tree;
> > @@ -563,6 +590,7 @@ extern const char *ceph_session_state_name(int s);
> >  extern struct ceph_mds_session *
> >  ceph_get_mds_session(struct ceph_mds_session *s);
> >  extern void ceph_put_mds_session(struct ceph_mds_session *s);
> > +int ceph_mdsc_wait_for_reset(struct ceph_mds_client *mdsc);
> >
> >  extern int ceph_mdsc_init(struct ceph_fs_client *fsc);
> >  extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
>

