Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7302E3A758C
	for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772842; cv=pass; b=hAbMS/UqnbcBD7ChTP5qAVlzotj0vZw+B7Qw81Gl6OJf0iSLgyjcxnfa1dVcciLr5WU1NQsZ7CQ3uJG2vYIb9t47fGbTs6kp8GU9ptWOkPAY3GonImeOKmFsbDkdpXoYDJc6rgaLdHc68x1Ov27AToKhP/pBoSIn5s3cDz0Ysq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772842; c=relaxed/simple;
	bh=ZPhZfL76/CbOv+53QgoeTDc9NrLUatJkR6lDPLqo2dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW8SGP0NKCg7B1mnsuKwRIOPtcJ8faMVojXU5LEhYz9OggrxiuVTU4lJ7bltFF1aOc3VZP/XODcN+xZxcVX+mPCDnNT7OtGPd4fWMPuaktDlsayZzlCcvt77OFD/f+5IYPSCPATceqIfJKLWTINJ19Ghcm4kDODx3ldRJ9jKmaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg8d1Wcr; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg8d1Wcr"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c637089ccso518248c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2026 05:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776772839; cv=none;
        d=google.com; s=arc-20240605;
        b=gHmCMKrEVEdlhznzcO0FtQC7/m3+EvcndecuW4X6reZuwdOEuqIEjaxZdSSHt5mVL0
         De/EuRohD+oajA6/r3JKins0dVJzbfYZ7/3AS94vDpZUB2zYw6pGKGN/Bz50P/WI+T0I
         B2p5Wr7lNMHsux4VA4+ksXDrkoiOWYYmlVh25e0rG2OLWZr2asnImkftjU4aZmpPLTE6
         h0yHQGp4ABcV3IIQCZrZkcBT10kXUgN8IeeFMKchSz1aTaeZ3ubEQxHYZaO4Vt1FNrNR
         aE1yM2xLd1igb6/coyUBVsghZj18Conix0fxyv+e+AeoGOoheJvylshsH91aMRbeQurg
         NCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZkmI7tLC8YwaJ9Er1y5QntP91J2hgtVOWTCX8gv0Mk=;
        fh=Jt74uGhjWoFOZp4mDA5XTXaxh2IafbIMz2qerHosdJI=;
        b=HFGGh8vS/OitwBLp6mls8+8ryIoJ88AjoD+QQjJwQybRm9/FRvAVdSKbeALSHK1lyW
         DrSQ9199ReC3r2GbpKWNW2gYStbWlZ3hFPSTCiBIO/v2gEbWffHvX0HzqV+g7mO4L5H8
         soD8VYxxhzf0WVXxk/UFa8sQkY6FtfUCTqmZrrtHm10ZvM/EacJOZVaXDvU4nQue/j9l
         EZLfa9SDOUCio/g7gAopRxD8wLMihA6vxn5/3r5zt8rL+mttfLI4lJKkucFrEqSKPBwF
         dbW2aXbs2Wejb6SlqSx/3mnAUnaxYPT0eDTbXBtrDOCmnPGJYS4L8+NbKc/rkUgEm563
         ZFiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776772839; x=1777377639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZkmI7tLC8YwaJ9Er1y5QntP91J2hgtVOWTCX8gv0Mk=;
        b=Mg8d1WcrP1kW97Xu+osbHb0TisCdXZarcBPzmIwtv1Nmp07E7tBpIpbJAGlnwPDXi9
         iUwweJcF/DkuY2LnS0uMj4PzBJGrjHq3EmJjs85AqicoSvFCiMF1h3QD/ThTgyhNgLru
         RCHOt0fLTitVRGadojkgq86PFweNBp7aIbmoO7gayzO3rFhW47lkDXpzEKqKyi1rkje5
         zX930Y6kr8GVKXulzHMeSvFAf5h7DG+cY/WrJDI9ccqnLag7Yad3fdqahipDI2XdrHhC
         sjzw+yHx6f3BKFJNWRhokGGr+4/uY5gjAkj3atBK3EYB4m6plUqMK8PH36RX88UGaeRn
         ourw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776772839; x=1777377639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZkmI7tLC8YwaJ9Er1y5QntP91J2hgtVOWTCX8gv0Mk=;
        b=BX/Hpm5zZMrCRbH7HSHXx8MqTu3VyGFkCOD2gev9onSnziHYObmef/z5ojNgdQ9r8T
         OgSq2ffQnMHwTbe5LYr9mrUsYc8lGw6WbZCkDCzQv+f+6rQScyO7J2P/H9nAShALRtjk
         Xgh1tmOfQ/Pvydc9FOw2irjDcMYNtIFEayMkLR6pd3syfo+MteP7MVH4vNRv9Vhdv4Sy
         ly8ZtLtEx8ylfPZ5xikwZe6QEfYuM9ALm7lv9pvi3ERM7JVt6jMuzqmnNkKt+Ac8JOW4
         xQeO1Rc8g35T5ffXk+Atj4NkYkTE3sPONs/2V2FhiHWm245v1U1F0xObNXZB4Ib0Ajhg
         X2qw==
