Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F342B759
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067173; cv=pass; b=uQ0hC76cN9evZ/ZdoKkh08A2yTjJLJ0jteuZ7s/b9kpdI1lf03XF37n0eVDL/DeFc8s2Wqddm2hVcvVFwgHmwGPpGaxf6bXWkjNoRJuKRxVhwIUbDjfR3rYeWlblLeZc+WyX+xPKJGMesMYKn2i7bqrOjvZhET8bAIKOOb5iGeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067173; c=relaxed/simple;
	bh=GtPI6hrIfcNUTMZOYONpsobLj3QHc/UpYc1x8sGMdY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rU7x//XaxbaX0qtuSDT3WLVafpufDW/CRJzR5q/rsTtIXhiPXQIp9dYFvPeufUqQkpiU5LHgVB+jA6/O1bFrD3nhVtBx1Bp56JtKILPXEhvrlbdhsDXXN6TnXJPBQuTV18XTWLKs2bYPPOlD82Nug7sy3vZPKNeApEEPVzOdDYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFPhDapW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEcmcTSR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFPhDapW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEcmcTSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778067171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/aMPERyrd8ex/Ch7fYnCpSTn7vCQyWn980+FCKltjQ=;
	b=cFPhDapW5P9jCd9Igyn/P9jcy/zqGQ51fI9t7iUSPTuZr29sKfNVZJ/1+PU+Bfm4adUUy2
	FO2nQbMiwWj9xWhOsrPk57Tujjeiy/5GWmsUGP8Q3JAMATRr2Or+QvnW8Krg5GcIymJPJD
	J/8BihHJb9jBmUPLAlw9PYfaLji9gNA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-kn2rUqxtPLK1LoJS38WpJA-1; Wed, 06 May 2026 07:32:47 -0400
X-MC-Unique: kn2rUqxtPLK1LoJS38WpJA-1
X-Mimecast-MFC-AGG-ID: kn2rUqxtPLK1LoJS38WpJA_1778067167
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-57539d5391dso6354867e0c.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2026 04:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778067167; cv=none;
        d=google.com; s=arc-20240605;
        b=LDd0ppmpBWaZJuVgq9MM/KyXJpvEFqI7kWtlAGF+itrL+LlLylKtba16csqREQDj0K
         i40a6t58lgC2pSI/P114RKm3OgR7K5dKb53VIly5VGUZbY/d8/Sf3wrfiu/6CznOn4/N
         F8eIhx5JJxLcWcGb5Le8T10mYeiPn8GVSxUTCQ75f+Z/wRG2S8d4hiDDlGigciCIlMcw
         W6ts5TVuHQo6H/pOS4ImHGmICaMABF/2jb06+n6MnZgAtQs7KhkMKHpeO1NM/6Er4jYa
         VmPbPtrefQxmMVRJAgGcqWpoSWhpUK0a+dEW6wh7JeFM9NbSpAX6Ho42GM/c+U/2AsFH
         LVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/aMPERyrd8ex/Ch7fYnCpSTn7vCQyWn980+FCKltjQ=;
        fh=xMFqqtn3nOTgdN7AQgUPD8+FjUga8wgyYxyudv/dmC0=;
        b=lcigYDjeY+RVlZGaZnkPAP+2iZTFKjcpb+qejtfDaO8EduNXi2aOLLug5Xgoe4jWz6
         vJVPqPz3yZ4efg7ZnSwY+ZNNe7cKQUE9CUkbVfhMLAs1n4zM1822TtABOtPQPGoxL7vJ
         0DippMvJqdhGAN6yHOotWePPnrwwa/p8L9lH8/Yc9ccZFiHZzV6xa/iQU988+or51B3d
         8n1M01Gf8dTDtg5ZKkyY8HtWq8L5EJ+mdVvUSgA9fop8kFLG+EQ2MtdZJQCld3b8KM12
         NCVMKLzpQzAH61jTtJaGefuy9nGvDk/kkGjqgonbO3iG9J36hQ67a3eE6U4hrSkUmaai
         ngmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778067167; x=1778671967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/aMPERyrd8ex/Ch7fYnCpSTn7vCQyWn980+FCKltjQ=;
        b=ZEcmcTSR+pnkH9t6+rkY8EQQmRGdjGVSMl/+vgSto5PF2ma6T/wSlCj0Xcmeb6ZPU6
         59rvgJ4egVkyeIExUNYW5IWsvkS8bi8tQkWvCSdBLENhVYx7CyPaMfoJElnPpoe5dMV0
         Pb1QhR+7ZuI3ttaJZJTZ1WAEfc16IT56Ly62ZkItDFrwVR4hl4IL8ECnCLj1VHelhoFV
         42DRREAXP2wfG7Fb0XMWe75n1nseO31CSzUhdHRmefArmxb0KsEZWXbrVHFO61o8NVr4
         LHPINUgiCL1mRoOFMv1Eo/Ib702rB5NglOzx0mBSOYNYY5KKGRxxA94Cdhy3xF9EW9WU
         hx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778067167; x=1778671967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/aMPERyrd8ex/Ch7fYnCpSTn7vCQyWn980+FCKltjQ=;
        b=VbBInjZgPC6hU0+Bn9Qw5WtAg+0ZBPsEv6UVgNhJ/kFbKSvrjGqNy1dXtiGafLNAfz
         z+/gPbUa9FaW1wpN+J5iHJ9Cl5JJz7nS25EuFwf8PE2K6KqEm8tpw2jX76S1gix/psgh
         FgS0/QlC2dObYJuDGwWGhbi2Bx9hwHtxo+XZkEyAj18REwkWq0MIIVYM+E+6T4yxQUpU
         LZpDqURUD4wlmWYeD/gC68nINulfhYC+87YrLwO/khWN6YPdwEQmpToih89O65iVrVea
         XJUD0xwv+8au/3ce6K4finYOZ8KQzC3VQCwqLACPM3MD0ZC2VJ37vhSpkOQMZVwB5ok8
         ApFg==
