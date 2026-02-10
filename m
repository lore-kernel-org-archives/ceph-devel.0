Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8294C8F0
	for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726335; cv=pass; b=MdDHlo+yf7cJ//RfvxzDdYRpbZN6iWQt+GGAstrI9PoWFITLYiuj5icSgxqnatdMwHi4GVXnZlFjExHAqCRqT3bnMBeSF/JSZ9RPAtQRIW0/kZZRhJOor+EirB7KUV/2iJ9yIQ4wAgxmRX5H5ajpTNv3AefW0h7v0ri4dS+Yjs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726335; c=relaxed/simple;
	bh=jb3QxqqEthIDSleH58vWDEdSIpokZJFfaIlRJ/kKfQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJWnPG8/DOrywolwEeM6fO74z7je9meSTq6d/6YQauHNfFkYUpScQk8DAQaXn9JWGKyywyHMbXnUobnZzBUsaPJKejUgMLw8kA7sYZ/o47rEVf1FLIdDX9ZhOh0qKB9iR/8e9pa2kZWy9Ri+Jtivxyh7NXx6HGlihYsq48Ho6oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZJtoV+E; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZJtoV+E"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so5033641c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 04:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770726334; cv=none;
        d=google.com; s=arc-20240605;
        b=OXUNdgsH0nuHqK6xs9kHVQa9FvFCiKRV0/Ud0FfQxNx17JjQWQIVXyoPgkA7hOmPJV
         1rWX7UVhvXS1WGDNT0Ynzt8m229gFSSbV6mUHjlivYLmUiTfeRf9fCihRgoeehWgvHN1
         sSKkWFrNxWowCxCXS+XUxl8dEigVD4hU0uVkYq0reuoJzkRAw9zNt6lDHWRrTZ7OOW5I
         oIG/49pMaT8CjQWvy44eZgndl/6b+G+rnnKFLYhP/EJXxkXOLbsmk28Dcnm+nHgZmpmA
         vR/G5oVagKB4FakIk+zltvqFP3lpVzKsXioqbirX3O89Oh59SXjAW8BYQcxEGf3oFQlB
         S+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        fh=8/Cp8DkQm5Fn2sVDcz4JNplHSARDkJLMlYGhsHJi7Oc=;
        b=iHtNHLzwlewykV0+7jUTRdKuZfjQ0tw0Lq2lLsxDEqgF5ZrNQ7zOydfWCpNidkbS8N
         UkzvIKpm8AzhR7PCC3lgNQgy1bKUHEjNFl93vjZLAPpCUzYfKT/eZwAkBScxcQcoHVNn
         s770Bz/5bv281wCnMNAafy4jm4MrR9kbqU8HS2+FQXPtnMVA6SfdFomL/887b+cjWwUt
         pJ8hpcH1ImYpMG60fu6iP9MpC5sTWkIP8r3pfoX81KFF3FFyfRsx8Tv+K62x8HdUdUzw
         vV0mCLXBcSfXPcH9rsQcleW1XshHtew2Fe8aMx2BwmpCFxEIhm5h4eCXPEPCjo23PL0I
         +kVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770726334; x=1771331134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        b=QZJtoV+Eh4/kPGucGa7gvwGwhR5V9BR16k2L9iMRUI3XLM1qX14RtVuAS0RqqXjBSJ
         v0A7EoCSDRn0BLh6SmhZ1Lux8nOQULLRjgG0CNM6UTnc+LxCRzBlxCMXmV4fNvBvKihJ
         W++V8QGshfqPH0nwssdBMii+tah9AhkW9rafsXOBo8pq6HrpZCnJRjfbgEhZY4W4mLjW
         ij62ClE4wkKSpg/RnbkFVO+gyUZFTgbwFpchd7mpcv++o3xU+gBLGT7ms0CID+mdjZgl
         0aXWsZ9Lwkqc7HNl+vjHOJbd/RvUG4dIZ74deIZQiwjqspnH4qVdWuz4dYrw5ly+stt3
         DUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770726334; x=1771331134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lviK+3J/qBKUnpjJJ7UIbk90vVi/aBRhlSNNHXg7jFs=;
        b=ub9acXxDHHlGsRKCwAzMFSVmsu4BcSH5Ee99hlp9aLJXlzFR8P5coqkzRTO+2CULHj
         eU3k2/jMiO50hgKosy6VLjNevkl4wVqHHBU0EhTNRn7WWr+4zqs2pFZOY8bcYQXgdM+L
         +jTjjcZN4HW0LPsKh8id8pIxGz6U0ynyhSblm687pg4QYCQjmEsznvazoAqFx+QBxPP5
         cgRt42RVitV7VlW0AKQnuh45EhHCD5qvWQpvmF6ETnJ8WFQnGjU508lzsZmNPalW+5+k
         nqmBfxdbr4MLbqY5J9XSWgBelpx5lYxpYwzTjoWyKSCMV6MGQlGFdYR97lh8WOuZzROY
         BstA==
