Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAA139448F
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654269; cv=pass; b=BIsf5sOpyuPw+2Wr0ddgjhr7mgf0svhZWphMGmaGjD9Ds14bqCMKAFS0pHCD97HUL2uLLxjH+u+DQZ1X+gXuyEQ93x0LEgCLSPoeh3MQYng+ZrsGlHl29c+yaxGRM8MzONbsXYtR90qzh2uuBE0sjqs5JTPe0WWJD5hUodQ+RNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654269; c=relaxed/simple;
	bh=/VyfSd4LJb1EwLCokMYjjdGYOYyFyVprn/518uoDAtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DD+1c1VfKxvyaC99iw4X+unvQlOn7UZzAIit1SW2LEqP3YCS4BZImo8xelsgpufRBvDBDpcww8HD1ooLyuWIsJZEiDFoxQ7wnGeXrp6PkL51w+t6qhzXaeeX19BAJA3DYKOcv6oJij11JOe+CBKDZRlU8FRpYLxb2JOrYHsPaQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=FESmHSVj; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="FESmHSVj"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so698584066b.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 03:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787654263; cv=none;
        d=google.com; s=arc-20260327;
        b=YWlOxNpwfdecRRlyfm2UD5sl00awIP1MUzlQzdHhp0YGkf1tAnSXIAmd76uEgC4Hw6
         wyIm7tXKAbJoBpzxTR2DSBtbAxAB28jPEMR5VmZpE09Pbn7xw/nk+deaE8u18j9LwODB
         42SXZf6xPNtrt3kYnx9jve9nhxyiu3W0qwQo9R1I+lAQ48yfjmMszYtP1La3K6Ni0Pdv
         Yw/yha0KoZnPRGMT7efh8HzC3HVJcWMH41WbGjZ0KIa/mXRTfx3A+bm4FVWQArkOOOFq
         JYSesceE59trpzKH5nKuUQmY0glZuh2O+sXbWg4jz7cN9qb6Ly8Nm/VHm+Y3dI9pQOde
         8k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4t3V1apk/Mgs53kB/C548zWS3Sp3PgbLwPMr1IWQZ1w=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=XbopzYk+q7oUn3l85ZHOjtVgOk3wBG+BIeTTgyC13vA/7LWXzwMmq9g61n+3Xb9wpk
         ltpT3FrCGXY/ms+SVZZwLXg+fv8HS6AjMoJwF/4UybSqpUmNi/BhgIPy3+ojf5+1TJ9j
         e6aIv+XRW/V6/q8BUJzhwvZD8gNKXCplH1iC/xqrChHzBZrEMCBwEcuf6Vbxlh5HXbu+
         S8qjdTGYqWbaf5D0tCC1p3mkWOkcB93vR7yeIAT7i6ZcOFM4ueI6vi0Rh0Ae0nJtwIa5
         A4TS+8szsK7B/cpbDD51BSM74cU9GOF3sK8ADslbyce8fEA04YHKix90gmDbhYBMiO4V
         5Hrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787654263; x=1788259063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4t3V1apk/Mgs53kB/C548zWS3Sp3PgbLwPMr1IWQZ1w=;
        b=FESmHSVj02FL8l5g2zMHhS0sPSVXWJz3v164XaNTbqBslg/Su6q1nkOJHz9nmtFVBF
         A6SSb2zo0DpBJ5KhuhhKRDeuzXtuYmVXzupYatMXSqaJW8QaOsH+UcHo23Uq6X8P/QV7
         VNtEKVAlDHib41Rd7R4fpidbK37sj6WH11IcbhGFfJHfPhkNVdUt1jYR/2P+bSWgOAO4
         epHMCSajdT09CabtW5qiL8VqwNRS+badhoEFY1FOVDQJ9ZpBP3dYXcsaTQdvH9uzlFNJ
         axmnEAr5+596pt0Xdvk4cC39yXXt8D9ukrLProHStj02EMYACWNxkVDDWL+J0pjlrdti
         qHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654263; x=1788259063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4t3V1apk/Mgs53kB/C548zWS3Sp3PgbLwPMr1IWQZ1w=;
        b=dsiBEnaTN1eExQpo2ePBVdqQZDkF2spEVwAfQpo45xLX0lyOBuXEnbz/ePmyIRw1Mp
         wD1l9xbP+nX1erZ1Den6diCMba1n3TaHMyLG9YQwri/Loo7ceoe2fWkP9viKlv4Dm49I
         Qn+FV1Ae7eHKGE7gzoAMhKwCeD1X9f0MaIIx/9aQIPY3iPlngpsvnUmZ/cHdeJ33Jw2j
         U4dk11aN91h8ZOCljLX2mOkb4VxjDwiwZ1SQjMho4kiXDwwiYF+Gl0MyTMhHOQEUrZjc
         GR/dw5w+PLrtSEH1vG3JIkkmTctF+VQeKAGRJ6PTRZrP5h94Wi1/wEcIn6Ga29sipdyW
         zxEw==
X-Gm-Message-State: AFuF++l1gi9XV/FeQOv3RbZM7JmUw+8s+z3wjWZRQaHgiZcBB/OcuM/e
	S7Pqmct2hcoRKqn/Dy826viHO/x/qdVdY/90h+tqHsIRRo41HfUoOa7PNGQYkUi9c++56bz8PMf
	vAc7jSwul/KeRRMw22D17IiLRRzknC9X8ZK0W3MoAqQ6aPd4re0psPp0=