X-Gm-Message-State: AOJu0YxgeKUVb4PqRC5w06LhCo1pzgttJPGEc3I1uREmV39Dym8yQ1eJ
	7ySSn9dTq4P/kQYn275fmVURBNXWYUsXrlJOVSb/ryKrHaHiolg2X/dSdYAeGq9yxO+biUaSJPC
	GIkvZPRYp4INCJ+noKgagS6ukm3brOFGODcusp+OK6AY3d2bBpbq7XYiwFAr9ufo2Di3sPQLgsd
	e8VXGKG4APArGNaOtqOCW1+d6aHOTBPFmj3Q9oEA==
X-Gm-Gg: AeBDieubeGxPaofWcpE2C2ORsvCC7yG9g+MPHRSzlXYlZDxRdquB7J5munex5VKFOLL
	rrzKJ/48UBrNJn3SJ5ulanvKlgmi4SKAUR8psVeHzPBqe8tI7O5kmX/oIQVsU9vVZpBFCKwoFqS
	rBDhWvKrEjs9QgnGb48K4kIWN5lePtk8kl4hPe8qSSh9q6CTWEvWbkvHUzfYLosm7qll17yi38D
	C7ubM8W+Wr3B4A7
X-Received: by 2002:a05:6102:605a:b0:62f:2d6f:cc11 with SMTP id ada2fe7eead31-630f8e764afmr918458137.2.1778067167109;
        Wed, 06 May 2026 04:32:47 -0700 (PDT)
X-Received: by 2002:a05:6102:605a:b0:62f:2d6f:cc11 with SMTP id
 ada2fe7eead31-630f8e764afmr918449137.2.1778067166525; Wed, 06 May 2026
 04:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429125206.1512203-1-amarkuze@redhat.com> <20260429125206.1512203-4-amarkuze@redhat.com>
 <f3ff03de8cadd533fbe71f271f61890e856f3b06.camel@redhat.com>
In-Reply-To: <f3ff03de8cadd533fbe71f271f61890e856f3b06.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 6 May 2026 14:32:34 +0300
X-Gm-Features: AVHnY4Jxh3Z6dk4HIjyXT5wdwrdZFyYdBHOBWDctAtLPJ0l0Pqaqiia3OCW8NCQ
Message-ID: <CAO8a2SgwD2TomAVZEyQNugrZSRec=R4uPDp3cv_VQZyfSpoahg@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v3 03/11] ceph: harden send_mds_reconnect and
 handle active-MDS peer reset
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	idryomov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Slava,

  Thanks for the careful review. Let me address the questions that
need some discussion.

  xa_destroy() thread safety

  Good question. At this point in send_mds_reconnect() the session is
