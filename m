Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA153AEF45
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102980; cv=none; b=oK2QaRWnCRRBNHLsSP2wO6AOcWaGZocrBqhJAKJ0h7OzHhN4MpYxNVe2nYqlvQ+k8jvBujCRzRdTDFnElD13lGf4bqDyaZ/zoS95MiHg0lLrKQtmxWvBQ4Tebw9XjCg1qN5r0rDDqAhkLLTcPv5UpL3H6tBHzcCXO/+GFNudiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102980; c=relaxed/simple;
	bh=Q0EiSGNAilF3LepJTLofyQRmpIE4E+9z9Qt3gaOu9BM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s8CPqf2w6Q8p671b6J86WzQIbEP8j/Tun2UCh8EdghoiViI7StIeQtDHr60mJIwKTXJuvJXcjXcBtflj7fAwgWVpRQjOKhGX9CzP9NJQkZkSVbxXaAW3Ap1L+mc5hFy1fKK5rZ2K0LZlXlHmjaX5nAiWDwWsmxBqAs233Ske20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBI6QCsW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pSm8gIIo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBI6QCsW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pSm8gIIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778102976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvG0RtQj1Ea1EsjAUT8dhKWkNiLCMsptn2FZxCa5Jgo=;
	b=HBI6QCsWGbu/n186BWT+hSAvbBBy68rbv19WCg+ZXUTusE9n4uT2GDgcDdGERK6kRHU9Mm
	zYc1kNfl5jRBg+CzhM8hLKUkK3aY95JjpVb7rak9mPPsNyV9LKLcHvJBU5qudgA1Ax3EmM
	YiMBhyKAJHW8/aCnCSED+3wIl0XgTyY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-L2uOTIHqMJOoujLbDpjPKg-1; Wed, 06 May 2026 17:29:35 -0400
X-MC-Unique: L2uOTIHqMJOoujLbDpjPKg-1
X-Mimecast-MFC-AGG-ID: L2uOTIHqMJOoujLbDpjPKg_1778102975
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bd6f72e5aeso3704127b3.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2026 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778102975; x=1778707775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvG0RtQj1Ea1EsjAUT8dhKWkNiLCMsptn2FZxCa5Jgo=;
        b=pSm8gIIoQGnkk91ym/2scdnYlkIQix7P1t9nvJ+du9Z9ujtOOHT07Trs2Nv85Qq7WN
         No2pwhv6KIvDFIZle2Pei0Im6PQRzqphslEsp7qZisr7ZDMadKDLytsTHHjKA529xq2K
         9zlZhmFzMn+3S7xDjToEiU+m6c89M1t1rMbInsR59je1lr8JPQxKpp4njOUUaNZQa68n
         WpKgJ6rY8IxrYRwui1rVhIwdon2NHkeykk9/AAnH1hxQkC7+8oIIGksln9njRDKurXh/
         018O4cMI6jmjEKfW5RPqQ7LLPpurNX8SkXPrZvjkSPo7L93N3+4cYSEWr2cuCE9rkyEs
         hfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102975; x=1778707775;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvG0RtQj1Ea1EsjAUT8dhKWkNiLCMsptn2FZxCa5Jgo=;
        b=fkzSaeyCN/lIKYU//+YSPmDSKMLGJFTIJwTz5EzsrxW6CLXXwj/R28IP+NgI3aKwN0
         yH/il6+48RgMSPwqDpQ4SOuiuW7PB+0zpKxHtB0yge3MQvytAnh8RWaUSwz8qXamPK3m
         IXFQf63Qqw0JdMJjyjCwG1XAhlqrFGfmS277/t8kPS4EP3JgJy3bfWAEs2/QAXcpJXuI
         PuFNKOiFOAEwOaW1qXNOctNO4APIaPKvd6o45T1UMF4FlDKgqhFN1Lw/Di7aHp/R2sMh
         qY2JJTtn4wvQOgv4oX7hC00455ksptIInd4vjTHEwunW4GZMftnXiYY0wptdzXOcVpka
         5hrA==
X-Gm-Message-State: AOJu0Yw/ij8wOmCTOU0po0vdLizJepql0eTYLDPuYe3g37JJE+TNzmv9
	fz6CN7PTIUcEdDl1+Bxksp+goCYR5tCegsUuXDxOMOPB0o8TNqbazPw/eqXLuiLPyWREFCzJZdH
	CXCDDObc2biOd8I7pg5lzGg92aj+N0SvwP3lLwiT/poaT0RHp5UaBZFPOqnqFWLw=
