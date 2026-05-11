Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3733B47C1
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 08:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489115; cv=pass; b=i408u9vMKsfzXmwSyCbgtLtRGul1qhRLB/SJiKOwmbqO+FaHKBSnLtNl0JwtlNF8A0wKloyRVGd+nNUM9uTKjjncWsZ78xdPFgHV1EtEL6Auyqr72XxQNAmi4Tr0kXxUWYdeq7l+ndD9oFqNMZksVU2mv1B8ijCSO8ph5qTOj6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489115; c=relaxed/simple;
	bh=Rx7rIbY6dXgfL2VSK8Qg3DdiS0eolbMp+XIm/gYF0YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8BTH+5zpk4k0ZWxTkvJkS0OC9RpOWUhFMPLRis6epKTmD/38lHyOmbT3dcQAcZXUIMhmqKJP892HowbXyvsxYZP/7SVZnyBEuT0COM82wsZAjta1mtIZdWQhCSyrw7wlPy7kkRMK7qQH3mP5PpyvCVRy9EVT62xI7L2GL7rdXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LibbWWXZ; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LibbWWXZ"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95f2b0bd920so1283425241.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 01:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778489112; cv=none;
        d=google.com; s=arc-20240605;
        b=LM6qiX3M16kJoN57n9zasMna/wxnComnn4Il1SAfj9dOzNeKlz47ObnjRk42zt2iZb
         oXbtPClRAErXTVqzY3iDtDJlB8bK8Wbv4YJjezLvwAAHm2XHtzntoAcsrfTzM0sJm93q
         JP/eofWcYCjo66qJ0VavRCC87KPHZQmsxClT6WvbV2hiNFT2/pdu8mEKWinBQmVKff1Z
         LrF8rEoEc48buH4z3MvmeYLFwygCwno5FYp43kJTqW3ha38UiZzA09Qk8T2QQjm2ifZs
         dwqum26IXZF0401Y3fK7d3eAco9O5FxxehNcpApcCPSeWull1NZFny5aRRSYTkENE+s3
         TtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xOWt62nhgRQccxVM9V5X76aJFWsTZgXwnNDkAsW85b8=;
        fh=8Ad/ORz8wom+5ByP05fzVU2znSuk5kESUJWisHIp/KA=;
        b=F5suf5yCRD6L2EAk/tR7g2kOK2CHTRJY3AQCRKw275Bf1Qw5emZnbSokefvcbJwXxK
         54fAm75eCZXa+6BrObAyJrWl64x5VkfzLC+vmuQBiR9+RPemSdaH5ohC7Abcp4ZgdGcC
         RqG5Iia+9lEx0h0a+hrB7xKNKKa1ekE+l6K3M8j/DzIeEgPlUS8w2oPzJmjSA+ramSKk
         myZDLzZHiyKJNUXSSE+oMbGJqXGE8OierXl8wUr3wZ0WI7IJem8TmUNarr/z55SUQLYw
         VNOz4k27x6kItaLu+aYucOU1TyBb93H3UjTUZmK8KmrBJcXIt1FuAfe7V+nOyq7GtqHy
         VLfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489112; x=1779093912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOWt62nhgRQccxVM9V5X76aJFWsTZgXwnNDkAsW85b8=;
        b=LibbWWXZkFsIOsISuOiTSgS17TaOk7+zsZHHnXDnaQMD4iPkHqKIy0M/q8HOz+t9aS
         Lj2x0LJ70WROoKY1DeUYLDj+VvBPNUP7SYtlgrbLgcbMC3d6zYGE3fdJ9YqhgHKBrqsI
         eCtFEJKlCNYzgqFsBuFESs6n83mRX2Wta82jvbNNBnIyjK6FJ0W1Lb8dA+TWLsjuL4qM
         QpEtCR1MO68Rv/mJO7YuGokdNezPqG9BT6Htqxt20TwMtgZpSpfPqFH4CnYKmz3RoBwG
         4qEpK/H2CcobnNPitKsSH89EZ9PooA4dDcZlXB/unVD3vDCsdtU8aKkzYic+MD8M3KxL
         jKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489112; x=1779093912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOWt62nhgRQccxVM9V5X76aJFWsTZgXwnNDkAsW85b8=;
        b=qBUDUhvau3RVU+TbPQOOY4c06Ajm4AERNr7bYeAnk5m69/IrvOMFuUDuj8QgWccuz2
         r2E/WnzDovmuI/iKkkUyr9YvoCplczUnILE+a8QHUlmw393qjUDkfagm8ylmf3LmxbWa
         7ZzY0RdKbN+m/QrYJjT27BtuA2yPaq2cP2tFeKrP0KGNqaEl3Ba0a32AtVFpNk1MKZpf
         SrQP+OYAydOX9aSlfUbRu6dOG/00AUxzC4DHpzjhZniBGPfiLNiRjCl3yeZOa9GeNtPV
         HRgHk1PBLnJdorcDnM7FhlREmZG0lYUZ+8PKkm1dYcdzgpe+lxN0NRd6u/pu61Eyzzdj
         d2EA==
