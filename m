Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541B46AA62
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115720; cv=pass; b=ojkQsizngQD+c77DOd62iSkVgR067oSAizoSti6oeHIg4MfK7v1krZIW7OWESTMP/ITk5kx9DJrhTyN643evPysxsqgStSdgSpDy/TRXM5m7vNKEDlAzT6IglkD9e2w7edu5yKv4tdr+mlBSoHvQ/qfznzMOi1SAObLP+ozZPVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115720; c=relaxed/simple;
	bh=EWhTHTn+OWnuuhEcJdKbNbsbpxHkgQ+m//GuxSpgv8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkTyV+u1uBCqg/JXL+N9awSOK9z8DGKuV0H3HWCLAzmOEEuJnmfSaD9PZETZQ9cfjzH/H4KBYXOlujyg2dUzJQ2LcCQsnyqbkp8zgggrnMO4d+Ncv0X2qXVcVMkmwt4aDTLGgeDUdR7CnXe0wmhBtTeO5nNdMNX9/T9X1H+u+q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5MsnAJc; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5MsnAJc"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf931c0e9cso185261e0c.3
        for <ceph-devel@vger.kernel.org>; Fri, 07 Aug 2026 08:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115718; cv=none;
        d=google.com; s=arc-20260327;
        b=Xe4zGNWbIbharDo1qxGhCJ1G8DvngPJSmiHADtS6WPtJStMMwCV5GOwtZvm7EWjncA
         AraJPK8i40iB+KjCrQPbMUOWjz0oFWfBgUpbmw7ihmOYo+jdHZit3G1ghtrVBkywZumb
         kghqZlv8aP6hvtPaSwqkdYJ9TAp7YSe276Qa0Etjs8JvbrBlRNNYKGm+/RIzohMXEQ9I
         VDQNNharXtxsqAPJbJB6HqiYqmoiFnozj/c2ravMZzhHuE/lTYqdoNwBUcZ0YS4qQUlt
         6AyIG5MGH7Z5+h7fvN6ka8mFxTfLGUkNAqzSsu7uqaAds8eZYj60nv1o+7TLmyF1RcT0
         E88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ov2CxRqHcHYMqrGtlXjkHs8CQ1d5Y7HjTsBViF9OA6M=;
        fh=3BwgWCR8AxgGyD6nnKrEbR/TFQHhBkncloAVmurVH6s=;
        b=sdvj509aEqSnj3uCpt2OGmcMfrFa1hvnm7kL6d4oWD/eUt/taHpcbqCSIUR5Bq3ZYF
         RX27N/bPtuPFFrexuETs106ZslRqg+u6+J4frRZd/03rgH0MoFqqelWr2fOJHheBIUUK
         4N/HuKkVmRNsTOFnc03owGDQZ/LhXsqPF8qt+3IpfVH6cfiULR0IzdIxFx6AzJa34oH1
         FLB0T0y6kCcsR6V2efCf53pMHJMqZolDhoGNrUBtVP2lrDHPAytNic8f1UnSOwSjY95p
         BxUzL/ocLzFbyYqktDvXZv+Q+I3TYkIi2PWlj2rFqg3nq3IESQlJ4sxfiTFZeNv13Hgs
         toJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786115718; x=1786720518; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ov2CxRqHcHYMqrGtlXjkHs8CQ1d5Y7HjTsBViF9OA6M=;
        b=Y5MsnAJcJHMREJlNOjyaprOEYhqx7srP0wqYmH6aOUd9CkRmb0pKe8ixxjmmgSPNiG
         5Zblea7n6dee5sMEYqs8HF+ntkX02xASVEu/bMtfsNlFy2os2BHWnxELZ/x11VGEHXqF
         OcEp0PUMHCCDARHNhgm7mOcdqbxqfM/zQDVOr1NKZLNe1oy6eZfhNm0M+gayOKT5G8x4
         hWt7bVR1m5sa5nE5eqCPzz1N+9qtaqJSnp9iivuL5Kl451GbpsTf3q4dxhhlcU/oP3fp
         43M2m0nKXNNQq+bCdpgx6Nj423xnCmSSOKl1NzTjy/PYZZteTrKL+8k3SoRmVkIIliWg
         JZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786115718; x=1786720518;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ov2CxRqHcHYMqrGtlXjkHs8CQ1d5Y7HjTsBViF9OA6M=;
        b=RmCiZG3t3hwG8o1SySn+GxBLmHveDJabDGk4SK4eB9OrhICLQkqESNdhdDcrc7dLbN
         1Be8px+LTjZjLzzaCz7IVRcFO0X7gqDutOxPTJRlpCL2u0yUui3Kf5e6QnR7MVKzW/Dh
         YG7i/yzeGh7PvcKI2lNW/DRIu2CutjfkymxYHtX37yL5WKC1rbS6PBDe++iXYF4sA/r5
         sHlT0Tnk1h2Ba/TSfaJOGowd7Zyj0niBBSwa1QH7Q9yBdwRL7Az0BFwIEBQvrDuKRL6q
         AyyeBuDeLIHgfgV5v609H/mJJ0T3f/cLtir1pBDcQBqVhZ3oH/lmI+tSfcOHStJZkBod
         SBWA==
