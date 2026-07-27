Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1D3EFD04
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145582; cv=pass; b=SfIy4TfemkS0hDLNcAigKta+ph8lkEWPnPj5FLQ3hk1pUguHxuFgS8+IQq9hRlokuEznt2lhmEohimA9TW2MbEnCGTfvr+mUiJHxKytyQ+Vo6+XEL19gO8sYuT2RfiNEC8Ijp+wTGo5wlNM4fTbDKYyCuHqk43jySM6KzhU3pKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145582; c=relaxed/simple;
	bh=m092acKfRohrNRL8xY4DiOS3bkiqtm6u83bHCPIH+kI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpyGuZdX/mJ2ShQnkmkv3WtA4l6nZvvRDB4dXZJoai2sExXHWC8FkRcbnsFwpwLo5tx0TeH505q/wzJ24uNhbH7nFxhnCSCCZxqkRI7cYWKH4yqhBU8KZmXPnGsnTuGL7cXkbX2LQ2rYcgCBGdU2ybCIw1EYkjrS6dK8MuKTGaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xyu/3E61; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xyu/3E61"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1915763e0c.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 02:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785145580; cv=none;
        d=google.com; s=arc-20260327;
        b=TL/ol8883t07CVOVDDAvwXI78gPLPo2hSBlq2+HIFlmh3+Ft1Wqfo+aePQ2KZ6oR2Y
         NsQ6NCaPO8yvfK3h7Y6TRmaC2J9AmL4SJ7i/xsuB4sl7aW8lmAagS2wq2PO2V1K1SYpJ
         EvDezZSQSFtXhnuPzUbCFMnqncMP/Kj+YXff45EOOPc/5t4MdAL5SQvqnGwAgH491vNh
         hSDYDLkPBN0ot92JlpwkLH0ILZsA8lcJGLfCWxTLXgbAQ07ykznsMOSxT8uHAyfArGGy
         767T/HWPJDptTSetxqwb8R359JM78okViaILfVL6Rk2OeVaoiUiZvQwHjuVPzSK/dNr4
         uf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vWMEYSdru9qsRUac4GgMLo5Rs9+K/BL9z26XIIhNsgs=;
        fh=iorZ41VpxRPYucZTK2MtQKl6a/np1fvPFNjIF5zpx2s=;
        b=MqBSK3gxwEWbnp9/Kf2UnhBBGtYdq6EMugGk+w1RW1rzFSX47e59isur8zMZP50qSN
         LLyUCE747Hc5ZJ4bj5jv7P9np8m61Ykyqx6kCFFAFsWWKtgydP2Ze+VnDd2J3+Pgq1Wl
         zr9i1wIvx/4xfjGj0IiDbZbD79FQrGOAWZ82sVxhLd1qZFs5beyRC5jAvO1MVbX8EtbV
         bOoW7dqWkU3U6OvgHIh0UPgpTxEdHyc+nlHzbIYQUnfTrT+0MTrrecjcDBQEd9mA3oL5
         wfUr1njLmPhXfXYrIGCWiDwf4tHAUTnXUjIXaivhH7eOa00qXsbgsJber+Jg2tvGCbP6
         DSjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785145580; x=1785750380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vWMEYSdru9qsRUac4GgMLo5Rs9+K/BL9z26XIIhNsgs=;
        b=Xyu/3E615BstDP224g/8Hz05i0wqW3alM1du1ZO6U/FtSYi2nDaYJkP2SF2A2wqjn6
         lxCKMWM36oSl6k1jt0+ePzlTL6Hh2A+P6rahLRuuPNdcgcSqdNr8/umjdejNVk+WbZoI
         fWvwy2KW+RqpVRIMHR9e82mKYYjIUf48JnuFkgrPhmSpS14cQ9dwZzBZbKPMhBrfJF1s
         3idghNyneu6yE1Eg+QfGcpYRZPcIHBmeJdf8RzQMR4SLOLkOwiWnmDnu3QZ/pffVNqHA
         3DVDepoQkOB4tAWCPKPW1BwWOf7Qotnx9qZG5UOJIm36M8QDtCcSmLZo853cUykAzpen
         UEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145580; x=1785750380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWMEYSdru9qsRUac4GgMLo5Rs9+K/BL9z26XIIhNsgs=;
        b=AP8EAcomydurZMw37HGDcv8vlkH81IRNqYWcGAZbeun9fx9RrmK5l/+dFGDEEG+WhH
         BJmAunqOpfVIbYX73MHw/OPqo2LztDFs7KFYBOuqauHa1091yPkN05fVT1QbjfjhsCAh
         9c+WSUCt8mTtwHbZa5jYnrYBpb4wODu6GNakjAvhE6DSl46+dw1F1X3548Q+VAbATr+j
         j5I1dlIUtVgMA20lOQCWtPZwJN8UZP3WiWrqKaiF/VdH04tmrkXpz65MlKwaFo5gIK/6
         AcO9WbBpkBcIDviZvtKQpyTMN6RXtfgSwCT1S7F2P+d7WOHtLmbbHTbemyhbn4T8knAO
         Ptsw==
