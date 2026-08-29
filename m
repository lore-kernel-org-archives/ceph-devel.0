Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4B34CFA1
	for <ceph-devel@vger.kernel.org>; Sat, 29 Aug 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006835; cv=pass; b=IkXyhh3ORUYjS2YhUgQQjwNncjgHdgfINgEu+/t6S0kEb66o/X34ttO7eFeLpuqcWrsY9Wp3aEzfZYuU3q5NIh+qM/cDXVwqvyG+CDnVUpXUrh0/htCuO8LbvtzZ18pD90ery3ba8WV/azoK3Ou/2VC90xprnhqspSO2/KZ+gRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006835; c=relaxed/simple;
	bh=hBwV6bw+8UpmBV7uVU1vSp5FlWAejGuVAmSKursMnzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XF8MGLfEkVYq4T6ZSPBiQiRQgcfP2JoDv8St02T3KTLh1XQL1tZOL0QEKhj7zZSyFifAjk6JMNUvlfTj3Cps9SUZbeezbIqY5uStt0YDu8rbroDj3dOOwygs1jEB6llAjLz4UUhmxHU50/wHSX/PMKfs1NtzBQ3XsKRn4AK5/BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=cgdAAOfR; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="cgdAAOfR"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1670dad7a8so304020666b.3
        for <ceph-devel@vger.kernel.org>; Sat, 29 Aug 2026 05:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788006830; cv=none;
        d=google.com; s=arc-20260327;
        b=JkMAzci9/Ahm17ypiDJSTvLERbKm2ScyEjG5CQBGJv17FyWRCJlgoSura8ulgFTSfD
         8tFr46shwZEWssZy/qqh98RL2YYT0KbMlXqB8tVQ/Ntcs+Wy0CwglfhY7ptW+k69w/RU
         Weqt/chl7kFQGi0BS0J4nPROGY3PxUfKQSZIrL+uyIfsJiiQ4wismO2Gf02c2MpENgd/
         j6YvMvpy8hLDia1EKaU3fCOQdPOKhyWG3VaZ3GsNu8IkKEc3J7ol6opgwwzV5E7CnQnL
         6b4AYYqbA4dEGVOFd9gRJWqPg9+Qq8/MP5AhXC5Zbk4yDbT4XStohAjIvk3RjCWa7jHM
         smZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eleisf3XG7h/r4Bt4oplKXRzj71VJ+TpPnU8vz1RmL4=;
        fh=n+LfmJGlj2+y+D0uvhKBhGA7/QJbrOQMA7VNsCdyb70=;
        b=Qi8nhBws9P6l+jasW4XzcJE6u0mu8ClbUm728885Ly2aYjV7X2FMT5wbiVa6OBQa9k
         y8A9X28aU4f/T57jWpZVbV6KCBqDk3eb33VHZJ72JbFQGq6qvkfc3/+Py9VWZBznd47h
         lwvKdGhF3Y2AX7X+LHUnPjP6deTLQyV1UbYQtKBehbwnvUG/YEY925I0SrhlLI3H0Kim
         p5H+IUlpDljzVIV5e83DFxUzmcD+fmRf0/hqlhAgflWwED/k0f7Vp5aRbBYmemPb6NAk
         dUz1Y/XshiaCpDRFizrkEZ3cVpuqshXCRqh5oIrEe08ve6bQP7uwzr16mPQzEMjxMwHh
         IR2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788006830; x=1788611630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eleisf3XG7h/r4Bt4oplKXRzj71VJ+TpPnU8vz1RmL4=;
        b=cgdAAOfRToRAu3QigzA2nTO6OtCaV0oG0T93EPsESfQxRNCkm6bYTqyvej6UlgHQBz
         BoW64dTHpZSX9V1VeDpHus+ph0yD8RCmiVVQvPXI/A5YMV4MijnIFZtOK3PXB5kT5x/s
         WY7eXCt30xNhBp4ljuK4O4quslLDXeIP9Id4reEbQWfryFr6XEEHDqpiu6yrbnEY/VSf
         keiTcAAax5Kpop7Qti0okRlK3dOlr5FK5z/aMgAi6wuH100dYEO3Vg4SlCdf+Un/+UUO
         IzqZijHwe8oW/m5aspxP3xH5JBZzFDg3uX7F5CZzytiDfnW58jkRUSMOFV6cNWEb4jvZ
         qRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006830; x=1788611630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eleisf3XG7h/r4Bt4oplKXRzj71VJ+TpPnU8vz1RmL4=;
        b=O/PGN8m2+jlx/tdSXB/95HxGbkMirC4fAHlT9dlZd29aPvrtt7P+eoRKAnjXBUoRh8
         AD8uE/j8gJSVO7SilzZnl90eQbYlHPBLseFqPcZTFAXs+CTWM0StrTIy6zJrYWzq1L9Q
         s4EzEobNbDc/ealoxWgKU5FmzXpuw0kL/odsSLBVUWdvAmLF9c3xstv4tEQcntTr5ijx
         h+W3m//gLjDHOV8HqLHx1I3gpSai9NqqYDWGBRAyWk6/RxiJjSodJpGPuOMAvug30nAL
         /A8vt+0Jpyrm7AN89TQRxczv9Jt38/OMn0PAmy12Q0Ktazy/3EVj1+/p26eN+1caaxpJ
         YfRw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5ZkaFoxPyd/BAVXDMbYJxXzJvtotyx4/WsOkrXVYg1bEZvquPyHJB/rY+qxLAYSUTulKW+WQlQDcI@vger.kernel.org
