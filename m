Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B593793AC
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564522; cv=pass; b=uD3G/jgnvQvntI8rJ67HAOZ362O+lIE2Z1FzpNHydHBDom6ebDPniHuspWd/ztF0EzTflNsOkeEGyBEvU2YXmF42WUR3IXRq2GMle7GRINx2c2ETuapR1xK4XLfWt1PtljAT2YsJYyHjLDEq4yaM4PlQ5titG/U67K8VYe3lsSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564522; c=relaxed/simple;
	bh=aVHP6aOrXDQiPayu7rSfj+AIL/ngK9HNzzA4FQjdLwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSQVtD37EDLrijW9dbSx9N1Ab3ww72pxoQtybH62ictivDs/8a1v8u2Zq+g7ehxxKZWkSCNAvF7+Xi/boDQrbMllAahVvCS61AW5COa6JWpyrGe8j1S64jpZgcc1Wa+jkW5XXjqZxlJkTj26PLSFt+5Z/JPMIwSpQmahzPWwuTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hINF1b9A; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hINF1b9A"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso378780241.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 12:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564520; cv=none;
        d=google.com; s=arc-20260327;
        b=kd1zK68qJ4EKb46yuGqz/0KTN3lYw5w82P1ZoAkexb/yOJS5aZP2n59G3YW4cyDfUC
         dIYU/ciZePXq7n0T3yoY3qfMK8I3pco/VlysLEoi5xbKs/g4OvMErw7zMAfRuE/5h/Ll
         Bf0tb3tFv7UF1zqal8rLJWi6CfRJEfA7Ic/s7er4pCLWrDZfLwJFDUJVxJ0r3Jbn06PO
         rnsB3F9QhzYFuF5wMitFsOdEdhmibyWYNklEW8T91QbknQVfl/JlMR0e5zrOi82GdyKv
         0NFpKCf8t/gmdtfgBdUUNP1uyap2g/aeR+p4cbqR5pfLEXuzfaNy5J9Eq4cRTL6DeDuz
         WEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        fh=Dred71HeP9ajSjCTRMEgFaRA1SfJIoRRWKyXpg9mfM0=;
        b=XG0Xi6+R9hxtA1//ts2G1+odXODjs35ApE6CSHI1dQ26nowUelMQEOLetL14aNk7ei
         Z3Eks++l2BoTfxbQwArL1FH5BWgDpgiUCBaGWpX9JCDbxBrEG8mYHireBi0PROSlTT/9
         10ne6LOfKCNKZqtPCQXNb5f35d1FvU3T6AzYzwfCFX0mRqSAXx8sXc4QvjEpJOsBREDK
         z35BcBAKlrUgZlyTV6HiiTpfMeIZIvER96S0nBHMs3osnxKidvV9bJknnujowgAqJrSt
         M0lEUwRopKBXjJLequDUazMmiD86Seeto2d9QWBVF9Y2DXOQO/vxiELRPq6lhVT0/lqs
         obBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564520; x=1787169320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        b=hINF1b9A/ajp2mUM6O8F/fcjTeQXVcatvxiPFE7qzOQ/l9t5IalThPXg7fVHIb2su1
         dxrfVnfEXKkTLEa+81L6hO0OAPr17RBWbizwpx3vqn+tFonHhjrHlzo7csBPYx4OWnKi
         hk5mt0iPFxl9nUaOI9RavPgLEAHutJwfoV5qunFoz7HER8vQgpJo76BLvYjkTrnOfrnq
         fTts9cWmqj9SziUSH0pU3Nr0uB9sfUwVsOdyhEmOAFdEM2EtOgxlMJr/ebxlT3ynDQk+
         JFTXtmDM2yV5zMhotcTEfnTnEXG95Shdk3Uw8EjI7WiJ2kgZXN45NWbQcXUEiSlLTFHU
         QGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564520; x=1787169320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        b=D0b9zazk2FsfB2WZepAPoP5q4Noozc48P3EO9QRsDWeIo/oFwWujRae09td+VJyo6s
         SS3eokNCVFuRoL7b/kv0uEzGENtXJiYGVHbIufMrbPAEJpT9ztIgYFkuJQj/aUKEkKHx
         PtmoGWPqi6hxjmV3SCxmArQyikU4tE6+suM5jiE4cF6IZkjFj1QcZbEpSt/gd62SC7Yh
         eao4TtnjDT5n9+o4p6BtedCwPpUgRCxuTvnqCYhFl6Az9hc79m1k2hOiqpCl7oxT3IeL
         4AgQvib0l7hT6o7OIfg1HZrJqR4svfOfhWOitJtau/GII1oli/3IDqFYdGzwSgGd4zaO
         GenQ==