X-Gm-Message-State: AOJu0YzYczsayhBiEtow6uVYCZwyEiFjZvsRFQrYW9SMyL6ErazBu8GF
	S/1evVDbbK0F84z/vj15mcMIg1ePMMsmw8fJAUGuLc71mP+wrIY3nmRIzAA10m5uLJPMCk5aT19
	iKPP4Gjx8K7goWCuWaYajhxe+oYoKMas=
X-Gm-Gg: AR+sD11/obL+JkumyKvtULL1C0daE7LPtSS6JZDR+BEMVhzWXGBxZzdObne64sBGxFo
	NlVSF2PgambJ/FfQJeFwLLB73jZv9EyELu/2QA1ekElB2hweaNctBjEEWMiCGBvx6DKj6Q/C0NM
	e8Ep4XVG/4uAVhgvE+BlkjLL6g4RDgtrodsLkhsL9XUh94FxjUD+bpI6GAhTOfVRF1b319mwS62
	CUGDt/blZxl3eIkCVpD54cDAe2rNWv2mxh/DYsLHSOWV/KieHZwgQqMCdt+oeuuG4fq9z2u0/DH
	F4KFgJ6vUu4ZCwy7ZiA=
X-Received: by 2002:a05:6122:1782:b0:5bd:fb8c:5db1 with SMTP id
 71dfb90a1353d-5c306d1bf78mr3354573e0c.10.1785145580061; Mon, 27 Jul 2026
 02:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706213240.139919-2-slava@dubeyko.com>
In-Reply-To: <20260706213240.139919-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jul 2026 11:46:07 +0200
X-Gm-Features: AUfX_mxPQHU2ZAH-7L2WzVOCcLYltrHlrlYAVKgwzcyaMThwWZk9WurevHAr24o
Message-ID: <CAOi1vP-Y69oF5PDpS0TrZSKHCTr2cfGHTwv1Rtbri2UwLasvog@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix denial of service issue in ceph_update_snap_trace()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, pdonnell@redhat.com, amarkuze@redhat.com, 
	Slava.Dubeyko@ibm.com, vdubeyko@redhat.com, sagemct@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:32=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> A WARN_ON() fires inside ceph_update_snap_trace() when the client
