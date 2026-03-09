Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FD3921C9
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052380; cv=pass; b=HLL73dVJUWdpXTI7t3AXgbCijkVSlMafgKfylmibkbk9mGA0s1wp1WcfyfCFFQrNl3toRrz3X9BoS4qLNPGRTtbxjQZC9Y3yc6P9ZnsNDrIVgU6mEdeyasS36KYLRB6xoHjM31GIqcdKspjpTA8K/Qh5RnTvmWaBe8SeggXHcQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052380; c=relaxed/simple;
	bh=u/7jvDv+qOgBMLoVYXHgiIg3zx7tL2fXpaUac/nRf28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5WpP/BtQ7BYaMrw5NXzD5oj0yLRJwSNDklcshoYXzvANEH7cQAuLTjZrwIzTpHrxPxDDLkBpXvJe8eOeF38qa/WAM8xlL3CwRF9e30KheOdm6Lbw3kqHwiV+vA5DNf6Y5K25lH1a/V1bqFNYOKyf4FnGLJ2PRPkRZJKU1vQGEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sd/lo89w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9cW4uGf; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sd/lo89w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9cW4uGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773052376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RS0C6yXRM6YYn+XOfW44KJzE3mlraWJc/4BCYy6/cS4=;
	b=Sd/lo89wk6nJLLDvmOg6Mqu2wSXYH07prkrVjTeDYrLguRNkVmE+tCJHdudoSvBgVnqmRd
	1S/vIZgU6fFSgrimq07i9LwaXO68yNSuNeKKFXsTdzrUhKnH7GEEJ4dsD6G1R18ZZyLklh
	FKL52Ops35CiioxLrX61nnhl51+xwuU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-KC1bFsdKPl-AUzy_CxeVfw-1; Mon, 09 Mar 2026 06:32:55 -0400
X-MC-Unique: KC1bFsdKPl-AUzy_CxeVfw-1
X-Mimecast-MFC-AGG-ID: KC1bFsdKPl-AUzy_CxeVfw_1773052375
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-948476b92e8so19008440241.3
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 03:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052375; cv=none;
        d=google.com; s=arc-20240605;
        b=cG/yq3ievOb9d7n4NtEXxKFERpcOBWyVheaDOHQV8hQ0asyRkC7koN1zfvtBk1TfHS
         WjjEs0H6EiuU3BQPT8aO12D8HnSTZh6XI1OY87oWq6sOPY6dMgjYPPVAmUXrzQ1oOyrP
         Qo1Ww/XmYPVQicuYz17XwGG/FbAlMXvSXGCCwxH7YKbX6I7RWIW4lSOEF5RuQOHMD2VT
         frPklCkX0ca1J4ckezOL4LTKRzO69Y+TL6oVtD902ml8oUMXKOwlsSimgflflH06vVYI
         mxuURYdkr5tmviLeEH0Q6swaKv1w1KZSxlidIpX54WhMF3hhzqxrfiSbcbQ3P7wU1JdL
         DkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RS0C6yXRM6YYn+XOfW44KJzE3mlraWJc/4BCYy6/cS4=;
        fh=ZcmlDZpZepjW29Sxcrl50L6zCHgByB1p5N5PPmHMTSA=;
        b=A1SzTbdSvy6zQbfBiSdheaAu1bpq0XcAISCNfJhSJqN/DyqivGXvUFkFEHVUYpZ1/R
         IeZtz0AVAbCZ4SW/gB2Cu0LfulfeGndl7CWZcRGoh/TyYTZdBNYgrvzDpgcydrVi6EjD
         xMHQiFwDj5sBSfReN7gMWnP6WPGVXn9N1yC9DUXWKYgelxZkfLwWgny0cqlASi1VcoVy
         e+qqeEfPpYerfBGo+eWpwIQyyBTPlRYF7cvarK+tZpqWrQ/7qCKkXlsCBRo/DohHORZ1
         nO0OzHqVf+dBUEKzn1F+tD6CAziQ9sSOPHX8gAGg8qKIjTPNO6nxTx2WNKu9i8oseFGw
         S+Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773052375; x=1773657175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS0C6yXRM6YYn+XOfW44KJzE3mlraWJc/4BCYy6/cS4=;
        b=b9cW4uGfgm9vY3M2juC+GCgRRMlONCRWSglizlfz6JWdott2hG2Ltzv5FkQoO1A0th
         +N8G8xL1tR71uXhCVgGf5DopQ6Pk1rBnhjZD3/DlbI2Bz/XkuQpR9w/JlgdMImDaRGL7
         B8s4MWD/C8hIgz/hiPmvNA6CHaSf9RYzYeASVSkmJ8EQhdYQshdTOcmNNhnkYcpVgzeW
         uqTTKJhA7HDEKdBhnNUHEfjOHXYwmKyObvPH6CqVlIyeXMIs98i3FzgHBtaSYx60ez5N
         O5KighHNKsTCRhprGnhO1EHoQxJDKWCYEefaG59v6O3l2cPlU66alyl6k3mPNFi2Vnej
         U9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052375; x=1773657175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RS0C6yXRM6YYn+XOfW44KJzE3mlraWJc/4BCYy6/cS4=;
        b=W1FzNOk4qi2ZAcla3ypMzeZXtSvxRc8LSNVmp49p4VSDgS1tZOA5kTZzdanY0sStZr
         mXpTEoe3gt/dQFpJ9M7UUEDzpRfv2WAsgKVpLSYuTplUAffCYvHzExqkELTwfz7wWI5K
         dQ/5H0GP3NdDPRwqqKMQbFmBVP6Q083fiMqTgH+lBiLavUssCZba4ToKORmSEzZKmYCz
         wNqjOWe0FFBHOKaHHbKlzucZs/nOXK+viFE50kfSW8EAI9SqctMaWPa8v7zxLDXVTlmi
         iA61vOtH9ysCsj5alVw94kozquSpo+2mF9noAQvMIZVnk9Mznjz5o9eSmjU0saqw2PvR
         VZpQ==
