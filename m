Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2342405EB
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933605; cv=pass; b=uewxBYyh0DWwfA+DDW7FTfguGnxs8ZSt12Pz2EGgUpUWoRI0CXBD3w4EU+EHas1lJo+yk4/HKwib5hoqR+iFUYDAUzoL7VQRSDB8QqpI9d2wKrQomRqRz+JpfModPmOpUHQ7IxeoatUX+NzmnD+TRGI0rRHtMi/E/z5ZaGn+nQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933605; c=relaxed/simple;
	bh=GsTjto3M9TDUjL0GYUMtZDAzX3U6QWNQNCQQC0hE+iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvpCHqnHVdmGLgbHJcPHY0Rnrd7A+fqn3/281E+5eviGxMOfruIQRQjN4UT9x6D62VEDpaDvy+8TESRkZ49+Y7xfrfJSsijHdR5Woj+drSYnrzlz+A1Lqy2QL+4KQfRjqcBpxPnEaN5pKRh7ujrByAtzJiy3c8v230jcPJqs0SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=TPHHl4C5; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="TPHHl4C5"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1671ec8692so394699866b.0
        for <ceph-devel@vger.kernel.org>; Sun, 16 Aug 2026 19:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786933600; cv=none;
        d=google.com; s=arc-20260327;
        b=KMS1uhuFbAaqf5F5pqeN1llWgj9G3h8wSvgn83c4UHcmvBw9PvazsrZekUPaeoB7ly
         A5s5M1DdR4ErybcIVts56WKro0SzWGQlRMr7rvJnv7EAuDeKipJv7A8I0u7oe9PHYlFk
         7g5ITBGRBs7F4MxARi/pG8fIybj+qFH/GLsJtzqeGt8/2ytybUGldcJd9WqL2kOsQ/BA
         EjXCDBw+79aYDm0/cl7kIg+2XOeISjL2Y1wlZBxGCJtln4YxvZ18khqrsTY1hfHfBAv0
         grasflR7RirfbUtj0FKsqtfnQJpz8iz0ZimC6ytpTHy6wcdgLKVsu+PHPrRXKazZ9gg5
         xyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GsTjto3M9TDUjL0GYUMtZDAzX3U6QWNQNCQQC0hE+iA=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=WFfvF1mODlyfYHKJ3kV5rZRvSPFEuE8p9EK4+4M/fU4NRIRtxHMR4/NaaKhfIv0+YQ
         Zs2amHi3JAt+9dPCHjAWGe1ZHTWXiJqbr9BtBCPegczJRFiui48DbXSES1W+WhLY32LC
         gXfzp0VS2RhWAzuKcm2tpUE7OXcoOKGJk05mubPIrxXmPiqCRazj1U6bWl0YiTM47PfW
         3IpEQk0RXuW/t9E2CREaehvnI4BOt6ivBJ+F8IvIMRgeN++j8EZG3yutllKRz67Sv1Ze
         Y6T9VBOv7y8r3AHTemXZE4BiTAPICsmR37sLdQKnFEglibK8Xyxlfs9d6H7bi/345BVr
         5E9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786933600; x=1787538400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GsTjto3M9TDUjL0GYUMtZDAzX3U6QWNQNCQQC0hE+iA=;
        b=TPHHl4C5wIim8UmZX5a5J2Psr1uKeeTsWKYN+hMY0APlJFNaZ40nl2MChlkY5wlxPW
         ZBjokN20k3xuWscx0+z6dwPKEI/uAFcxRvvmJf/R7lXTlXRPciLNqBs/tyVjaNJ9Dbg+
         GeagDGUGt0ztg8tDZVNFcNg30YRRpkBXAHyE0Y5Jqxpx5FQ8r4IhvLVFKHYd/LPXE3gg
         Q8nmGbej3vDA+5BwuDPOlBagDW+gH2IMf+7SkuY3X6lupoV/zlOJJDvU6Tueu79eBTj+
         Iu8z7BXsULL3AbOYABOxaHEEW1CfYKSaKE2QqxqpoVz1pwClekHkTO8eBMF0l1MCZOSM
         x6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786933600; x=1787538400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsTjto3M9TDUjL0GYUMtZDAzX3U6QWNQNCQQC0hE+iA=;
        b=oced/Auijfv/To6I3GdcPOO9OmWzsaBf0VOK0jNgywygikMzMFkNa+ya9adlmtCaBF
         6s1mm8D7+zAmDGb9kx+VeaoDmQIwA4sR1Eazby3NuaeDIemV6k4VgbUjFbGEzp40fh7X
         8e4+mKCcp3jpS187hG5h/xNMC1SilQD3TkAZP1THEd5xl+Q5G21ri9c/dVZnqtKI6mDe
         CCA6FFDmN0SzpjJM/N8E3cuKtTa32/tzCT1G5UCUXfmc4q3daEAu8thltZmuJobAqz/d
         M279qZfn45TJBf0Np4qJ6yEupJcY4PUtm+U99PpURJFqA/mS4rJwCd7rktF8pl/odyu1
         DXgw==
