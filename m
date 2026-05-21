Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2F2C21DD
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2026 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325658; cv=pass; b=Y+g7jsdI8KTnaPuNCoqaWfPeMNAmRdXjkn5GNnu+g2FvtdoU35bVk891cg6dtimds/C7AmO2Dpx4Q/ZEALtDC5KQkgFOpE44KLBFL5S0napEr89RxsuMAqtUKmCrcgoAgggNRgedCgBfIYe9IMcHHRfsGVGp7+39glXwqCohpn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325658; c=relaxed/simple;
	bh=6o6OhfFgqhvs6+Xg2vngq/GiNQmqcRy4IaSDQZXFPoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH1zow//HNZ0/wOSG2gzgzz8gO2kJtmEGcw1TASpLg9ViPg73ZA2BCXKZ2n3+5azaNwdQvv64P1s2FLNnVJzOqDodJHyJ+6PYQcqd7CsMThVq4jG5lGhTpL7BF/PIUCjlxaM+uchk9/Q1iypHVXFd0nMBGLFnGWG42hAKMc7tqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avOEfJQk; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avOEfJQk"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b41fdf9de2so39600557b3.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 18:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325655; cv=none;
        d=google.com; s=arc-20240605;
        b=Xs8AxTTzeMdOyU8biZ6zmrKuUXCKGWhVSXGtSDi1sw2YTX0shT7CWs8uwFxEr7PnCt
         ZwbDnTHOeF1JueIPgAszSCTHUZE805wkYdM9Od+Ma4zYhWiqCzgWhEyI/gZHK9IkoVyl
         R0fllECiQUh3EZ0dwtu9iP/Xwueip+n+DCr9fi3uW0Cx4sYAjaYTayWui1XCRKPWIBqG
         9mCFlh6GJc2FuSkA1lpDjh93nMr5TG8tnGqAwenX98zj0WquqNWqPr/1xshhHko7IKDs
         glkwnWNeGsPB4tmJvAc4T5t9SBRrmLZJlLUP5jsYhAOVLI/HUhW8pn4ZWvc7qP7fDrwS
         A0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        fh=pn4J0ZSLUIPZ54URCXxo37R4SvqncX5ffsda4z5lA/w=;
        b=AjCXA7AQNp7F72hfNSHGvNUl4zDYGzvno5bE6MyMLE9KqA2ne78+6KdMrEBe8xQfUo
         WU4Y6IaxIjtgtRZvY4IuLz98sldSG2kMYOMnImtbBj+0icCcAEMUeAgC5vivunt4Zypz
         9qM0xNdgu7czU4aTRNU4NnJ3KfFxpV4Ev+E62Y6J1RSspqtK8cToFnrW8YPajCpMFTRz
         FXyhbKDvNvVtEDt10w4d8g2QncrB8/CA6oltK/BPUax6Z9S02Y1LmAmUsN990vU4jLjM
         L9s5MQuZwOuQv9HrOdW/hcPtjm9iN85KLdx1EWcDKsn7Y4DupM8XOK64kSn0gg7N/SM5
         Wosw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325655; x=1779930455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        b=avOEfJQk9XPK2nssdDJ5nZCRUosqu0jqYFCpAwPRnWl0C12aO1jsWg708ei2jymQB/
         +pKxukhxaH+rBE5ZT8hiVaah38/9ReQPspWVqX1BgUoJOsQbpehJOQbQRFOM3BqwLpgw
         sbYtFGcsVg7tXjTSwukM4dIYa6c2QJnGx8wezwh+LLrnlGZgY2IhdyMKIkmbztm6J6bh
         i2nXsAIbVOSsFrqvPAf4cc4uCmsCeM8FWFO9sKdam9G3pRFOy94brZx6DL9nt/M/0Wcs
         Oio1Ln7nnYK4RRT6rUv4yk2kNBO/hsi40w33xg2PCtwd0N5Mn9WANJBGe1HtFpAla8Eg
         NtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325655; x=1779930455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/c0mGkmQo08jz/C9LTSuPhAbp4719+rYek+3orkehRo=;
        b=kB5v9VDMC1AdD9J4mywHFN/jNq8MkpPkDq7m/nAg7ltPW4tOQBmYXlx/YoODWfpSox
         bm/8giPBwV1SCi8U0WJjwUBVoUq7W7Ju9wxEEqAJID7SgojRBi9tLTDN3s5+AV9GqKSo
         CCGViGBGQjAcgShGdIeb20h/bfSGnfGahBAMxjwe1uO2NK14bSnsl61dVAE3xuQYXHOo
         ITalU/MulWXd+KjJ3ebJYBhRVE6hgbCjvLn3bGQ/GO3dGn/if7rhSoj8dFuz0SSvK1Cp
         DsHDD0GxaVRt85o/dL1bxjnzjYoitS4R86zDt7YEWyxS5upVkhQWL8IOZq6TAR9FuM33
         DwFg==