X-Gm-Message-State: AFuF++nd6pieA4yVwNxpKPwtNUxNrD0tNSDqprgcLjkYpTBrAjQy3ob4
	bhAE6jqcRRs8DVssmSALXfM0AsT8Lln9QXltmFeVPr6nES/oZdzoJyfTaHEChAu+1+yHlzQdVvF
	/EOlgYj3ogi6BThxr07vP/OEwjU+XhfghFp56IZOtdQ==
X-Gm-Gg: AR+sD13jJ6Ek62MvbTpjvSh/chhvFuWCZ7WaXb2+P7R/eV7nNtloZVx51YV1slOzVGQ
	e6VEJ7FHLPwExKqEaFWBlLgmPDj7hvqWcoOUZOOiS6qUGGGFutCjkzK3LxilB84Vgten103WSlD
	egtFcFZKVlmUhhZYp/14zGysQtC1OLRsIBDUqEPyH3BG0OcThvHeaN1Zx2kPTYOw0P4n1wmOexd
	uVSuEs5t2X17XiZRoDVy1rPmYhaEeAsjUC5tNDdCqNHFs0qPWsEPoSIv3yQUl68qhIivjvbSis8
	fo6Wa3xB7ZSj4tB556fQso8QRWMivMgIkUwDsQDb1BIlqA==
X-Received: by 2002:a17:906:100e:10b0:c25:74ee:9e3d with SMTP id
 a640c23a62f3a-c2574eeae06mr153899566b.14.1788006830455; Sat, 29 Aug 2026
 05:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-b4-ceph-fix-abort-request-uaf-new-v1-1-96e480d5a028@clyso.com>
In-Reply-To: <20260828-b4-ceph-fix-abort-request-uaf-new-v1-1-96e480d5a028@clyso.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sat, 29 Aug 2026 05:33:37 -0700
X-Gm-Features: AcwNN1VWDF9gPaDesRBI7J-vzZ4wmg5MfBnswgC6T-0HRwQHc_bfSmNuQ9uK6yc
Message-ID: <CAOJNxR+F0C5R9rXzCxm57hHcmqatzxaF3TR1LvV-8skrtUSoZQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: unregister aborted requests in ceph_mdsc_wait_request()
To: xiubo.li@clyso.com
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also found one bug of this patch. I have respin for V2.

Thanks.

