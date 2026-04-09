Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB823B8949
	for <ceph-devel@vger.kernel.org>; Thu,  9 Apr 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734465; cv=pass; b=edI1Mdrx+lCWq1x1GsdrUuA9Qj/kMwEp1AaJOGww6UPrdWu9pRvzBsiwIrZk4dcgZpiv8UxI6O5IORm6x896JAV1sQs4Hotq0xN7xaqBGyGSe/51fX3GT7djHQX+v5od5/5/AtNEABBmrkzKaWO4ZUPFbbweT3vLvG3gARAcc5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734465; c=relaxed/simple;
	bh=L+Wczuh9KLGAXgg+iq0uFWPCITlLrRyjxt3LtFr4r7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDFRwDeTJCukXhyVu8elXzS/83ko+81+ILMtGJZkGAhH9V/RXUdImADHMwSPh2CuJeb+57f9W5j2bRq+rQb+UlYeUALVt/qxQG3kcCx2Ao0APK81PAjtsjNmgaNrkrbcAnzw8j5qws75IzOFpzuWgkK/2YmZC9O5cWnEmE8QTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVwBGJxY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSW4B+rx; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVwBGJxY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSW4B+rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775734463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
	b=GVwBGJxYaEIC71i/OFgzSDtNets6sM9YUt+ilaqN0qixknrrIoMhhso1XOfWtuTO3C0ppr
	lYXVAf7usutWvPEjEptFW3P8rllALbEqldt7a2zVAivZuCG06yHWn/PrgXDjGoR5xJWwbl
	6+8oSqYxmTc6R0R3h/hMko39PDndL+E=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ckrnagsnO66as-duCOM0ww-1; Thu, 09 Apr 2026 07:34:21 -0400
X-MC-Unique: ckrnagsnO66as-duCOM0ww-1
X-Mimecast-MFC-AGG-ID: ckrnagsnO66as-duCOM0ww_1775734461
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fc74c6634aso1108313137.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2026 04:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734461; cv=none;
        d=google.com; s=arc-20240605;
        b=Eo4R1lw3ojgwAPWsKvpdGfmf77ClNFdt6hEtmreSRRLnus22M13BIs4VVqVt/KgF4+
         KRifQnLJHJbr3bL6zahGHdSe3DNQPt9ib5QyaF0wydwcy5mDbR0Z3e+UeGOO0fAD3tF/
         8BQrJilqH2RSjVKEgURwmGZ8xqPQV5fDc89iWd3W2DRbP1XSLoOFO3m5WuPw4gEeTxyt
         +QDJPsZ9/JrZWiPO0Fht6ikJUwZAFAsLStQ/JoCYQVvZvRcZIBUpFKPCPliDADnvxmfA
         AsZPL1xcDFEReL09gEAt5MEODUwPxRFRX4n5MG4r8/JpJ4hy3igt0B+fdh6qqCPC9fsD
         Sx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        fh=4sJrSkY7V8JT6AvZB1ZW0rR3MBJS7LN5g3XPU6S/PJI=;
        b=JrBkjjDnY7zQ7tQbfq9UeTAEfmEE4lqEacrC9pNQs2c/kLieVATtpPeJ0Pwj9oIIHk
         auci/MQqNYg+q3fh7db7Qb2QAz/n6sQ+FyvOrLTTkLEieECW1d9/2tT715igKpi9pEbU
         mMQq2C0wCiCy18aPmUmZ1gyO6b1z+L472xobstZ6gZ2TpD7N2uEVUDbIBtVrGLWSivn8
         5yKNY6KEpXiOLDVYbn4ccaItXPjORHd4sTF3r1u/Quu2EDwki8hh54+h1+RYeg0st6i6
         /VMDw+5JQAvr9aDYUBASeGCUGWh8/OwlqzpzBwWi8N4qZqZUbSqkLtqRET336lSWi0ov
         /kHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775734461; x=1776339261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        b=dSW4B+rxncCdBUH4hsExy/ydX+glNM7G5nrr9uYQ12KbKmm2UW0tBxUBkJRXKtOZYK
         xQngfa0STZSHZtuxItDyfOS6Sipyr8/uAXWhC3Ru4we96RBYBxNvuS7FXJu+Z2N8DodX
         uQ3PeW5dbRIsJ8xew27UJfVuLNRl0eALxEIjbdPorhZEfAqBS3lgazfRgduOe8D/nsl/
         AHlkaAwCp6cmDbSmyKWpDFQt+YCihFf15aFU79BT05Ugplff4Saa8wniVkTQSTFY1/wh
         nBHaPy34NVYVTHyvWLBaecwSSHDE86Z8bb0gvfFQG/eFCZLHafdUasUL7djwWhD0dWTJ
         nkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734461; x=1776339261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgrCj/PkEUGlRNLIdX4qp/95pD0BbHO19KX/pjOhdks=;
        b=d4ifhJpLrF9Ajo+Y44c5gwIviKYcmoFKYkmstguXx2y8A6knhDOpPKTLBurRCzcg1Q
         bGni7zuMJ27WquirdMPKppDZe0qiPa+W/qACVv7S/f8c6CZd0NHjSKks+WOoWvmD+jB5
         t0FUCn53VAwYgtsB6ksguAU5z2hhD3mDVLmICxh7ZckJThF9W801B2IMkB3E4kAJL4uv
         5j3U5OHegjc2A3A8JqPT8mAkpL5lbHVBLlkdqpVQQiV+yU8wMd4fu4PfmAjaG4aPYY6X
         AxP/Vx5WZMd46mSZ8067nYMKrxpuQIs0M81yACc04elucVKD4KYRP95z2L5jptMRe0Gu
         0l3g==