X-Forwarded-Encrypted: i=1; AFNElJ9VVfUjl/i0OySsENRnMCh4yEcs/zMJp6o9RBKEc56KCfOH5qRaCmDh6pef5pbz/3hAlIvGFYGDeN5p@vger.kernel.org
X-Gm-Message-State: AOJu0YynAAruZ2k+qm1cyEzhz8HBKj1pXRjtV5KRWVTIJDvM+XQNeUTS
	/Wbw9vZh8mzO4smmzE09sDG/2bx3TrxA6Gp7vUwBrhuN4Z5vg4hbfk6m+p+bbhI2OIj8SeLHInU
	Z4XFPTKBIBrwgvMDs8zQM4Elw1EDSefA=
X-Gm-Gg: AeBDievyGo6jCV202ISGvQUZebyDGleW7cvydtBWuw40owaT6ctWTdHbL2S9VZ75WqV
	5Nh7ub9SXjsj19UnPav0qCTfWQt2q4cp0ianSUuOLFA7z9LDiksAKv9B6ukwFNqjoMgzMPMGoKM
	LZO5SomKS+8VYTg/SuF6J70WMLe6kDJuQor86/USFuhI6MY8l3/b0MUYUVdwpFSgbhkV10rmg7B
	Rsefez3pMhjBzrRvEoihp0EOO/IBoL4bwlNdm4tB7sTbRkkaHuX1ci0rFA++x3rXGZGdT5atjNe
	6cuptRLe1mayJuVbgw==
X-Received: by 2002:a05:7022:ff41:b0:12c:8e70:c33b with SMTP id
 a92af1059eb24-12c8e70c6d6mr4798398c88.8.1776772837728; Tue, 21 Apr 2026
 05:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421082701.310432-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260421082701.310432-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 21 Apr 2026 14:00:24 +0200
X-Gm-Features: AQROBzD4gU4xUzOsR6uQG3E_vnPu2zLTptBePcxleYOIPBmtHReA8Bjgfd0Lwps
Message-ID: <CAOi1vP9ZswsADMSARutMQxEgQ-yy1=BstYG3V7s0c_DTu=iVqQ@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix slab-out-of-bounds access in auth message processing
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:27=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> If a (potentially corrupted) message of type CEPH_MSG_AUTH_REPLY
> contains a positive value in its result field, it is treated as an
> error code by ceph_handle_auth_reply() and returned to
> handle_auth_reply(). Thereafter, an attempt is made to send the
> preallocated message of type CEPH_MSG_AUTH, where the returned value is
> interpreted as the size of the front segment to send. If the result
> value in the message is greater than the size of the memory buffer
> allocated for the front segment, an out-of-bounds access occurs, and
> the content of the memory region beyond this buffer is sent out.
>
> This patch fixes the issue by treating only negative values in the
> result field as errors. Positive values are therefore treated as success
> in the same way as a zero value. Additionally, a BUG_ON is added to
> __send_prepared_auth_request() comparing the len parameter to
> front_alloc_len to prevent sending the message if it exceeds the bounds
> of the allocation and to make it easier to catch any logic flaws leading
> to this.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth.c       | 2 +-
>  net/ceph/mon_client.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index 3314705e5914..17660bde896b 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -257,7 +257,7 @@ int ceph_handle_auth_reply(struct ceph_auth_client *a=
c,
>                 ac->negotiating =3D false;
>         }
>
> -       if (result) {
> +       if (result < 0) {
>                 pr_err("auth protocol '%s' mauth authentication failed: %=
d\n",
>                        ceph_auth_proto_name(ac->protocol), result);
>                 ret =3D result;
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d5080530ce0c..51220f1a8f03 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -174,6 +174,7 @@ int ceph_monmap_contains(struct ceph_monmap *m, struc=
t ceph_entity_addr *addr)
>   */
>  static void __send_prepared_auth_request(struct ceph_mon_client *monc, i=
nt len)
>  {
> +       BUG_ON(len > monc->m_auth->front_alloc_len);
>         monc->pending_auth =3D 1;
>         monc->m_auth->front.iov_len =3D len;
>         monc->m_auth->hdr.front_len =3D cpu_to_le32(len);
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
