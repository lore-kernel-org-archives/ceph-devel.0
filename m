Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F839424D7C
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174126; cv=pass; b=u7s4vr4P0HgAYtl+IyuFwU5VAL+VbiSNep+qJ3mahmw6Y+E0zb73k/tc37jrAvKAzm9+kv5igd3sthkRnekUImKlKeF/+fMzo38VF++7YWaLWpBn12yjPoOv4MDJj+LBqo0F1ayLGrjIZQ8fZFfOJgiBTVynf4/V+DMj+ABFCyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174126; c=relaxed/simple;
	bh=p4IbBim5O/J4PTXG3A6iGROS2pr4TIL9zOaTGq5aeVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcyMBlfBkmb5vGAK9X/J/cN0EvXnqhiBcKgdxXTh2IoYMEiNQ9MQ7ZOM9LbxIfwClu6R5L95x1bi0UwhhevX4ZoipbB1IXAZNYORpbPxXu4ws/PwkniaheAxKE5XW7lgwDzv9WTa5WSlVwcJNRgRkQNWMIJdewilXi7TPZwt6Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnuv28nj; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnuv28nj"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96944741eaeso1037999241.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 10:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785174123; cv=none;
        d=google.com; s=arc-20260327;
        b=G9kX9DGiSEw09NbHO2xYEa/XErMgv/yIXiEGCYw4eOMnwmy6bsc7havCExLMWWsOmb
         IFiPTn6AvfX/7URBrnfLgVCjblv6M4ZwbGkYxUtPoQm2jDJwnKxt57I0v2hHrrQBAzst
         jREqaICDSpUXP/GDdbCW2mx+sDS3lJvqwH5a43NgQKmd7xJqR0CapRYpwKjn+ucl52Lm
         JxwZTpk1Bm/qEjV21iCU0BxX15am5pmLOrkB8Vto4laE3sYCWjKGXvDXIwlm4/W8N2gH
         YJzWPLCJvr0xN1AQkSzBbyRTa6ez6jQ2ywCdtyNPXTWbRB+WMN8ItC+irEc0lWoq2YfJ
         FUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3jvogCWCCwgR2vah0y9v1ywotlFPbCAqTJPypcZqMY=;
        fh=48utguRYxUK2cZef9gZS1Yxi0bh4K3f0i58kNF5Gwv0=;
        b=FMwkFDpPUpSIeuHQLVEBgzZqo0AkwndNrRRnSjohIMYggCJbvJcIhkC0EJWVOnVs1b
         PY5nh0tlGZoQ+L+b7XRsGfTKeuej1uZ/aic3lUhaWUP9LIJeu0cBhAm/7JnO/0nIj3xI
         gdzlDijfMCk5bAsJB3ABs+rYgTl7oBiV3gnPgnOWhAfeEM5IjHyV9t3iJEah08HHmOYa
         RKbKkcLdVkkBeSyqkUBSdVKffSAfe2ShZ/abDHXMxqsAymIx/FlJUZX+HgIeDbBZH3TM
         yM5oSl04p1NT4f0Pkk5LaPJllW8F2i58Ig2oAM3Ro91PTeNLk7Hg8+awYdLtCRM1RJ55
         jHIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174123; x=1785778923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3jvogCWCCwgR2vah0y9v1ywotlFPbCAqTJPypcZqMY=;
        b=Nnuv28njT6suqPhwihcWvP/ZW5/zfCA/eApDlw5hfcvYtk8iLgF95emBc5F2yMWG+a
         3FzO8WvAujJHOGcXIlwd2nQwWvPJcNgF7wLiDx/RWBgxKiiYFI2Fc9w4uK500tcSjBCz
         m04YF0fJ2x3bNotL9sIFtIoUOBtMYQ0tMqRl2hfb4E/0xzm0GjTSz/Y1Fg/xqQR/T376
         PTrZs8atPIAgTYUB/Nd8NLAf5mFOdp+5OZIkPVxnd4qKyT8pFfjQ5RuGs6LGpTihp19h
         m8X4pNOqPDrRivxhXzHCgEbg7Nncf4sIDbELqmJ4xaZ9XxcwsYaTS/7wOs85cTkGVt+N
         geqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174123; x=1785778923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3jvogCWCCwgR2vah0y9v1ywotlFPbCAqTJPypcZqMY=;
        b=FcZBrzgqNTL48zwybLTFAHwGwZBFe4BC1ShrUbGhgxu9Sj6pnQ/K4R9XIMx2mMOlfm
         pKmKkZaOpPn+bi3xmZGAvF6Vs2ltiuC7bbisE2iWqh9dpbv/36M0tqE/max1sbDi+vxI
         kkq5R/Csvct4DmwB5Xd9avxUHQrupfdtuQzwWfPSEV7B1jt30D/egFHbZN4Wwtz9jSuF
         rDOifvpzxQxISVlt1dbCO6XS3AZ9J/ZJJ4g66FndE+wqz6Uhg5jSKXLRl3CooWyiNFTB
         FejhsSUEpxEo/ipCps9z6nmlg7WVKaBG1FRPzI1ouVKs/ALMwbyl9KT9y9e4q6savyou
         QWkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8T3bH9yTLaIU0Nx7A04M4rrCKT7bTCg2aZhYB893Yu9vC8X7EpQkSvrPQYFepGJZP0TXQg6AsvfSn@vger.kernel.org
