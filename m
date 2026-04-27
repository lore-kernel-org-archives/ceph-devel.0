Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CD3D34A3
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299477; cv=pass; b=dXQRnQCG67UFu7bgrOfEjQIjab8+n8/PeZS97d1ytXTPIUyaEHH76L4vN+lSjC8OButht+3dVHDOYvfw8ZXSCQ6emuCZjzKh6jNl6bFxHAhWldrgd0wSUQuzngZsBrwzTHI0NMws6CNipWtcyS0y41JB+Ni2l+ALu52/D7IpPJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299477; c=relaxed/simple;
	bh=dCas8RQKsBsKm7RPEue3wRPtJ4lneFcySX6TUqGbvVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqZo1as4Kb+WtIp1eWNbvsC9HwMGG6lheEIk6FGLm7hREBvv1i06DCULRfJguUyjYoxzUS3bD9Zdto+CgpsiwleORXzQ0qaDhtETCiwhCDzKdLFVcCDz/MbAuMmUr8U7HLcQkJmk1ATm6nkJ6eCfiGuKTCvYu+uBQz4+uwJcWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV7XlqUV; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV7XlqUV"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56db1b3626bso6691885e0c.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777299475; cv=none;
        d=google.com; s=arc-20240605;
        b=C4P5c20UF2Wq/NcjGETCiN9Z+1FgbUAz4xIGX0eBVlvZTauwJSKUWjmLLj4A20Aexm
         3hUxtpoQrW2GTNVukAmFegI/mbApzbF6m2TFHnVNBmO1gxJIadcIx7WRrzT8UxrRWpST
         WXkSkViu3ee2/dW0Jbr4W/gerbwx1gRkRw6SX+Eqd9Bp2nAeffVib9vh8y42H0S9OSqA
         oIlATM/5eIcTRDJU5v1XbpHs3oNmttNBBzw3yNU9nhSNeiGrjBF5CBThys2to58UZZJ8
         6+Ofo1+qx3dJPsvB/ofmZO5SNZdUAqC00YlVZHSFWjF9Yb1Q29Xt43s7KsQWx63onnZC
         TU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        fh=n+nzTUwBZBFZDJUY/TKNBxjsaQEkXx6wrQiws+MdN/o=;
        b=W9TeC+BxXjjsuK+HKdnesew6po9U+DpIBg0WSlbyWzQU5JbgDMN6A3xHRsBYkNy9Nz
         gl/MZcsgCdxGWNy+2UWhO0WqgUD97epuQ+6fRTwBU3IgLDEz5+sSv7nEaK1ORvfVgbF8
         u43WPI2v1a16OmADPfFEcU1Qwp8BSNXDlgfIEWJukWjqu4XR5gFBjsdtBRRMPOsBG3Ir
         dD/K54RbJaJSC+F6k/nXrmJwuvoybnFyhqN310llhyc77e+kGLlSLtaVR7T3s6kzb3uu
         BV1r1NqdFzg5tDhqobjyUwLZSIeRwuwOzclSxIrZ567jWTBzbBNn1BiHq2zHi6AaHgme
         4rRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299475; x=1777904275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=UV7XlqUVvinNvlG4ozIHjmCDkWLWkXqWdHVlwKleD4e0udKlFPCyhDThue+4KCSFuf
         4PPkqV7PBmqSm85u3fIzULTAc9+wtQaK8rViECu4uoP52DqNbn15+/ac4reFdyXrn/B1
         s3/x0N6JxPqqHQ+SvjX5nH64ret3FMse3JDW0UFDRIL8eY4pp1TNXlldauyddtT20e1L
         qF3CPo8D4Y7Ek3KN8fARmEEs5LMSb+8CfKYUV0BkpMnaU5nmr2gie+0EpOmT51BfojAE
         Cr7faIb0pQuMBU6P/HjjO15sUUH7oPx7M3XGM8FLv2JB+tutyWbnxLL5ubYguDpuqSMe
         bJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299475; x=1777904275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZ1b/SaO6jwDwL2+8FqnCPqXNKQ2XKB8aPpu8Tl3aso=;
        b=sAIRHn8g+i6NGdGSGp5Ioej+5+pbgIghxq2afLSLx9QJGdosi0cDKfeyz5LW8GExAU
         WaxIpfEfY/dAALG51EDvkGTawlV1y9gMcpmM4zuj0HLAJNBOF7NrjIFbCShYZSrf9qaL
         RQ1D59lfNa+VDT1pbb2sRBU37Wbv+7Y/gilwWJ4/Jmf/1q+VzBJzYL/P59hUx/k5SZUH
         2GJHqvgKCqXQsjEpO59itKZdZyYIRPB6y1QrZ/9y9U/bWQW93rX/ZCpuZbelOP81pUl3
         n555wH5nub5Bh+Qral+g4O5cMFOK6sgOPLMDlqum92KvYD1Y12B2+grViVx3P8mJDVvc
         JV9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LTuMpMexWTTgaF2ax7BeWPllPoSpx4kC6ZFvWqOOZ4tO5InF9SlPblcyKvCWaiYcqCU8kyRy7DVAA@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGSu6LKPO+3WxM/+OB/TAM7GlR/QY6cw1RALQiB0eOue6ZkLt
	jQ4dL8SigM9y64gYfmx3EjBC12gWBXqXEstyW/zSni4KFhiu0VxkrVYRsqQ5kmDz9DK+XGt2CIz
	rn841KFgMreYQG3bAxF9EMv+LKORfgxU=