X-Gm-Gg: AR+sD13+TPGfdyZA+PB1Nxbagm2V8jnlsnvql8n3qrbcnoU0fqCAY9CqjAAg9k8xRZP
	yEELwyaqqZovAJ17ouh8q95H/7K4OFu5WVti2JJ+73nypI9E+bo0uxw4EXMpYXFEK+FQX6tvXYu
	Yi70uuu2Qo/bnvwF4GgJGNagcHOXt87jJrAPcGiGgzvIjIjfDWvadSFQS5z5BsA+QQCsoH/c26Y
	vd2iiOiAi1AKxlCy44+sADyGLz59snuR80meo7tAQRsHx93J+SHxMtfawgv6Agg+33x+6O8SvLX
	wQCw9/TVfQal59t0ShQwkvzXzSG+Pt+aMEhZT82HEhsjKQ==
X-Received: by 2002:a17:907:94d0:b0:c24:8a09:8195 with SMTP id
 a640c23a62f3a-c249238cd91mr2542620366b.3.1787654263123; Tue, 25 Aug 2026
 03:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com> <20260824064834.2509055-1-amarkuze@redhat.com>
In-Reply-To: <20260824064834.2509055-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 25 Aug 2026 03:37:30 -0700
X-Gm-Features: AcwNN1Vwm4Dl8chtycdT4EWqTRd6KNh3Qf7F28j2C-NvH-pyOWrWaPW9j3fBlPU
Message-ID: <CAOJNxRJzAb=oHFMRsiO9fiXzcX3XcJVMDH+yj=j9j+fCxVPSJQ@mail.gmail.com>
Subject: Re: [v4] ceph: add 'lazyio' mount option to kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for the detailed review and for pointing out these issues. You
are right, those are good catches.

This also fixes the read performance issue I hit before.

Patches are ready and will respin as v5.

Thanks
- Xiubo

On Sun, 23 Aug 2026 at 23:48, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Thanks for the update and the extra testing.
>
> NACK for now =E2=80=94 please send a v5 for:
>
>   1. fs/ceph/caps.c:2354: FLUSH can ACK a LAZYIO revoke while pages are s=
till cached
>      Xiubo, `ceph_adjust_caps_used_for_lazyio()` is applied in
>      `ceph_check_caps()` and `handle_cap_grant()`, but `__prep_cap()`
>      still does `cap->implemented &=3D cap->issued | used` with the raw
>      used set. `try_flush_caps()` and `__kick_flushing_caps()` pass
>      `__ceph_caps_used()` straight in, so used is CACHE/BUFFER from
>      `nrpages` / `i_wrbuffer_ref`, not LAZYIO. Once LAZYIO is gone from
>      `issued`, that drops it from `implemented` and the FLUSH/reconnect
>      message is an implicit revoke ACK. `ceph_fsync()` hits this easily:
>      `file_write_and_wait_range()` leaves clean cached pages, then
>      `try_flush_caps()` runs. After that ACK the MDS can hand CACHE to
>      another client while we still have the old pages. That is the hole
>      the v4 `implemented` comment is trying to close, and it still
>      exists on the FLUSH path.
>      Suggested fix: Run `used` through
>      `ceph_adjust_caps_used_for_lazyio()` in `try_flush_caps()` and
>      `__kick_flushing_caps()`, or once inside `__prep_cap()`. While
>      `implemented` still has LAZYIO and CACHE/BUFFER are not issued,
>      report LAZYIO as used so `implemented` keeps it until writeback and
>      invalidation finish.
>   2. fs/ceph/addr.c:1999: Non-lazy mmap can keep using stale page cache a=
fter a CACHE->LAZYIO transition
>      The new revoke path keeps the inode page cache when CACHE is
>      dropped but LAZYIO remains, and the used-cap rewrite then lets that
>      revoke be ACKed. That is only safe if every opener is lazy. After
>      `remount,lazyio`, `CEPH_IOC_LAZYIO` on one fd, or any mix of old
>      non-lazy and new lazy opens, a non-lazy mapping still faults
>      through `ceph_filemap_fault()` with `want =3D CACHE`, gets only RD,
>      then calls `filemap_fault()` anyway because
>      `!ceph_has_inline_data()`. Those retained pages were kept solely
>      for the lazy fd, so the non-lazy mmap can observe stale data.
>      `try_get_cap_refs()` correctly refuses to satisfy a non-lazy
>      CACHE/BUFFER want with LAZYIO for `read_iter`/`write_iter`; mmap
>      never got that gate.
>      Suggested fix: Only let LAZYIO cover retained page cache when every
>      opener on the inode is lazy, or skip/invalidate page-cache faults
>      for non-lazy fds once CACHE has been revoked.
>   3. fs/ceph/addr.c:2149: ceph_page_mkwrite() can sleep until killed if c=
aps are gone
>      The new lazy-fd path drops its refs and waits in
>      `wait_event_killable(ci->i_cap_wq,
>      ceph_have_dirtyable_caps(inode))` when it got WR but neither BUFFER
>      nor LAZYIO. Session reset wakes `i_cap_wq` via cap purge, but
>      `ceph_have_dirtyable_caps()` stays false once the caps are gone, so
>      the waiter goes back to sleep. `ceph_inode_shutdown()` does not
>      make the condition true and does not wake the queue.
>      `try_get_cap_refs()` already fails with `-ESTALE` on shutdown; this
>      wait sits outside that path, so a writable fault in that window
>      wedges until SIGKILL.
>      Suggested fix: Include shutdown/session-loss in the wait condition,
>      and fail the fault once the inode can no longer regain BUFFER or
>      LAZYIO.
>
> FLUSH/reconnect still ACKs a LAZYIO revoke while pages remain; non-lazy m=
map and mkwrite shutdown wait also need fixes.
>
>
> --
> Alex Markuze
>