X-Gm-Message-State: AOJu0YyhK0LdCVCP+hlRKnBHsaNH3xAm0EoR/FcgmVW1BoFwBx6dxnzC
	qRZHxjzxQjScFIXqFUqKeeNaP49lsK15KgpprEfCa7meVZllXHiFQEcK3CIW63pqc6+3uJ9hbE4
	LYnDNMjy8vJ1ery3ajvYm5PGZEygpJIcBcN78
X-Gm-Gg: AR+sD132AP/u8QjjODh98Oc1mQ3HMHDYRlH+AteVjoiwO6O5ZKkccHyAFW3S2zZF9pB
	2zem+RV9qxpAptaDvNO4wzMr5wBrpD4chCJgGOE2H9QgKejY1KwparVn5rU6Tjenyx+PIVHA52n
	aITHwZr1PLubc/urj5kTif+OHagpFy64mrvd+O/0Nc8gRwckcSB62zoVASQdaPLUgrHcWOYTuai
	Qf21101LiIi0Pb9o+sApdo1vPzNKdXSwhjpBcxYbnlYnXAgeSUPxv/VAFdD2grgtE29QNj3tzGE
	d6SudhuAwMnsSlaB5uo=
X-Received: by 2002:a05:6102:80aa:b0:739:77a7:90bd with SMTP id
 ada2fe7eead31-75040ddd495mr4682456137.26.1785174123316; Mon, 27 Jul 2026
 10:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP9jaHW2Eixk6i0gemBnWUgcybciFv025sXykPxk19ojpw@mail.gmail.com> <b027e46f-0af9-4980-b8bf-afaf1a4b4b43@tu-ilmenau.de>