On Fri, 28 Aug 2026 at 00:19, Xiubo Li via B4 Relay
<devnull+xiubo.li.clyso.com@kernel.org> wrote:
>
> From: Xiubo Li <xiubo.li@clyso.com>
>
> When a request is aborted because the waiter was killed or the wait
> timed out, the abort path marks it with CEPH_MDS_R_ABORTED but leaves
> it parked on a wait list (r_wait) and registered in the request tree.
> The waiter's put can then be the last reference while the request is
> still linked, freeing it with r_wait non-empty:
>
>   WARNING: fs/ceph/mds_client.c:1233 ceph_mdsc_release_request+0x247/0x25=
0
>   WARN_ON_ONCE(!list_empty(&req->r_wait))
>
> The freed request stays behind as a dangling entry on the session's
> waiting list, and the next __wake_requests() or kick_requests() walk
> uses it after free (a stress test that SIGKILLs waiters during MDS
> failovers reproduces this reliably).
>
> Fix the abort path so that the request is removed from its wait list
> and from the request tree when the waiter gives up, making the waiter's
> put the final reference on a request that is no longer linked anywhere.
> Both operations happen under mdsc->mutex; a racing reply or forward may
> already have unregistered the request, so only unregister it when it is
> still in the tree.
>
> Fixes: e1518c7c0a67a ("ceph: clean up mds reply, error handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> The full call trace:
>
>  ------------[ cut here ]------------
>  refcount_t: addition on 0; use-after-free.
>  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x6a/0x90, CPU#1: k=
worker/1:1/99
>  Modules linked in: ceph libceph krb5 netfs xsk_diag vsock_diag uinput sn=
d_seq_dummy snd_hrtimer rfkill nf_conntrack_netbios_ns nf_conntrack_broadca=
st nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject=
_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc intel_rapl_msr intel_rapl=
_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_disc=
overy pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telemetry intel_vs=
ec kvm_intel kvm snd_hda_codec_generic irqbypass snd_hda_intel rapl snd_hda=
_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_seq i=
TCO_wdt snd_seq_device intel_pmc_bxt snd_pcm i2c_i801 snd_timer pcspkr i2c_=
smbus snd lpc_ich virtio_balloon soundcore joydev zram lz4hc_compress vmw_v=
sock_virtio_transport vmw_vsock_virtio_transport_common vsock virtio_net ne=
t_failover virtio_gpu failover virtio_dma_buf serio_raw i2c_dev qemu_fw_cfg=
 virtiofs fuse
>  CPU: 1 UID: 0 PID: 99 Comm: kworker/1:1 Tainted: G      D             7.=
2.0-rc7-lockdep+ #13 PREEMPT(lazy)
>  Tainted: [D]=3DDIE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-10.fc44 =
06/10/2025
>  Workqueue: ceph-msgr ceph_con_workfn [libceph]
>  RIP: 0010:refcount_warn_saturate+0x6a/0x90
>  Code: cc 48 8d 3d b8 f6 d4 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d b7 =
f6 d4 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d b6 f6 d4 01 <67> 48 0f b9 3=
a c3 cc cc cc cc 48 8d 3d b5 f6 d4 01 67 48 0f b9 3a
>  RSP: 0018:ffffcdb6403a7cc0 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffff8d5e6441c000 RCX: ffff8d5e43de6a60
>  RDX: ffff8d5e5afbd468 RSI: 0000000000000002 RDI: ffffffffa7fbe040
>  RBP: ffffcdb6403a7ce8 R08: 0000000000000001 R09: ffff8d5e5afbd550
>  R10: ffffcdb6403a7cc8 R11: 0000000000000000 R12: ffff8d5e6441c000
>  R13: ffff8d5e5afbd028 R14: ffff8d5e515c0000 R15: ffff8d5e5a621008
>  FS:  0000000000000000(0000) GS:ffff8d61f7904000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f0541dbf000 CR3: 000000011ad8b005 CR4: 0000000000772ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   __wake_requests+0x3af/0x3d0 [ceph]
>   mds_dispatch+0xad/0x240 [ceph]
>   ceph_con_process_message+0x88/0x1c0 [libceph]
>   ceph_con_v1_try_read+0x316/0x6f0 [libceph]
>   ceph_con_workfn+0x1f4/0x500 [libceph]
>   ? process_one_work+0x20d/0x600
>   process_one_work+0x234/0x600
>   worker_thread+0x1e5/0x3c0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x24a/0x360
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  irq event stamp: 7923424
>  hardirqs last  enabled at (7923423): [<ffffffffa6d5b2a8>] _raw_spin_unlo=
ck_irq+0x28/0x50
>  hardirqs last disabled at (7923424): [<ffffffffa6d4cdb5>] __schedule+0x6=
85/0x820
> ---
>  fs/ceph/mds_client.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 85f8ceb10377..6b27146d0c9f 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4024,6 +4024,19 @@ int ceph_mdsc_wait_request(struct ceph_mds_client =
*mdsc,
>                 if (req->r_parent &&
>                     (req->r_op & CEPH_MDS_OP_WRITE))
>                         ceph_invalidate_dir_request(req);
> +
> +               /*
> +                * The waiter is about to drop its reference, which is
> +                * the last one held by the request's caller.  Make sure
> +                * the request is no longer parked on a wait list or
> +                * registered in the request tree, or it could be walked
> +                * (and in the tree case, replied to) after it is freed.
> +                * A racing reply may already have unregistered it, in
> +                * which case it is no longer in the tree.
> +                */
> +               list_del_init(&req->r_wait);
> +               if (lookup_request(&mdsc->request_tree, req->r_tid) =3D=
=3D req)
> +                       __unregister_request(mdsc, req);
>         } else {
>                 err =3D req->r_err;
>         }
>
> ---
> base-commit: dee30ce1286a0d18b14545ecac345e4cf4a80511
> change-id: 20260827-b4-ceph-fix-abort-request-uaf-new-a98f8c6da00e
>
> Best regards,
> --
> Xiubo Li <xiubo.li@clyso.com>
>
>
