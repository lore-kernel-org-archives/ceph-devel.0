Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC243264F9
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568024; cv=pass; b=F90ZI1vdXvzk0nLvnK3ZXAILzQwTpL7WB2gLfMR2U8FHdpTX+jTPhfK2NuvEoHWw87kYwTjSVKplTs2nkxKjvI0p6tmUM/s5XJ6bHfowy9Q0Uu5iDylXJi0aKPV7X5+c2gGlMAwDeSAuvbHLYl11GmACCd5JSRMqz8yZ1Ip9K38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568024; c=relaxed/simple;
	bh=W0CyOq1EP4N0f2VqRPqdRlNMZWp938OopvqfIwR1luw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB4rfGdze0tlL8G4G5cRHzsB6WcRnuJ3KxuqCpOM9ASNGCZQE2B8jpCT2Duo0n1D2fSkfQ7DWClVSHjckXf59Ai0NmFm6FaX9BMqtzWxflmNXtExuiztF2XQcQUnY7xm+wDO2fqLeNuQjdSFtL7Baaip9EBw31KqW2/O6AwhzUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PSHAwJ5X; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PSHAwJ5X"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so138251766b.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786568021; cv=none;
        d=google.com; s=arc-20260327;
        b=qEHZmJl2LE/p4td2Fm9/JQTaEZYGpR3QzeOHIJaqLi2x7bQ52X3q5ifaIVuY7VMXU+
         JJ2R9uoZB0Cbux1p5p8qD9gKL608S/Nxhbs6mGm/SGoYfz0eHqcZ5GNWMkxWoOQGLnH8
         vZvIpcoxUAlYtOFcrSj6t3JthcFtkP0BJhydS80tphMTNmSLuCT4LBVFVtfQikOpApdY
         /y0ffHVEi7WnJt+05egQyrbF1jI681fpCGX+XO/VdhNkB7UqpZx4b68FbQU8iCNclwIm
         suXiiaiZG0n1eKMBChZcw1+4LHSXtElEI9I9mXtGISqB6X4Ujk0r0qoh4nCFxtwRA/ec
         f6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJV9Vn2rjJynndyx66nALvQFHG6+wL2j2Qp1pTECLWk=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=eoYZJPzPltSEg6fOWPFUmbklGbGoS3uZ76iqyLOHNwIe8ajeFOPfoyUaG9uPjLNlw6
         0EHyzB8Yvyq7bzrGCsbjcJZf62b1vj5hXNRjRTpThUAl34qrgPakqNI0mslSj4xHuwov
         RhAOHtkc/RxSDR8vSa/8kF79wlp1Wau8djISopwNqjSrx5d7VOp9AIfDysobx4U6Xt2v
         kCXJa8cc75rh8gqc9MVMZaL98FZGNO2jea6z74Q9aeYMRuM13IB2TeAJ5OMw1kyqcs3O
         QZzqbpkJBpTZE9ogwDGpcqfKkkvm2+zZmpCS1sT/rceo//OnsOCH490PVcMNVg2qHusp
         bE6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786568021; x=1787172821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJV9Vn2rjJynndyx66nALvQFHG6+wL2j2Qp1pTECLWk=;
        b=PSHAwJ5XGrxk0MwvyKab61rOYr0pzmXFlse35l+o1M2wrm+8AtbfLOpHrhPRDc/uSQ
         5GpK9JPMmAOhOSX8p1xIczoozIT7dAlZpbXl0t+8MOiY63vwmrxCIvuNcLFPM0Od6C3o
         cfb/ofz9lTWEr1eW/1Pnv2t/JhGdrX7rRTvepdU3bKmyyFWFgy5pJCh9/AYidWuly3Qm
         tF4qiGDYiffnn4Lt04rwkM1SSHJuE5xnRDjmkCakxWmMPkdTJXqtYMHXmWnestlwHwmG
         8iTP4ZlQFQpUqGIvDQsOcw3B8ReHA2HhX94fwLFSXAEW5f/qkW0dqSkNDpzszSFsWwQ9
         Nf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568021; x=1787172821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJV9Vn2rjJynndyx66nALvQFHG6+wL2j2Qp1pTECLWk=;
        b=HjsTYRayrdTFLoHMMzCsgQnymPoaoAZFVjtzpLDT0dshO1Q23GPE4iqarDFY8+jPNB
         G4w3cJ6nXql4z2Ctlr+bMjo4MChS9CHQCVRt+MGRypF+tUyN7+nk1VavfFZVMrDNgPeO
         221MMPFre1OYjVELtIn5JlrptHW8uqHxDQ541e7LR0IzfvmBZD6OBAUp9QgwhhOqKA+s
         e4/2qw1wVhuOvb3ZQhHFUasMEqQ2g6xFP9u0blo1/A2SfG6Csz34pkbRoNnKEad7yvLq
         e0I79iUBefvzMnU38o9jpjZTzYCQjjTdxuKlXoQk9gwDUq8a9cHMDkfDmAa5q90WCec5
         GFvA==