> receives a malformed snap trace from the MDS. The kernel additionally
> logs:
>
> ceph_update_snap_trace do remount to continue after corrupted snaptrace i=
s fixed
>
> indicating the client cannot recover the snap state and forces
> the operator to remount the filesystem. Triggered with the call chain
> reaching the warn from ceph_con_process_message() -> mds_dispatch()
> -> ceph_update_snap_trace(). Impact: denial of service of the affected
> mount until remount; the client refuses further snap-related operations
> after the warn, so any open file in a snap-realm becomes unusable.
>
> [  230.026879] WARNING: fs/ceph/snap.c:926 at ceph_update_snap_trace+0x30=
8/0x3300, CPU#1: kworker/1:1/58
> [  230.028125] Modules linked in:
> [  230.028427] CPU: 1 UID: 0 PID: 58 Comm: kworker/1:1 Not tainted 6.19.0=
-g44331bd6a610-dirty #9 PREEMPT(lazy)
> [  230.029089] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  230.029815] Workqueue: ceph-msgr ceph_con_workfn
> [  230.030177] RIP: 0010:ceph_update_snap_trace+0x31c/0x3300
> [  230.030550] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 23 26 00 00 48 8d 3=
d 28 d2 3a 05 48 8b 73 28 49 89 e9 4d 89 e8 4c 89 f1 48 c7 c2 40 40 8e 9e <=
67> 48 0f b9 3a e8 3a 7c db fe 48 b8 00 00 00 00 00 fc ff df 4d 8d
> [  230.031708] RSP: 0018:ffffc900003f7728 EFLAGS: 00010246
> [  230.032084] RAX: dffffc0000000000 RBX: ffff88812282d000 RCX: ffffffff9=
e8e3b40
> [  230.032533] RDX: ffffffff9e8e4040 RSI: 0000000000016f97 RDI: ffffffffa=
087e7d0
> [  230.033008] RBP: ffffffff9e8e3c00 R08: ffffffff9e8e3b40 R09: ffffffff9=
e8e3c00
> [  230.033460] R10: 00000000fffffffb R11: ffff888102928040 R12: ffff88811=
031a3e0
> [  230.033937] R13: ffffffff9e8e3b40 R14: ffffffff9e8e3b40 R15: 1ffff9200=
007eefd
> [  230.034401] FS:  0000000000000000(0000) GS:ffff888254a05000(0000) knlG=
S:0000000000000000
> [  230.034941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  230.035315] CR2: 00007f7efa7be740 CR3: 000000012435c000 CR4: 000000000=
0750ef0
> [  230.035803] PKRU: 55555554
> [  230.036001] Call Trace:
> [  230.036175]  <TASK>
> [  230.036342]  ? mds_dispatch+0x1ceb/0x6f60
> [  230.036645]  ? __pfx___might_resched+0x10/0x10
> [  230.037010]  ? iget5_locked+0x44/0xb0
> [  230.037316]  ? __pfx_ceph_update_snap_trace+0x10/0x10
> [  230.037670]  ? __pfx_down_write+0x10/0x10
> [  230.038005]  mds_dispatch+0x1dd1/0x6f60
> [  230.038306]  ? ceph_con_process_message+0x1ab/0x270
> [  230.039024]  ? lock_release+0xc7/0x270
> [  230.039321]  ? __pfx_mds_dispatch+0x10/0x10
> [  230.039622]  ? __local_bh_enable_ip+0xa1/0x110
> [  230.039992]  ceph_con_process_message+0x1f4/0x270
> --
> [  321.986495] libceph: failed to decode MOSDOpReply for tid 9: -22
> [  330.121991] ------------[ cut here ]------------
>
> The error path in ceph_update_snap_trace() is reached whenever snap trace
> decoding fails. The two entry points are:
> (1) bad =E2=80=94 a ceph_decode_need() macro fails when the encoded snap =
trace does not
> contain enough bytes for the declared number of snaps or prior-parent sna=
ps.
> (2) fail =E2=80=94 reached directly from -ENOMEM returns (ceph_create_sna=
p_realm(),
> dup_array(), adjust_snap_realm_parent()).
>
> This patch fixes the issue by changing WARN(1, ...) on
> pr_warn_ratelimited_client().
>
> Fixes: a68e564adcaa ("ceph: blocklist the kclient when receiving corrupte=
d snap trace")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/snap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 9b79a5eaca93..e5d8d59ffc17 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -923,11 +923,11 @@ int ceph_update_snap_trace(struct ceph_mds_client *=
mdsc,
>                 pr_err_client(cl, "failed to blocklist %s: %d\n",
>                               ceph_pr_addr(&client->msgr.inst.addr), ret)=
;
>
> -       WARN(1, "[client.%lld] %s %s%sdo remount to continue%s",
> -            client->monc.auth->global_id, __func__,
> -            ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
> -            ret ? "" : " was blocklisted, ",
> -            err =3D=3D -EIO ? " after corrupted snaptrace is fixed" : ""=
);
> +       pr_warn_ratelimited_client(cl, "%s %s%sdo remount to continue%s",
> +                           __func__,
> +                           ret ? "" : ceph_pr_addr(&client->msgr.inst.ad=
dr),
> +                           ret ? "" : " was blocklisted, ",
> +                           err =3D=3D -EIO ? " after corrupted snaptrace=
 is fixed" : "");
>
>         return err;
>  }
> --
> 2.54.0
>

Hi Slava,

I'm confused by the patch title and description.  The title is

> ceph: fix denial of service issue in ceph_update_snap_trace()

and in the description that is expanded to

> Impact: denial of service of the affected mount until remount; the
> client refuses further snap-related operations after the warn, so any
> open file in a snap-realm becomes unusable.

The description ends with

> This patch fixes the issue by changing WARN(1, ...) on
> pr_warn_ratelimited_client().

but WARN -> pr_warn_ratelimited_client change that doesn't magically
make the blocklisting that precedes the warning go away.  All (not just
snap-related as the description suggests) further operations would
still be refused one way or the other, the MDS session would be killed,
etc.  What exactly is the denial of service that is getting fixed here?

Thanks,

                Ilya