transitioning to RECONNECTING; async creates belong to the prior
session epoch and cannot start new ones once we enter reconnect. The
delegated ino list is stale after a
  session reset since the MDS will not honor those delegations.
  That said, I want to ensure I'm not missing a window you're seeing.

  Could you describe the specific scenario you have in mind? Is it a
case where ceph_get_deleg_ino() is called from a path that doesn't
hold s_mutex?

  mutex_lock(&mdsc->mutex) under session->s_mutex

  The nesting here is s_mutex -> mdsc->mutex, which is the same order
used by cleanup_session_requests() and other existing paths.
  The inverted order (mdsc->mutex -> s_mutex) appears in
check_new_map() but there it drops mdsc->mutex before taking s_mutex.
  So this should not introduce a new lock inversion.

  If you see a path where the opposite nesting can happen
concurrently, please point it out so I can understand it?

  MDS state check narrowed from >=3D to =3D=3D

  This is intentional. When the MDS is past RECONNECT (i.e. in REJOIN,
CLIENTREPLAY, or ACTIVE), it will reject CLIENT_RECONNECT messages
because it only accepts them during its own RECONNECT window. The old
code sent a doomed reconnect that
  the MDS would reject or ignore. The new behavior tears the session
down locally and lets new requests re-open a fresh session, which is
the correct recovery for a connection drop against an active MDS.

  That said, I understand the concern about changing established
behavior. If you think there are scenarios where sending a reconnect
to an MDS in REJOIN or CLIENTREPLAY could still succeed, I'd be
interested to hear them. My understanding
  from the MDS side is that it won't accept them outside the RECONNECT phas=
e.

  Thanks,
  Alex

