Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C334BA24
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2026 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126439; cv=pass; b=Y1v1nxevqPPf1+nPUTbanzZ4YKjGjkHac3zf0/dhDJfU4/lKVFuTD3yt/TbG4nmByuu9mWOEXUv9QomSMZ3kazXCvtMd/WcBDie1NHJrNEGgxUFGwmeK60tIlFY5OLUTbhr8X/NT8VoBZwpSYSbFCmDUzoGqwcd57ufEevXKk3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126439; c=relaxed/simple;
	bh=K3Xuf0R4IM+Zbo4XXVROPT6Z2IDLZipVyLye6XobMiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6zj4b8eQrLhtMHXEh0QPefjVFfusFVZW4yPIdKg17qQwNjb2rGBbQPN7+oPMakRCO5IQZhso8R4Ro1Ak3I8ErhzYc5Edm2to9xslgxepO2qctrv89HFB+KZmPjs0+QfKhvVa9LaXcBZj/Gon2df3oIRRunrOIjrR3p3Ms7jwUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnmoyMzW; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnmoyMzW"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-96935063700so2102827241.0
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2026 11:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786126437; cv=none;
        d=google.com; s=arc-20260327;
        b=pAWf8+xwjb1Vxrdr5dpLR1t9Xqm+gN1kpSiLq3sYiactM+zrCmcDTHGZIL+WKNT+hQ
         osRq/bY7JqsDLeTWC64V7NUq0gIPCU4ZUdlHCYNKbA9R4qZb/Z0dV324oBD6YYernR79
         yCQRAHtA6VaShGtFak+Suyoh1CWihtCXQGtLQPbRA+iPbOucVYUMpPgbWCwd3+6PQwsx
         hRwI1k4tF3j7Bpqp5fRMeQ2+lAZoRjdbmxvwCNpnaNQZyLNCAOcogC23G0yn7CtP47Ka
         auC6WBhMQ19IP2MOmZgYN/5CnnXAiaUq4Lx3YNnXBQNhJfQg1N7EHEVWWkJoWgjmfZR9
         QN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        fh=pIK+bk78BAcQVcVu3IGQLiiBakBTdvz7v+3RXF+eFM4=;
        b=EznADSZrAKG7BZ/+RVpx5K1wg74TKkzfzZL6bK5wXVhcREs0xQKCM6YGBq6Coe/8OO
         Zv7nkQLdyfsUE7eNwTgrS9kvWQ+/qR0qyya9vDqUplsPiNNULmgTuURS5hq4lbthA+kV
         auiATrTSDGxB/wxCwFd9KLv1bdfh8xIK6LVBLj4nFZOy3bfWJhXa0AQKPOmpjb9S1P8i
         aYN9BfhRwDpkkQce3FAIalpGcwbZxBX7zSfeqIRY6fff/rxKPQiTE4q5H8d3nS5xp8Nz
         aSoYVYTwkCoE7UXM5LB5kplDhid8owb3y8x2HqNOOEOHNWtUq5eMDWP8hYypc67gpR5h
         RpZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786126437; x=1786731237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        b=WnmoyMzWba4poxUVruEJ+D1IobNEGN0K/4akehXk5m9BqgN2CO01QABrJv1l3n2OFj
         dJqO85xLp9bCK2LeepIQoETrGHOP+Q2BtxnMyDFvqVK2yFrwWMzkqirDgZ3iwAU3MmaI
         hYbF9toVcWoO7gWgwnf5VAyJiDdSKUKDIUT5tl+PS7czKU8xD5Omi0CKDEDZKeSSjSsS
         adTvHfQZr+u8UUEDSreBCYms0mSNdZ5j0CmNYoXm8Bit1J+g1NixSAE8/KJ7Km7HWbZV
         D72SB9uPMz8meIXkIyLuMe6pyHfDSXKuBllhGgxWWtDKWdrCZBJtpSxUKDfnwV3l2W6A
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126437; x=1786731237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        b=kAhiH9xKYlGQRdHV/dPR5ldaPYM9uxzovYLO+zq85jjsms5AKY2yo8LABLOaDqds7r
         Hi5JLqda+zlU75VTRe9We2q8tZtNnHkI2G4js1HAHZZVHOdBtkFdMRVjYKM/Vj7BegjD
         Y6KK5Vidsiht1EQejMTeDFP3EU3pA5Z5U+jxNEzIH7IY6CmDetvZZjRvVSvz0tim3qR2
         TcX6TCMnw2Tn9jeL7akJ8UtJf9pToJo+5OQSCQyYut5kVGF5UJBOQ8HaMJgSph9LaC6B
         FAL9aZ8t8mwpwzYSJaCHz/s3Ox/oHWCqm5OkQhms3zutN+LmrOk3plUzrFxntODYBh/4
         dNvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpaEOLAS18bthw9K4H799slBHZ8XyTgPFqzWlT1bmTgw2ZCkZZqyffHjjABi3uQC+nVpV7sR920KmTU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TaMuOmA6H3y/X7uTpoveeNECvbo/6GT1RCgSoHsmzirBjU82
	dLcENs6iJQ6KUYUOnkImEPwseLHrDi7+UEO6E2Bhs8RC7dIGKyUWNcbOwd6KCzRtaKx4T1ghoj+
	Ryn/3PwQOezJTSxCMxA+IOSQ6sGO1GjU=