X-Forwarded-Encrypted: i=1; AJvYcCUbePPmQNTfJMHEouRs5hnMmEYOu00XtWmkIDmG/znYOmOD+3cuOLSyNp1SJP/ylxiRtKg9wADZhTW4@vger.kernel.org
X-Gm-Message-State: AOJu0YyAN80Fj57zmExDPDWTu8V5mtX72TyVaiJ9NogtXEWapOtQ57Si
	K1Zug2AoYXbRjrU35oMbElTu4QjIm7PgJ3DLCICsuw1yeexdslkd5OD79a091FVQZFheorJWZnP
	q7fQDkaG9xUunEgLGARfUIpDcQzJcZxY=
X-Gm-Gg: AZuq6aJimF+2ae6ZIhd/SfjNQJeP/3kqFmdFOIC7Lmgs6WKhdCKndGCjW5j74ppeoH0
	6p1ks/CqYj9KM0NTaci5rNRpKPoMVYoy04k+dfc+u0kss2GtRIHrWftsr1SXfoYC7rzSREeHeh/
	AbNeV2QK31KQ4rXAcSLxcAo4KX8D5+ZpRr86vb3pk2iNsgHvRVaIThp463u0BWUelXFUwH0S7u3
	HWtrE/BNc8jcKtst44crFcuYOTASWfXNZOfd0cb47OBGm3HiPMfUBpbj9X2I3M+dSkr62nMtSnD
	CLO3BkI=
X-Received: by 2002:a05:7022:224:b0:119:e56b:958c with SMTP id
 a92af1059eb24-1272431f95amr858651c88.17.1770726333597; Tue, 10 Feb 2026
 04:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOi1vP9fvjfu-WsfL4RUw8mAK01rcbU94VvVxfacnskW6JRMNA@mail.gmail.com>
 <20260210071929.15602-1-ionut.nechita@windriver.com>
In-Reply-To: <20260210071929.15602-1-ionut.nechita@windriver.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Feb 2026 13:25:22 +0100
X-Gm-Features: AZwV_Qgh3WVc2qo4eqJSbtl9thpMXsvcFZWidI0_bdYXe-7IhGbPjDprxBTST1E
Message-ID: <CAOi1vP8WVkwy85VechMGzbROEB6AFzey3Uquz-sYRrJ2uLm6wQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: handle EADDRNOTAVAIL more gracefully
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org, 
	clrkwllms@kernel.org, ionut_n2001@yahoo.com, jkosina@suse.com, 
	jlayton@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, sage@newdream.net, 
	slava@dubeyko.com, superm1@kernel.org, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 8:19=E2=80=AFAM Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> wrote:
>
> Hi Ilya,
>
> Thank you for the thorough review and the good questions. You're right
> to challenge the "1-2 seconds" claim -- looking at the dmesg data more
> carefully, that was misleading in the commit message.
>
> > I'm missing how an error that is typically transient and goes away in
> > 1-2s can cause a delay of 15+ seconds against a 250ms, 500ms, 1s, 2s,
> > 4s, 8s, 15s backoff loop.
>
> You're absolutely right that if the address became valid in 1-2s, the
> third or fourth attempt would succeed. The problem is that in our
> environment, EADDRNOTAVAIL does NOT resolve in 1-2 seconds. That was
> an incorrect generalization from simple DAD scenarios.
>
> From the production dmesg (6.12.0-1-rt-amd64, StarlingX on Dell
> PowerEdge R720, IPv6-only Ceph cluster), the EADDRNOTAVAIL condition
> persists for much longer:
>
>   13:20:52 - mon0 session lost, hunting begins, first error -99
>   13:57:03 - mon0 session finally re-established
>
> That's approximately 36 minutes of continuous EADDRNOTAVAIL on all
> source addresses. This happens during a StarlingX rolling upgrade,
> where the platform reconfigures the network stack extensively (interface
> teardown/rebuild, address reassignment, routing changes).