X-Gm-Message-State: AOJu0Yz13I2s9i7sF80MhVmFy0RyxyFyU95nsX2RKSwwxLfyHijo+M97
	220nS5TD/mdMImdgs3P5T1gFcVrISbDnHsn2ngx60OOnlMfon8r+rfNTSJnPkFIWTqFHoyMGS2F
	3pvaMOxXFnMPiEsVJNh1GGVlmv03rwPcmgLyHsN2BBEe8Mma3lO+a29QhrtJNig66qlvwVcAJvD
	WtEEenZr0y2d7RHW45XsXcOzy7VPlIXz3jvzxeMQ==
X-Gm-Gg: ATEYQzz+5pPueRX89trDCHf/Lw+Z5X0sE/GBcqC0PcswoFBSS9UGnWWRX2L6W2oB2DL
	P+dULSFVo4Bf86nTp5NOx1Ngimc3+L3KES0ytzAfu31YHV9FAyatDH8/BiWJNAbROgPQhfrGxM9
	FmDIVS3kolSqjgRabtwJg84Jv0A7rXNUmNq7zz9Zmw5tMrisUT+gC1wiY/vCncMfrG/ICmCykUw
	QUPZA==
X-Received: by 2002:a05:6102:a54:b0:5df:b5d4:e45d with SMTP id ada2fe7eead31-5ffe62136bdmr4231267137.33.1773052375037;
        Mon, 09 Mar 2026 03:32:55 -0700 (PDT)
X-Received: by 2002:a05:6102:a54:b0:5df:b5d4:e45d with SMTP id
 ada2fe7eead31-5ffe62136bdmr4231265137.33.1773052374615; Mon, 09 Mar 2026
 03:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308221142.695096-1-idryomov@gmail.com>
In-Reply-To: <20260308221142.695096-1-idryomov@gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 9 Mar 2026 12:32:43 +0200
X-Gm-Features: AaiRm53NExyT8wcbY-6f1q6fp1YyFqlrefjRprqZ-KwdJpfLIjXfLhKjcehuk1U
Message-ID: <CAO8a2SiFgDK7OpdgKoPb510PD5f_t9oogEG93iLgeMdkcJPRhw@mail.gmail.com>
Subject: Re: [PATCH] libceph: reject preamble if control segment is empty
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Mon, Mar 9, 2026 at 12:12=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> While head_onwire_len() has a branch to handle ctrl_len =3D=3D 0 case,
> prepare_read_control() always sets up a kvec for the CRC meaning that
> a non-empty control segment is effectively assumed.  All frames that
> clients deal with meet that assumption, so let's make it official and
> treat the preamble with an empty control segment as malformed.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/messenger_v2.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index c4ddf7911f7d..50f65820f623 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -392,7 +392,7 @@ static int head_onwire_len(int ctrl_len, bool secure)
>         int head_len;
>         int rem_len;
>
> -       BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
> +       BUG_ON(ctrl_len < 1 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
>
>         if (secure) {
>                 head_len =3D CEPH_PREAMBLE_SECURE_LEN;
> @@ -401,9 +401,7 @@ static int head_onwire_len(int ctrl_len, bool secure)
>                         head_len +=3D padded_len(rem_len) + CEPH_GCM_TAG_=
LEN;
>                 }
>         } else {
> -               head_len =3D CEPH_PREAMBLE_PLAIN_LEN;
> -               if (ctrl_len)
> -                       head_len +=3D ctrl_len + CEPH_CRC_LEN;
> +               head_len =3D CEPH_PREAMBLE_PLAIN_LEN + ctrl_len + CEPH_CR=
C_LEN;
>         }
>         return head_len;
>  }
> @@ -528,11 +526,16 @@ static int decode_preamble(void *p, struct ceph_fra=
me_desc *desc)
>                 desc->fd_aligns[i] =3D ceph_decode_16(&p);
>         }
>
> -       if (desc->fd_lens[0] < 0 ||
> +       /*
> +        * This would fire for FRAME_TAG_WAIT (it has one empty
> +        * segment), but we should never get it as client.
> +        */
> +       if (desc->fd_lens[0] < 1 ||
>             desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
>                 pr_err("bad control segment length %d\n", desc->fd_lens[0=
]);
>                 return -EINVAL;
>         }
> +
>         if (desc->fd_lens[1] < 0 ||
>             desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
>                 pr_err("bad front segment length %d\n", desc->fd_lens[1])=
;
> @@ -549,10 +552,6 @@ static int decode_preamble(void *p, struct ceph_fram=
e_desc *desc)
>                 return -EINVAL;
>         }
>
> -       /*
> -        * This would fire for FRAME_TAG_WAIT (it has one empty
> -        * segment), but we should never get it as client.
> -        */
>         if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
>                 pr_err("last segment empty, segment count %d\n",
>                        desc->fd_seg_cnt);
> --
> 2.53.0
>