In-Reply-To: <b027e46f-0af9-4980-b8bf-afaf1a4b4b43@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jul 2026 19:41:51 +0200
X-Gm-Features: AUfX_myw4beNru5koX-gmnEpQHPcms9V9vsw34MnzR-7agMRazAEX00djfnHnok
Message-ID: <CAOi1vP8k02Xe0MX-+uYGOsSPP2MGijUHcVEa1WGs0yrqZGFWmQ@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:32=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> On 27.07.26 12:35 PM, Ilya Dryomov wrote:
> > On Wed, Jul 1, 2026 at 5:56=E2=80=AFPM Raphael Zimmer
> > <raphael.zimmer@tu-ilmenau.de> wrote:
> >>
> >> A corrupted osdmap received from a Ceph monitor or OSD may contain
> >> placement groups with osd indices that don't exist, i.e., that are
> >> greater than max_osd or smaller than CEPH_HOMELESS_OSD (-1).
> >
> > Hi Raphael,
> >
> > The osdmap doesn't contain all placement group mappings -- they are
> > produced on demand by CRUSH based off of the crushmap that is embedded
> > in the osdmap but doesn't contain any OSD indices.  There are a few
> > (usually small or empty) exception tables in the form of pg_temp,
> > primary_temp, pg_upmap and pg_upmap_items where the "override" OSD
> > indices are stored.  Are those what you have in mind wrt. osdmap
> > corruption?
> >
>
> Hi Ilya,
>
> Yes, it's about these. I looked into it again after submitting this
> patch and concluded that the problematic part is specifically
> primary_temp. In the functions called from ceph_pg_to_up_acting_osds(),
> non-existent osds are removed from the osd sets. Therefore, the up set
> will not contain any invalid osds afterwards and will also have a valid
> primary, as it is always one of the osds in the set. Similarly,
> non-existent osds are removed from the acting set. However, the primary
> osd is directly assigned from pg->primary_temp.osd in get_temp_osds(),
> without checking for its existence. This way, an invalid osd index can
> be returned as target osd from calc_target().
>
> Therefore, it would suffice to add the check at this position (in
> get_temp_osds()) and set the primary osd to the homeless osd in this
> case (or perhaps to another osd from the acting set, but this doesn't
> seem like a good solution to me, as the osdmap may be corrupted even
> more and other osd mappings are also incorrect).

Setting the primary to the homeless OSD in get_temp_osds() would make
the OSD set invalid as far as osds_valid() is concerned.  I don't see
a problem with "another OSD" solution because corruptions of this kind
shouldn't ever happen in real deployments.

>
> > If so, I'd suggest adding map->max_osd checks to the corresponding
> > decode routines.  Munging ct_res to CALC_TARGET_NEED_RESEND as done in
> > this patch doesn't make much sense -- you are asking the OSD client to
> > arrange for the OSD request to be resent when there is no valid OSD to
> > send it to (and no expectation whatsoever that the resend's invocation
> > of calc_target() would produce a different result).
> >
>
> I don't completely agree on this matter. I specifically reassign the
> request to the homeless osd here and don't ask for resending it to an
> invalid one. This will result in not sending it out. __submit_request()
> only sends it if !osd_homeless(osd). The same holds true for
> kick_requests(). For linger requests, send_linger() also ultimately
> calls __submit_request(), leading to the same behavior. Finally,
> recalc_linger_target() only re-links the request to the homeless osd if
> calc_target() returns CALC_TARGET_NEED_RESEND.
> If applying the solution described above (checking in get_temp_osds()),
> this would furthermore only happen once.
>
> Adding map->max_osd checks to the corresponding decode routines would
> also be possible. I initially decided not to do this because the
> proposed solution needs fewer code changes and still resolves the issue
> of a potential out-of-bounds access. If we wanted to add checks to the
> decode functions, this should be done in all of them for consistency.
> That would mean we need to change multiple functions, including their
> signatures, to pass the map->max_osd into them.
>
> Do you still think that checks should be added to the decode functions,
> or would a check for either ceph_osd_is_down(pg->primary_temp.osd) or
> !ceph_osd_exists(pg->primary_temp.osd) in get_temp_osds() be an
> acceptable option too?

If there is confidence that the potential out-of-bounds read issue is
limited to primary_temp, I'd go with ceph_osd_is_down() check in
get_temp_osds() and ignore the primary_temp entry if the check fires on
the OSD in question -- the primary derived from pg_temp or the up set
primary (if no pg_temp) might very well be actionable in case of legit
mishap on the monitors.  I'd also warn though since this isn't supposed
to happen normally.  Something along the lines of

    /* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
    pg =3D lookup_pg_mapping(&osdmap->primary_temp, pgid);
    if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
                                             pg->primary_temp.osd)))
            temp->primary =3D pg->primary_temp.osd;

What do you think?

Thanks,

                Ilya