X-Gm-Gg: AR+sD12aMkAw4TsKdc0UVQxb5VIrJ8/Y0O7OIBFO9Jg+ByhdaQV6t5sILDYwaMFZne1
	EOVy8mFav9c/66cdZ+Qz53Kiq74os6BqSKkMJFAV/DNMOFHakURVEtxO0zylgl3DIHxkm04A5vh
	T1nvtXrrp+xL8L84/hXTLrxqyhvfvvP6skK3xHSj97fB2RS+S1pRluMg41Hk+DvFUjN4q0nlLCL
	BXdt1Db2VlRQMndROUODvilO8NPv/1DCcsVRj8Gp/P4eWXD5O8qBWnziXg3JGBI7rTHGrHrZiW8
	S7bL98FBP66nbXxLAgCHrxcDWs662vT6BRHPNBfxiPVIwMgIBW6cNSzGhLk0lcY7qJK9xt8puRv
	KGg==
X-Received: by 2002:a05:6102:4bcd:b0:74a:b492:3a62 with SMTP id
 ada2fe7eead31-760e7cf60a9mr9067303137.4.1786126436709; Fri, 07 Aug 2026
 11:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
 <20260602050219.1043295-1-jhapavitra98@gmail.com> <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
In-Reply-To: <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 7 Aug 2026 20:13:44 +0200
X-Gm-Features: AUfX_myaOVIROm8ifzt-g7-Tn9KOW2aJbXRe1sRMeX-CyhuzEZwrcqkF_L5RqaY
Message-ID: <CAOi1vP_4FW-j=UNw0HGUpuK2+7gY8W1bSexu4-92bikYvxoXwg@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: fix multiple unsafe decodes in decode_locker()
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Slava.Dubeyko@ibm.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:15=E2=80=AFPM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> Ilya,
>
> This has been Reviewed-by'd by Slava since Jun 2 (v3), no outstanding
> comments or NACKs on this one. It's been quiet for two months now.
> Any blocker to applying, or should I rebase and resend?

Hi Pavitra,

Sorry, no need to resend.  Slava forgot to add this patch to our
integration branch like he did another similar patch of yours which
is already upstream -- "libceph: fix two unsafe bare decodes in
decode_lockers()".  I'll eventually scrub the list and pick up anything
that was missed this way, at this point likely into 7.3.

Thanks,

                Ilya

>
> thanks,
> Pavitra
>
> On Tue, 2 Jun 2026 at 10:32, Pavitra Jha <jhapavitra98@gmail.com> wrote:
> >
> > decode_locker() in cls_lock_client.c contains three unsafe decode
> > operations that allow a malicious or compromised OSD to trigger
> > slab-out-of-bounds reads:
> >
> > 1. ceph_decode_copy() at the locker_id_t name field has no preceding
> >    bounds check. With p =3D=3D end after ceph_start_decoding() accepts
> >    struct_len=3D0, this reads sizeof(ceph_entity_name) =3D 9 bytes past
> >    the validated buffer boundary.
> >
> > 2. *p +=3D sizeof(struct ceph_timespec) after the locker_info_t header
> >    is an unchecked pointer advance. A malicious OSD can position p
> >    past end, causing all subsequent _safe checks to pass against a
> >    bogus boundary.
> >
> > 3. len =3D ceph_decode_32(p) has no preceding bounds check, and the
> >    immediately following *p +=3D len is uncapped. A malicious OSD can
> >    send len=3D0xffffffff, advancing p gigabytes past end and escaping
> >    the decode window entirely.
> >
> > Fix all three by replacing bare operations with their safe variants:
> >   ceph_decode_copy   -> ceph_decode_copy_safe
> >   *p +=3D sizeof(...)  -> ceph_decode_skip_n
> >   ceph_decode_32(p)  -> ceph_decode_32_safe
> >   *p +=3D len          -> ceph_decode_skip_n
> >
> > A new out_bad: label is added to return -EINVAL on any bounds
> > violation. -EINVAL is appropriate here: the data received from the OSD
> > is structurally malformed, which is an invalid argument to the decode
> > contract regardless of whether the caller or the wire is at fault.
> >
> > KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
> >
> >   [   26.183969] ceph_oob4_poc: buf=3Dffff888009e31000 end=3Dffff888009=
e31fa0
> >   [   26.186087] ceph_oob4_poc: struct_v=3D1 struct_len=3D0 p=3D=3Dend:=
 1
