Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6C34A791
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623489; cv=pass; b=FRQAcWFRsbfyfvqNnqW2ipQrvj8bNZX6s1uxb96knub3JAlzw1qFt19qebNo6OhWDVc9bwnR/n066mDGdAyedkPqtHtx4Vp0eEr2S6BYEyr3nzkSu+/ZFUi/OSOUeGUevdF5rW0CJxbyl2oSRnpPQrEjpblgkoxcVjQuYQrsOBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623489; c=relaxed/simple;
	bh=7UP2eMaUt9ObpltR/8GQki4dvd5tCj3SIcHzWrt9T94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEpAi16UlZ2TgN4uF5Ezp4mCxIsvUBaULAnO+J1mtbyrcBTtMghrG2s1wW9g2ct56+xQOLmgrYdyn8igoQM856A4yjFAZs03Rg2m2MNU4K200dmtX1+6WCEfiS6+lODyjBaSjsuPyAPMkugpbcFzjPIsebuFmtmVpkNyKe1lAm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6nPRXqt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q72fLyy7; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6nPRXqt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q72fLyy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786623487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qUHFWUDQz/MEraJh+J1O/f5gfgcsCAk1KSe7ywJpi8=;
	b=C6nPRXqthNeIX6G2wjfQVKswwhhI+s3HFbmoUUEi5fUciZAusKIbXPwL409YzyMxyE6PgA
	h/PyWiyPFUNgB37HSaIuMbNgHbwgn7akr/RIG4wrfNNUHtxDOve+MXXcGhG1FsuKv8Wbtz
	JjDirlwNhpSUhX6Q21j9pECSGt6TWN0=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-u65J_mlPMdK-mRXIfyXfvg-1; Thu, 13 Aug 2026 08:18:06 -0400
X-MC-Unique: u65J_mlPMdK-mRXIfyXfvg-1
X-Mimecast-MFC-AGG-ID: u65J_mlPMdK-mRXIfyXfvg_1786623485
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7382fc429f6so1656720137.2
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786623485; cv=none;
        d=google.com; s=arc-20260327;
        b=NFdUasLc6F36gmrn5v4JerAU7tJfLzOf8ASvXfmayLmdM7QKpUw5K3x81zC1LH8Q7V
         mOoe42nCIwE8J9wTqZ1OjGj/2aPXqR9HR1yNQPt7iUwUrBaG9eejbrPZACzkZtDB+77M
         21kL50HOUIh9kq6CMgRhuiRTUiCSPPFYVhZdrYHMPb+DGdT+x/nUhJc/zUuZgCkG+iwA
         VFd/AfTi6pReKtPyRX1NPW0D6cytIBUIgSSPDU+/Yx8F4LizCRRHyIpmcQnQdVt19yD+
         Op4RpNXYYNGAPqAEZQPkGRLkekHaxi5h93XREQc+kvDx7DZANNBBaUMFd2B0uPzoLUu/
         +b/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qUHFWUDQz/MEraJh+J1O/f5gfgcsCAk1KSe7ywJpi8=;
        fh=LpwjGZqwoI4MLFK1qKLtetBXvVkLl/nQSD1pa0JPWZs=;
        b=JIjUznrAzpVmonbyXniLFd2bYz6nmG+7aHSbq2f0wA5qZ5+o1jQYuoVocI9mkTjtHX
         LnXmQQt2V8i2KSLqHsCCpaa6JnbEcAiVjQJM5P0DXtr7ojEC4+dk6spCMaveiQyY+XuB
         PZZI+qBll3zNoo7rmS0XJKCnGJibsDYPfwcbQOq2Z3UCF4ZJqqjDXY6Mn49Z9u2Puvk2
         MhJlgPXgxM6smpQeShnpaqpuO/fqXtButZzZi3md+UYF2m4zByDv9zThsvrRBVVvJtHb
         50rT+mHXrW3BaRCMR/RnlH9rx0hli5ySOttqK6eWojc0SAtKw+dFz231azQoQM4tcrVg
         Neww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786623485; x=1787228285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qUHFWUDQz/MEraJh+J1O/f5gfgcsCAk1KSe7ywJpi8=;
        b=Q72fLyy7I05BC+lA+FK46S6dmji5avZyn8QS/buVfveJAKSoSJMihZQ6fuBk2iJ2ZQ
         gukdvGTGb/9m4nrOhwzmBO08MuZmaEVhkRUIYqqWGmW4ZcFIA4Ef1xjcC5hHMl6rKJDA
         fgg0rUCwBwyj9fvsStrBp/CVMViZ8Oyri/L9WXfW7FlTCFpHNRJPbyGWmws8EVhDSylD
         sKBijSR96eyK+Np56pzgqJw4fEaXhLzGHv5LKGWNsDKvKVgBszhlFaeMi6GkF52AWzYR
         pE17YWw9NwTqXM+m0w2HdzcDJm/GK5S3jtG6acmpZAtIXpNa23adv7j5fW8JoQG6CIK7
         4+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623485; x=1787228285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qUHFWUDQz/MEraJh+J1O/f5gfgcsCAk1KSe7ywJpi8=;
        b=MSH70ixybQ78Zah0UTj/RH5p0fPsaIRbeS+1KWDN80yspcm2BvtpS3+j51LdLb0SW8
         ASCejxx4dXTTXGu3+HQ4gp90pVgEWRKLuD5DsIt8mpGqZrLwU/h4PeIXMItbdwUk1md0
         YkSdnkR1LVCWV9oAMJC8LROAjs+Tue2cgDUPf5XAi2TieJHqBAbOMyy8S8dCLQsxVKPw
         obN5Syvf8YhAS+TrmHlDI2PxEwUlsaFj8vWrCclLPsylgQ5H0VGiwcSoR0TGJCjtfFn6
         MMNZlezr4OoHRysKAr9knyMJI+wZkQLNyyTB8SBS+TAiTXkYwtnY2m8pdf6R/j/Cz8K4
         gU1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoP1fX64Vvcf55UupEiutedhyXkdPGYi3E/vuxI8kDCz/CfdGPlC/pegkc9W/6WpdzzSOGMzfAdEAM9@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnz0V5wlRz4t5iJ9UO2n7KIc5D/Q8oUlm19Gt12hPGKbHkIGl
	aZIq90XVaOUWSMoNnbskG295CjTonHdeaN7e4kKt4gkqzWEKY6g3BqX5pAaZg/ZfzP734FaM84N
	ZcUQBrP3jBFE5fGK5D46UnPGMCn45OpDHu5Nly0z2K46En33ZtUTrs72qmJVub/UX/hxQ1TpB+/
	rIDUG9G/NIsmZxUw5b/EowI+slo+xXKSZYD98C8g==
