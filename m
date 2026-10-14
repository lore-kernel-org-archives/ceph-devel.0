Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236394BA1E1
	for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978647; cv=pass; b=qQ2jClA9d17rkmEBgPrbGsNwJr8tnnfCO1RJ9b4EAElhevdtXmaZyFTbUlXY81cuhQFdyl01caAkDqFtpeb4vHncZtSA1VmUV2WL0AIi30cBupUaTNA/Avm5b7qI7/o5IXiqHm5A464UvEtcVlRGZpFe8/HB6feOcQUGBraGx5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978647; c=relaxed/simple;
	bh=1/9wWtkCVuLP+HndxiaJnX37Iwl0UJ8x/5Z9QzRW9so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AmHgtpWZheBDjsNH85UT7N7EtXGZy4Reku6+brKQZNWnuwmXlWZ97d4g+6IclnpjDZ4luZpxpLsFKyUDmCSOXo7HAqPT72ZTKiRgw6lzubl83D9QHaqQkBoR3ONM9epbnJl0AcidVr9chKflGZWr284eZdqSVb+84C5lPp1c3Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VzZBYDqT; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VzZBYDqT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so705493166b.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 04:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791978640; cv=none;
        d=google.com; s=arc-20260327;
        b=a+sasvK/iDBpdQN0+oUbboyW3gkGLp6Cjiplay++ZQ4Iy6qNYBzikg3GA6bgUOe5LN
         gIX7IbIW/HMhrfFcIAoW5hVOsptSzDSu4tSkQ9qoi31Y7iCeZ2BZ0dwxG2BGv2WnJ0QL
         ey7MzPEFfslSD9pdnSZWG+48OPFLj7VPi6yLTWP7DyKNQZc9/gw0oOe0Biuf4VENafTI
         196B73XgjIuU66GTkkniyr1rnKMsPq9HBs7QbPgczysYDOTkVTD2ll8zuEwdGZqNPSUU
         aLxwykydWTa1DlPO5P82LTrCNThH8VuHhy2C/+gopZeVlKZHUb0A4/S8lE8QYcDYxPqe
         Zfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/9wWtkCVuLP+HndxiaJnX37Iwl0UJ8x/5Z9QzRW9so=;
        fh=uIUSmn0x7P79offwEFPLWwnB8m3z0BHIrStMHDLjL2I=;
        b=eMdeabj0Kgv11z8qpSyA1toZaU90fdMJWSSeCXZJuJnnqpnxO+Km2xWheZzu6UrMQ2
         T4Wm8oIHNh8EBhget8RcAr2a9ImrhyVg7mE6bhXpJnPXkVEPxp2e2j+Zek73zmKnhB/m
         boVXeZOxKjPobzSVGkO/2gLVMdP4d8mbwovXmzc9uaBwpBw29ZMgnuR/tKKMwBkcOS2y
         oPYrXub/b2fuzhY0IGn37uGpkN36A6kC5ynggfFaAS+iMe2Lk/JI5s9ZJEJxYHPKVi+P
         dp/4Uatr9M19OgQ4YjFL26QeF70dwcZDcTjR6vvRZ640C4a2MxtvFitKFATBpfcq5Ouj
         R9fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1791978640; x=1792583440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/9wWtkCVuLP+HndxiaJnX37Iwl0UJ8x/5Z9QzRW9so=;
        b=VzZBYDqTxofJS1YeruugwPOXcqTr2nLfrEzw1FtObffvztD4TjuAhA6A4VkZID1CXN
         ND+AN4fC33vyYECBgSACKVMH5DoNbF71SAms8v5cSUBsEPFh9FSDgvUSQDY2doD0sFCd
         n/vYaXvv8GCDAN6nDrKApVurZrmS6sS1D3JR47Z8FhgbJj6RRR9tkbdLLFeI744B5O9A
         8hoftcexk7vgIRftjPKxGwPGrtDDpTsNDlNh0NaLKqMraVaWjmdE+aPWmYjBtNQHeBkI
         z82MPo4qqv2bwtdlO/7V74tr4156hw7dUgCKWumyDbpj6CS9MOfUUTZCfc+p4tp7C46C
         Ptog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978640; x=1792583440;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/9wWtkCVuLP+HndxiaJnX37Iwl0UJ8x/5Z9QzRW9so=;
        b=MY2/d+5l/h1d+7HqFfHso2Kx7Xjlqfb5Ab1NjBhF2qrhK7T8c7PgmPb5vsVjUnc4YJ
         nNwEP7i9bEQ0PLjqAb5sBp2NodNzQyzqCzFZ0B1WKTZnHuGaO4T4GDpp4Yt8FlVo2KYG
         4Ldto+asOBbFIuRU4f3uadved4i8n8qp16hAvrVO7/sq72D4MZ+x7+uOxLrdhBFuAGWu
         q8OLkksN7ouVh1kxzvjSODtlIBtP5rfwgpqhzbG6E7g3LWnCaLA8IUeL65toAzCk7qVZ
         lUX8p1FK8GRcUJFyOrhMfQf/CC5++hJ40gVcp2bsiXlF68wcesNzGh2vR6ds+J9RCPOU
         xYqw==
X-Forwarded-Encrypted: i=1; AKwUvByXwyE9q9AM6YLf3kI5qSsIZB+gM5mrfo9YMuu1iEUW3JvQdxFQZxRibf9dnqJYgrjVtD+Zx76e4q4V@vger.kernel.org
X-Gm-Message-State: AFq9FYKW6HaizHAGiuDqeqS8c5kqJqp2IZDISG5mNc4fRlN1Ori39qW+
	c2+GTwYReu+D9rMcJjSRgnSp9jikmCXHEGFbCeVBKdoRAwTpisT91ZQ7Ac5DiNMKMs2cvnfNzVB
	t+NNHVV9KKeCnA5owVflA3vcJTY5HdxFoJtS9k8FCQA==
X-Gm-Gg: AYBFou2YG1KGXIV6Ash3CQnoDngr01JIe0r2WfzfI4ahjj/2YPyHTHrKDHUvt64FoSj
	IPN4FV7sAef4NoF4ogqWFF5QGUde50FQEYHKO+qjJcI/veqzkJh/8r7NNP+ItBa/q0UYoAGXtP6
	pKAe/M+3K7xyxu8BEtpUQbpQowGlcOVPd6QweacP1P+BMPMek/KYHjZyv+vc1h1kPnuAmT7+Oxs
	2BE06Lq8qHDp7uLeh1+wK96FT6Z8PcUKSG4OUvvsdfOfq/aHaGYFcJ2VNKAlvY5hUTl8QdLnieh
	lWmDo7/2Ch4XNMnD67trdy6hyiMHQrO4nPxltgR4HFDmzv5kO07nDC6hFIA8WjWO0aneNXgnFG5
	htMZITimB
X-Received: by 2002:a17:907:1c8e:b0:c2d:ca8d:435a with SMTP id
 a640c23a62f3a-c31a9fd6f9bmr1557096366b.38.1791978639567; Wed, 14 Oct 2026
 04:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
 <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com> <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com>
In-Reply-To: <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 14 Oct 2026 13:50:28 +0200
X-Gm-Features: AclHuK9sSR_6nkWZJStfKgewh42m0NwU8VaKEe8YILznWZ8_5zl5u-W4tA4Sl-4
Message-ID: <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Alex Markuze <amarkuze@redhat.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 1:28=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Max, Please resend the patchset, the tree has diverged since this
> patchset was sent back in September.

I see no rebase conflicts with linus/master nor ceph-client/for-linus.
What other recent changes would make resending necessary?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