On Thu, Apr 30, 2026 at 12:23=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-04-29 at 12:51 +0000, Alex Markuze wrote:
> > Change send_mds_reconnect() to return an error code so callers can dete=
ct
> > and report reconnect failures instead of silently ignoring them. Add ea=
rly
> > bailout checks for sessions that are already closed, rejected, or
> > unregistered, which avoids sending reconnect messages for sessions that
> > can no longer be recovered.
> >
> > The early -ESTALE and -ENOENT bailouts use a separate fail_return label
> > that skips the pr_err_client diagnostic, since these codes indicate
> > expected concurrent-teardown races rather than genuine reconnect build
> > failures.
> >
> > Move the "reconnect start" log after the early-bailout checks so it
> > only appears for sessions that actually proceed with reconnect.
> >
> > Save the prior session state before transitioning to RECONNECTING,
> > and restore it in the failure path.  Without this, a transient
> > build or encoding failure (-ENOMEM, -ENOSPC) strands the session
> > in RECONNECTING indefinitely because check_new_map() only retries
> > sessions in RESTARTING state.
> >
> > Rewrite mds_peer_reset() to handle the case where the MDS is past its
> > RECONNECT phase (i.e. active). An active MDS rejects CLIENT_RECONNECT
> > messages because it only accepts them during its own RECONNECT window
> > after restart. Previously, the client would send a doomed reconnect
> > that the MDS would reject or ignore. Now, the client tears the session
> > down locally and lets new requests re-open a fresh session, which is
> > the correct recovery for this scenario. The RECONNECTING state is
> > handled on the same teardown path, since the MDS will reject reconnect
> > attempts from an active client regardless of the session's local state.
> >
> > Add explicit cases for CLOSED and REJECTED session states in
> > mds_peer_reset() since these are terminal states where a connection
> > drop is expected behavior.
> >
> > The session teardown path in mds_peer_reset() follows the established
> > drop-and-reacquire locking pattern from check_new_map(): take
> > mdsc->mutex for session unregistration, release it, then take s->s_mute=
x
> > separately for cleanup. This avoids introducing a new simultaneous lock
> > nesting pattern.
> >
> > Log reconnect failures from check_new_map() and mds_peer_reset() at
> > pr_warn level rather than pr_err, since return codes like -ESTALE
> > (closed/rejected session) and -ENOENT (unregistered session) are
> > expected during concurrent teardown. Log dropped messages for
> > unregistered sessions via doutc() (dynamic debug) rather than
> > pr_info, as post-reset message arrival is routine and does not
> > warrant unconditional logging.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/mds_client.c | 169 +++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 155 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 871f0eef468d..b62abae72c4c 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -4416,9 +4416,14 @@ static void handle_session(struct ceph_mds_sessi=
on *session,
> >               break;
> >
> >       case CEPH_SESSION_REJECT:
> > -             WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING);
> > -             pr_info_client(cl, "mds%d rejected session\n",
> > -                            session->s_mds);
> > +             WARN_ON(session->s_state !=3D CEPH_MDS_SESSION_OPENING &&
> > +                     session->s_state !=3D CEPH_MDS_SESSION_RECONNECTI=
NG);
> > +             if (session->s_state =3D=3D CEPH_MDS_SESSION_RECONNECTING=
)
> > +                     pr_info_client(cl, "mds%d reconnect rejected\n",
> > +                                    session->s_mds);
> > +             else
> > +                     pr_info_client(cl, "mds%d rejected session\n",
> > +                                    session->s_mds);
> >               session->s_state =3D CEPH_MDS_SESSION_REJECTED;
> >               cleanup_session_requests(mdsc, session);
> >               remove_session_caps(session);
> > @@ -4678,6 +4683,14 @@ static int reconnect_caps_cb(struct inode *inode=
, int mds, void *arg)
> >       cap->mseq =3D 0;       /* and migrate_seq */
> >       cap->cap_gen =3D atomic_read(&cap->session->s_cap_gen);
> >
> > +     /*
> > +      * Note: CEPH_I_ERROR_FILELOCK is not set during reconnect.
> > +      * Instead, locks are submitted for best-effort MDS reclaim
> > +      * via the flock_len field below.  If reclaim fails (e.g.,
> > +      * another client grabbed a conflicting lock), future lock
> > +      * operations will fail and set the error flag at that point.
> > +      */
> > +
> >       /* These are lost when the session goes away */
> >       if (S_ISDIR(inode->i_mode)) {
> >               if (cap->issued & CEPH_CAP_DIR_CREATE) {
> > @@ -4892,20 +4905,19 @@ static int encode_snap_realms(struct ceph_mds_c=
lient *mdsc,
> >   *
> >   * This is a relatively heavyweight operation, but it's rare.
> >   */
> > -static void send_mds_reconnect(struct ceph_mds_client *mdsc,
> > -                            struct ceph_mds_session *session)
> > +static int send_mds_reconnect(struct ceph_mds_client *mdsc,
> > +                           struct ceph_mds_session *session)
> >  {
> >       struct ceph_client *cl =3D mdsc->fsc->client;
> >       struct ceph_msg *reply;
> >       int mds =3D session->s_mds;
> >       int err =3D -ENOMEM;
> > +     int old_state;
> >       struct ceph_reconnect_state recon_state =3D {
> >               .session =3D session,
> >       };
> >       LIST_HEAD(dispose);
> >
> > -     pr_info_client(cl, "mds%d reconnect start\n", mds);
> > -
> >       recon_state.pagelist =3D ceph_pagelist_alloc(GFP_NOFS);
> >       if (!recon_state.pagelist)
> >               goto fail_nopagelist;
> > @@ -4917,6 +4929,32 @@ static void send_mds_reconnect(struct ceph_mds_c=
lient *mdsc,
> >       xa_destroy(&session->s_delegated_inos);
>
> Is xa_destroy(&session->s_delegated_inos) thread safe now? If an in-fligh=
t async
> create is mid-way through ceph_get_deleg_ino (which does xa_for_each + xa=
_erase)
> while xa_destroy runs on the same XArray from a different thread, that is
> unsafe. What do you think?
>
> >
> >       mutex_lock(&session->s_mutex);
> > +     if (session->s_state =3D=3D CEPH_MDS_SESSION_CLOSED ||
> > +         session->s_state =3D=3D CEPH_MDS_SESSION_REJECTED) {
> > +             pr_info_client(cl, "mds%d skipping reconnect, session %s\=
n",
> > +                            mds,
> > +                            ceph_session_state_name(session->s_state))=
;
> > +             mutex_unlock(&session->s_mutex);
> > +             ceph_msg_put(reply);
> > +             err =3D -ESTALE;
> > +             goto fail_return;
> > +     }
> > +
> > +     mutex_lock(&mdsc->mutex);
>
> I started to guess is it safe to call mutex_lock(&mdsc->mutex) under sess=
ion-
> >s_mutex lock? Could we introduce potential deadlock here?
>
> > +     if (mds >=3D mdsc->max_sessions || mdsc->sessions[mds] !=3D sessi=
on) {
> > +             mutex_unlock(&mdsc->mutex);
> > +             pr_info_client(cl,
> > +                            "mds%d skipping reconnect, session unregis=
tered\n",
> > +                            mds);
> > +             mutex_unlock(&session->s_mutex);
> > +             ceph_msg_put(reply);
> > +             err =3D -ENOENT;
> > +             goto fail_return;
> > +     }
> > +     mutex_unlock(&mdsc->mutex);
> > +
> > +     pr_info_client(cl, "mds%d reconnect start\n", mds);
> > +     old_state =3D session->s_state;
> >       session->s_state =3D CEPH_MDS_SESSION_RECONNECTING;
> >       session->s_seq =3D 0;
> >
> > @@ -5046,18 +5084,34 @@ static void send_mds_reconnect(struct ceph_mds_=
client *mdsc,
> >
> >       up_read(&mdsc->snap_rwsem);
> >       ceph_pagelist_release(recon_state.pagelist);
> > -     return;
> > +     return 0;
> >
> >  fail:
> >       ceph_msg_put(reply);
> >       up_read(&mdsc->snap_rwsem);
> > +     /*
> > +      * Restore prior session state so map-driven reconnect logic
> > +      * (check_new_map) can retry.  Without this, a transient build
> > +      * failure strands the session in RECONNECTING indefinitely.
> > +      */
> > +     session->s_state =3D old_state;
> >       mutex_unlock(&session->s_mutex);
> >  fail_nomsg:
> >       ceph_pagelist_release(recon_state.pagelist);
> >  fail_nopagelist:
> >       pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
> >                     err, mds);
> > -     return;
> > +     return err;
> > +
> > +fail_return:
> > +     /*
> > +      * Early-exit path for expected concurrent-teardown races
> > +      * (-ESTALE for closed/rejected sessions, -ENOENT for
> > +      * unregistered sessions).  Skip the pr_err_client diagnostic
> > +      * since these are not genuine reconnect build failures.
> > +      */
> > +     ceph_pagelist_release(recon_state.pagelist);
> > +     return err;
> >  }
> >
> >
> > @@ -5138,9 +5192,15 @@ static void check_new_map(struct ceph_mds_client=
 *mdsc,
> >                */
> >               if (s->s_state =3D=3D CEPH_MDS_SESSION_RESTARTING &&
> >                   newstate >=3D CEPH_MDS_STATE_RECONNECT) {
> > +                     int rc;
> > +
> >                       mutex_unlock(&mdsc->mutex);
> >                       clear_bit(i, targets);
> > -                     send_mds_reconnect(mdsc, s);
> > +                     rc =3D send_mds_reconnect(mdsc, s);
> > +                     if (rc)
> > +                             pr_warn_client(cl,
> > +                                            "mds%d reconnect failed: %=
d\n",
> > +                                            i, rc);
> >                       mutex_lock(&mdsc->mutex);
> >               }
> >
> > @@ -5204,7 +5264,11 @@ static void check_new_map(struct ceph_mds_client=
 *mdsc,
> >               }
> >               doutc(cl, "send reconnect to export target mds.%d\n", i);
> >               mutex_unlock(&mdsc->mutex);
> > -             send_mds_reconnect(mdsc, s);
> > +             err =3D send_mds_reconnect(mdsc, s);
> > +             if (err)
> > +                     pr_warn_client(cl,
> > +                                    "mds%d export target reconnect fai=
led: %d\n",
> > +                                    i, err);
> >               ceph_put_mds_session(s);
> >               mutex_lock(&mdsc->mutex);
> >       }
> > @@ -6284,12 +6348,87 @@ static void mds_peer_reset(struct ceph_connecti=
on *con)
> >  {
> >       struct ceph_mds_session *s =3D con->private;
> >       struct ceph_mds_client *mdsc =3D s->s_mdsc;
> > +     int session_state;
> >
> >       pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
> >                      s->s_mds);
> > -     if (READ_ONCE(mdsc->fsc->mount_state) !=3D CEPH_MOUNT_FENCE_IO &&
> > -         ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) >=3D CEPH_MDS_S=
TATE_RECONNECT)
> > -             send_mds_reconnect(mdsc, s);
> > +
> > +     if (READ_ONCE(mdsc->fsc->mount_state) =3D=3D CEPH_MOUNT_FENCE_IO =
||
> > +         ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STAT=
E_RECONNECT)
> > +             return;
> > +
> > +     if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) =3D=3D CEPH_MDS=
_STATE_RECONNECT) {
>
> We had >=3D CEPH_MDS_STATE_RECONNECT before. When an MDS restarts, it mov=
es
> through these states in order:
>
>   RECONNECT    (10)  -> waits for clients to reconnect
>   REJOIN       (11)  -> rejoins the distributed MDS cache
>   CLIENTREPLAY (12)  -> replays in-flight client operations
>   ACTIVE       (13)  -> fully operational
>
> If the connection dropped and the MDS was in any of those four states, th=
e
> client sent a CLIENT_RECONNECT message. REJOIN (11) and CLIENTREPLAY (12)=
 now
> fall through to the teardown path, not the reconnect path.
>
> Thanks,
> Slava.
>
> > +             int rc =3D send_mds_reconnect(mdsc, s);
> > +
> > +             if (rc)
> > +                     pr_warn_client(mdsc->fsc->client,
> > +                                    "mds%d reconnect failed: %d\n",
> > +                                    s->s_mds, rc);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * MDS is active (past RECONNECT).  It will not accept a
> > +      * CLIENT_RECONNECT from us, so tear the session down locally
> > +      * and let new requests re-open a fresh session.
> > +      *
> > +      * Snapshot session state with READ_ONCE, then revalidate under
> > +      * mdsc->mutex before acting.  The subsequent mdsc->mutex
> > +      * section rechecks s_state to catch concurrent transitions, so
> > +      * the lockless snapshot here is safe.  s->s_mutex is taken
> > +      * separately for cleanup after unregistration, which avoids
> > +      * introducing a new s->s_mutex + mdsc->mutex nesting.
> > +      */
> > +     session_state =3D READ_ONCE(s->s_state);
> > +
> > +     switch (session_state) {
> > +     case CEPH_MDS_SESSION_RESTARTING:
> > +     case CEPH_MDS_SESSION_RECONNECTING:
> > +     case CEPH_MDS_SESSION_CLOSING:
> > +     case CEPH_MDS_SESSION_OPEN:
> > +     case CEPH_MDS_SESSION_HUNG:
> > +     case CEPH_MDS_SESSION_OPENING:
> > +             mutex_lock(&mdsc->mutex);
> > +             if (s->s_mds >=3D mdsc->max_sessions ||
> > +                 mdsc->sessions[s->s_mds] !=3D s ||
> > +                 s->s_state !=3D session_state) {
> > +                     pr_info_client(mdsc->fsc->client,
> > +                                    "mds%d state changed to %s during =
peer reset\n",
> > +                                    s->s_mds,
> > +                                    ceph_session_state_name(s->s_state=
));
> > +                     mutex_unlock(&mdsc->mutex);
> > +                     return;
> > +             }
> > +
> > +             ceph_get_mds_session(s);
> > +             s->s_state =3D CEPH_MDS_SESSION_CLOSED;
> > +             __unregister_session(mdsc, s);
> > +             __wake_requests(mdsc, &s->s_waiting);
> > +             mutex_unlock(&mdsc->mutex);
> > +
> > +             mutex_lock(&s->s_mutex);
> > +             cleanup_session_requests(mdsc, s);
> > +             remove_session_caps(s);
> > +             mutex_unlock(&s->s_mutex);
> > +
> > +             wake_up_all(&mdsc->session_close_wq);
> > +
> > +             mutex_lock(&mdsc->mutex);
> > +             kick_requests(mdsc, s->s_mds);
> > +             mutex_unlock(&mdsc->mutex);
> > +
> > +             ceph_put_mds_session(s);
> > +             break;
> > +     case CEPH_MDS_SESSION_CLOSED:
> > +     case CEPH_MDS_SESSION_REJECTED:
> > +             break;
> > +     default:
> > +             pr_warn_client(mdsc->fsc->client,
> > +                            "mds%d peer reset in unexpected state %s\n=
",
> > +                            s->s_mds,
> > +                            ceph_session_state_name(session_state));
> > +             break;
> > +     }
> >  }
> >
> >  static void mds_dispatch(struct ceph_connection *con, struct ceph_msg =
*msg)
> > @@ -6301,6 +6440,8 @@ static void mds_dispatch(struct ceph_connection *=
con, struct ceph_msg *msg)
> >
> >       mutex_lock(&mdsc->mutex);
> >       if (__verify_registered_session(mdsc, s) < 0) {
> > +             doutc(cl, "dropping tid %llu from unregistered session %d=
\n",
> > +                   le64_to_cpu(msg->hdr.tid), s->s_mds);
> >               mutex_unlock(&mdsc->mutex);
> >               goto out;
> >       }
>

