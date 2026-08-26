Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD647728D
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766673; cv=none; b=VXF4a4CLnZsj9yYQRnQXpkcbY7L49fpAFjzhqGR2weU8Cz7nFJDffFEFl9RSkRa/Mz/Jqni6wXxMheh5TbzAwrSA/XXcVpfh7+lcP2ZWCsoLJtDM0bAA7F/mRhXOgUaADISbv/A6ftFjiqkcC/BNQRD1YfgpPxx3BTomCqgXi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766673; c=relaxed/simple;
	bh=0jUOdvNyX4RsR6mKJHTab03ZUHefsyLeuH43wzYU81E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=khGU9jzG97/dBSRBUmi8G3V/ov/3Q9jxTtRs3cq1E1dbch6ujQc0/CaQSzmVfiWvXpY91ZQZmyzNu7SEq+sJYk9tCEY8jcPv5hSM0JI7sSGlXuV6nroWo46fnfuIqgCOmReqYMKTuSiukkB6VGbtGOpdpQ7QtQEy7chwJAj3YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dreamsnake.net; spf=none smtp.mailfrom=dreamsnake.net; dkim=pass (2048-bit key) header.d=dreamsnake-net.20251104.gappssmtp.com header.i=@dreamsnake-net.20251104.gappssmtp.com header.b=b4Ht/rmO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dreamsnake.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dreamsnake.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dreamsnake-net.20251104.gappssmtp.com header.i=@dreamsnake-net.20251104.gappssmtp.com header.b="b4Ht/rmO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9309d4ea213so98629685a.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dreamsnake-net.20251104.gappssmtp.com; s=20251104; t=1787766644; x=1788371444; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E9IJ6QL60xBSdWk9Vt9JZinHJuOtL6ddseKSBQWb39Q=;
        b=b4Ht/rmOM+Ls7OPATaz54OvjjIf4rhqxutVmm9BLJFKFCWQ8knpT7TNQ6q8gYOLv9r
         WLMTtreS8Tx2weBbTby2MIFSaRLj70dpK1Kl1gasf4QBiFTR4RMlHPTjUFFCW4EZZIXo
         /nfLC2LaigbVxXsdHvxxLpOCUAYVaCEgUVpxP/QH/gfyzdUheBLnAkvQJvyTRmTRFFHw
         LtBNLBj1pOv4kNvjcbMYyR8YFtfgDClqMZOAHZW4pMTKBbnijBrQazlFz8wSpa/vhdwF
         vIEjYf1235/xxqmhnc9/KdvjklNWiTSYvBcA57uR/3oBMkohq23gbNoW4Ve0aUGUahQt
         vWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787766644; x=1788371444;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9IJ6QL60xBSdWk9Vt9JZinHJuOtL6ddseKSBQWb39Q=;
        b=fzcD0AauOAJ31rv4FNaX1Hu5iOEW/bORWxv3R/p3wHFvpFJZbm9C9YoKpLnWi4d+WL
         h63HowXL0LbPSGRESmkyqXcIkecJWVZP97XaOukpw5Z9XboTNTSKPVLyJQpEcTK3NnE2
         4PtNOShkgAv+ZVxK5y88KFPrpDFT/fxUO1q/yIpsPVS0S1egdhayUfZhazqrlTkL08J8
         CppkbTUgbdYPAi0bWaAbmI9WDttR2rM2XT50sbf7Gi/yzSWYFuHYPoIysaqY5J3cQCnm
         RKJ6vyVsMMyr3IH+myrLtlTnIdxjyz1jbQxaT1rh28XLtLv0mYL8PjchsDbMX465oMkN
         oppg==
X-Forwarded-Encrypted: i=1; AHgh+RoCCrzqWawMsPgD93JebBp3K4hTx5dy1QmvNLU2e8JLDtXHwN1I//Ww+C5VUfVjFt57A96zVcdvDM7e@vger.kernel.org
X-Gm-Message-State: AFuF++lfAaJ4CW3e01eQGHZtI3wL36sYTBL5p/OGTIU2nJ+9G7ywZgNP
	+rYSkU345wvtY3bQ/RH49PEN2eYpv2s8YBOQxbRWCiD6Kp1Rmy8v3yE4J1UJA8cU
