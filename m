Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945DB67E
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645433; cv=pass; b=nvQi+GjFbiUROtemJbZL1US4rI4QWEQA1bmaOMdoGyVvOpbJrMA5fKnYLcXr6KTSjGC0rzR0BaY6iAVnjzqUCVcGCnDromz3o1g7pVLteajMycrIDHZn/lr/qSKgcD2PWvPBPVruh7fB4CR9HX4+HFHEtKM9qYBy2eEbFBXPb/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645433; c=relaxed/simple;
	bh=CRea/sHGoU31RRDtXpjn0kXbvznYwwDits66631/iI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxXmHrM6zECch4kWBIphIcMbSnRwN3qrYQ0WzryUtJ1IjZx1jqU1zPEl3qVSK6xFSKQ9XdyimQoTeLvGfOFCSOqPeYb4pQJC5CO2IkYpqaaWaZYZMeSaLdwvjl5qMs80A52sSNT5tjMmRd9WJkQdvvP7zr9T6UEnohdU9EKzrUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ZwhSgu; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ZwhSgu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4327790c4e9so252666f8f.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 16:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769645430; cv=none;
        d=google.com; s=arc-20240605;
        b=DsYqyo8LWxNHUx1HiGv7Hfx5hrVLJitgpmQAxR5unUJJYPWiw+4tXrZK9gyMlxo1B7
         1l07MA00Qx4QCe2xzs0PJh4AWEKteFBHtf7U2t0kB5puGTak91A10pHWN4t3UXATe6uf
         IqxCF9wtlLB25RP5qJRIhVjLVFhGYPa7pQJ8P1CIrTRs6F6Y1/VqFh5L8rxX+4CSNkaI
         V+d5PaQvxyD6Tps8g8j8QVW2lNgx4u1f0xDf28qp7zz5U5fSbg9kaRXX2joKQQKvf84l
         GM/rlW++1RCYYe5QJHZrhGS/J4BmMedt/bWf8wMSB0LkYXi9JqPv6mudmH0fBDt2pSF9
         vJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        fh=9yc/riKyXzFbfyXWJCp9Hwpw2bTbnymiFOCsMs1vrfU=;
        b=XysB9ume+1+qqaXe8w4tHK219AcULo/iy50sLfPOrcGFmPlNGM6TwuDXnomwi+7pTN
         8CiuQCUOS2WnZ1fYVkaVoFi/b28s3ot7sgONZX/SHTNGleOn9sBoFYVP+t2WZH8QwYTc
         z1/QyYueKy3Kf5MEOJSZCdPzNB9fqq4jv8LRMpfY5IVqME1MpQgFCVCgVZDo5tQTymO4
         4xQFhD4VLIRSmNlI+9QGr4nj4Fx+oGBDzkhkuLx7zwcr5YiBkrgWEcrVnj+2cEDHBve3
         Cr9UFEl3X57Wx2BjaL3pU/ln/8a7q4fiA8H09+lcuI9eAC9eJ7vNwcjDUZCyc4WiWlap
         ggCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769645430; x=1770250230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        b=R1ZwhSgukAbK11t8YuLgthPzrOe0KGWQcNzWQXg9hTRAaoc57OM5Rn6kUaUnMbaE1w
         ya8GN8L7p1yaF9w5d4kgIOwRw9SFyUnDIojLvHcjqA3Tf7JreFNBYO4qsEgLcgvPxG3l
         mtkyog+60vKQshjDziB0XHtgQFOhPQzhXGEmzLskNnoq+6tnfuWearO94+QlKo+n+Njm
         WuV/kl8Ijye2mJfEmNJgg8arvdHzQZgxFQXgaBBex9MFqlDJn70phWH3GoqiLpSF7fFB
         6+Ha3asIcuGOSPO4Jxw6H8krt8CpNGuZGmp+UksvGN3HJqwJZ+sM9N//Eht5l8wlfSAY
         jScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769645430; x=1770250230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqJ0WvFK3b9iPhiYy6g2qTs0iQN4YJvVeIc2JBueXkU=;
        b=VDTIHH684W36lIG6KpC2dUihHwE2sG0Pl66ujuhiznlDFwCKgdBFrdKzq3teFOmECg
         ei+wGjczA4AuIFTEOE83qxsHp01iRbnvR6QM9bvn8RjJI2Yvo+v0l4ixBAA75LGfHwVB
         ZYItVAgPF9RJk6fxq/xbGh4DsLLQbVADvJk2kWSBUxjvDsJrkWgONM6YXcF2Bg9g9jXo
         yV3XZL6jNBAsZE5ICIRBiA1kTjvYeNb3oJGn/GvJfFiXYbmanDeZpA7HZEppULWS2AGq
         SKScqx05ORw5WW1kkcMKhNQXvA6Fj5uPJOVDce+xyhzDVwiGkz35kfrmZkwn3aQ7sxTW
         Gsuw==