X-Gm-Message-State: AOJu0YxfjBwJeEalqMjtO+kJLntBTQQvsFbqS5b6lJI4vpYtvYXTZjHw
	HkzuWeHIClyCEqf2kmw7PwjuVEXH8eR2+ZKkWZ54Z+myr33zgXk6Lfli071xkrkkAwQKyEfCk5y
	Eqfr/Gc5Lhdc7G/QC7FFBoYf58nixTPI=
X-Gm-Gg: AR+sD10rQuzK+nHuCrBXJA0vvycXiNsKcoY+sJBrhla1ic3AMmvEmPMuT9kGxjr+JT/
	GUeI9mLJ7mblV3EiwYQjwP0pwi4iZaxPXiyUfLvcL32hZoychgd6K9E0BqHaM92n9kULMM9zl8z
	YkNVnAiOzYT2rPoKxkHAISrIuBjRqyGasUDWibGuC5q6Q3pvGZkw+J0/ZuZZEiWBdCh3tgc+r4p
	ZUBrQnyz3gtsTfupN6MJ72/lQdct+FlGAmuKE1vTlrjSMJrWUvnjFK89eBDx1XCrjn4Ft8VmxRf
	85CQ2ciMtqZbMtZ126rRX7CTdeV3JENt8yHn573zTNA4qXBKJw/A4URfxfAqh2AxTsGl93vt2/8
	q
X-Received: by 2002:a05:6122:8601:b0:5bd:ae1c:afcf with SMTP id
 71dfb90a1353d-5c3d929878emr2744936e0c.3.1786115717916; Fri, 07 Aug 2026
 08:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com> <20260602050219.1043295-1-jhapavitra98@gmail.com>
In-Reply-To: <20260602050219.1043295-1-jhapavitra98@gmail.com>
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Fri, 7 Aug 2026 20:45:04 +0530
X-Gm-Features: AUfX_myxafkyN0hVSCzstxaKWa__jBsslsO_MS3wRG1SKpTXNyfO6JGnm_mHxHg
Message-ID: <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: fix multiple unsafe decodes in decode_locker()
To: idryomov@gmail.com, Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ilya,

This has been Reviewed-by'd by Slava since Jun 2 (v3), no outstanding
comments or NACKs on this one. It's been quiet for two months now.
Any blocker to applying, or should I rebase and resend?

thanks,
Pavitra

