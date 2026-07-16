Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61F382F1F
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177455; cv=pass; b=FmJf4d0RSS2O47RpvrOv/Ii/LK7QJo83lxacsXLpmYGNHLN9CqQB3tkoz2V9KwUFDLrUkEfuRXvlIHTCQIgMxVNcqvSQojwO2JETRCR+EHzTKm4jV5dLy9EKvOPll/xPDDNNcY3Vxi2Ob66RCQSbaXxMvplUPXqAX93+9wVzVdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177455; c=relaxed/simple;
	bh=Yp88bq/Uio6Fe1B73zXzKjlr6SafSJJfZ10M6u7sq9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQ43qavkQXVKhu1unWIjCW6Up7Y4lXIdurlbD/UKfR5GWDd+5S4sLlObztJ9Alg/XCBZV5UqFNtZ4liSQPknJ4oSfXunMPQNGFbgD+BFPyka6HRwKPt+9us3uj85I/2BNHGxcqmKOK2DtyZC67CjbBqTU6K0gALyjqny9D5nBlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=Nv5bPyLi; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="Nv5bPyLi"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15c42a45adso34360066b.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 21:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784177450; cv=none;
        d=google.com; s=arc-20260327;
        b=enK73oq0eno7JthX1IqrJBAzq2RXelfHznbEtfnan/Rjl6XVp1I4MQhNUk2K2ycIgr
         zjpXe4Q9EGUcoo0ig3txbHJyCh10AywpFpvGvVF+2x8GA1E+jNkjUe89EAroWSQp0KvA
         6xlNIh2P8SRWEexKZ+DsKt62LaVs37ywV9a9WwERDrCFVE4HZMYbvE74hDSyf2/EHUlp
         KfMrVmici3kXEugLbV04IuSmPFj6B9vqaonjXhGiafkW1g7XDI+lA/dHkqoEJ177TT0h
         R2G6krKf/cqkyn4WSguRixzMykAOasRt7Nu1+PXPDxBgk46U0qkIjlM7yDOtyidCaZ3Q
         0RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZ9hziPWAp8IhVg3lRvrhKLmXhCilUOpc7UuKP0N5qo=;
        fh=O1TtJK0UvnQ4ak89qzVcMjc8uHkIfAbB7QHralLoZog=;
        b=AxDNgNHSTzJEYrDLSbl1q8dMoHD1844UUv1+aQ39du9VRFTKty3ouH1Eh6t2T20iou
         Bt82DZeK+jpSQj6gbsMSIYaP8nrE3JsybFIvVQAosmVGMdiT+ttfRyt+6ALdJX1Pt3sl
         XW0CIOFUpkbrJWesYyZ8LZ3Jmzz5qdIW5qjNQwyMuShkwzrvkndMW/rWT4uDcsErFgK4
         ze4/ZEZiAFnNhUvdoOIf06I3tj+1sB67sskzF6ekHZRnMmb0KMmAiQ6Oo6koe+paXtia
         MhLJGcSu5CZ/1xuimwHjcKWMowsq0C3Bxy8+YX++XMFyDOQLS4oqgtpbTpaBWuiaWKIS
         Qmpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784177450; x=1784782250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZ9hziPWAp8IhVg3lRvrhKLmXhCilUOpc7UuKP0N5qo=;
        b=Nv5bPyLibDKXmuqIigaFSPJkSoscziT4+y9onVdm0SpLP3CwV6pL2AO66CFXBU4OqR
         NPlYxyufqO/2Hl9kgB4DfmGWOHs819TpbHYFTWE/97UmjlJa6U2IXA3jDhnTaEqAY6JJ
         XNKmKn07Ic9Q5entNHbC6A8GjODIZC4OXXtBH39lYxqlU92j762fPQ6I8cT5bbfa+wI2
         nMGWRFQWACrId+yafhIDg/CnX6MQm1a8O+5t2gAUzQ5zPh6wAkRnGckhZ18Khin32U0q
         WRfahbbWD+osJVb4RQbOMYPXWFh+toFN4v93K9QyxmjsBVkFRegGWtMISRM2NgdyhCz4
         ewMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784177450; x=1784782250;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZ9hziPWAp8IhVg3lRvrhKLmXhCilUOpc7UuKP0N5qo=;
        b=sK3kPrh1p8icJqkSqXjp6CyNvlW52cFTGNNbSxyiZG/rhBIh80lzmzMqTM2au3ehwT
         wir7xNLFIFKNjVjSxUksV8eJjNKybwhKftBdVg0QXEWNzqPlXh07AYwKhY8SVxIAZaZ6
         ZxFp/Of77g2Fr8EWBjsuFswJCXNbO1TcCRLiC1MaOWTMF6roulbTe4R3jn5tSZgSi9FL
         D4NnR2SMpIwfIOvb5X5uICtsLtv1hjMBG5XrAd74l6FuNLGkIkVG6OQ4kHeBXqNLMfpE
         B6rFu/pCA/mlR4+F4+ZnutOMsKsdcWlU78WeUmTZ4mh5uKCuCWEl6Lw2qPU+gJbPbnJp
         IhRg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5Pz2RP/AyFZyHhPCtgx7gkhSqTdFxM2gVb2I3UmCL4m4+UsOgEHSob7888i7gurCpR4DoxZM+MKAT@vger.kernel.org
