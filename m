Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849128;
	b=O2kqnoHXJsCHzCiaICOE4DJ8VfjRrPGlYyGZqghL4ak2b1cwgQ5zfMLUeUdeW7LOAM+d
	 GPGosYBrwPqLqo4MikGko/bZYrkE5JUZpjXzKKOrXobarOGflxoGcPbPorDRkaHpS6jQd
	 +eMstXKhp0awb2c2qsjB1gv62CJWHEhhUPcxASoPPsCYHkmIS+nlbLlVdwQYUJzROXSmo
	 BbSs6ZcW8g050jgu2HWVO4jPsFj64XfO5kn+CdvRFhWJaFyjmnO3F3HSR7myA9A8/v4yF
	 xynSwkpVC/7HYGMQwdIJRVKZIb1VE7Ax8BPZ09lZfnWC1TA4dsEfwGxKRLUWAYago2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849128;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DFRZ7QXKXPAVQTwjKmq6RCiErLGdMEwaLBPGPazQE7A=;
	b=grkiHCwfe2XK21t4zvqxgKjv80O3hWcyz1pPGdZID0ffy5mCVu1420P1KHUjj22v9MdJ
	 X7tTStgqpgN1pfY3A2CF1XXexky6GISWRklZoaZw2/XqzW/n43oGMkwGXBSIFURT/R2cY
	 UNUggeIm5FjnSP7Uato0Zw9vLmX3vdozoKKMMQx/h17PnvlpqPqtC2/VaVTQBxkevGfoK
	 G/ge9y+QtD2cjlIcdX12EMIs+uaByMEImijTmukVugZHf6bTTM+1mB0rDht+v9iW3uHdk
	 i0Q2upQWAs4Y2WfxJ5ajMfxQB4vqz/lagbssiP2A2e5ACadDJywdK2Iewhtn6JjdM4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFRPOa8v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCC606A33B
	for <ceph-devel@vger.kernel.org>; Thu,  5 Nov 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFRPOa8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B9C1F00A02
	for <ceph-devel@vger.kernel.org>; Thu,  5 Nov 2026 03:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793849127;
	bh=DFRZ7QXKXPAVQTwjKmq6RCiErLGdMEwaLBPGPazQE7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KFRPOa8vKidxfknkfWYdWtFWhdGgDILXr/LpGwlTMuPUGRO9lV9p0wRwWaF54QN70
	 4DKRT0c3mvKU6nhUedhQgwsIdVKI9SE/98GlzNRgmxaMfOaEBS1YgIoebv9BU0wvCe
	 Fszcu+DRuceUWHowBmokByklB/TBTHkhYihCuh6rVkQc9msjGavp7d5VLwkq39SrT2
	 6300BJxhF8T4Cvj5v/1jBji+kw1g6r65QEiJFCdscSSAKDCVsPjx2cZRCItVy/YE3f
	 VLlFjGLAJLSV+/F1zEfQvvVAIe06QvW9AFk7kraaJNyxPFaXMmFdgfuba75vJo4j8m
	 +s7riBgiw5AdA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso1122308e87.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2026 19:25:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzo3/1AZGfJXPSNcV/+orGANonJkEfsY/shpeppZxljXbdWmbqGuwbdXnvl1Kc3ce0+uSJhnD7eBxiZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8tlPkeblkmh99ggo9NENbqkRgfLSn6i0B/Ox/5dASJd1Sop3Kl
	bhMAvUTKk1ZW7+ZjFGAUdezmfa/W7yGte64LpdlRFBz3NDGH5JReqALbz6NlAH8rBSlZsmDnLKQ
	jaRzq0OqChhdxWBmpXXgRz8kQmCQUFJ4=
X-Received: by 2002:a05:6512:3e19:b0:5bc:c325:1260 with SMTP id
 2adb3069b0e04-5bfd957e7d6mr5933625e87.55.1793849126127; Wed, 04 Nov 2026
 19:25:26 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910123951.1241279-1-max.kellermann@ionos.com>
 <CAOi1vP9mrDMaABV=KtLRwrGVkBrPrGGBU8mUUnfm6wpdn_rM7Q@mail.gmail.com> <CAKPOu+82TXE2PqXSmSa2hPdj1X-AtP3BVACsBEhn=EKuOdjSRg@mail.gmail.com>
In-Reply-To: <CAKPOu+82TXE2PqXSmSa2hPdj1X-AtP3BVACsBEhn=EKuOdjSRg@mail.gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 5 Nov 2026 04:25:14 +0100
X-Gmail-Original-Message-ID: <CAOuZWzy1MQ8WNvZbfQj-vaN83kiZzuKuyV3yxM-W8aBLsz2e8w@mail.gmail.com>
X-Gm-Features: AclHuK-E-HFu7aurtBFFGXkXEBaOQEk070VBg_Ma8mHsee35kyST0vbL8Ms1-gg
Message-ID: <CAOuZWzy1MQ8WNvZbfQj-vaN83kiZzuKuyV3yxM-W8aBLsz2e8w@mail.gmail.com>
Subject: Re: [PATCH] net/ceph/messenger: print TCP connect error
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, amarkuze@redhat.com, xiubo.li@clyso.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:06 AM Max Kellermann <max.kellermann@ionos.com> wr=
ote:
> On Mon, Nov 2, 2026 at 10:08 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> > I wonder if saving the error that way is actually needed.  Can
> > con_fault() just reap it with sock_error() at the time it runs?
>
> Maybe that would be possible.  I wasn't sure if sk_err (from
> ceph_sock_state_change()) would remain untouched until con_fault() was
> eventually called, or if it somebody would clear it in the meantime.

It does get cleared, by ceph_con_workfn() itself.  SOCK_CLOSED is only
checked at the top of the loop, so if the error arrives after that
check, the ceph_tcp_sendmsg()/recvmsg() in the same pass reaps sk_err
via sock_error() and con_fault() later sees 0.

I tried both on a 7.3-rc1 kernel.  Reaping in con_fault() works for the
remote ECONNREFUSED and ECONNRESET cases, but with a refused connect on
loopback (ms_mode=3Dlegacy and crc) the error was lost every time:

  state_change sk_state 7 sk_err 111
  try_write ret -111, sk_err 0
  con_fault: sock_error() =3D 0
  libceph: mon0 (1)127.0.0.1:1 socket error on write

With this patch the same case prints "socket error on write
(-ECONNREFUSED)".  Using the try_read/try_write return value instead
doesn't work well either, because msgr1 returns -1 for protocol
errors.  So saving the error in ceph_sock_state_change() looks like the
simpler option to me.

A normal FIN-close prints no error code, and a synchronous connect
failure prints "connect error (-ENETUNREACH)".

Nit: msgr2 still prints "ceph_tcp_connect failed: %d" in
prepare_read_banner_prefix()'s caller, which is now redundant.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

Max Kellermann <max.kellermann@ionos.com> =E4=BA=8E2026=E5=B9=B411=E6=9C=88=
3=E6=97=A5=E5=91=A8=E4=BA=8C 08:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 2, 2026 at 10:08=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com>=
 wrote:
> > I wonder if saving the error that way is actually needed.  Can
> > con_fault() just reap it with sock_error() at the time it runs?
>
> Maybe that would be possible.  I wasn't sure if sk_err (from
> ceph_sock_state_change()) would remain untouched until con_fault() was
> eventually called, or if it somebody would clear it in the meantime.
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
>
