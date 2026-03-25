Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AF3CF05B
	for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439715; cv=pass; b=TEJBrkjxO7LyxA13KVUHdlIu15E6MFRgiKE9c9sKeOnITvXwVhjhrTxnFcqTazlJuFk9YDamiMPnLq7HCRQnWVx3qA67Y0t9hSxwqXRGHz3oDLU+PvWq75JYKx92HJU7SDj7T7haE/h3xSkPtYc69hLgiLInHwMDq5ftdmdv6ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439715; c=relaxed/simple;
	bh=/4W9RE8z21QjkAb0jO3bHGuVegorEkbX+UlniHVigxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHsQMQu2fzZBR4GEru40MXQDJ020rU1cctR2OqW8FZXrW9HBFS/gxssRRh13y1q1JwIOwip+xpqx+n4YJbd+FEuqk5tq+urrsNph12uE6SO8jiC3PB9VTfh8Zu6deRg7MnDcGFuHcq2SrsKKLbVnZwAy8+iCVqPG5lQ/zI1Loos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+x0XmLf; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+x0XmLf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0c955a481so397532eec.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 Mar 2026 04:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774439712; cv=none;
        d=google.com; s=arc-20240605;
        b=LwfVBJT8O571M8LdKnXuEbAKytE/OgigeoubSPsa55PqF4UJsBmrqVrNlyyvSnqHIb
         qpfJbwT3ttOh+1pWunNthM2iwC7Vxo8SLfuob2s17kr0L3EgjvyIdWwd6dX0jP9Dy8c+
         w32vCLTCwWRTrtXk8NoyLRGIrgmDDQi6BkopMaWzD/O9Or8S06L+F+1leR6Alu0VDuSY
         CpE0oOGbuMaDlncUgGSURtK+63sU3i+3dHAdHWhQBvDlglkwlwhO/IhcuXk0zUbg4//F
         vgLWaXFCnTjhPgrlbdg+7RcJXJamoe3ZeetCq8mIAtshACiKlhbh5o5+RWXQJjMFZYHU
         PhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        fh=5f47nJsS/qaAIHqsz/glzef1Hc3/TavoWHMxlChrRZw=;
        b=h99j1z89AGSTk2UHNUKAJx9JdB/s71kK3TIf0wrsIZyFAU2NOmAuN/KsTAhwLGJPfy
         e98RpqNA1G3M/S6P8BB0/H7jW5azv1K25UOCQzBAGlBzYsIvf7gSUVyMhRoW/UGpsMyA
         Au7Vt2QhBKkMzaxREjwMf5GF5hwrTUhI0c1M4g5536nVV1bFYOzSXQbF4edeNhxGk/Og
         fxRNkHYaxatKpguuTI5BQruU3TnGQGOiz1S68OeeVwgAeX1+RiwtJF8fD6ipQ+1Johb/
         d4Awn8iw7EzR8rUsjXpBVt5UwEChtxPI5dId9E7xzkAabFhJV20eRuRQ1ynclKPyXQZj
         qCSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439712; x=1775044512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        b=q+x0XmLfUxENP+VpFR9OWfQphoggsulItHTzscjxKkf53ROnFeRtoP/fCzUolSIAGk
         a+E8gGXFkSZS9RXMR6CL89/OkrQ9e22Yoxk3DVh6cx7zw+nLNnTLxMvIgN4M0Zd3uC9k
         SFI6lzNOi+nwzYnCDXkTsMN/wsRLDFHovEnVwrJxYg4lQ/AXI79gwItZnel3bUe/I7YK
         SgyCrnQcLzo1XuEShNlZPcNzxECxwiRvIhNrCKLkeDnQ2MwXbHeJpQdFHI/6mSlNUl7J
         YqQCOGfyH9kHThOOBY7xHQUIx04ixA7W4MjNTgxchPuw6bwoKhqpFz62eEus1FZabt1c
         Mraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439712; x=1775044512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        b=Ndb+5KWX4BQYR25G+UvebwkaWcR6FgD/JSchlob7LovT8HW4mT93ZwEEvcohIg6ycb
         bjqen1bj5ePWEJn0YpE/o1Wwgoiq0WifIRQUpt9efj0KUM7kpBV1OiJikA+l1B96zhFo
         /r6bjSvd/jSi69buRl94suWun27y3u5Pu8xDbpH78P+NZ0Wkk+k7v0tX2LGuxm4traaS
         R/BjsM/CsRL+pLHCGD1XSxTLHGuuSb5WPdHXlU8H6rV+SsInjJYtwC3F9Nvp+tXqtIzG
         j5ckOVxC7AXSEp7bYc+5KBWB4i006MWyeoDUsC+9R9rZAwGH0y0AgRmo/Hb6HjdJC3YX
         abkw==
X-Forwarded-Encrypted: i=1; AJvYcCXPjoLUIlGPv1z9CwgHZFSN8CPicOpgDIRz0595bngw5fM4ZSkzEiy+4sDLkuMOOIRA+7F1Zd0bNXse@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOra1fwl5EIZ/x3gj3LMlgDrJOFa8z33hPS79FKIKdc/j1Q+8
	/HH8asqk1KqxFnmj9AuFhUEuu49+HCk/jzTJp6F/U2fbezsOIUhGa1TKX+tHC5TkZUQFV5s8PFu
	zRtWKiPMzhc79nos26Q7vgZmQSjl8kUw=
X-Gm-Gg: ATEYQzxvOvj6daxFz3hGMkEURo/bD8O/1MxLRmilkaRJUDZiTKe7MGG4j7qtXspX9Jl
	qL/YN1EaOkrBKADDjbAANKdYQQKDaCy4/mDEFOCrqWVcqbf5VGTqpjDisvGbqKgxOcL7E+NSamc
	r+OvCcKRiqCEfxugyrFz0u8zcZY39Av6KwN87bb4Ap53ZnVH9+qluDBpUpKHxpNqzlrkYXOupOb
	sBIWOA1l3b9GavXZ5F1OKziwVrpMdhWwKqbYHUVJ+48/m0GdLGT6pznz9DeXfpMZmpAO3FUmKMj
	Xel2ga4=
X-Received: by 2002:a05:7022:78e:b0:11b:9b9f:426b with SMTP id
 a92af1059eb24-12a96ed357fmr1626314c88.20.1774439712218; Wed, 25 Mar 2026
 04:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318023733.116789-1-CFSworks@gmail.com> <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
 <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
In-Reply-To: <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 25 Mar 2026 12:55:00 +0100
X-Gm-Features: AaiRm52dih7Y_7oYw7_JM8EEfbKO3eAvCioYFA-s2Ei8UUpBTgqfSuvyd4F9rTw
Message-ID: <CAOi1vP82GXftssgpm3VQgcQ5N9yQV+eYN8sdswJtMhy-NETYRA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 3:56=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On Wed, Mar 18, 2026 at 12:42=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> > ...
>
> Hi Slava,
>
> > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> This looks like you gave "for future reference" feedback and provided
> a R-b tag for the current version of the patch; is that it? Or is this
> a tag to roll forward to a v3 with your feedback applied?

Hi Sam,

The patch was applied as is last week:

https://github.com/ceph/ceph-client/commit/681a6d350eff104294bf8aceebb627a0=
8c037298

Thanks,

                Ilya
