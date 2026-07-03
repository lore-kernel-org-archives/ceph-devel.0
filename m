Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE00340A47
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jul 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063217; cv=pass; b=BvGQveLs+9XuNrS/+0Hn9kd5mn7NDVtsFeg2xn5fbWzdE26NssxJnnGN6YcqJKP6zF3tnMCeGS58zRD0CjUmzzCOIRQ7GtpmQE2gEMeZ5kWb51Ob8HCfn2m1MyMTbdyU2jGt43FGCvtgJSKwPNdaI5eJro8xfcSkzBk6BYRGsWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063217; c=relaxed/simple;
	bh=l5K7+smxo031yhaanxRMaaO/cbx3ix29IndZQhgvDRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV/4cZUt/nU9DjIf6q6aG2Nt6aeoBqLYHXSI0bp2VUXhX9fYG2sthnuwxpLb2ecJC0EtVf2xtV8J262TF1f5LtcAE4VFIM+6y3Y68z1pz2Ik6jomqhyxZC+2FWl/nPqcJUyu0Gciw9+ciXsuUUw6Vm61ZUmKUQ9qhN0lhyZXLZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IKGWW60i; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IKGWW60i"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1268d56234so24474366b.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jul 2026 00:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783063214; cv=none;
        d=google.com; s=arc-20260327;
        b=SMc+FgK0kkc9IoHygyVZo/A4Q2f1JbffUV5PR0hyepvzDT+ZFPzTIG55O0pE50Dg4/
         fVv8FQCf38OgkAzbe2HrCFHvMeFr16lC7zrcuCAOAYoznAt0n+czw+xj0KugLFiVoxCn
         iixiRb08DwyE94nRzdoX+2X6UjdihJi9PcHDe4A3nChCjB4Bp9qc8ADVdRQppSvU7PC2
         cdbTD+mV71jGKdy9YQ4nyibrPgmykNMr8uCeNLiGKY/lBbwCiMUVwDCqSW+Q2gNFByjU
         SBUTGZUj8EkeY714ejERU53IduP5gEi2ygEnpxbjwzJQWCoI9X/jOZATSKkx22YC633V
         enCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFdj7QiBpWZI/1mqCJvt0ySOjHkHZGWQDb6yOAmSu2k=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=JpL0FtwO8/+PusHMH6zRamh3Z9RW7w4wNKmE11OO+ehalDAqIrpX6/B7rA/gilyWVq
         NBWdNE2VAa35QOqBEAs2sYnoZWb4zOFPLmc65UC8prT354Df/7ZhDw+H9c2WM0SHpvz/
         f8ZAIUpFx1wC71pYP2WsgB0+9fx1MVjDx/Ca9zgH0SuZQfnvEeT5bu231Fbv0GYaYhD2
         WwojcE7czVaMqBNFz93ZqNLF2EskYANFtpajC7Fp4Com+XA+2NvqN4a9B/keBvhDppkS
         cHFV19vdZ5TM4YT9JPFd+kvPIUM69lgkR48z/gD3zeZ2xELL4njJn1bW8cwIdk8x36Zo
         2EGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783063214; x=1783668014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFdj7QiBpWZI/1mqCJvt0ySOjHkHZGWQDb6yOAmSu2k=;
        b=IKGWW60iUWUycJE9CjzzkHScXqjWhtU9DFnI3au/pNaaVDngR2y7Q1AmVSYBXMy8MN
         zndJ0EECGuvNyivOlrPc8nLoq0m4V86vMTxtQK7ZGl+M95PALtjRxLf1PMMu85ZOFvsy
         ti9hQQGCl6757VyU2E7nOTzexXKDK8dkFsnTCEc3VK2U2kYSHniVidmKMnMzCnTiQ1F6
         O+enF+HDDvhrjONmPQlZxJ4x4PczWA2cLs9C2/5FU9gn+2gniOPbQbPt7dZIM/CCfxRP
         YY83LijuE9ubhwVT31dVn0aHvGWpsdtiz1SDVhzUzfFzDKVo+BkYiPtcr3hbUQj9Yp8w
         wtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783063214; x=1783668014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFdj7QiBpWZI/1mqCJvt0ySOjHkHZGWQDb6yOAmSu2k=;
        b=jvqBkt183/QwSDFFYnE4I2c2O0zaTrQC5VlrWcjbPZ0zsFU+XWOoFJCj+1mfLN7dUw
         fnRDnU9KGww45xNLdXAdUjaJdYcxOey5lEKAu2BugopjLf5vY5naFm0yX6eFGPsBb1wl
         up/54jeujZvmWB2Siwf+omxeSNEVRWePdoUcL0juEvcjEXb27PyK3vvJDxqYVoLgKU4L
         VGZLWDjpCxt5AA2d9dM5nZgk4TVzARuc/m5rfMHW5zNo+EGmwAzY4DOsbqQqKQsoj+1I
         NZxN//USwgnE8RPjQyHRIEmn6JfJFMeTdCdAQX3wacZZ9H8MzifcUkDiIYH0N1+74m86
         c1uA==
X-Gm-Message-State: AOJu0Yx56JpmTYuElvJMSYFV+obQcNjUkW2466h+a+9ioD5ADZT20Kwl
	p+Dshin5I/6QN7o1u8/nS/VxhhKjBZz6kU5DSbzPKdjLhYXOGXm7gQUcKOEe/zVl3kq+bUO1Z/o
	r1QNUuT6nMdRORIXPCH75XufHuc48P+Fq7RE7oRD3PdhIL39ST+Zhhwk=
X-Gm-Gg: AfdE7cmYkt+biE5BOHXFXZzOeP7djsPtOHP35tS0zL3pEGQB/1WZ905H9ZHGbzXMsRX
	/31i4JKsNFlauuCj2/eTTUDtr4uz73vueGv8Rq2od0d7oMIrFDF3QG6p/SEIBxDyv0SjJUHA8S6
	YJ0haK2QrRXchGecibxWJGslGezJH2w/MhSF/Gtb4h9QuKOBqlaSfVNIy1I0ks6OFRLd/2TLfX1
	fIdjLCLve/QzesiF+e8fT+f/YV9wRVukErQZt5wqEu0gCLmIzmbWu6oFY5+HfgSLG0ve609zkZ/
	ZFu9IuSOfpUyAP0kU+hL1fYqFw==
X-Received: by 2002:a17:907:a06:b0:c12:9ede:d308 with SMTP id
 a640c23a62f3a-c12a9d19558mr427082466b.12.1783063213746; Fri, 03 Jul 2026
 00:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427155813.2561935-1-max.kellermann@ionos.com> <20260702114034.917507-8-amarkuze@redhat.com>
In-Reply-To: <20260702114034.917507-8-amarkuze@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Jul 2026 09:20:02 +0200
X-Gm-Features: AVVi8CfbGdVcnY98ki0hcr9n4zE5yINNKDptegrLbmpgfNNgFuvfsMyATOrUQpM
Message-ID: <CAKPOu+_O-j3KdUmfAPeQrUPhpehAGeAQbnZd6J+OwG+duBJbcQ@mail.gmail.com>
Subject: Re: ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 1:40=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
>   1. [minor] fs/ceph/caps.c:3093: Timeout constant should be a #define

Why?

>   3. [nit] commit message: Missing Fixes: tag

What should it say?

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
