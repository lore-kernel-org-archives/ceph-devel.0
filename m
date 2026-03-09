Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243281732
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052478; cv=pass; b=asIl8yqqrOAZ5PUmmU/1nBaQWt8BZ866kB4jkpdz5+dVp7pcgmdwoq1vSAmodOdYm0DCsLnnWbHQIlGr4SYCjQfe8gj7/gUsR9Pw8/N9FelOwWJwZgCdQQJOSVN9xRyeETxlgcRqO2RJ0AHSkMullw9M7SLzheY7oE/dz3r7a3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052478; c=relaxed/simple;
	bh=GP8uZl6Wmv9RRVr1kA0xa/VwS3xaMeSXJiYwpRYNvPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lANvsiyE+AMXwZL/UGBn3a+upIga1k6PC58EtT/Fiw4sLHTH2Tr4WI6eLNNv9cO+p7owWu3p7mEBDICcxQ14gCiLf2Iqg4e64IGL5dST/6Az+6M8W9OExw6jyw2ulzDt58H1IEK8zia0tPwyaQjBxTZI1zAlPfg9WiYBDK3BtyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF6JNwuz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qdslLlM6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF6JNwuz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qdslLlM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773052476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/MUwYQCV+pHLvZ2GFWTkmrjb2btb9FHKQ4QChpnHEk=;
	b=FF6JNwuzkI3jTA+2sZvydahVwwt1kX3b3S8aidOpPB0gtKgL7lyczAxyVCO8DiFofk69rf
	HOM1Nq652ok5ysk3dy6S57uEfp0R2CPmkaXCm/1tPpyE6ywnLa6W40n6ia3EJ9nYRk3vzp
	eCVIAlXPCmZ32vaTiUgpNPkmNKofZmM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-Rih7_OaRPW6d7kJAyKCq2w-1; Mon, 09 Mar 2026 06:34:34 -0400
X-MC-Unique: Rih7_OaRPW6d7kJAyKCq2w-1
X-Mimecast-MFC-AGG-ID: Rih7_OaRPW6d7kJAyKCq2w_1773052474
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5f934f736d4so11153813137.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 03:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052474; cv=none;
        d=google.com; s=arc-20240605;
        b=lCF3RhlKviq3GcRnC8zxIKsvgnbGbMfbMdAyLFDKluW3IDPhKtIlckkbF/+CdvLiyY
         +uxOreXj4NykiNojwKTOxRVlUrezy6w/nNwu/myxwO6jS6K1MDNoOJeqVyRQKX5bEhn6
         B+GLQnAX+xENA3nnVuaslmujjIssExkeifoLVh7Cs4bQoJuIW8TSuePqGB24r+KTN6zQ
         OrWPMJr/Q55Ia4Yychf3h/wPlT/yJzdYYUlLuYy4pgy2nF09ju+RMVWKG/U5ppDOg8z5
         mnC2nopQ5ekoQYdMjdiqZAVnK/YibdsuAbiv/qBOg1XmXejJvpOifYxv55AtdQFKSqN6
         cHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/MUwYQCV+pHLvZ2GFWTkmrjb2btb9FHKQ4QChpnHEk=;
        fh=ZcmlDZpZepjW29Sxcrl50L6zCHgByB1p5N5PPmHMTSA=;
        b=BjzSXjV1a3jPq3QiqjCMq2icTCFMgHVh0sJLexZGnnWBgdX5lCBdCQfh/K/BvUjBJu
         14930trJ+fGbY1qa1NcBDgvWHkNSs7JvHkDgQCKW8oWF2w0c4YvSWCNzdMuB0A2hk7HH
         ZA2g/9/f1XZq5TXUBlv5jwPQQgTPmfBu34v40GVnHlHArXGyU5axpkm7GW/u8nvejn8d
         ywH0QpFJ6QQMT2yp6GBcYnx0ik1xsC7aCjZ+iokL8nqTfX/vK2gjBxPqYgBfC6rzmvfj
         gMJ9DzpZdjONnQ5iDYmgdbCTiGvjpMYaqIU35Qs3Pddt7vqzaypiuUM7FhgQTojaiuBX
         ljKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773052474; x=1773657274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/MUwYQCV+pHLvZ2GFWTkmrjb2btb9FHKQ4QChpnHEk=;
        b=qdslLlM6MfbAfJZ/EWb7CzUqwzuZu13RyiMnFwKWHnGhUqx4eQFoxJBvWhb+JuCXGF
         X1ujAXLp5cdR4oIqhd/JQQc8yxZNig1vsXuMFv+W3EU7so0d0vDDjq7EDFOxe6vjpfjU
         Tw4/PzUcJMbaJN17Haniq21pOVRQz0CCBmlzW2h018yne0nkGa0a68p35PB3zdr5v9GD
         nhoXSziMQnrj/uoPm/ja0UE2rv/hdH86LDer83/7SKzYc6tBxNty5qWxa1y1SYwWSxvp
         SP1yXOKeSte95E0JaD9wymRajduebGhDeYG/BpMpOYYkNHHv7MjMV9N9Q+8yFl79gfih
         dQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052474; x=1773657274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/MUwYQCV+pHLvZ2GFWTkmrjb2btb9FHKQ4QChpnHEk=;
        b=R+X6ukdoHaAsrOkJMKAqcKiUjNdvQx3Qzpd8jk+PDYC85Jsx2aRm8r4jXbidn5yjzg
         jJt0ALnaS8wFpztGVehJbwAj+skZkOvCfqO9dW9OZ7WKpHGpuKZ8xWbTTRr+8FnW0Z8m
         SxpeP0bcmIOSm8PTKi1Ae0SC0ASrpr7Ep2ZlhU1T8No6gyxFD41yq3bRlUocB54FedO9
         BSA6aaut4itaWzo9JgXHHkxS1a5QCUEKXxN+HGfnCReVx9xdyfsqSyGps1Je0bhNiMQu
         QtJDuCeADGyTRfxUYEo6zQX/yaXRc2n4CK1nXYGj1tTAyS+yNlRinYTi2wCkj9HLrok6
         YwKA==
