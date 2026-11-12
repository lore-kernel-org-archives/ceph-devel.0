Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441734;
	b=daibN+tbHa0ynxC7ZLrtaxCq3f0UYg7PRF8zXnBYYtU1diQSYQ25fts0Cum/a+C7KdI2
	 tAyue6GT5NkrrOLW2C0TUTqBrhvgFvijz16E0mh5I6GeJdPul50oLTicqw9/8lb59Flke
	 /i7VKeFiil/l0M6UOYI+MO07q64f0yWQLr3p/d+dEGNpezA3RtKlg2THHItVSpFxrVzMo
	 iIh5ZQffRT7I4madYrTKpuDrB17CNUwjaodtCro77aKcUpG5ZuSqFSRt1P1IO6nak0g+g
	 K4hgQY79yn1zyH5DjljVHMh+f0T9qrx2IMCTIGMfO38P3MBwb4496yQwW/QV3y22clw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441734;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=NsTC2dQPRiEtomqMvFPQ/TlE2NzSpNLDgkBlzzhgbXY=;
	b=xMQyRSxSWuop5NtjPCSVihWyBG7VApfbgihEmVqd9J8qGM+hf97MdT6aIfWHpl2ro+Pw
	 8FCum0X8J2scA6FR0ZPbO65MStXWd4e9zb3aM5lcuQ9I/RCLTEtqCfRI4puSEkQ30qRHz
	 363pNKQYW4yA3e860A4uFpm/4NufecbbBmj39Qp/SsWCptKbe0ArdA4Eew58zfobrqeVB
	 aFLpRoaKwFZCP4TSOGODwbAEdp/Apot3wJS9K4nFPauNU6PmcYTe0b2bfgutDHbYWYEtd
	 1Pu5foRYpU9/rH7aSt9N5hs+Ul8gvDW57m43xUEqgCNGPNQ+G1PA5EBJfYJ1ZxOlXBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AYJx/Y9p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A2606A321
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYJx/Y9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4280A1F00A06
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441734;
	bh=NsTC2dQPRiEtomqMvFPQ/TlE2NzSpNLDgkBlzzhgbXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AYJx/Y9p2SZPhLKgMScrmLLLBBzZ8+nkWBctreQSd1cj8IRbB+PwA2EfJdgI6blCp
	 GFYeE3gKaSwbhUuSu6Pd2iQ2dbeUSu2P+qazx+vdF/bcv9FoWBypzY+GJH1/ogtLEc
	 YTU18MbRFIfiWWsZpRbMLF05r+25Juk5XsIZaQbdiY2M8dTgJtAU6I7UApPlu5ZEM4
	 RDuC9honjMkVgyblDRIIFvJW6bG9Ok27a9LH406Lht5tF7D6qoFxmZkbg7VRx3TxiI
	 SilJ0idifzV/6+sLkvbpAqJr/b1JhvuqoYtIpUPEHuy5CKT7PpmkjeCg3zBRSFaE8u
	 SY28L0VNnkj2w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso368966e87.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:02:14 -0800 (PST)
X-Gm-Message-State: APuU4Z/an96hdLxRXBM/P49jsqVGnbsS5rgDobHFLx9Lkup65GaIkMfF
	1n2ciau9uRWmLdFAdQxtWawUTAPKHLCW/A5cRL2GnfefF3eX1p+mQnFg0gRyJBmYrl8jzDxmmzS
	S4bWSrBQNOtlNFsRWQHvJUZ3YCHc5gP4=
X-Received: by 2002:a05:6512:250f:b0:5c1:4e10:20b2 with SMTP id
 2adb3069b0e04-5c164eda049mr248783e87.45.1794441733029; Wed, 11 Nov 2026
 16:02:13 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110201025.255594-1-idryomov@gmail.com> <20261110201025.255594-4-idryomov@gmail.com>
In-Reply-To: <20261110201025.255594-4-idryomov@gmail.com>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 01:02:00 +0100
X-Gmail-Original-Message-ID: <CAOuZWzw-oB+LGWOJzwBLfA9ankF+7eo3y4iN=mx_Fc1bWAywVQ@mail.gmail.com>
X-Gm-Features: AclHuK9qvpI_q0FjKqJCYHH4jxuK6uJoAPjk7WF_nTpQwbLH32R-skgDB6BJoVE
Message-ID: <CAOuZWzw-oB+LGWOJzwBLfA9ankF+7eo3y4iN=mx_Fc1bWAywVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] libceph: include current latency in debugfs osdc dump
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Dongsheng Yang <dongsheng.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On 11/10/26 21:10, Ilya Dryomov wrote:
[...]
>  static void dump_linger_request(struct seq_file *s,
>                               struct ceph_osd_linger_request *lreq)
>  {
> +     struct ceph_osd_request *req =
> +         list_first_entry_or_null(&lreq->osd_reqs, struct ceph_osd_request,
> +                                  r_private_item);
> +
>       seq_printf(s, "%llu\t", lreq->linger_id);
>       dump_target(s, &lreq->t);
>
> -     seq_printf(s, "\t%u\t%s%s/%d\n", lreq->register_gen,
> +     seq_printf(s, "\t%u\t%u\t%u\t%s%s/%d\n", lreq->register_gen,
> +                req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,

lreq->osd_reqs is only protected by lreq->lock: the linger callbacks
remove and put the request holding just lreq->lock, after handle_reply()
has dropped osd->lock and osdc->lock.  So holding osdc->lock and
osd->lock here doesn't keep the first entry alive, and the
req->r_start_stamp dereference can hit a freed request.

I could trigger it by delaying a linger_ping_cb() call (test-only
msleep() in __complete_request()) and reading osdc in that window with a
test-only msleep() between list_first_entry_or_null() and the
seq_printf():

  BUG: KASAN: slab-use-after-free in dump_linger_requests+0x3b5/0x450 [libceph]
  Read of size 8 at addr ffff888233b79460 by task cat/8550
   dump_linger_requests+0x3b5/0x450 [libceph]
   osdc_show+0x21e/0x580 [libceph]
   seq_read_iter+0x2e9/0x12d0
  Freed by task 137:
   mempool_free+0xd8/0x150
   handle_reply+0x995/0x1120 [libceph]
   osd_dispatch+0x9f/0x160 [libceph]

Taking lreq->lock in dump_linger_request() fixes it, and the same test
is clean with it.  The osd->lock -> lreq->lock order is the one
handle_timeout() already uses:

        struct ceph_osd_request *req;
        unsigned int age = 0;

        mutex_lock(&lreq->lock);
        req = list_first_entry_or_null(&lreq->osd_reqs, struct ceph_osd_request,
                                       r_private_item);
        if (req)
                age = jiffies_to_msecs(jiffies - req->r_start_stamp);
        ...
        mutex_unlock(&lreq->lock);

That also makes the watch_valid_thru/committed/last_error reads
consistent with each other.

Minor: the continuation line of the watch_valid_thru argument is
indented with spaces instead of tabs.

Thanks,
Xiubo