X-Gm-Message-State: AOJu0YxGMMOvIqb7TaEJtCNR3B7vsYDd0ZGYVRFC45GRXJGHvnSpgiLh
	MqkoUgQUN1xKtutJpW/lFns4Kj4tz1vawc14V9EoIib/YiaCLPjDFQoxkB6vjH5Vh61dBOYjF0j
	AfM4d9NjzjcKESdUsqB7X9Rt+9vmWqiSu/310+fRSs2i4BVqhoHlVj0g=
X-Gm-Gg: AR+sD13LQlS6nK3iod/+5q/ne4gk/J02pTAUR/b9MOil91CT8/5/IoZhItovNM6AEdA
	9utbbp8Cn1YJc5iIfqOPaJWVULJV/TCoywPaUfE0qJn3j/pbSwuKfgsvOt9oIohakZ+hQDa26A8
	PYONslCqayVv4c3ENtmNkKNFLrKDaf8tvfDr2meV3jRlPy0HgKrRLOfmfwuSbX2wCwl5mQWCFyu
	jTfJSajV5mkpwUOkRn1IfeI38xDxOKTBHTd9BtnjREfUGtpGQLLN3wdPIrof4CPfauadR5/VTZZ
	Oov6lrEWhiO2wsiG8ozX7c3qqmxHcDoT4nKQqSjztunnAnDtBGgc+a5H7WXmf/oejXvu8UJqhA=
	=
X-Received: by 2002:a17:907:18c4:b0:c16:26c7:6ba8 with SMTP id
 a640c23a62f3a-c2108dc360emr54749866b.6.1786568020774; Wed, 12 Aug 2026
 13:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708083455.78487-1-max.kellermann@ionos.com> <20260811142538.2701033-1-amarkuze@redhat.com>
In-Reply-To: <20260811142538.2701033-1-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 12 Aug 2026 22:53:29 +0200
X-Gm-Features: AUfX_mytSqSyOyIBvq3eRJbE17uZSxCff13qpN2pt0pggFKUpw4VGC6UBunnCR0
Message-ID: <CAKPOu+946t8E6b6U0UtyqddoU869-tNg96BkytCa2MOsB6QsuA@mail.gmail.com>
Subject: Re: fs/ceph/super: document struct ceph_dentry_info and its flags
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:25=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>   1. [minor] fs/ceph/super.h:440: CEPH_DENTRY_REFERENCED comment is too n=
arrow
[...]
>   2. [minor] fs/ceph/super.h:422: time field comment says last touched bu=
t is insertion/requeue timestamp

I don't understand, please explain. The "time" field is only ever updated h=
ere:

- ceph_d_init(): initialization after object is created
- __dentry_dir_lease_touch(): I documented this as "last touched"
- ceph_invalidate_dentry_lease(): preparing for destruction

None of these insert or requeue the object anywhere, do they? What
does "insertion"/"requeue" even mean here?

>   3. [nit] fs/ceph/super.h:399: lease_seq comment says REVOKE but client =
sends REVOKE_ACK

I have fixed 1. and 3. in patch v2.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