X-Gm-Message-State: AOJu0YzRWts9mf2Yd7JMb5bUrN/Zj55/pvkPXBkAuwmH6t7H5n+2iU7K
	9X0RdnCrIKjsUxAjsiFQcB7RfoTgUvi9bRXQhYGNmhxCG7+JepJJ2NaE3IWPHRvS9aZlUPXPEDJ
	C5A2c0lenYL2yEWaoTjsikot5mk7TlUQOoXCXaox6rA==
X-Gm-Gg: AR+sD12ftDhzwpcTUuJ8caK5Clf/AcwkjN5DIwqo7ULB/OJb7wCJBYRElSr+Mbeatq1
	OjtHhHjpj4CDY25glyIsH6VHfHhl7jTjKH/Tj5EhdghceV+uhqMU0gGVhqMEkB6+cfeJtm8N6/+
	PGtkx4Pvpm+LR3o6716dlHT2P0CMyX0lMtRUp1z2IIfLRE/XAIEtRxabOq8774bUMTybiq9LTOc
	hwTmhb0SdQNv8gfurTxnD/5LdhVYRUIc9/fHQUyVD4t+/xj09AUBtGD4JHpyhimoj89jSzalq5S
	TDBwCg9UFoKJ3GwWka0t0LhnjS9iMwKZPhAVqvF/8V4uWj/2EFevUD3e
X-Received: by 2002:a17:906:6207:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c2129be130dmr1070312166b.12.1786933600065; Sun, 16 Aug 2026
 19:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-b4-ceph-copyfrom-v1-1-9a4c229df6e2@clyso.com> <20260813120910.4001650-1-amarkuze@redhat.com>
In-Reply-To: <20260813120910.4001650-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sun, 16 Aug 2026 19:26:28 -0700
X-Gm-Features: AcwNN1Uuf3AdXvbIz60XUCglHLW2D2urtpUQUylZWaX85koPfLGzPGCRRVsp6X4
Message-ID: <CAOJNxRLRGqUnE+TpecHMr-pc3i2iZq=tqG20Zqjapkmn2h8xeQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: parallelize object copy in ceph_do_objects_copy()
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the feedback. You are right, those are good points.

Let me fix them and send the V2.

Thanks
- Xiubo

On Thu, 13 Aug 2026 at 05:09, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Thanks for the patch, the idea is sound but there are a few correctness
> issues that need fixing:
>
> The drain loop walks past the valid window on error =E2=80=94 it derefere=
nces
> request pointers beyond the tail of the in-flight window, which are
> either freed or uninitialized depending on where the failure occurred.
>
> The window size is read from copyfrom_max_inflight on every iteration.
> A concurrent sysfs write can change it mid-flight, causing the loop
> bounds to shift while requests are already in-flight.
>
> If a request allocation fails partway through, the error return masks
> any I/O errors that were already recorded for earlier in-flight
> requests.
>
> There's also a design issue for mid-file copies: parallel writes can
> modify the destination beyond the position implied by a short source
> count before the short is detected.
>
> Could you respin with these fixed?
>
> --
> Alex Markuze
>