X-Gm-Gg: AeBDiesJESOqTkz6zvQlrPcYa2kM6RfIdqFTJ2wE81t1VDP6ev9NWkdxxcJB2oejQEn
	D4l/lJFdYc3RD2zsh1gpXt0G8xXQo1Z/7HwK79WtBsR8Sy/trdhsTicBjYLg5796tarvhgcCttU
	WeP0Swz27b9j/4UpYdRsz0nct9LwjOXmJytXaw3fvHL2q9JZHezXJN/P+q9nmRaoBVWBB0RBYEx
	16lJdlucGZg1Zl7OuP2mgYVs3bWBlgsSNNxO1M7pZ/JCXSUgqqpfRdsuEVJHVo1Xu8ZMHd7ceht
	9TSKrbf4gFFQjpsxnZ0sNUUbS5hNIyHFQzrwcE3qWgxkTxMMqppD
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr21307327e0c.5.1777299474612; Mon, 27 Apr 2026
 07:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 20:17:43 +0600
X-Gm-Features: AVHnY4JD2JZaiwDyyuW_kBt_sHjEkoUZKURjGdK7nlj6KmXsjRIqpl4zFGzklnA
Message-ID: <CAFfO_h5B=Ox9S=Xc=az2vQwowffohch-mkvSggYAfNXaVuv5GA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Florian Weimer <fweimer@redhat.com>, brauner@kernel.org, 
	Alejandro Colomar <alx@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:28=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Dorjoy Chowdhury:
>
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..bd78e69e0a43 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define EFTYPE               134     /* Wrong file type for the intend=
ed operation */
> > +
> >  #endif
>
> This is what POSIX says about EFTYPE, in the Rationale for System
> Interfaces:
>
> =E2=80=9C
> [EFTYPE]
>     This error code was proposed in earlier proposals as "Inappropriate
>     operation for file type", meaning that the operation requested is
>     not appropriate for the file specified in the function call. This
>     code was proposed, although the same idea was covered by [ENOTTY],
>     because the connotations of the name would be misleading. It was
>     pointed out that the fcntl() function uses the error code [EINVAL]
>     for this notion, and hence all instances of [EFTYPE] were changed to
>     this code.
> =E2=80=9D
>
> So I'm not sure if reusing this name is a good idea.
>

Thanks for pointing this out. I had started out the patch series with
ENOTREGULAR and it was discussed that EFTYPE was a better and more
generic error code which is also used in BSD systems like FreeBSD[1]
and MacOS[2]. I also agree that EFTYPE makes sense. We can of course
change to something else if everyone agrees.

cc Christian Brauner who originally suggested EFTYPE for input on this.

[1]: https://man.freebsd.org/cgi/man.cgi?errno(2)
[2]: https://developer.apple.com/documentation/foundation/posixerror/eftype

Regards,
Dorjoy