X-Gm-Gg: AeBDiesOnznssRZH75y7Qnn0Vmg6AGOgSXrbJCfPdO5cuw/3g55MM8eur+G91CsPYhn
	BhLIkQFY5fdea/hDs7+PUHmrSUYPR45NXeT18Gx4dmlgd/vjTqwlXJ5+03cAMd9HDESFU2Q47ox
	F5e3Hz0LXPqHoSsUZkUVJq+D3FXbW9JdJQUldAgUXzQiCWtO5iyxDuJBU6qvErvnk5QTCGeXWp1
	AA4i/+D4drcUG8Lw/O0okUl0Le7X56efL6ecVNlTRXHcgTTPVDro+w9Zw4LQbhq25J5gj9sQN0d
	A5BcH11Uei631kg1/4V2+1DabHJM+KBXOHIWYdcZyUYTKU3zeZumZnkp9CF841R4KtlQYV7z02A
	a+8wqSjtTVRujhKlmJuClnEswzz3Ua8yhiR0C7upCdeHWYNN5VjBdxQM28pM4oE0=
X-Received: by 2002:a05:690c:dd5:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7bdf5d651b7mr61018747b3.4.1778102974982;
        Wed, 06 May 2026 14:29:34 -0700 (PDT)
X-Received: by 2002:a05:690c:dd5:b0:7b1:fa45:72e3 with SMTP id 00721157ae682-7bdf5d651b7mr61018437b3.4.1778102974513;
        Wed, 06 May 2026 14:29:34 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652742csm83050307b3.9.2026.05.06.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:29:34 -0700 (PDT)
Message-ID: <979770752db43066a74249f237a2a4d66b7c11e8.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 05/11] ceph: add client reset state
 machine and session teardown
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	idryomov@gmail.com
Date: Wed, 06 May 2026 14:29:33 -0700
In-Reply-To: <CAO8a2SgcoFjAn_YuXHLc9rtA49xoz-4EvTLC_9skkEZ82BeuOQ@mail.gmail.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-6-amarkuze@redhat.com>
	 <eaec3781eb6034d87a0fb4cbf011c3dbe6d73eb4.camel@redhat.com>
	 <CAO8a2SgcoFjAn_YuXHLc9rtA49xoz-4EvTLC_9skkEZ82BeuOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 14:39 +0300, Alex Markuze wrote:
>  Hi Slava,
>=20
>   Thanks for the thorough review, several good points here.
>=20
>   -EIO mapping for blocked callers
>=20
>   The design intent is that internal work-function errors e.g.,
> -ENOMEM from kcalloc, or a transient encoding failure, should not leak
> to unrelated callers such as open() or flock(). These callers did not
> trigger the reset and have no way to
>   act on "reset ran out of memory." The detailed error is preserved in
> debugfs status and tracepoints for the operator who triggered the
> reset.
>=20
>   That said, I agree that -EIO is broad. The challenge is: what would
> be more useful to the caller? The caller's only real action is "retry
> later" regardless of whether the reset failed due to -ENOMEM or
> -ETIMEDOUT internally. If you have a
>   specific error code in mind that would be more informative without
> leaking internal details, I'm open to it.
>=20

It's hard to advise something useful here. But if the caller's only real ac=
tion
is "retry later", then, maybe, -EAGAIN could be used here?

>   msleep() for close grace period
>=20
>   I share your discomfort with msleep() in kernel code. The difficulty
> is that there is no completion event for "the REQUEST_CLOSE message
> has been transmitted on the wire." The messenger queues the message
> and returns immediately.
>   The grace period is purely best-effort. The MDS uses
> session_autoclose as a fallback if it never receives the close.
>=20
>   What event would you suggest waiting on here? One option is to wait
> for the session state to transition; the MDS sends a SESSION_CLOSE
> response, but that reintroduces the stalemate problem.
>   If the MDS is stuck, we'd wait forever for something that will never
> come, which is exactly what the reset is trying to break. I'm open to
> alternatives if you have a pattern in mind.

I see the point. Yes, it's complicated of suggesting something more useful =
from
my side.

>=20
>   out_sessions skipping ceph_mdsc_reset_complete()
>=20
>   Yes, this is intentional. The out_sessions path is reached only when
> st->shutdown is true, meaning ceph_mdsc_destroy() has already taken
> ownership of the final state transition. destroy() sets phase to IDLE,
> sets last_errno to -ESHUTDOWN,
>   and wakes blocked waiters itself. If the work function also called
> reset_complete(), it would race with destroy() and potentially
> overwrite the shutdown state. The comment on the shutdown check tries
> to explain this but perhaps it could be
>   clearer. Would adding a comment at the out_sessions label help?
>=20

I am slightly lost the context here. :) But, I believe that adding the comm=
ent
could makes the situation better.

Thanks,
Slava.