X-Forwarded-Encrypted: i=1; AJvYcCUsTzyBjcBzcyRnM1aJI6FQpLUETSGccceHt99tOj+d/TJ6W/YVZ8AQZfoOznAuhQn8aUzYDZKEX3dn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8G/JJ+0bdkyc90else9K6OXV3D9rtz221OptcoDFEWgWFsTk4
	BG1QiNjdfD2Krn2eqLRe/oJp+LKvvjD0BDwvw3vgBgu8dIcR9jOjeLIJHCuBqYiBSSagl+DglhH
	KIsTSekSIW4V+OBx1sg57N/zx0HpsfIM=
X-Gm-Gg: AZuq6aJmrwnb3nijIlcvFeTK138SpPFs7Ovf2gxO5yeDiV6fNhlgYNFREsml2liIYl3
	1uCjmDwc7Qm8xh5TT1AHAigtqrP+Giy0J8pEXKdTpyTKdQcCwhzH4EuJfsRZykeyiDTiI5Ws84X
	MiTVm+b3TZb2zgQAhNlJjLf656r1Lu9iEwAZqrs0Hok4HNMgdzvR7aYgMn/UQXSd3irjP4Snf6B
	SncfTw5UQZkPJcOdcvlo04DrJn6yexF6rKJQjDbo5nmXV388nlK7UT1iPiGKb19C5qwpP88qeJX
	cXhT3+G8KqOYjJEkxFJTi4Jh/uc=
X-Received: by 2002:a05:6000:2310:b0:432:ca6c:7b03 with SMTP id
 ffacd0b85a97d-435dd073c8dmr10943655f8f.26.1769645429765; Wed, 28 Jan 2026
 16:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
 <f351a9235ec9da785af840beb28db0513aa66ba6.camel@ibm.com>
In-Reply-To: <f351a9235ec9da785af840beb28db0513aa66ba6.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 28 Jan 2026 16:10:18 -0800
X-Gm-Features: AZwV_QguMmRDCrhJq0NR6nex3VxA2VLwfomnVytdVwhjNkrsdUh2ngEaeAZktgA
Message-ID: <CAH5Ym4hUiVHgHQQA15r2ZRaq8KNg4xLs2Ub5fFs1FaPOcgHZbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Milind Changire <mchangir@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:51=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-01-25 at 18:27 -0800, Sam Edwards wrote:
> > If `locked_pages` is zero, the page array must not be allocated:
> > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > allocate `pages`, and redundant allocations trigger
> > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> > writeback stall) or even a kernel panic. Consequently, the main loop in
> > ceph_writepages_start() assumes that the lifetime of `pages` is confine=
d
> > to a single iteration.
> >
> > The ceph_submit_write() function claims ownership of the page array on
> > success (it is later freed when the write concludes). But failures only
> > redirty/unlock the pages and fail to free the array, making the failure
> > case in ceph_submit_write() fatal.
> >
> > Free the page array (and reset locked_pages) in ceph_submit_write()'s
> > error-handling 'if' block so that the caller's invariant (that the arra=
y
> > does not remain in ceph_wbc) is maintained unconditionally, making
> > failures in ceph_submit_write() recoverable as originally intended.
> >
> > Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..c3e0b5b429ea 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapp=
ing,
> >                       unlock_page(page);
> >               }
> >
> > +             if (ceph_wbc->from_pool) {
> > +                     mempool_free(ceph_wbc->pages, ceph_wb_pagevec_poo=
l);
> > +                     ceph_wbc->from_pool =3D false;
> > +             } else
> > +                     kfree(ceph_wbc->pages);
> > +             ceph_wbc->pages =3D NULL;
> > +             ceph_wbc->locked_pages =3D 0;
> > +
>
>
> I see the completely identical code pattern in two patches:

The second patch only contains that pattern because it is moving it to
a separate function, patch 2 isn't introducing any *new* code.

>
> +       if (ceph_wbc->from_pool) {
> +               mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
> +               ceph_wbc->from_pool =3D false;
> +       } else
> +               kfree(ceph_wbc->pages);
> +       ceph_wbc->pages =3D NULL;
> +       ceph_wbc->locked_pages =3D 0;
>
> I believe we need to introduce the inline function that can be reused in =
two
> places.

Patch 2 is introducing that inline function as requested -- but that
function is not actually used in two places: for now (in this series),
it is only split out for better readability.

These patches are organized like this because of kernel development
norms: bugfixes intended for stable (such as this patch) should
consist of minimal, backport-friendly and correctness-focused changes.
Moving existing code to a new function is a separate change and does
not constitute a bugfix, so it needs to go in its own patch that isn't
Cc: stable.

Cheers,
Sam

>
> Thanks,
> Slava.
>
> >               ceph_osdc_put_request(req);
> >               return -EIO;
> >       }