X-Gm-Gg: AR+sD11qQq44YtNtwhtAWJN8mQBF2baVBJD55WU7F4GjcNzIcX1KNKMRQbM/t0OoaE+
	zwYsca1om6vAVbNbnNT68L/1v4UTWk8IhZ8p7NvS8wNyP+0spPOklq4nyybd4Ls/Ow9OWV3zF/H
	3s+TtfszBRevxSByvd67dm6ZcdMFtaQvexHyBkvbFDjCHJXqJqf3Y42lnv05Pv0rMlB4C7Dq0s1
	jqqkAvoLTLnlPVC1kvV0RF4Y3HwmFY7cdEQ24ZJeTCrc6jEj6B++xD8UHoW65xZ056VQ0e9zbPu
	c3k4il4U7mSLLcELpDr78IsJ2ZvG4NboALM0PWn2hzHVLOgx0qhMh3p5Y81vOg2stqVizojYk1D
	mUJGrbF5h04kCv6x/gwpgbX3nOtDQ9Daku7JIFRoD5ovPT6HRpS6eiIutj3mZ54ypTvTPNWfSh0
	oJJVxOEnjpZDIvJO6pIBxGyka3O2uPdSg7vzGhzlmXLDKgoaeYwbOtl9nZWABjkURxKRaGDniVp
	SKNOTvyw0R6ySB5Rb7y25TnCnaSyF+LENAuC8BoZiWRig==
X-Received: by 2002:a05:620a:708c:b0:92e:f380:dabf with SMTP id af79cd13be357-937803ebd11mr814952885a.30.1787766643575;
        Wed, 26 Aug 2026 10:50:43 -0700 (PDT)