X-Forwarded-Encrypted: i=1; AHgh+RphYyNI1PKic3n8tdFl0sMTry0KspE/87I+O7FOI4YKKBCc9HADxp8DmBZ/5l4zVFM8zBVSI1X6wYul@vger.kernel.org
X-Gm-Message-State: AOJu0YwjXU+zY3JqLriQRP5MOwy3xrXL0lpTN6szQggqkXwQ0AoXh7Ws
	97esSqbyrz0OSpE0w/44RgeIAMb9vRB1JPqN51EHlmtOiI2RGOku6NimW96sxnmgLHXCuQcjref
	84WVHfwRbyGBGCLMweaEkONlSlfNqN9s=
X-Gm-Gg: AR+sD13evofUVoPdm1uQncEijkp1NTpste7tWflu8R6hioKVt22JEk+hOrK8e+Gup11
	QXVMrZKZ3dagsHqTCWF2SHhHsjMWh8GKMwAb4LrpCQgnSToMFTcmAjwxBgrM42WxVN4KupXEGp/
	vRqfKSckEtLU78BUvtFT2dJ9BvSmaZ/tn88ombThyFlCHDR3tX54d8xlsbYz3MuW/ZmH4G7n2EH
	6lKMQpfJ9KGcRIhnycgT3cSdWZfCAJSxmAczJHA6dVDzXGLL5BZObTLyMI10stH1dfwkAnH7Rcj
	FGnDn30ZF3vIlTs5u62VyscDVS/YLBgQl6fOLQwaGkSnLu9vyE+W7HBVyq/v3FBAVhVJeweHUEg
	i1LdvfP5Um2Hg
X-Received: by 2002:a05:6102:2b85:b0:74a:b1ee:e034 with SMTP id
 ada2fe7eead31-76db6884b10mr227289137.8.1786564519957; Wed, 12 Aug 2026
 12:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702114034.917507-12-amarkuze@redhat.com> <20260708053941.90316-1-jhapavitra98@gmail.com>