X-Gm-Message-State: AOJu0Yz1wfu7jR/UNWkCX1iVfiGJjYvKOkei5g7GpPu5Y1QDZR2K4x4I
	DQeplc5slEg2ce4Yc2GH4HN8iVmFlAjmWeNb8sFyG1NwKGxLupUZwZsKxTM8qYTXplrj4URIYCZ
	F020edDe/5JW6uACvDd38BiJW18AsD1VUQKvQ+TR+KUiM2+c9N+coxeArbhcQVSklzC12/cSyF6
	v+po6m86wM16+7WQirJTeU2h9YS1YkU4GipH9AcQ==
X-Gm-Gg: AeBDiesSRrLurKzx+/ml6/Z4jYY4d8XB6TrkkwlOnx0LqLGHqA2IWSTt/dORtstoKws
	gXUcxY7cb4H5fCB7Gng8Y/jlJD4VdhjSvCnPI9k1etKXDh+Ft7eY58flKK36e8D1iExDzuX5pMq
	F7xlx0AhGEOYaUZQjXRCQ1VQOaxrR3tojxM2Zg+NDm+gfLhCRKnpR0+jdnHiDqOxsw1VMeLtTUl
	uMmlA==
X-Received: by 2002:a05:6102:644c:b0:603:273f:3576 with SMTP id ada2fe7eead31-605a4e0c576mr11168304137.10.1775734460967;
        Thu, 09 Apr 2026 04:34:20 -0700 (PDT)
X-Received: by 2002:a05:6102:644c:b0:603:273f:3576 with SMTP id
 ada2fe7eead31-605a4e0c576mr11168299137.10.1775734460536; Thu, 09 Apr 2026
 04:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408181123.310291-2-slava@dubeyko.com>
In-Reply-To: <20260408181123.310291-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 9 Apr 2026 14:34:08 +0300
X-Gm-Features: AQROBzD2oAW4zebr47SzIxZN4ebOV7_ib45EoYE6M5Hr_27mto2gFY8z02oGRbQ
Message-ID: <CAO8a2SgeDwVzdKphHYQZJMV_z5Sg7Mc=jfPY3q1RZTvCWaUDkA@mail.gmail.com>
Subject: Re: [PATCH] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good catch. Please add braces for multiline if-else statements; braces
are needed even if it is only a comment braces are now needed.
Small nit, please change the comment to  * Treat it as "no quota realm
found" and fall through gracefully. you are not returning.

On Wed, Apr 8, 2026 at 9:12=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
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
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/quota.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index 4dc9426643e8..0fa0e7c4b52f 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -231,9 +231,14 @@ static int get_quota_realm(struct ceph_mds_client *m=
dsc, struct inode *inode,
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
>         else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection.  This is a transient s=
tate;
> +                * the realm will be restored once caps are re-granted.  =
Treat
> +                * it as "no quota realm found" and return gracefully.
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
>         while (realm) {
>                 bool has_inode;
>
> @@ -343,9 +348,14 @@ static bool check_quota_exceeded(struct inode *inode=
, enum quota_check_op op,
>         if (realm)
>                 ceph_get_snap_realm(mdsc, realm);
>         else
> -               pr_err_ratelimited_client(cl,
> -                               "%p %llx.%llx null i_snap_realm\n",
> -                               inode, ceph_vinop(inode));
> +               /*
> +                * i_snap_realm is NULL when all caps have been released,=
 e.g.
> +                * after an MDS session rejection.  This is a transient s=
tate;
> +                * the realm will be restored once caps are re-granted.  =
Treat
> +                * it as "quota not exceeded" and return gracefully.
> +                */
> +               doutc(cl, "%p %llx.%llx null i_snap_realm\n",
> +                     inode, ceph_vinop(inode));
>         while (realm) {
>                 bool has_inode;
>
> @@ -496,6 +506,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *=
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

