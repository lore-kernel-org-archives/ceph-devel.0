Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9D386564
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784175960; cv=pass; b=PF9GTeyZZctCrrAs5IVJe5Yx3UdXNPo2+y6tm/W1VLODhBSI0SVWvLfAVbTrj3fr3gbFV2kye6HBzEg3Pj84plkbRHNTq4ARspQWp14UPSxOepUhz9O3U/AHDcno7aYhK/7HBP+UfY8ALgr6OsYgBMxC7kmdtuWpdUt4zAbdt6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784175960; c=relaxed/simple;
	bh=xBU0NW9xmoTGHGsF+ze++Sqk8JDjmH+utkDd6Rd26kQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keuIFrw2A3jNbAC3aQKFx39I72bkGgdElwJjeGCsU9a90Bfg/E0TTjwROwUDloKxCgECdSB+m4z2GTd+qCjR6qX+uOhC6N7zIwHtNsggcYHm9dPSlut3qfgPXcZbminOBNNgl7ne1bRtSnRQ/cjTQUAPrz7WRSRl4EQbiur3/qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=NN5PMJFP; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="NN5PMJFP"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698562f10e7so8728328a12.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 21:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784175957; cv=none;
        d=google.com; s=arc-20260327;
        b=srTHnBYtsruz8S4PRj+QvcOSIlCtPl83Y1GaVHcL1y7pwDQ+Z5UQOfaiUcV9LBp/1f
         MKpA/P0O48J7eD9aR8yxxa9o8N14DacbqEcEP3wTWcXasFx3k9cahGtdC7dBH1du7Fjp
         AU+ln1hNkl1mB2Of4t15FnnCOYiUPW+XLMX1oA/nRN3FSDnFTAi3cNnhxyweVoYtTEsN
         uQkPZTPEjloEiEC31BwJHWBb0HvgUbYFdauX8rH9xE3l8TI9b1r82l2GV/gddJus9lrh
         KYWCo+p/M+P6XTZmnKKQ9IA7mGp0Sh3IRF/lwQMO+rR16zsW1cnp+AjySVtfCt3HtxmV
         d9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jZgVnmutSmZmyTUfXxfliaZNrEfs4sYsU6s/GCY96C4=;
        fh=ASSqXtgvJZp1MP1ic55XpTL1Wij34Kg7rwlosIrNhqY=;
        b=bvhC5f64cy7FO+c7i9FhxNrAn3OM5k7f1UpS/aBjOlVblUE/0tubkkSEp8BmYqSACZ
         LfOQ26SuCnFm5H1tywzNqCMXxZ/2/H2mHGtILVHUY6Xbxm4q3LMctTAh+cTJuf9IC6hl
         Gmb5dd0DocRlkS32vALZdBxhD63sIQ3t3+xY1rXUB+aGLRu7qmlhiYs7G1a4x74gnur5
         Pl5inaTTnvMbUCuHHblNOm6EuQMYrXPL8zLoNxWhLFtNAiGNvH3F6+MJuY9lUKNEZKgd
         0PuY3YJ70uvlpgY8siU+JIh4Eont8KDlyXiMtXXD5DFeXYujzEOtjs/A71C0SqgzQnKO
         GEOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784175957; x=1784780757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZgVnmutSmZmyTUfXxfliaZNrEfs4sYsU6s/GCY96C4=;
        b=NN5PMJFP0ZqHcmk+9mp3LeAcgGoBz87+dUjiUm68fDMGvr8RCAal95pJMnDCjlRQvQ
         wYze/IzVwV88quxjPyuXaGTTKm+V8qqd7lkd23EqTHJVeAGDkwgJ+FToeu3rCrJcG35L
         7FNSMoUHwFioUpoZSDslSDbrs+gGVNbptYWNsUzTfEzyHhtuL9R4RTYnEIaec4ceb0rD
         miZLlR4rEoLr6Z478kqeUIe51HK+cW5eUWmjqvGF0vKs8tXSKlndX/PpJwfMl50auUeY
         kIbBbrF5gSVFaY4t6XeLC8TXqd3q7de0jZ/m1/kaNBAy9mQcNyZXnq0F2uRslKaUuNF4
         8guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784175957; x=1784780757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jZgVnmutSmZmyTUfXxfliaZNrEfs4sYsU6s/GCY96C4=;
        b=pvZSR5TMymIxA+pVmIQAn8PXM3kcLaErjRcXEhu1d9YCg44kYgNt+QML2jUYF08E59
         APBC8UX8tcGD4gklIv7hokZm2MtCTCqQvIACizYqJzW5j8md/ctuvCGrwAATT7NysNPC
         s5Kgxq2lzuie28N0ukSJXRa49Gjb9Zncq5RBOPGM1ouZLySe82tlCkVsp8zuMciz9ZE4
         8HlwW087CsElCt8c98NC6aRdaK8cXXZI/BkjLAoHtIVS//6KSYXBp7mo/BX7WamUqMv8
         HFcY6tNNtnJz0sCiM9uh/xqqkHbGYyrF3mNImApmz4o/NShTf/kwBfHfPaGDbpNXtFBm
         lGDw==
