Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5735A397
	for <ceph-devel@vger.kernel.org>; Sun,  9 Aug 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296816; cv=pass; b=mVX0MKZVddkogUmsCnfiMQ6n8YvfGd70Sx1AUCN4REnKayzfRJ2xNNp4+BP7s7pxcV81pdzxRgKk/SFI26NkfntORuMzYJsy6i9hqukv01V+OnBj1hDGkIdOBCa0vH2ftiF3FCMf8JbF2FfMED0TRQIT5FfRNCic6aq4bQgSn+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296816; c=relaxed/simple;
	bh=mWlp5QNrExYXsGTZE+zqwgU6yWdZR31aZMXuOmCIjYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJAEl5Ne232jBlPEVUg6CDzi2LCcapwLKZiwben2xm1oPtSj1x1zUuzQyjgXKlc//CgNgR9RY9V3cb+9j4rBFDN2nOVCk5KxGd3Mx5LI/maVwMmcLRzYmXcPXmtXVd9ennPGxl7xngeyyk74cIUG82Li05RFbzavEZk8zRsgH+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dULiT3du; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dULiT3du"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7377dde7bc6so2157572137.0
        for <ceph-devel@vger.kernel.org>; Sun, 09 Aug 2026 10:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786296814; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/k19RKZByJ6UAo3gk1ZrwhhiwLUZ6+Gw6VBVZpMOC4dX+iU4yFlXWKFed+KRljA2P
         jCPCe1M/tF0VTgEiZk5KmqS7y+HD5J33lfBUAA9hp2bSryWAmOS+oWzyJKZPqgzHerHc
         Epr+r7DiQgKZKnXHM0PKqnFFnRtXK8Vr+R6mj0BZJ/MOQo6/eSSIv3SgQ1W2Fp3BacWh
         lXc4gC+Flso6u1CDrJlZM197rYwGpLfPJ+9BqxYM1n/4h3BL9wE8/rW5ETloklJ5Fm9j
         uLKxbZbSEHCPEnrTPLL0hGCZT0zBwY7ZAqDxqeNyTZde0S75SvONPb9WzfOcHDImvcs+
         8KNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        fh=1URUeC1+I+Dy6PwazdjTL3XkANxLk6Qe8GxhMWhL8g8=;
        b=YHQPgH0qjAYWPecMDML/hFeq4Ze/KwQbc2QnJX5ED/1SQ/WJMyCzJTcHJFCVZGkmty
         KF69gtVXhVfcV8vVSrtcSjzhVQedTOB2huHIXEBop0CBqEMOej658LdmfA4CuoA3P+TK
         vuZoDnyfomkPGeS6MD4GIu+o0ZRBTjEvaV8BGPPZb8k1R7uPWSNGIewvV+Ngz4M2F3Sr
         lY6hfYXluzwJqigAUCCjhW/ucxlZ3n1K3+KgzmMWfj7+nxucQFbYP6JY94MqCMdO+ZRP
         aGaTl8NfBoVFT1qLXO+/uxfcD/nXjcFfidUFMGoYa2AOdKo+2GzDLQm1Zg4zVvvMhMsg
         BaSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786296814; x=1786901614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        b=dULiT3du6l7QG6u93CVqzr3atDrTUbHxgFxv4W6Air89yJKedwPr8Qnn2H6/pXBz7V
         acMp6wqniUr3hHCZzVP6V+Lo/fqp1QvoKc4nbCCNAMuqgLMVt6+aIvaz4E2A5o3Q6MWd
         ZpD8wdzhlsGwyn4uk6Al2Xb2yLOz2T9DbZPhUluAQlVNI4CgC1Z6QgF2fFTnVKfM7rzL
         tFSWXCviQjI0DXCuSTGG8yQMebKacd+kOagRByuGX2SMj6R8/mxLXAtzLV5hylY3nrq3
         QVKIL+4QtlEromfPT2+AOR14kM/mvldmWMfBcuzhPy0tPyLSF2ue/6lhnPEqIYsNRMGm
         UB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786296814; x=1786901614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnzny0f6nQDl/3k7kZ8Guokf4/cEXHhhetxys39MwOI=;
        b=SKlA9IWCEIHdzNEGJdRw7hqjF5Z53fVBIt4qZ/h5jUYrTMzb0UAo1b5pD0Ql2XRIdX
         8Gf0H0wwoD2xu9mkGUPV6bofz0e1gPtg88uVmtNOgVzyqIiTmL9gGGwVYCwoxjHMnUrt
         hyjDhcNwVZqMy1AURso/7azZKTAdlJ1WAs+PsOsw2pNN7w9x0uZSubykdnXLQFFPqDAi
         5YczTeENxTo4W7JLtBYwqGfJrHPNsPsmrB/6CHyiS83TyXsy9edeRvObjLS1e8XJSe/y
         UXzk7pxiSVcefettcrnnNVpe2/GGiDK4d48vb+Afgs5AnxDiLMzpc4PESNVdUToFwgwA
         uvyA==