Hi Ionut,

For how long of those 36 minutes EADDRNOTAVAIL was actually being
returned from kernel_connect()?  I'm trying to separate the time for
which the external condition persisted from the time that it took the
client to reestablish the session after the resolution.  The
"approximately 36 minutes of continuous EADDRNOTAVAIL on all source
addresses" makes it sound like kernel_connect() was returning
EADDRNOTAVAIL all that time.  If so, it would mean that the client
managed to reestablish the monitor session in 13:57:03 - 13:20:52
=3D 0:36:11 (i.e. just some double-digit seconds on top of the error
disappearing), which would seem acceptable.

>
> The reason the delays compound beyond the simple backoff sequence is
> that there are two independent backoff mechanisms stacking:
>
> 1) Connection-level backoff (con_fault in messenger.c):
>    250ms -> 500ms -> 1s -> 2s -> 4s -> 8s -> 15s (MAX_DELAY_INTERVAL)
>
> 2) Monitor hunt-level backoff (mon_client.c delayed_work):
>    3s * hunt_mult, where hunt_mult doubles each cycle up to 10x max,
>    so the hunt interval grows: 3s -> 6s -> 12s -> 24s -> 30s (capped)
>
> At steady state, each monitor gets ~30 seconds of attempts before
> the hunt timer switches to the next one. Within those 30 seconds,
> the connection goes through the full exponential backoff (several
> attempts up to the 15s max delay). The round-trip through both
> monitors takes ~60 seconds at max backoff.

What is meant by both monitors?  IIRC the client only tries to connect
to a single monitor at a time.  How many monitors does this cluster have
configured?

>
> > How many attempts do you see per session and in total for the event
> > before and after this patch?
>
> Before the patch (from the dmesg):
> - Total error-99 messages: ~470 connect attempts over 36 minutes
> - Per monitor session (one hunt cycle at steady state): ~8 attempts
>   (immediate x3, +1s, +2s, +3s, +5s, +8s before hunt switches)
> - The sync task was blocked for 983+ seconds (over 16 minutes),
>   triggering repeated hung task warnings:
>     12:52:11 - "task sync blocked for more than 122 seconds"
>     13:31:05 - "task sync blocked for more than 122 seconds" (new sync)
>     13:33:08 - 245 seconds
>     13:35:11 - 368 seconds
>     ...continued up to 983+ seconds at 13:45:26
>
> After the patch:
> - The ADDRNOTAVAIL_DELAY (HZ/10 =3D 100ms) replaces the exponential
>   backoff for EADDRNOTAVAIL failures specifically, so retries happen
>   at a fixed 100ms interval instead of growing to 15s
> - In testing with the same rolling upgrade scenario, the total
>   reconnection time dropped from 36 minutes to under 3 seconds once
>   the address became available, because the client was retrying every
>   100ms rather than waiting 15s between attempts at the connection
>   level

This is where I'm getting lost again.  It's stated above that in this
environment EADDRNOTAVAIL doesn't resolve in 1-2 seconds.  If it takes
minutes for the underlying error to disappear in this scenario, how
could the patch result in total reconnection time dropping to under
3 seconds?

> - Total attempts per event: similar count, but compressed into a
>   much shorter window with faster recovery once the address is valid
>
> I should correct the commit message -- the "1-2 seconds" claim was
> wrong. The accurate description is that the duration of EADDRNOTAVAIL
> varies widely depending on the environment: it can be brief (simple
> DAD) or very long (complex network reconfiguration during rolling
> upgrades). The patch helps in both cases by keeping the retry interval
> short so that recovery happens as soon as the address becomes
> available, rather than potentially waiting up to 15 seconds for the
> next connection attempt.

Is this setup experiencing the brief or the very long case?  Or is it
both, heavily intermixed?  Speaking generally, if the address doesn't
become available for tens of minutes, waiting for up to 30 seconds on
top of that isn't a problem IMO.

>
> I will also note that the connection-level backoff delay does NOT
> reset when the monitor client switches monitors via reopen_session(),
> because ceph_con_open() sets con->delay =3D 0 but the new connection
> immediately hits EADDRNOTAVAIL and con_fault() sets it right back
> into exponential backoff.

... but when the new connection goes back into backoff, it starts at
250ms, right?  I'd call that a reset since the new connection doesn't
inherit e.g. 15s delay from the old connection.  Are you observing
something different there?

Thanks,

                Ilya