In-Reply-To: <20260708053941.90316-1-jhapavitra98@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:55:07 +0200
X-Gm-Features: AUfX_myzt3DZxzwoVJieGS3PuCqaD99jyI5Z3-nuBvhafXSZMGJzvxBTER8UqCI
Message-ID: <CAOi1vP-14HiHikaQuiKPjaMd35ujMu+dE0+V__7Km1o=JHvcDg@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix OOB read in decode_watchers() via missing
 bounds check
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: amarkuze@redhat.com, slava@dubeyko.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 7:40=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> ceph_start_decoding() validates that struct_len bytes remain in the
> buffer after the encoding header, but accepts struct_len=3D0 as valid:
> ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
> compromised OSD sends an obj_list_watch_response_t reply with
> struct_len=3D0, ceph_start_decoding() returns success with p =3D=3D end,
> leaving zero bytes guaranteed for subsequent reads.
>
> The immediately following ceph_decode_32(p) in decode_watchers() has
> no preceding bounds check. With p =3D=3D end this is a 4-byte read past
> the validated buffer boundary. The garbage value is then passed
> directly to kzalloc_objs() as the watcher count.
>
> The sibling function decode_watcher() already uses the safe variants
> (ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
> after its own ceph_start_decoding() call. decode_watchers() is the
> only site that uses the bare variant, confirming an oversight.
>
> Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
> *num_watchers, bad), consistent with the established pattern.
>
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
>
>   [   72.047085] ceph_oob_poc: buf=3Dffff8880085936c8 end=3Dffff888008593=
6ce
>   [   72.048685] ceph_oob_poc: ceph_start_decoding OK: struct_v=3D1
>   struct_len=3D0 p=3D=3Dend: 1
>   [   72.049477] ceph_oob_poc: triggering OOB read past slab boundary...
>   [   72.050699] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   72.051427] BUG: KASAN: slab-out-of-bounds in
>   ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
>   [   72.051427] Read of size 4 at addr ffff8880085936ce by task insmod/6=
1
>   [   72.051427] CPU: 0 UID: 0 PID: 61 Comm: insmod Tainted: G O
>   [   72.051427]  7.0.0-rc7-g9c2abf69da83-dirty #14 PREEMPT(lazy)
>   [   72.051427] Call Trace:
>   [   72.051427]  dump_stack_lvl+0x4d/0x70
>   [   72.051427]  print_report+0x170/0x4f3
>   [   72.051427]  kasan_report+0xda/0x110
>   [   72.051427]  kasan_check_range+0x125/0x200
>   [   72.051427]  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
>   [   72.051427]  do_one_initcall+0x9a/0x310
>   [   72.051427]  do_init_module+0x186/0x410
>   [   72.051427]  load_module+0x2ba7/0x2e50
>   [   72.051427]  init_module_from_file+0x15c/0x180
>   [   72.051427]  idempotent_init_module+0x19f/0x430
>   [   72.051427]  __x64_sys_finit_module+0x78/0xc0
>   [   72.051427]  do_syscall_64+0xe2/0x570
>   [   72.051427]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   [   72.051427] The buggy address belongs to the object at ffff888008593=
6c8
>   [   72.051427]  which belongs to the cache kmalloc-8 of size 8
>   [   72.051427] The buggy address is located 0 bytes to the right of
>   [   72.051427]  allocated 6-byte region [ffff8880085936c8, ffff88800859=
36ce)
>   [   72.051427] Memory state around the buggy address:
>   [   72.051427] >ffff888008593680: fc fc fc fc fc fc fc fc fc 06 fc fc f=
c fc fc fc
>   [   72.051427]                                               ^
>   [   72.051427] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   72.129720] ceph_oob_poc: num_watchers=3D3435973836 (OOB garbage)
>
> 0xCCCCCCCC (3435973836) is KASAN redzone poison, confirming the read
> landed in the slab redzone immediately past the 6-byte allocation.
>
> Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> deployment (e.g. cloud) can trigger this against any kernel client
> that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
> beyond OSD session establishment.
>
> Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
> Cc: stable@vger.kernel.org
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v4: Rebase against current linux/master and ceph-testing/testing.
>     No functional changes from Slava's reviewed v3.
> v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
> v2: Correct commit message; retracted overstated impact claims,
>     verified with follow-up KASAN harness.
> ---
>  net/ceph/osd_client.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c..2cdac81a6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
>         if (ret)
>                 return ret;
>
> -       *num_watchers =3D ceph_decode_32(p);
> +       ceph_decode_32_safe(p, end, *num_watchers, bad);
>         *watchers =3D kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
>         if (!*watchers)
>                 return -ENOMEM;
> @@ -5044,6 +5044,8 @@ static int decode_watchers(void **p, void *end,
>         }
>
>         return 0;
> +bad:
> +       return -EINVAL;
>  }
>
>  /*
> --
> 2.53.0
>

Applied.

Thanks,

                Ilya