X-Gm-Message-State: AOJu0YyyyrLRlFwK/oT9T/A/I5vjlRuLsTgdM4oJanfeflmTmVl2JffP
	mXMS+R1gtu555tm7NRsnRa+wiXuN8M1iJ9n28tP36e7mm45q7VUPRvH1z1NAOFp3nM3IaB244bO
	CzgloO+aZG0+Pu5IZxvYPvKvYhPyRjYIzRWZK2cG3rA==
X-Gm-Gg: AfdE7cmWVA0rrCqvt2f3CwnRxp8ZrEk/lDUDkLZ55yxSn6kyMediHCNee6ynjJ+8pnV
	dZXc7ZBPNehnEKRwmRPGaHDlULt2QtpoWovwrEeMU4NaHVsXnKM8k6r9BVrYU+XGtuIIPaLgh2u
	JQ4deJbsbHMafpe8exY0Lyh3kVQc5DMI1dhq/9HzYl2fMHjqVPAfouO0LHaTimv8EC6lYKBg4kU
	tnLOhjtUhDaX3yDleq7/4Dd0sSPaxGvGBMXJV6nzGihlMAop2Ty+RQFdpUTEPB4LKpGeA==
X-Received: by 2002:a17:907:a70c:b0:c12:cb91:58aa with SMTP id
 a640c23a62f3a-c169229c0camr45321166b.24.1784177450047; Wed, 15 Jul 2026
 21:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
 <20260715-ceph-mdsc-mutex-optimization-v2-5-90e81b726724@clyso.com> <c9ce608055763b943837451367b90716a343845f.camel@dubeyko.com>
In-Reply-To: <c9ce608055763b943837451367b90716a343845f.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 12:50:39 +0800
X-Gm-Features: AUfX_myfYzS95UJ5BqVBdq7-RpC0hTXzXwofcPfy4Zk3VmDFY-6ARRvlD74n3FY
Message-ID: <CAOJNxR+POiN4GG8V_5AHd6JHHSKCx=CoffzU0E0G6z_iHs5JoQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ceph: narrow mdsc->mutex scope in replay_unsafe_requests
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E3=80=82

