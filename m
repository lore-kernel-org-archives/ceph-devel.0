Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8B3DDAE1
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141859; cv=pass; b=CBgIMSi/funNYqOXN+dgXA8/+7yk8ItY9mG9imd5MljngGQIX/Huww8kAqCtoVPyTNc3kRXUYlEVRT9vPCsRTaqJqNaCDOHwIJZCvGxu+JMRPMCHt0qGiqp+BvimUDU79Q+aeDiFab0IIwgltVy6YiI8RpHSSRsM7B4mcujuEc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141859; c=relaxed/simple;
	bh=YFn+SG3jt0W8ClbW1A5ZvhnjFO3y0/T59yYvALkEpOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv2OFY4RknlRVs3kw+AuyczXzTRInpn58UVmDRRAR7bzpy4QVRB+YmHR0cFDDc8MVuqlge7zJr17XEEw65xEWjjhn2m12Yp0N3sLjzqSJr0ejDNsrhCbe/pvP4eQtncWLlka0tbZO43rCJaShS/lTKsqPjKdZvq+QdwaQ+UJ6u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZI9xoAZ; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZI9xoAZ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-97723f98735so1659123241.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 01:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785141856; cv=none;
        d=google.com; s=arc-20260327;
        b=pZuOxDfcsyIR699hXMnnm9rsoaS+Ad46l8MxESj9nnjmzcTQNKV+5Db2IFOuNWOx/i
         zOegsgo3wjUxVudY/v1hQ4bQtsNrJCNJkzVieT0408M6ef32SpYs5LgvsD8dDLkJPjR7
         js+r/ahjTxTC8HHMXF+IGcqDJeI4YPCRlAcShCCO62xlBuYEtMVwV/PI6+bTCyRWCuH/
         f9R6dVf6R+KgvQ5cYy3pkwc4NDr9q0ygRS6KW4bevK2sQpEEij0lAZXRIj7+KVXo5TEW
         LFKCRraWBex/5n5JQeOkt5KdQ3NJEk23p56RVSvOKmFtOEf5x0OrCJFpor1Wbzvj7LtW
         g+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        fh=fhJPsWkkqYAFx7ufgZZauNIwrnwuftRRHenS3BG2YXs=;
        b=Co4MOo+I1S2e2guOgESqkZHe5f3PLzv8oJVgaqwN5L3n4BcJszOIEM7C2D6O43th+P
         PpSpWb2T1+9sQVq0gEq7BMY0yEoDrmmH+wJ0A7crNPnJgMMoTIzQ7QQzVFKdvKkGyRAT
         w43lIDccMqvMSIyu9raltJ1ZNUhELQJaNDggsdXgQBpHtMPLBt/NjRe0a8f4TupMDW3R
         FJB2YtlOngOh8lYLjOs9mxuX92hTCWqiseK4CvfcvKoFDJsg6ZRuNHZUdwYrWocxFCjj
         N9fgzSsRqFEiv0g9jSn8wfMh7vhmxna42VFweNwjhrnn9YtUgSeXJkER2nc4gV7R0k8t
         94+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785141856; x=1785746656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        b=EZI9xoAZbvODmBSux/cJ/a+6T1/UIO2yDCT7uFxWhmMDMcnk9XC0F1hGVBlIwVI9Fa
         JdJxPevAc6CST4aFSSv7r6X7zBkGUzM9Prb5FzWIxFuFKvbdc9bXVkjKljPctxk1kkMY
         Jz4XMK6/RHaC7f0TRdDVMTPH8m7zNbtfV8LyRXmDWqLvNZqtqc8IMzo12XqNakYwrTAS
         hG6Q4D9r2gmz2X6N072eP+uBdfaIp03RIDBR6Isg7Y4axnxLjcLVdMscHTuTUDnyPsCb
         Q4RejeHj6OVkBHshHlIQbpIBeqn025/wqyRfc8sBQWcCzcIa/po0WZvdIC/aBCOVO1Ha
         Jwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785141856; x=1785746656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6ZJtMg2ZwUmSn3lFbPCBamJdEbDXw6UU/0/bZEAB3g=;
        b=QW6i8JJpOqZAkLmjeCltNy4+q6fnc5XUdSgob5kMF173A9d3ZO9J0aG6V+qtcLD5iZ
         wRLGBPV//woz6xnZQyUovyC1e5DJlLRODrSJZJVZ7srCv5Ls5XDXVwvlcFWsbtmBRRQD
         R8/UD9lbg+OABuEpetbK/7p3xXPyv7mu+t3d6h+hT1lOCZgb6HALVMObKqMXPf9INOYh
         1DuhfPbI2h3aNXoY8q6Apvjz1by62oFKErjsNO/Bdj0HQPO4aQ0R1fsKa+Exss+rwvDG
         q3xCJYTdYWv/ayX+WH+HQd0zJAxFAkZCc2M9Utq+Eb+IyGbZRyIq4y33gyRICWqQjt2f
         mBaA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0ffPcEA6OlK0Adw5HIEOOnifekdFmDxi6Fbz/tLulZbF65i8xgHZfQOSqZVVnxvwglhcpesPqzDBb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eFuCMyYTZOrnPVZbZEkejFdOeW0XI2Pdc4JaGj2XXT+zLbHW
	knHE/GZ3NuQ5UrnBikvQAk0xNkwm1JwAOqNFWmPCbGz7uGNee4SH9BZ7zwfwwWtUgtyW2ii0sN7
	xcjT+GqkZRxiqrF/20i3/pap3o7Wr3+WVaBG4