X-Forwarded-Encrypted: i=1; AHgh+Rqpo3DcGeyblbHYw92cNEZ/VsPh+eauo9RQQzli09PHtmfn2GKL7EwHif2bcIWsRt/II1kgxwP5bSj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Dn+M1H7dcSJL7+2tAkdxA0V1jekx/PW2B7lI7st6bJNmdvMp
	13GguiJXBMDX6oDG8/vBolxAM9xxxpzM/y3EpxuFvgsD0PK5giLzTaLKNbqbT7cAkaQToOSEOE0
	qhXTLMRP3Y3ixFhMEYX4P+yKQWfYQ4sFYFz4s8y+x9w==
X-Gm-Gg: AfdE7clTfDZQzcapvAmQ8OTx63FnoALJ1K+WA8c9QAkER+GEvqGKv8bHyaelWSC1WP+
	n3FtuV9oNQbd1GSqXPOoCyQPZy4SP8XpXOcVTytT2BuKjLrEMXVy+NUXxH0ttZ6ywVIn3TJi+UW
	WklvuypDfOxMifsaQUPvu61itqJqjTq67fnsRHwBnfB7EdkU3q06FNRDdLSdpmOp3MxhYvOXd6m
	8TuXpJAyuGBIDFuk3KRz4O+IYfnUxmvyz31jsPveabWwyCtmrLUxFoiqBq+DarO/lis2Q==
X-Received: by 2002:a17:906:c14f:b0:c16:5ae4:77a3 with SMTP id
 a640c23a62f3a-c1667a11420mr651953866b.25.1784175956874; Wed, 15 Jul 2026
 21:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
 <20260715-ceph-mdsc-mutex-optimization-v2-3-90e81b726724@clyso.com> <2d940ebd58b730d06bbc262aa1dab6011d65110d.camel@dubeyko.com>
In-Reply-To: <2d940ebd58b730d06bbc262aa1dab6011d65110d.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 12:25:45 +0800
X-Gm-Features: AUfX_mzr54LfeB9RxQulNjAfp03woV4Do1hYgKxfjxl1BVwJM_a3J4JWBSdPk1A
Message-ID: <CAOJNxRKKcv8yajNJHCcDVNz462Ei=sTVASXoe8fiasqZOAVa0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ceph: add wait_list_lock for wait-list serialization
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 02:30, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > Add a dedicated spinlock to protect the waiting_for_map and
> > s_waiting lists, which are currently serialized by mdsc->mutex.
> > This is a preparatory step for removing mdsc->mutex from the
> > kick_requests() path: xa_for_each() is internally locked and the
> > per-request filter checks are lockless, so only list_del_init()
> > needs external protection.
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> >  fs/ceph/mds_client.c | 18 +++++++++++++++++-
> >  fs/ceph/mds_client.h |  3 +++
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 239ed34886f9..a250938f32d3 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3669,7 +3669,9 @@ static void __do_request(struct ceph_mds_client
> > *mdsc,
> >                       doutc(cl, "no mdsmap, waiting for map\n");
> >                       trace_ceph_mdsc_suspend_request(mdsc,
> > session, req,
> >                                                       ceph_mdsc_su
> > spend_reason_no_mdsmap);
> > +                     spin_lock(&mdsc->wait_list_lock);
> >                       list_add(&req->r_wait, &mdsc-
> > >waiting_for_map);
> > +                     spin_unlock(&mdsc->wait_list_lock);
> >                       return;
> >               }
> >               if (!(mdsc->fsc->mount_options->flags &
> > @@ -3692,7 +3694,9 @@ static void __do_request(struct ceph_mds_client
> > *mdsc,
> >               doutc(cl, "no mds or not active, waiting for
> > map\n");
> >               trace_ceph_mdsc_suspend_request(mdsc, session, req,
> >                                               ceph_mdsc_suspend_re
> > ason_no_active_mds);
> > +             spin_lock(&mdsc->wait_list_lock);
> >               list_add(&req->r_wait, &mdsc->waiting_for_map);
> > +             spin_unlock(&mdsc->wait_list_lock);
> >               return;
> >       }
> >
> > @@ -3740,9 +3744,12 @@ static void __do_request(struct
> > ceph_mds_client *mdsc,
> >                       if (ceph_test_mount_opt(mdsc->fsc,
> > CLEANRECOVER)) {
> >                               trace_ceph_mdsc_suspend_request(mdsc
> > , session, req,
> >                                                               ceph
> > _mdsc_suspend_reason_rejected);
> > +                             spin_lock(&mdsc->wait_list_lock);
> >                               list_add(&req->r_wait, &mdsc-
> > >waiting_for_map);
> > -                     } else
> > +                             spin_unlock(&mdsc->wait_list_lock);
> > +                     } else {
> >                               err = -EACCES;
> > +                     }
>
> Do we really need to add the curly brackets here?
>

Yeah.

Else the checkpatch.pl will warn:

WARNING: braces {} are necessary for all arms of this statement

It's a hard requirement of kernel coding style: if one branch of an if
has braces, the other must too.


Thanks
Xiubo

> Thanks,
> Slava.
[......]