X-Gm-Message-State: AOJu0YwJ3UU+A6azoac1LJtWGpisuoCqIm5whzLV2hzjDfh3WfUpLWi1
	UqmxnUBk8zbfSJnDzX5TPUqpHzyejo00OUJVq91PlqxE6tTKuCaM4rP8aOShAbXhBbUdY9doBM8
	fSPODc3Qfnho8bDVTkh0qvfWU7C6fj9HQMc5MG/oBl2y0Ub9trgKUVOdz/m0NDhoh0Fg9XpahI6
	aetCAed1CqyJLcvWhQskvECC6uE95uXfhCVenjiw==
X-Gm-Gg: ATEYQzwtDBTaEZvLE5Xxtizn7gdyGyj/IINomghxm4AHTVH7N1mJOPpZxroULx4sqaW
	teMoa2oFlVXrPPABOn8fgjuY24tZpDbDkd0lJKlyYZQSKQVMoSykBxayaqlgUnJZyVZd8vYkLlX
	s9d8kISlPDHqxwQaTwv3JEGGM7zFrdFFtKy3yED7N5q8IAFqvQQ1mDgPywh4LiASZgajvBrSV+T
	86GYg==
X-Received: by 2002:a05:6102:1612:b0:5ff:fe0f:67a4 with SMTP id ada2fe7eead31-5fffe0f7eb2mr2108155137.14.1773052474363;
        Mon, 09 Mar 2026 03:34:34 -0700 (PDT)
X-Received: by 2002:a05:6102:1612:b0:5ff:fe0f:67a4 with SMTP id
 ada2fe7eead31-5fffe0f7eb2mr2108147137.14.1773052473977; Mon, 09 Mar 2026
 03:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308220804.694227-1-idryomov@gmail.com>
In-Reply-To: <20260308220804.694227-1-idryomov@gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 9 Mar 2026 12:34:22 +0200
X-Gm-Features: AaiRm53gruotbTsCF3dR6sReMa9M50u0e1BdaML0b0JsLsaF2UwI8-J1s3-FaaU
Message-ID: <CAO8a2ShdtyYKOseEVX-iwUoHZvtfPDyAkJeFyJjxfQxg5nvuQw@mail.gmail.com>
Subject: Re: [PATCH] libceph: prevent potential out-of-bounds reads in process_message_header()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Mon, Mar 9, 2026 at 12:08=E2=80=AFAM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> If the message frame is (maliciously) corrupted in a way that the
> length of the control segment ends up being less than the size of the
> message header or a different frame is made to look like a message
> frame, out-of-bounds reads may ensue in process_message_header().
>
> Perform an explicit bounds check before decoding the message header.
>
> Cc: stable@vger.kernel.org
> Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/messenger_v2.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> index 5ec3272cd2dd..ed618435d33a 100644
> --- a/net/ceph/messenger_v2.c
> +++ b/net/ceph/messenger_v2.c
> @@ -2833,12 +2833,15 @@ static int process_message_header(struct ceph_con=
nection *con,
>                                   void *p, void *end)
>  {
>         struct ceph_frame_desc *desc =3D &con->v2.in_desc;
> -       struct ceph_msg_header2 *hdr2 =3D p;
> +       struct ceph_msg_header2 *hdr2;
>         struct ceph_msg_header hdr;
>         int skip;
>         int ret;
>         u64 seq;
>
> +       ceph_decode_need(&p, end, sizeof(*hdr2), bad);
> +       hdr2 =3D p;
> +
>         /* verify seq# */
>         seq =3D le64_to_cpu(hdr2->seq);
>         if ((s64)seq - (s64)con->in_seq < 1) {
> @@ -2869,6 +2872,10 @@ static int process_message_header(struct ceph_conn=
ection *con,
>         WARN_ON(!con->in_msg);
>         WARN_ON(con->in_msg->con !=3D con);
>         return 1;
> +
> +bad:
> +       pr_err("failed to decode message header\n");
> +       return -EINVAL;
>  }
>
>  static int process_message(struct ceph_connection *con)
> --
> 2.53.0
>