X-Gm-Gg: AR+sD10s8DBsKbGzskHlwIq7hHihOYGo7eQ2nw2X9j2XFDdg//EW5JqBYyubqi76Ypv
	2juOo988NiJ6GEASjrpOZ6Aax9wgtkqWITfdMMug4CNd3wRRNGMYbQ06NtXJ1Cv7H4y0asDgut3
	pvylwgzbFWprgr6u8GkTEwN3MmI7FEqU+9if58opCdTg0geXDPZFc5jjMq2MGok62z9Acl+5wqa
	Z0F5p5gWOFjeN+CGX6mOF99rGismSgxWmZ02YVj+JUQCr7RYcNkKY1F2aMEmL5h5ZROfhQLQlsM
	HzIpVXFLt7hrmPXG53E=
X-Received: by 2002:a05:6102:80aa:b0:736:e4c0:cddf with SMTP id
 ada2fe7eead31-7503e05c0e3mr4177154137.6.1785141856027; Mon, 27 Jul 2026
 01:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104920.6493-1-zhuyiming@kuaishou.com> <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
 <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
In-Reply-To: <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jul 2026 10:44:04 +0200
X-Gm-Features: AUfX_mwPft2RaWQR3lusQ0AdXwEBit482lAfq2XN61nxaMw3mFMqLwj4V9u202s
Message-ID: <CAOi1vP9D1RbVkKLg1P+4ia1T+0QiwXp2hxOgnN6u=S7EVU5J3g@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix mds random selection readiness predicate
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: =?UTF-8?B?5pyx5LiA6bij?= <zhuyiming@kuaishou.com>, 
	"xiubli@redhat.com" <xiubli@redhat.com>, "amarkuze@redhat.com" <amarkuze@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 7:59=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Fri, 2026-07-24 at 11:40 +0000, =E6=9C=B1=E4=B8=80=E9=B8=A3 wrote:
> > Adding the current Ceph client maintainer list
> >
> > > On Jul 24, 2026, at 18:49, =E6=9C=B1=E4=B8=80=E9=B8=A3 <zhuyiming@kua=
ishou.com> wrote:
> > >
> > > CEPH_MDS_IS_READY() is parsed so that the ternary expression can
> > > return true for an MDS entry with state 0 when it is not laggy.
> > > This
> > > allows the random selector to choose a down/DNE rank.
> > >
> > > Group the ternary expression under the state check so zero-state
> > > ranks
> > > are not treated as ready.
> > >
> > > Fixes: b38c9eb4757d ("ceph: allow choose random mds")
> > > Cc: stable@vger.kernel.org
> > > Link: https://tracker.ceph.com/issues/78648
> > > Signed-off-by: Yiming Zhu <zhuyiming@kuaishou.com>
> > > ---
> > > fs/ceph/mdsmap.c | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > > index d8e46eb7e5eb..450a4dc9662e 100644
> > > --- a/fs/ceph/mdsmap.c
> > > +++ b/fs/ceph/mdsmap.c
> > > @@ -15,7 +15,7 @@
> > > #include "super.h"
> > >
> > > #define CEPH_MDS_IS_READY(i, ignore_laggy) \
> > > -   (m->m_info[i].state > 0 && ignore_laggy ? true : !m-
> > > >m_info[i].laggy)
> > > +   (m->m_info[i].state > 0 && (ignore_laggy ? true : !m-
> > > >m_info[i].laggy))
> > >
> > > static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool
> > > ignore_laggy)
> > > {
> > >
> > > base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> > > --
> > > 2.55.0
> > >
>
> Good catch.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Applied.

Thanks,

                Ilya
