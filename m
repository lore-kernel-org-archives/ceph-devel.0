Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01D30AD15
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289834; cv=pass; b=J/oHRa/pER+W6YXpYv0bPEmGWYjJETAX+7rzp+qQnyY01jsR/rEv3e4e3Arp8afzJ3ac4MomohCRgyJb8MKsq6CYB50y7K8+XdmArz6itCAcVle9u/y5/CsSbCdUpcJ+n96eWOd9yHkmZl0m8U/o2VSmKFmUrUfc5vwQg8sYzUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289834; c=relaxed/simple;
	bh=F354IfJDkCCLKOl/sPhPTshgNWF1UuOVHEJ1hU4hlwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtA7qu/8In1p3dHCuy9QOUTDazqxOT7n9S5aZcpPniub85lUYxAdUFmym/eCSOVlKZvz0fBXC24lGN/LKi5SlcFXp7V28DGeKSIdf2vgh29VidS1vc7EDkT6TQyRMF8ohq6tHjje5YV8qqXh4WDj8nTincDGI9cVv3u7yT3ZR+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+DBz/hf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3PnSW8R; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+DBz/hf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3PnSW8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777289831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
	b=d+DBz/hfPsTzj2lP9qAgE4WZ5gmG/SkX7AqUh9myWYRqVj3QHQET47WRPOYXQ6xAvkwveS
	kQ4mCK78zR3QOGbinh0jaorw49TXSmlatu+CbqIsOU3kMYS2gNWeIXJOn7/BWbet2Ceb70
	WTN6XTrM7Wp8jMfIX9SeINpdmgRc7bs=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-II27LN2dNteNfT7vgLLD3Q-1; Mon, 27 Apr 2026 07:37:10 -0400
X-MC-Unique: II27LN2dNteNfT7vgLLD3Q-1
X-Mimecast-MFC-AGG-ID: II27LN2dNteNfT7vgLLD3Q_1777289830
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-953e8999d8fso15190556241.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 04:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289830; cv=none;
        d=google.com; s=arc-20240605;
        b=hWrw/ts5V36xqheA/bnqEpI1cnf9y1S+7/L/c5LuESpVrJI1qMWTOxm7d6zhgvgozs
         qHvf6TFy6/AVHAAJWMudsbTRjbLa1dVi/AJTYYexcqaNM7VDgcuCOD/rxtlGNicaB/7v
         XuIg42ngjtebqKAYOaT+EnfI4F13vShRUr0T4y+pkW7dSeClNWb7H6G5Mz3YoHe8YR8V
         6K39fyXcPnPjxzv7R/Hl7CPLEURRXw3xHGxZfNIemg+4DkxY0BIi4jRNyrM5lxob/bCy
         YuU5CyMpcrlxjGpBYOF4mrbYXoRXbtNl0SZztMwSgBXhsEg5rEwak16BTc8CZL66qJOM
         XL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        fh=4sJrSkY7V8JT6AvZB1ZW0rR3MBJS7LN5g3XPU6S/PJI=;
        b=WtDBWQmx3vFRuDNpEArU34YMy4Q98tsQZSW7xC+mCwD0VeXuv4UQ/bbjwVu05O1oVM
         OdDdHZWXYCSicK12notpXXvj/GW6lFRyJ9zpuWytxUl0hIcDHZxA8GSqz/KqxapTjrWT
         pQacwB30ngES7c2vdGsZcdV9FA14bdkGoQrmBRnjJJQ/lq9eJKQrpg/fLlHC9pTSyYg4
         9ZObZtVhtrrjn1la1JWsgM2HeKsycntk8FwDP9xpjS2gpVq/TI3y9hE/OgC8bdLB5lBU
         vGCuxFj/KQ6kEcFkmmrWEsvgolG8Feui6WYu+pYAY2VusANwRCiNasFbYi/oXJ6vzrbx
         8ruw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777289830; x=1777894630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        b=c3PnSW8Ro4kn/OpVNYtpjvPLyxFcjsUsELT4DW5xoO12WZtzac5J40stJGwgjl53mI
         k+G+mhMkrI/7e6eChnKzkAIJjp+ZkHPTmvq6j8XvgGWtW5xney9RbWqfxEuLTaumN3Wb
         zkEGg/Z4y6TGnLbnLVTV9Qus6kWNdFsQDoB+VTxTgyK1OWRib31mruGjBq7AP1EnDHNn
         D7Kw+ko6c0UIHAhp9hzzpUZzH3wydtxB//nDSLx/09lN7/FMA0eaXf/BjUtl6TtfFf7v
         x/4QJbFle8XFvaxsrXRxoO9OE9tseQk1j3SV7eBxk7tcsrxu5F0jczJAFNEZgnUNEpV4
         ckWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777289830; x=1777894630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z1t0q+WL95cKXsfCC9nv37pKUgFW8rNlOq1DBxIRgsM=;
        b=Eca+xnoQ9OpGjhnfCLDsg4sS5BvH29GNvlX0+K2CI/67zeSQgLVtdCI8Eu9zp1IKi7
         /kD6ONjjeSKj4+hYDvuRmsA35AlmnrDWRZe6+LJ4T7Nv5+fhjUpaZie6kfXiHIWXz1BO
         4w9zIq5n3A5+qP68GdkTTg2gcR2Za/GRx1EpSjPunSFWaXPnHLvoZ0L43IsqUNHLTpt1
         u/vDEnP1YsbSbJBD32HbEDg1y/CpETvLNrkeda/yb3PuJVt9btYdEUcmhgFpbOjPmeIJ
         8wD6au80TY8blDk+FtZY43HHYMykO9/ybbe2xr/jAjaJhlRlJQwsU5A2Jw6w4WfaYM5T
         oiIA==
