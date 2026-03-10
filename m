Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFC31B828
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173732; cv=pass; b=ouZTCuT3usm9+zleMFvoglQytqUKpqauutLy89jmG4DvpkWDcs2awpbTo2buqTTNdE4bWc2jszzqcPB4ETRWqzpZt43Rr/dJztwZOPxli2aSLN2pD/blVfyxDVAfBPNdun7qHd1iOcft2aaibKEeMvb/RGUxRWvr5g+pO7qkUbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173732; c=relaxed/simple;
	bh=7JQU5p+6t+bMhEiDC8ETgDZ28PSGAqoxjB7XgazXNwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9GelgzANEuPmajZIxdW4b74Wgft50sH9s9fLna8RSY4KrEyCPi8oSmh1EyMOL53kg9bRBUzDxcrcB8gMb8xDVoS5Mx5zRDmZwowRmOv1WZFxo8d67AfXXYP9ppxn1jxFpfRUa8roGurbLXhwH2ABTwor+emenSGAdJp/uAPKyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg68W1KK; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg68W1KK"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1279eced0b9so13509563c88.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 13:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773173730; cv=none;
        d=google.com; s=arc-20240605;
        b=UlNlAXIxlLR16iai6+zWAsWmiSlnPb9NbOO8T9u3nlwH5BS6ng0gvS+YcVP645j+4A
         5RWzIl2ChmQOm6WaMI1AZ/dFsBbHhSJtEBycN9Yyol7eILTPFq85jRp3QYKtplwxUjFu
         CSfbT0P9rltezfO2uQ47p4TqGV4ZzmrBDKI6+fdPhcHHHqgfteZ1rIJ+IBHVAut972jq
         FQiCSZpdeFs5vZZ4uQyHEwp2tEedcshHs7zMb7Qmb8l8XlayBlu22wjKbIQB10GE0v9A
         OBO9eEcrDfNh/M7jXy2U8kM/bLPsTDxfQAsyOwRzW6xU58aG0GWJiRQRZHUNIzBNQvt2
         IwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BYHXiQrocNln+bJpY9YDkRcCEgLP9SshpANek1qf+A4=;
        fh=cINBpnWJwMVJy3zzSFq+nb0eSpeAq1g8S5rvQRM/qkY=;
        b=WKLdUlMl7sgV2lfKihGAaoedP9RzpQsqfCIohNTf8XiF3pcsPptt+RKI7VMg6LVTvt
         or0ERPkFqj6bB/3SL87kghP0RToDvgK/AXSuhNLtkoDUw5Iu8RCDbNVDRk1RcA0v6xRH
         9cncAiZMeV2D7DVftRxy3Seb3X5qiKiMz6oQABg9+39D22ljQ0/NBcSKx2ykQ/9PESVY
         VMOaKU5zA/E44GtcHI+jdQjnBNZyKYrxQqfqvnmGUsr0CyMGUomtOKSmVtEXtf2eEYFT
         kvCRtnphdMqfGFhHdG8hp1XdVFavvN2/QEQNMvzRRXCEaYfoFuZUd2yHCCnMgxkih4LI
         Ivkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173730; x=1773778530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYHXiQrocNln+bJpY9YDkRcCEgLP9SshpANek1qf+A4=;
        b=Tg68W1KKHIRsYmH32qHQhXivxZDJ6UlR+1hBGd3L/+p2WicB82TJvzxqFlf27K7Zh/
         ML/EW/2C/ZkJrcelt5rjENMGq6K8EsMfE+BNUSshpkPHjwd1Db/NNEJQgCreIUGzCu5z
         GM/B1gMauxdwcuHcix+p2Wkz4X14Pg5DUhQOwbf6niPbA6riHcck0ULEfx5p9HxeEBge
         2vdZQ5yWx3wtmMXaYBWT9cwFWdW57mff/LcT12We20QkM5aKIJ4zQfLsi0XTNtqIaNZG
         jhIy3S8XKLywXCAa8lagr65Az8wAJrIwl61/XHpw4VVDrIuj2l8K62ChbfR1oRYnNDLM
         N1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173730; x=1773778530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BYHXiQrocNln+bJpY9YDkRcCEgLP9SshpANek1qf+A4=;
        b=MtR+w4DRkHq44l+2AvDDmuS+tfOp52RPes3WBTMjItqMYWzSz4g5YbnzuABZsc3RZX
         Q5SoCKUXtxdRIVeCRtY0PsPng38y8lOYfwOUWksh36/Bb5g/cSXKoE6no/ipsQUQRHGU
         Eys4pwqGS5v7BWFAjXfHDMATDK1tnFHZa6Hu4NPBPCaCORehp2XIN0N1sn40FvEx3knU
         mNZCytoVtljj0bpPqC7mjvSbZodAjRtXsv98q9pkDAmc42+dJKZerSJnH7nsijI//gh+
         ECbHdyKyP6TGuE7YF5d59Q6NJWJr5qnC0bWu6D8mq3R3eTuP6duQHdDIquI7fWnk2gTC
         +z0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrtfJToPRhoTEOFODSughY2jPwXvQ3Bfod3o2BbOIxB17cGSHKaUMiGBbUWpxXHoq/MGkY0RMJBfey@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LC3oGiLpb+jl9AhgpxjQdvtZXd1Zln6I1/3tlGMdaBtqgw+6
	nQyDCh52qw90HF3dISd4RAWqTe1noQMtUB+XDtrFMimC1eqQtxSLdBkL8dRbQifHXYsojwhMTxj
	14NM13yWnoCHl4K8zRLLRfPP+BPV7UP4=