> >   [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past sla=
b boundary...
> >   [   26.187679] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b=
/0xff0 [ceph_oob4_poc]
> >   [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod=
/59
> >   [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G         =
  O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
> >   [   26.188236] Tainted: [O]=3DOOT_MODULE
> >   [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> >   [   26.188236] Call Trace:
> >   [   26.188236]  <TASK>
> >   [   26.188236]  dump_stack_lvl+0x4d/0x70
> >   [   26.188236]  print_report+0x170/0x4f3
> >   [   26.188236]  kasan_report+0xda/0x110
> >   [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
> >   [   26.188236]  do_one_initcall+0x9a/0x3a0
> >   [   26.188236]  do_init_module+0x27c/0x790
> >   [   26.188236]  load_module+0x4a9a/0x6350
> >   [   26.188236]  init_module_from_file+0x15c/0x180
> >   [   26.188236]  idempotent_init_module+0x21f/0x750
> >   [   26.188236]  __x64_sys_finit_module+0xba/0x120
> >   [   26.188236]  do_syscall_64+0xe2/0x570
> >   [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   [   26.188236]  </TASK>
> >   [   26.188236] The buggy address belongs to the object at ffff888009e=
31000
> >   [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
> >   [   26.188236] The buggy address is located 0 bytes to the right of
> >   [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888=
009e31fa0)
> >   [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236]                                ^
> >   [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.255513] ceph_oob4_poc: len=3D0xcccccccc (OOB garbage from KASA=
N redzone)
> >
> >   0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
> >   the slab redzone immediately past the 4000-byte allocation.
> >
> > Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> > deployment can trigger this against any kernel client that issues the
> > lock.get_info class method (e.g. during RBD exclusive lock acquisition)
> > without any further privileges beyond OSD session establishment.
> >
> > Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> > ---
> > v3: Split ceph_decode_copy_safe call to fit 80-column limit,
> >     per Viacheslav Dubeyko's review of v2.
> > v2: Move inline comments above ceph_decode_skip_n calls, rename
> >     label bad -> out_bad, per Viacheslav Dubeyko's review.
> > ---
> >  net/ceph/cls_lock_client.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> > index 4e6a6d3e4..79a449897 100644
> > --- a/net/ceph/cls_lock_client.c
> > +++ b/net/ceph/cls_lock_client.c
> > @@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struc=
t ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
> > +       ceph_decode_copy_safe(p, end, &locker->id.name,
> > +                             sizeof(locker->id.name), out_bad);
> >         s =3D ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
> >         if (IS_ERR(s))
> >                 return PTR_ERR(s);
> > @@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, str=
uct ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       *p +=3D sizeof(struct ceph_timespec); /* skip expiration */
> > +       /* skip expiration */
> > +       ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_ba=
d);
> >
> >         ret =3D ceph_decode_entity_addr(p, end, &locker->info.addr);
> >         if (ret)
> >                 return ret;
> >
> > -       len =3D ceph_decode_32(p);
> > -       *p +=3D len; /* skip description */
> > +       ceph_decode_32_safe(p, end, len, out_bad);
> > +       /* skip description */
> > +       ceph_decode_skip_n(p, end, len, out_bad);
> >
> >         dout("%s %s%llu cookie %s addr %s\n", __func__,
> >              ENTITY_NAME(locker->id.name), locker->id.cookie,
> >              ceph_pr_addr(&locker->info.addr));
> >         return 0;
> > +out_bad:
> > +       return -EINVAL;
> >  }
> >
> >  static int decode_lockers(void **p, void *end, u8 *type, char **tag,
> > --
> > 2.53.0
> >