X-Gm-Message-State: AOJu0YykHYWON/GBnnr9Sxmq1VNtPrFu1mPP+mCCPKX5Ne7FeGu5xKln
	9QigKlNaiUmBkDTb0A0AEMVuVOi3ahbqXRb1E+bFpyuFHzN7QMoHOnEY7VkYm9OP8N6GanFMFYT
	e9L3rJt7nDxH0e40Swj/nuYY5yYGJvYgq5VeVkQJTkUlRq9MeVuyeTsATCSL+cQR77bEhyfh/v2
	OfTUoJiPsHJ9DgbCW1rqzwT2qBr8n+DR7r1mFMnw==
X-Gm-Gg: AeBDiesgiL1bQznwXxs+mxhIH67WfcZjaMgrF9dWfg1NQvM552nwOEaUJP68F5r3WOF
	aTR4Q8mCK9CA1JjC1ClZSbd04xSZJJx+cBvcGsFwrzRSJhT5Nlf9E9hb0aFU0hmEXuuI/ZJzQs3
	qz6fvsJSJghF6As/R+PAtnL0tGvbxO2KTviHjk9k1siYpRpCTkXXlHS86M9kaxOMEhJz26Y+5OH
	2lL3xrCYCthxoA=
X-Received: by 2002:a05:6102:f9a:b0:607:4fe2:a64d with SMTP id ada2fe7eead31-616f473aae6mr22733249137.6.1777289830068;
        Mon, 27 Apr 2026 04:37:10 -0700 (PDT)
X-Received: by 2002:a05:6102:f9a:b0:607:4fe2:a64d with SMTP id
 ada2fe7eead31-616f473aae6mr22733236137.6.1777289829609; Mon, 27 Apr 2026
 04:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409190046.317760-2-slava@dubeyko.com>
In-Reply-To: <20260409190046.317760-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 14:36:58 +0300
X-Gm-Features: AVHnY4JiTwgyHXokkmc5nSoTr8J-qjc92vaTullRpUsi0AKyA0uLuOI7ElxuhlY
Message-ID: <CAO8a2ShUgDbnRygsFDAmQXtTC9hh4eAWh0PW6jFGsZ0szd-4LA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Apr 9, 2026 at 10:01=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> When MDS rejects a session, remove_session_caps() ->
> __ceph_remove_cap() -> ceph_change_snap_realm() clears
> i_snap_realm for every inode that loses its last cap.
> The realm is restored once caps are re-granted after
> reconnect. It is not a real error and thsi patch changes
> pr_err_ratelimited_client() on doutc().
>
> Every quota methods ceph_quota_is_max_files_exceeded(),
> ceph_quota_is_max_bytes_exceeded(),
> ceph_quota_is_max_bytes_approaching() calls
> ceph_has_realms_with_quotas() check. This patch adds
> the missing ceph_has_realms_with_quotas() call into
> ceph_quota_update_statfs().
>
> v2
> Small cleanup by adding braces for multiline if-else
> statements and changing the comments.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/quota.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 4dc9426643e8..67ce1ff1a421 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -230,10 +230,17 @@ static int get_quota_realm(struct ceph_mds_client *=
mdsc, struct inode *inode,
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> -       else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +       else {
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection. This is a transient st=
ate;
> +                * the realm will be restored once caps are re-granted.
> +                * Treat it as "no quota realm found".
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
> +       }
> +
>         while (realm) {
>                 bool has_inode;
>
> @@ -342,10 +349,17 @@ static bool check_quota_exceeded(struct inode *inod=
e, enum quota_check_op op,
>         realm =3D ceph_inode(inode)->i_snap_realm;
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
> -       else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +       else {
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection. This is a transient st=
ate;
> +                * the realm will be restored once caps are re-granted.
> +                * Treat it as "quota not exceeded".
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
> +       }
> +
>         while (realm) {
>                 bool has_inode;
>
> @@ -496,6 +510,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *=
fsc, struct kstatfs *buf)
>         u64 total =3D 0, used, free;
>         bool is_updated =3D false;
>
> +       if (!ceph_has_realms_with_quotas(d_inode(fsc->sb->s_root)))
> +               return false;
> +
>         down_read(&mdsc->snap_rwsem);
>         get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYT=
ES,
>                         &realm, true);
> --
> 2.53.0
>