X-Forwarded-Encrypted: i=1; AFNElJ8Gdf4bjZe4N8DiUJxQyTeMUcX5Cls9hIvqBUB1H9gmzxeze8LeB3KTcUYS2dKEMiM9LLBpkxVReBC7@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmKbAYt0QoG4DT/Jpm4n0RFBxes6YBRdTWvGEynv5mO543zYh
	OGFnmNtiPYYbSBq4Dg92nhqZJJqE0H6txGqHvTKcxUcZoSfXZvzZdu+DGUPyJpQTB2hia1gg5lb
	8OT285T5UIWn8H9tamSL2K2uTwW2jZ1c=
X-Gm-Gg: Acq92OEj8BUPxi272Rd+PDxJk56A0xOoKzRT8f2ztiuMmSRL27+3i6p60CY1fbk+R9X
	PtuMY6bYn98n05IOiVocBAiD0mxeWV9nE6bMK6XxOdVDAZHCdrggO/vHWypH75EESr5NwWptQAb
	k5bD5QXf6vXO4qfa8GmOk2Xm5l92n1WMvtGWQI/sGgDgIaZblqNyEhbY/QgIrh0FD3hU27oKPD1
	p5ft4GUvi97o5j6J4njBXzSdGuVhG60AlBoXpEhOOoqKbWuwEwcUQXaIyuD1WOwlw1VR/0lY15h
	jJKvKeUh0+cqyiBDhC/LD5jABWJ8VPMjNC7k6i87j6Td7E5/zMPRiJK38g==
X-Received: by 2002:a05:690c:23c3:b0:7b7:1753:1bd5 with SMTP id
 00721157ae682-7d20a2bd737mr9515747b3.7.1779325655215; Wed, 20 May 2026
 18:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519113017.1851462-1-michael.bommarito@gmail.com> <6176a49943969a3948b21bfa98c98aa69c0b6c16.camel@ibm.com>
In-Reply-To: <6176a49943969a3948b21bfa98c98aa69c0b6c16.camel@ibm.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 20 May 2026 21:07:24 -0400
X-Gm-Features: AVHnY4JjLe5tM-z0l0ct9MDwLv5s0xybADAO1684DUHRrmgfjftmm_3pCPqfb04
Message-ID: <CAJJ9bXzUcYt5hT8ejxbFW0QwwHdQS=N_RmG8ZnU07=E2_L_P1g@mail.gmail.com>
Subject: Re: [PATCH] ceph: bound num_split_inos and num_split_realms in ceph_handle_snap()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:47=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> I am not completely sure that it's good to mention it. Do we have final p=
olicy
> accepted?

Yup, it's now required to disclose:
https://docs.kernel.org/process/coding-assistants.html

> We introduced the self-tests recently. And you are welcomed to add KUnit =
based
> unit-tests.

My bad.  I can add one with a patch set in v2.

> I don't where patch uses i variable. What is the point of this change?
> ...
> I am not sure that we really need Claude AI generated comment here. Maybe=
, some
> short comment is written by human being makes sense. But, currently, I pr=
efer
> completely remove this comment.

Sure, agree.

> > +     split_inos_bytes   =3D array_size(num_split_inos,   sizeof(u64));
>
> What is the point of this alignment? Claude AI like this? Please, double =
check
> the generated code and follow to Linux kernel style. Have you run the
> checkpatch.pl script for the patch?
>

That's all my whitespace, not Claude :)

And checkpatch.pl does ret 0 with no warnings/errors.  But you're
right that it's not house style, I'll fix it.

>
> Could it be possible that split_inos_bytes or split_realms_bytes are less=
er than
> SIZE_MAX but we still could have overflow?
>
> > +         check_add_overflow(split_inos_bytes, split_realms_bytes,
> > +                            &split_bytes) ||
>
> All this check looks like a good candidate for static inline function.
>
> > +         (size_t)(e - p) < split_bytes)
>
> The whole check looks complicated and confusing. It's really easy to miss
> something in the logic. I believe that this code requires some refactorin=
g. I am
> not very like the pattern of calculating the split_bytes in the previous
> condition check.
>
> What about this?
>
>   split_bytes =3D size_add(split_inos_bytes, split_realms_bytes);
>   if (split_bytes =3D=3D SIZE_MAX || (size_t)(e - p) < split_bytes)
>       goto bad;

Yours does looks more intuitive.  I'll refactor those and inline the
check in v2 tomorrow morning.

Thanks,
Mike