On Thu, 16 Jul 2026 at 03:12, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-15 at 11:58 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > __send_request() is lockless so holding mdsc->mutex across the
> > replay loop only serializes the list iteration itself.  Collect
> > the unsafe list entries under the mutex, then replay them without
> > it.  The old-request tree walk uses xa_for_each() which is
> > internally locked.
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> >  fs/ceph/mds_client.c | 51
> > ++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index be0dae919d69..c313574def74 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -4744,30 +4744,66 @@ static void replay_unsafe_requests(struct
> > ceph_mds_client *mdsc,
> >  #else
> >       struct rb_node *p;
> >  #endif
> > +     LIST_HEAD(replay_list);
> >
> >       doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> >
> > +#if BITS_PER_LONG =3D=3D 64
> > +     /* collect unsafe requests under the mutex */
> >       mutex_lock(&mdsc->mutex);
> > -     list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> > r_unsafe_item)
> > +     list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> > +                              r_unsafe_item) {
> > +             ceph_mdsc_get_request(req);
> > +             list_move(&req->r_unsafe_item, &replay_list);
> > +     }
> > +     mutex_unlock(&mdsc->mutex);
> > +
> > +     /* replay unsafe requests (local list, no mutex needed) */
> > +     list_for_each_entry_safe(req, nreq, &replay_list,
> > r_unsafe_item) {
> >               __send_request(session, req, true);
> > +             list_del_init(&req->r_unsafe_item);
> > +             ceph_mdsc_put_request(req);
> > +     }
> >
> >       /*
> > -      * also re-send old requests when MDS enters reconnect
> > stage. So that MDS
> > -      * can process completed request in clientreplay stage.
> > +      * also re-send old requests when MDS enters reconnect
> > stage.
> > +      * xa_for_each() is internally locked.
> >        */
> > -#if BITS_PER_LONG =3D=3D 64
> >       idx =3D 0;
> >       xa_for_each(&mdsc->request_tree, idx, req) {
> > -#else
> > +             if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> > >r_req_flags))
> > +                     continue;
> > +             if (req->r_attempts =3D=3D 0)
> > +                     continue;
> > +             if (!req->r_session)
> > +                     continue;
> > +             if (req->r_session->s_mds !=3D session->s_mds)
> > +                     continue;
> > +
> > +             ceph_mdsc_release_dir_caps_async(req);
> > +
> > +             ceph_mdsc_get_request(req);
> > +             __send_request(session, req, true);
> > +             ceph_mdsc_put_request(req);
> > +     }
> > +#else /* BITS_PER_LONG !=3D 64 =E2=80=94 keep mutex for rb-tree iterat=
ion */
> > +     mutex_lock(&mdsc->mutex);
> > +     list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> > +                              r_unsafe_item)
> > +             __send_request(session, req, true);
> > +
> > +     /*
> > +      * also re-send old requests when MDS enters reconnect
> > stage.
> > +      * Must hold mutex for rb_first()/rb_next().
> > +      */
> >       p =3D rb_first(&mdsc->request_tree);
> >       while (p) {
> >               req =3D rb_entry(p, struct ceph_mds_request, r_node);
> >               p =3D rb_next(p);
> > -#endif
> >               if (test_bit(CEPH_MDS_R_GOT_UNSAFE, &req-
> > >r_req_flags))
> >                       continue;
> >               if (req->r_attempts =3D=3D 0)
> > -                     continue; /* only old requests */
> > +                     continue;
> >               if (!req->r_session)
> >                       continue;
> >               if (req->r_session->s_mds !=3D session->s_mds)
> > @@ -4778,6 +4814,7 @@ static void replay_unsafe_requests(struct
> > ceph_mds_client *mdsc,
> >               __send_request(session, req, true);
> >       }
> >       mutex_unlock(&mdsc->mutex);
> > +#endif
> >  }
> >
> >  static int send_reconnect_partial(struct ceph_reconnect_state
> > *recon_state)
>
> I believe we have problem in the patch.
>
> Once mdsc->mutex is dropped in the new code, a concurrent "safe" reply
> for one of the unsafe requests currently sitting on the private
> replay_list can call __unregister_request() =E2=86=92 list_del_init(&req-
> >r_unsafe_item) on a node that Thread A (running
> replay_unsafe_requests()) is simultaneously iterating and unlinking via
> its own unlocked list_for_each_entry_safe(...) { ...;
> list_del_init(&req->r_unsafe_item); ... }.
>
> Two threads mutating the same prev/next pointers with no shared lock is
> a linked-list corruption =E2=80=94 it can skip or duplicate entries in
> replay_list, dereference a pointer clobbered mid-update, or trigger a
> list_del corruption BUG() if that's enabled.
>
> What do you think?
>

You're right. Let me fix this.

Thanks
Xiubo

> Thanks,
> Slava.