On Tue, 2 Jun 2026 at 10:32, Pavitra Jha <jhapavitra98@gmail.com> wrote:
>
> decode_locker() in cls_lock_client.c contains three unsafe decode
> operations that allow a malicious or compromised OSD to trigger
> slab-out-of-bounds reads:
>
> 1. ceph_decode_copy() at the locker_id_t name field has no preceding
>    bounds check. With p == end after ceph_start_decoding() accepts
>    struct_len=0, this reads sizeof(ceph_entity_name) = 9 bytes past
>    the validated buffer boundary.
>
> 2. *p += sizeof(struct ceph_timespec) after the locker_info_t header
>    is an unchecked pointer advance. A malicious OSD can position p
>    past end, causing all subsequent _safe checks to pass against a
>    bogus boundary.
>
> 3. len = ceph_decode_32(p) has no preceding bounds check, and the
>    immediately following *p += len is uncapped. A malicious OSD can
>    send len=0xffffffff, advancing p gigabytes past end and escaping
>    the decode window entirely.
>
> Fix all three by replacing bare operations with their safe variants:
>   ceph_decode_copy   -> ceph_decode_copy_safe
>   *p += sizeof(...)  -> ceph_decode_skip_n
>   ceph_decode_32(p)  -> ceph_decode_32_safe
>   *p += len          -> ceph_decode_skip_n
>
> A new out_bad: label is added to return -EINVAL on any bounds
> violation. -EINVAL is appropriate here: the data received from the OSD
> is structurally malformed, which is an invalid argument to the decode
> contract regardless of whether the caller or the wire is at fault.
>
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
>
>   [   26.183969] ceph_oob4_poc: buf=ffff888009e31000 end=ffff888009e31fa0
>   [   26.186087] ceph_oob4_poc: struct_v=1 struct_len=0 p==end: 1
>   [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past slab boundary...
>   [   26.187679] ==================================================================
>   [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
>   [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod/59
>   [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
>   [   26.188236] Tainted: [O]=OOT_MODULE
>   [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>   [   26.188236] Call Trace:
>   [   26.188236]  <TASK>
>   [   26.188236]  dump_stack_lvl+0x4d/0x70
>   [   26.188236]  print_report+0x170/0x4f3
>   [   26.188236]  kasan_report+0xda/0x110
>   [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
>   [   26.188236]  do_one_initcall+0x9a/0x3a0
>   [   26.188236]  do_init_module+0x27c/0x790
>   [   26.188236]  load_module+0x4a9a/0x6350
>   [   26.188236]  init_module_from_file+0x15c/0x180
>   [   26.188236]  idempotent_init_module+0x21f/0x750
>   [   26.188236]  __x64_sys_finit_module+0xba/0x120
>   [   26.188236]  do_syscall_64+0xe2/0x570
>   [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   [   26.188236]  </TASK>
>   [   26.188236] The buggy address belongs to the object at ffff888009e31000
>   [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
>   [   26.188236] The buggy address is located 0 bytes to the right of
>   [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888009e31fa0)
>   [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>   [   26.188236]                                ^
>   [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   [   26.188236] ==================================================================
>   [   26.255513] ceph_oob4_poc: len=0xcccccccc (OOB garbage from KASAN redzone)
>
>   0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
>   the slab redzone immediately past the 4000-byte allocation.
>
> Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> deployment can trigger this against any kernel client that issues the
> lock.get_info class method (e.g. during RBD exclusive lock acquisition)
> without any further privileges beyond OSD session establishment.
>
> Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v3: Split ceph_decode_copy_safe call to fit 80-column limit,
>     per Viacheslav Dubeyko's review of v2.
> v2: Move inline comments above ceph_decode_skip_n calls, rename
>     label bad -> out_bad, per Viacheslav Dubeyko's review.
> ---
>  net/ceph/cls_lock_client.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> index 4e6a6d3e4..79a449897 100644
> --- a/net/ceph/cls_lock_client.c
> +++ b/net/ceph/cls_lock_client.c
> @@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
>         if (ret)
>                 return ret;
>
> -       ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
> +       ceph_decode_copy_safe(p, end, &locker->id.name,
> +                             sizeof(locker->id.name), out_bad);
>         s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
>         if (IS_ERR(s))
>                 return PTR_ERR(s);
> @@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
>         if (ret)
>                 return ret;
>
> -       *p += sizeof(struct ceph_timespec); /* skip expiration */
> +       /* skip expiration */
> +       ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_bad);
>
>         ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
>         if (ret)
>                 return ret;
>
> -       len = ceph_decode_32(p);
> -       *p += len; /* skip description */
> +       ceph_decode_32_safe(p, end, len, out_bad);
> +       /* skip description */
> +       ceph_decode_skip_n(p, end, len, out_bad);
>
>         dout("%s %s%llu cookie %s addr %s\n", __func__,
>              ENTITY_NAME(locker->id.name), locker->id.cookie,
>              ceph_pr_addr(&locker->info.addr));
>         return 0;
> +out_bad:
> +       return -EINVAL;
>  }
>
>  static int decode_lockers(void **p, void *end, u8 *type, char **tag,
> --
> 2.53.0
>
