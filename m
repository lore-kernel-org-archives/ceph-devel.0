Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7382F84F
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833076; cv=pass; b=WvJ16qznRNtQfapdEdribd60bCLKorKlm5G5Q6wHNcvdJFonSiKUulqVr/zrwOHtfW/waYhrDhufbZU8wo6JqyyIr5ikmLZ0QKvOUJkr9amVRh5okU9hm4GKGpvJbdNvVjO4uuWrhFq/PP2zMyQMZIlf/BAl7XDC/uKcxNUbK28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833076; c=relaxed/simple;
	bh=3nQ6I5h9VVjeqBcZY7RBWFb/gCG6Yni3uyEkOzWvfKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oi30eIBhkTO3QI0p5TpYDPPMcJ9vSBAFXDH2ytSFKwoQxlKiDst7RhuWH1ZDnUaKeagCTEl77XjIxLg0UX4HGZv8lQgPxCVkr7Q8JDOpt/40NOfWHw1UqwqOOtN9HDFcKdzXiujx5sN0E70tK5e7j8HGMQazo2k3XrajRY8g+K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyIl2ZaS; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyIl2ZaS"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233bb90317so957710c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 10:04:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770833074; cv=none;
        d=google.com; s=arc-20240605;
        b=ZSDuFtH3Xk6O/L0/fYbS6cSX/N0bPiQ5LAMM2wounv0TvQijXk4YBlDzTBcv382WcO
         18hve6rE2X+v+qNhavDjN/dHpqPnhU7PPqwRADzRsmVpcSM2/sNC1cHmnJtaoRtpiEIS
         lUCrgWniaMzKafkqFbZ9BewFxtDDZLeVsug8e/n4bMRelKdZKIWFq43DaT48roUhx8sx
         JoMeqVEqOaKgyT6JKVmuCfnD48gsxvHxKUONKpk1pc/WTDUV6FYi+y98xCT4/5itgxJd
         DBRUf/SkJOPZNgZsmt2KvBbIv5esz2H/qeOxsE2c2e/RC9k6czGEpnjSdxaEbmJrlkAM
         gXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bNt7dAISbhrxc3KA2vLPUkLvL/dkQCLUHE671jouiOE=;
        fh=X3S2Yh1EMTLD0cxiLrOLnfSLYldD9Mgx3BmHHW/lTwM=;
        b=XLYmGZftp97eTr6wstw+bZr+CvrbHBc1FTZaVyhBRSBLMHaFGSI+JNHuKLom9JS7jN
         2rW3VoVqzyhdxHYvd/eCFSiykK0PFCTsHXI27ZYlyJ0ZS4zs+MLxo+vRn+5GYAM5YxXx
         PrSwCgkENZ3suJ3lnTZ3Skn8PI/tvuHj8DSG8FfDZ89CVsTTUDAp7CTzETmCgsw4pEH3
         wR4Na5eGh8iply9+blaedc58j82XHbniyEUKEDeB2LOhoIm21hWLZW/xW7WYTYzewRG/
         E72ltJaQNtEez03XYXQVEcZghdaOU4BQ2VxRL9QzqtXkcvNIKk+/oQuhoZtCUm6EZSvi
         /59g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833074; x=1771437874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNt7dAISbhrxc3KA2vLPUkLvL/dkQCLUHE671jouiOE=;
        b=UyIl2ZaSh9F7vq379Mtdfdp4ZU2tfI2y9Y1+MWrIsBXWGak7Onkcxy0va6NK71UGGD
         r9gCabh/eomW17dr2IEeUvt26WrqYB8892flGzYK014wgZWD7s15TgPk9tw8X0AIrvXw
         I2h5W2kqwogSuW+C0TT/ka4Ox6O0F599rWQgRf60xW/P4JWFkGzcNwpvV1w52RXTFq9+
         h2DdmymXEaGgq/AzWAWe9l+Nxf5G+WVK2ShAavv0BG7Uol3DZ+i4hQyKySFAodyNfoit
         gIOlHRzhxwFyqTvVkbvh+rModbfQb8AFnM9d4noXU34w4R7e5cCVzgLDBkWGa8mQjbWQ
         lHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833074; x=1771437874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNt7dAISbhrxc3KA2vLPUkLvL/dkQCLUHE671jouiOE=;
        b=dPmjxDPh8gGyUNc2+gOJd31LzNbyCuQoTv5NpPL9Zj2tuR/YnhoX1F5z0Mqzxwi/mW
         KHDvk9VbXKA3tFKeHnDghQ2Q4xpPavgEJjxyd4VWFR0ROJkgyEze/QuqOe25HsNyTyou
         trTC/dBpJLIIzWtWge9Y6449IJmOsr/zdOm7REPshdUJ0HAG2LwJHAzzCcZxBXtUHm7W
         RiIpRUCW+QPSlnh3E8DaL4vjn4bKJxLZMsmTdT5so2JLU3xgdY5tuwbj6vVkhEX0xdQH
         AC1OBWB0dj9g1N3uoYYKt9GBCtHrYDnsqO3U785In4dHSUwngKhe2Yy/BP3iL4gN1HA5
         LkIg==