Received: from smtpclient.apple (pool-100-6-75-232.pitbpa.fios.verizon.net. [100.6.75.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e6156ccsm259959785a.27.2026.08.26.10.50.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2026 10:50:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [v4] ceph: add 'lazyio' mount option to kclient
From: Anthony D'Atri <aad@dreamsnake.net>
In-Reply-To: <CAOi1vP9HmkFa9swMLM+y1DjJVGeNX51bXe96E--2V3U3iPU_uA@mail.gmail.com>
Date: Wed, 26 Aug 2026 13:50:32 -0400
Cc: Alex Markuze <amarkuze@redhat.com>,
 Xiubo Li <xiubo.li@clyso.com>,
 ceph-devel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D69B78B4-9D27-4B38-BE51-9AC93B11EE95@dreamsnake.net>
References: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com>
 <20260824064834.2509055-1-amarkuze@redhat.com>
 <4DE0FB03-58E3-4BF1-87AE-055075FE0891@dreamsnake.net>
 <CAOi1vP9HmkFa9swMLM+y1DjJVGeNX51bXe96E--2V3U3iPU_uA@mail.gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Awesome, thanks!  We discussed it a few months back but I hadn't seen =
that it'd been acted upon.

> On Aug 26, 2026, at 1:49=E2=80=AFPM, Ilya Dryomov <idryomov@gmail.com> =
wrote:
>=20
> On Wed, Aug 26, 2026 at 7:43=E2=80=AFPM Anthony D'Atri =
<aad@dreamsnake.net> wrote:
>>=20
>> Any chance of getting in as well the opt-out RFE for going =
synchronous when an OSD / pool crosses NEARFULL?
>=20
> Hi Anthony,
>=20
> That is already queued, courtesy of Alex:
>=20
> =
https://github.com/ceph/ceph-client/commit/c7a12c20bfba96a76e94d8dfd700b33=
e92aa8323
>=20
> Thanks,
>=20
>                Ilya
>=20
>>=20
>>> On Aug 24, 2026, at 2:48=E2=80=AFAM, Alex Markuze =
<amarkuze@redhat.com> wrote:
>>>=20
>>> Hi Xiubo,
>>>=20
>>> Thanks for the update and the extra testing.
>>>=20
>>> NACK for now =E2=80=94 please send a v5 for:
>>>=20
>>> 1. fs/ceph/caps.c:2354: FLUSH can ACK a LAZYIO revoke while pages =
are still cached
>>>    Xiubo, `ceph_adjust_caps_used_for_lazyio()` is applied in
>>>    `ceph_check_caps()` and `handle_cap_grant()`, but `__prep_cap()`
>>>    still does `cap->implemented &=3D cap->issued | used` with the =
raw
>>>    used set. `try_flush_caps()` and `__kick_flushing_caps()` pass
>>>    `__ceph_caps_used()` straight in, so used is CACHE/BUFFER from
>>>    `nrpages` / `i_wrbuffer_ref`, not LAZYIO. Once LAZYIO is gone =
from
>>>    `issued`, that drops it from `implemented` and the =
FLUSH/reconnect
>>>    message is an implicit revoke ACK. `ceph_fsync()` hits this =
easily:
>>>    `file_write_and_wait_range()` leaves clean cached pages, then
>>>    `try_flush_caps()` runs. After that ACK the MDS can hand CACHE to
>>>    another client while we still have the old pages. That is the =
hole
>>>    the v4 `implemented` comment is trying to close, and it still
>>>    exists on the FLUSH path.
>>>    Suggested fix: Run `used` through
>>>    `ceph_adjust_caps_used_for_lazyio()` in `try_flush_caps()` and
>>>    `__kick_flushing_caps()`, or once inside `__prep_cap()`. While
>>>    `implemented` still has LAZYIO and CACHE/BUFFER are not issued,
>>>    report LAZYIO as used so `implemented` keeps it until writeback =
and
>>>    invalidation finish.
>>> 2. fs/ceph/addr.c:1999: Non-lazy mmap can keep using stale page =
cache after a CACHE->LAZYIO transition
>>>    The new revoke path keeps the inode page cache when CACHE is
>>>    dropped but LAZYIO remains, and the used-cap rewrite then lets =
that
>>>    revoke be ACKed. That is only safe if every opener is lazy. After
>>>    `remount,lazyio`, `CEPH_IOC_LAZYIO` on one fd, or any mix of old
>>>    non-lazy and new lazy opens, a non-lazy mapping still faults
>>>    through `ceph_filemap_fault()` with `want =3D CACHE`, gets only =
RD,
>>>    then calls `filemap_fault()` anyway because
>>>    `!ceph_has_inline_data()`. Those retained pages were kept solely
>>>    for the lazy fd, so the non-lazy mmap can observe stale data.
>>>    `try_get_cap_refs()` correctly refuses to satisfy a non-lazy
>>>    CACHE/BUFFER want with LAZYIO for `read_iter`/`write_iter`; mmap
>>>    never got that gate.
>>>    Suggested fix: Only let LAZYIO cover retained page cache when =
every
>>>    opener on the inode is lazy, or skip/invalidate page-cache faults
>>>    for non-lazy fds once CACHE has been revoked.
>>> 3. fs/ceph/addr.c:2149: ceph_page_mkwrite() can sleep until killed =
if caps are gone
>>>    The new lazy-fd path drops its refs and waits in
>>>    `wait_event_killable(ci->i_cap_wq,
>>>    ceph_have_dirtyable_caps(inode))` when it got WR but neither =
BUFFER
>>>    nor LAZYIO. Session reset wakes `i_cap_wq` via cap purge, but
>>>    `ceph_have_dirtyable_caps()` stays false once the caps are gone, =
so
>>>    the waiter goes back to sleep. `ceph_inode_shutdown()` does not
>>>    make the condition true and does not wake the queue.
>>>    `try_get_cap_refs()` already fails with `-ESTALE` on shutdown; =
this
>>>    wait sits outside that path, so a writable fault in that window
>>>    wedges until SIGKILL.
>>>    Suggested fix: Include shutdown/session-loss in the wait =
condition,
>>>    and fail the fault once the inode can no longer regain BUFFER or
>>>    LAZYIO.
>>>=20
>>> FLUSH/reconnect still ACKs a LAZYIO revoke while pages remain; =
non-lazy mmap and mkwrite shutdown wait also need fixes.
>>>=20
>>>=20
>>> --
>>> Alex Markuze
>>>=20
>>>=20
>>=20
>>=20