X-Gm-Gg: ATEYQzwF34IbLs8gc7gY8q8q3HAPz0f7/YiaB1Ov8Zo3TZnP5ytP4F+FVTYy1KcwxwL
	JYM7kaGVgA7hFNMkThernOOcMRP9HTDvEf1ilLgdKecEBXTKf0nvC0QPkEgTJivEMUTdVul2kIM
	uHPI7AWmSCzDTWcRxyjAN0GLyyBu39Aoo5zx9iujUpyZTxGj1u8pi6eVRudb5PqDwY5rg6vBN53
	Od0h+g4vx7S4gRT7XU9qtWEU2yIBuNg6Y3DGK4jwvA5vjAqBgAsTOWOET+RmklyWAB1ZB3b3Xi8
	qQRLul8=
X-Received: by 2002:a05:7022:160b:b0:128:cbc7:4c1d with SMTP id
 a92af1059eb24-128e78bb317mr30452c88.44.1773173730310; Tue, 10 Mar 2026
 13:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Mar 2026 21:15:18 +0100
X-Gm-Features: AaiRm50YMkWy5Z0S7MdiyTkFnUxR6bKMMyiICz0cdrFmMPF33zycv0SY8ml_QMY
Message-ID: <CAOi1vP9sVPbZ7yk=Ae85xL9-5mLE=H6iSQYR6-zDcWVQ8afYaA@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:28=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
> that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
> ceph_handle_auth_reply(), the value of the payload_len field of such a
> message is stored in a variable of type int. A value greater than
> INT_MAX leads to an integer overflow and is interpreted as a negative
> value. This leads to decrementing the pointer address by this value and
> subsequently accessing it because ceph_decode_need() only checks that
> the memory access does not exceed the end address of the allocation.
>
> This patch fixes the issue by changing the data type of payload_len to
> u32. Additionally, the data type of result_msg_len is changed to u32,
> as it is also a variable holding a non-negative length.
>
> Also, an additional layer of sanity checks is introduced, ensuring that
> directly after reading it from the message, payload_len and
> result_msg_len are not greater than the overall segment length.
>
> BUG: KASAN: slab-out-of-bounds in ceph_handle_auth_reply+0x642/0x7a0 [lib=
ceph]
> Read of size 4 at addr ffff88811404df14 by task kworker/20:1/262
>
> CPU: 20 UID: 0 PID: 262 Comm: kworker/20:1 Not tainted 6.19.2 #5 PREEMPT(=
voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian=
-1.16.3-2 04/01/2014
> Workqueue: ceph-msgr ceph_con_workfn [libceph]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x76/0xa0
>  print_report+0xd1/0x620
>  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>  ? kasan_complete_mode_report_info+0x72/0x210
>  kasan_report+0xe7/0x130
>  ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>  ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>  __asan_report_load_n_noabort+0xf/0x20
>  ceph_handle_auth_reply+0x642/0x7a0 [libceph]
>  mon_dispatch+0x973/0x23d0 [libceph]
>  ? apparmor_socket_recvmsg+0x6b/0xa0
>  ? __pfx_mon_dispatch+0x10/0x10 [libceph]
>  ? __kasan_check_write+0x14/0x30i
>  ? mutex_unlock+0x7f/0xd0
>  ? __pfx_mutex_unlock+0x10/0x10
>  ? __pfx_do_recvmsg+0x10/0x10 [libceph]
>  ceph_con_process_message+0x1f1/0x650 [libceph]
>  process_message+0x1e/0x450 [libceph]
>  ceph_con_v2_try_read+0x2e48/0x6c80 [libceph]
>  ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
>  ? save_fpregs_to_fpstate+0xb0/0x230
>  ? raw_spin_rq_unlock+0x17/0xa0
>  ? finish_task_switch.isra.0+0x13b/0x760
>  ? __switch_to+0x385/0xda0
>  ? __kasan_check_write+0x14/0x30
>  ? mutex_lock+0x8d/0xe0
>  ? __pfx_mutex_lock+0x10/0x10
>  ceph_con_workfn+0x248/0x10c0 [libceph]
>  process_one_work+0x629/0xf80
>  ? __kasan_check_write+0x14/0x30
>  worker_thread+0x87f/0x1570
>  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>  ? __pfx_try_to_wake_up+0x10/0x10
>  ? kasan_print_address_stack_frame+0x1f7/0x280
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x396/0x830
>  ? __pfx__raw_spin_lock_irq+0x10/0x10
>  ? __pfx_kthread+0x10/0x10
>  ? __kasan_check_write+0x14/0x30
>  ? recalc_sigpending+0x180/0x210
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x3f7/0x610
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? __switch_to+0x385/0xda0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> index d38c9eadbe2f..ee85c5e45773 100644
> --- a/net/ceph/auth.c
> +++ b/net/ceph/auth.c
> @@ -205,9 +205,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *a=
c,
>         s32 result;
>         u64 global_id;
>         void *payload, *payload_end;
> -       int payload_len;
> +       u32 payload_len;
>         char *result_msg;
> -       int result_msg_len;
> +       u32 result_msg_len;
>         int ret =3D -EINVAL;
>
>         mutex_lock(&ac->mutex);
> @@ -217,10 +217,14 @@ int ceph_handle_auth_reply(struct ceph_auth_client =
*ac,
>         result =3D ceph_decode_32(&p);
>         global_id =3D ceph_decode_64(&p);
>         payload_len =3D ceph_decode_32(&p);
> +       if (payload_len > len)
> +               goto bad;

Hi Raphael,

Using ceph_decode_need() would be preferred for consistency with
e.g. process_auth_reply_more() and other code:

  -       if (payload_len > len)
  -               goto bad;
  +       ceph_decode_need(&p, end, payload_len, bad);

If it's fine with you, I can make this change when applying the patch
to save another posting.

Thanks,

                Ilya