X-Forwarded-Encrypted: i=1; AHgh+RoPy+Rhax69AAGxDblw4e/O0h13XEHuPJq6gpWccqkMWaDaTKDuPM2WBc1rK2PryPrPobdAQ/u8pZi0@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpOhFaGMQ5beuAeUESKEYXUWev7/cEOcMXLTaIAyquDIA/IVW
	Nkyg1WTQGEqCGAeiwRQIzRi1Rd0TtC976JtLVgGKTLL3jtkbwA5C12/ktjMd09VX0QiOsv5pKp9
	AUe/gmO11Fy8LNIpXbHQp02eELf7MbwY=
X-Gm-Gg: AR+sD12OunP8XgVVf3uSADlk/ceqAmKMNT8oMKUmC/0EuxCy87x0AhkGvD/7r5bj9ao
	sk6KjewyMIyUm+eSztxpWzjtdASjxs40M6Zt52myqiQTGyhILDaeIuYu6CiEK5zY5RsW0O7YnQF
	inG6/ycm9xZppOirvqRkY2xEnP2EOrB6g9pweiy4aLQRzTokml6kBf2oS3m8oDZMixDuGY0e+5b
	imPS4KbfYpDjC8mbDepM1cEHUG1cedMwyGr1Ly2UNmIUacI+y5+Ffjd4Z23ghi2zpZG6kkT5KVg
	ae5/e7z4negYRf3NOdOPMYvcsNoD2yV0zyA8ltH7jiOHKtdzKsv3yNmX8gjJ6mfhKyTlyXfupOL
	PynY=
X-Received: by 2002:a05:6102:855a:10b0:747:560c:e7e0 with SMTP id
 ada2fe7eead31-7652017a8e8mr760293137.1.1786296813739; Sun, 09 Aug 2026
 10:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
 <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com> <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
In-Reply-To: <CAKPOu+8Y35cfhz5gqus18-HPLoVMiSWF7cVXVbyn6GmdJA3Z6g@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sun, 9 Aug 2026 19:33:20 +0200
X-Gm-Features: AUfX_mwnwy3r9fgavh_y4tM6O72D9MJwvIgSBEzeWm66BW3l5prqagQEgEI0_Kw
Message-ID: <CAOi1vP_oJC73d48w_qJaxtxrX-mVMYip3-rg-iYoHwHn6Tz-FQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 8:31=E2=80=AFAM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Tue, Jul 28, 2026 at 1:31=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > Was there any specific reason you used nop_mnt_idmap for these checks?
>
> No, I copied that check from another filesystem, probably ext2. I had
> no idea what this parameter means (and I have never used idmappings).
> I guess the amended parameter in this patch is correct.

Hi Xiubo,

You reviewed Max's "ceph: add owner/capability checks for
CEPH_IOC_SET_LAYOUT*" patch.  Would you be able to review this fixup as
well?

Thanks,

                Ilya