X-Forwarded-Encrypted: i=1; AFNElJ/0a9UAtJpjKjjRuaro4e8LjFjoa7aZBk8fAGRfbgSBxX9OiV4NEO7jz/Lcem8XeA1Nz2CxxSapSmkv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JyVwLulqzJ/ww4qV6HDJfwUw560EO2dm1D8aMuLT03ZRstHH
	om/1586LFPNvrjiQNYuz0+OKL7wCTa9zgvZbewcydKdaoB05GE3eo4VBD53Tlsh+EFBNQJQOukQ
	bdA4CaO5R4AbHx5By5Le6JiL67jdNLgc=
X-Gm-Gg: Acq92OEmWJiM5DTnGWNCLAhu2l5WD+u9CSobHeMwt3IYl1Y/6YLfJ0ZzHCjgXJ5nzXY
	IIyEod2UqZ/OMFeUgucfWW2eDcXEGjIEH8iQC5Udna1zwUwFX3Ra3gqU1JCzRGqiz4QqOYCDbjb
	SK2R6htGp91mWLQ1K5YJ9LElnVsLIecbGAa5MMYMzz0cVVVuJi+DAFfY3QR146TRCTQ7MxFG9Dz
	gUki41glKLCbGSsWNkjCRfjiVKsZ81mLe1OKVWKkg+cO3FtTj6N0a44HgpNMcfXhcYCy+0Y7Crd
	z1nXS63f5lRM/P6fkg==
X-Received: by 2002:a05:6102:3754:b0:633:4d1a:65f5 with SMTP id
 ada2fe7eead31-6334d29b72fmr1329884137.10.1778489112264; Mon, 11 May 2026
 01:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504155450.1892761-1-hristo@venev.name> <f6c8cf0d2e330dd7e41ade8574507d4d56aa71fb.camel@ibm.com>
In-Reply-To: <f6c8cf0d2e330dd7e41ade8574507d4d56aa71fb.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 May 2026 10:45:00 +0200
X-Gm-Features: AVHnY4KBubsJ6qDn2ELfMBCZEznggVBAJTyXr2yrwijzWKxaVWTjhuy6UNr-LMw
Message-ID: <CAOi1vP8umAAhueA7OjwFHm0qLxvf3SneS98MHP0dmwkqGan9wg@mail.gmail.com>
Subject: Re: [PATCH] ceph: put folios not suitable for writeback
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "hristo@venev.name" <hristo@venev.name>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 8:21=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Mon, 2026-05-04 at 18:54 +0300, Hristo Venev wrote:
> > The batch holds references to the folios (see `filemap_get_folios`,
> > `folio_batch_release`), so we need to `folio_put` the folios we remove.
> >
> > Tested on v6.18.
>
> I was able to reproduce the memory pressure issue on 7.0 kernel version b=
y
> running auto group of xfstests. This patch has fixed the issue.
>
> >
> > Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__tracker.ce=
ph.com_issues_74156&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8N=
Ju1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DfGECVh9OIwNNNybcbztAqVFqMJAoEKTmmjgXwIMX=
68N6Wb2QRdPxKMBD_o2dofyF&s=3D1oTu2pJ63znGTgZpIoo3RCvGPa50wY4lnL3paxdzb_M&e=
=3D
> > Signed-off-by: Hristo Venev <hristo@venev.name>
> > ---
> >  fs/ceph/addr.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 1454760332ff..0a86f672cc09 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1336,6 +1336,7 @@ void ceph_process_folio_batch(struct address_spac=
e *mapping,
> >                                                 ceph_wbc, folio);
> >               if (rc =3D=3D -ENODATA) {
> >                       folio_unlock(folio);
> > +                     folio_put(folio);
> >                       ceph_wbc->fbatch.folios[i] =3D NULL;
> >                       continue;
> >               } else if (rc =3D=3D -E2BIG) {
> > @@ -1346,6 +1347,7 @@ void ceph_process_folio_batch(struct address_spac=
e *mapping,
> >               if (!folio_clear_dirty_for_io(folio)) {
> >                       doutc(cl, "%p !folio_clear_dirty_for_io\n", folio=
);
> >                       folio_unlock(folio);
> > +                     folio_put(folio);
> >                       ceph_wbc->fbatch.folios[i] =3D NULL;
> >                       continue;
> >               }
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> Thanks,
> Slava.

Applied.

Thanks,

                Ilya