X-Gm-Gg: AR+sD12vaTAt/BKh7JD3n3JL+lBrIrZfo+n9uD5WaLTKzvrE743g+TC5QQHoioOqFFj
	PnX1y5u4eyltUotYN9z3IFenY69OhWVKXDAgGWWQ4gk5lpr+kHT+Or3SiKDeCofh958bSLGgkUW
	rok8ATcFFjdR58JZV/cZ/WQA50wRbo6nS+Mh7s6UGhsRPkybN8HamefUo=
X-Received: by 2002:a05:6102:8008:b0:76a:fc18:29c8 with SMTP id ada2fe7eead31-76db668464amr1600887137.8.1786623485462;
        Thu, 13 Aug 2026 05:18:05 -0700 (PDT)
X-Received: by 2002:a05:6102:8008:b0:76a:fc18:29c8 with SMTP id
 ada2fe7eead31-76db668464amr1600872137.8.1786623485092; Thu, 13 Aug 2026
 05:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810-remove-wait-on-page-writeback-v3-1-dd7531704f26@columbia.edu>
 <20260813112028.3989422-1-amarkuze@redhat.com> <709df647-3af1-4d9d-a99b-c36c9ee69ac0@columbia.edu>
In-Reply-To: <709df647-3af1-4d9d-a99b-c36c9ee69ac0@columbia.edu>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 13 Aug 2026 15:17:53 +0300
X-Gm-Features: AUfX_myXKkVLHvulRQVmMzyUu_qv7exV-qvoatfjLDFlQ5VLwI46XH_QXFBtWxY
Message-ID: <CAO8a2SiJsmNxdj3E_3EhjSYvacn_XCh=RCwhNF29GF79=L5Pfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ceph: convert writeback path to folios
To: Tal Zussman <tz2294@columbia.edu>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, its best to separate any mm/ work from ceph when submitting a
ceph centric patchset.
These fall under different maintainers' purview. The one exception is
when a core API changes, requiring a tree-wide change that also
updates the users. So any mm/ changes shouldnt be a subset incide a
ceph centric patchset.

On Thu, Aug 13, 2026 at 2:51=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> [adding the mm maintainers back to CC]
>
> On 8/13/26 7:20 AM, Alex Markuze wrote:
> > Hi Tal,
> >
> > Patches 5 and 8 remove wait_on_page_writeback(), thp_size() and
> > thp_order() from mm/, but those helpers are still used by f2fs,
> > mm/filemap.c, and mm/folio-compat.c =E2=80=94 removing them would break=
 those
> > users.
> >
> > Could you split this into two series? The ceph-only conversion (patches
> > 1-4, 6-7, 9-12) can go through the ceph tree once we drop those two
> > patches. The mm/ helper removal is a separate effort that needs to
> > coordinate with f2fs and the mm maintainers after all other users are
> > converted.
> >
>
> If this is the preferred approach, I'm happy to split it up this way, but
> to clarify:
>
>  - This series removes the definitions and exports in mm/folio-compat.c
>  - The mm/filemap.c use of thp_order is a local variable, not a call to t=
he
>    function
>  - And I don't see any f2fs users of any of these... it looks like f2fs
>    defines a folio-based wrapper with a similar name to
>    wait_on_page_writeback(), but doesn't actually use it directly.
>
> Given that all users should be removed and the relevant mm maintainers ha=
ve
> provided Acks for the two mm patches, I think this could all go in togeth=
er
> safely and avoid delaying this an extra cycle.
>
> Let me know what you prefer.
>
> Thanks!
>
> Tal
>