X-Forwarded-Encrypted: i=1; AJvYcCXsEnwQXgawfL5AbF9Wd4MU7ue6uiHBhxVM8zGAerykQBY2iqvXtos+e5s3TTbZKGQ7s5z+hwRiKuXm@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSHryu3ZHg6m+lrr5NSs84tOSmCNKOW/mGRVY0fqeyds5bjN+
	HVScxJjPaGBruna9s83qcLsjMyYIZZPXQWTGBf8aU9U7FNkTuTx5qpJGGJ2UMN6OQohHjW4xH6t
	IgwR/92MWOjOSkw0oJq7JXb4Cv03YOxNc8XEU
X-Gm-Gg: AZuq6aKxTRMJQtd+jeXs576/vOPTUk/UHoADSTXQ+7TIcWFZfSBJcsRCpAUmbB9tupt
	pKbbm8qm31FT9aR7kfSnwnl7idITzrAaODplf9B+KpyXPOTyG9zhG3T8vPpgGoBVDu+mws1CcXM
	PNM1leIa50x6TNJHfr7/yiwGHU3jVaCe8tLDHWtQbEmO/uptX+HH4oLKvLNbw/cR8lFIXaG/7/w
	iALJaSNiHDqTk9r4AOMvQ6vhZVPYl4VKodjQiVD+60ifE+aejZn/VqkdYRO+OnFGP09m4rDnPCV
	bM/wWJo=
X-Received: by 2002:a05:7022:458f:b0:11f:1e5b:2dd6 with SMTP id
 a92af1059eb24-12723ee2c84mr2791031c88.17.1770833074228; Wed, 11 Feb 2026
 10:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126023055.405401-1-CFSworks@gmail.com> <20260126023055.405401-5-CFSworks@gmail.com>
 <345540f12f8825ebbe067564fbd94bc1966e126b.camel@ibm.com> <CAH5Ym4jsBiEHoyPnJh+dffGzuKuvaF9JOV2WX9_sU6V2NLqXxA@mail.gmail.com>
In-Reply-To: <CAH5Ym4jsBiEHoyPnJh+dffGzuKuvaF9JOV2WX9_sU6V2NLqXxA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 19:04:22 +0100
X-Gm-Features: AZwV_Qh_zyyLPXKYfmFkPo2qMpn_St-xP0woISeA3eR5j5VtVS8eR0jhv5e5aJU
Message-ID: <CAOi1vP_tqdHGhwJSgRU5xbNWYBQ8aUkQuQ33jHknHcuqs7hSCQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ceph: assert writeback loop invariants
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Xiubo Li <xiubli@redhat.com>, 
	Milind Changire <mchangir@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:14=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On Mon, Jan 26, 2026 at 2:54=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >
> > On Sun, 2026-01-25 at 18:30 -0800, Sam Edwards wrote:
> > > If `locked_pages` is zero, the page array must not be allocated:
> > > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > > allocate `pages`, and redundant allocations trigger
> > > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (an=
d
> > > writeback stall) or even a kernel panic. Consequently, the main loop =
in
> > > ceph_writepages_start() assumes that the lifetime of `pages` is confi=
ned
> > > to a single iteration.
> > >
> > > This expectation is currently not clear enough, as evidenced by two
> > > recent patches which fix oopses caused by `pages` persisting into
> > > the next loop iteration:
> > > - "ceph: do not propagate page array emplacement errors as batch erro=
rs"
> > > - "ceph: free page array when ceph_submit_write() fails"
> > >
> > > Use an explicit BUG_ON() at the top of the loop to assert the loop's
> > > preexisting expectation that `pages` is cleaned up by the previous
> > > iteration. Because this is closely tied to `locked_pages`, also make =
it
> > > the previous iteration's responsibility to guarantee its reset, and
> > > verify with a second new BUG_ON() instead of handling (and masking)
> > > failures to do so.
> > >
> > > This patch does not change invariants, behavior, or failure modes.
> > > The added BUG_ON() lines catch conditions that would already trigger =
oops,
> > > but do so earlier for easier debugging and programmer clarity.
> > >
> > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > ---
> > >  fs/ceph/addr.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index cdf11288d6b7..4e392fc70d33 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -1663,7 +1663,9 @@ static int ceph_writepages_start(struct address=
_space *mapping,
> > >               tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_w=
bc.end);
> > >
> > >       while (!has_writeback_done(&ceph_wbc)) {
> > > -             ceph_wbc.locked_pages =3D 0;
> > > +             BUG_ON(ceph_wbc.locked_pages);
> > > +             BUG_ON(ceph_wbc.pages);
> >
> > My complains are still the same. I would like not have BUG_ON() here.
>
> Hey Slava,
>
> I understand your preference, but as discussed before, the BUG_ON() is
> defensive programming to catch an invariant violation earlier than the
> existing BUG_ON() in ceph_allocate_page_array(). If the invariant is
> broken, we'll oops anyway; this just makes the oops happen sooner and
> easier to debug, and reduces cognitive load for future programmers
> trying to understand the loop invariants.

Hi Sam,

I agree with your argument, these BUG_ONs seem on point to me.

Thanks,

                Ilya
