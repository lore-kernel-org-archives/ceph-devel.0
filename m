Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60640DB5E
	for <ceph-devel@vger.kernel.org>; Mon,  3 Aug 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763301; cv=pass; b=eAFpEHSJXsrzSjDdfaPqKXa56GI9AiGOHCTYmaGIPtcARfEkiA0frz3q0utx5EmVgWxD31TShG1EmYnAdZB53Fp9c408uJTokwsODAMSiPqIIHkvod3iL9YjToinaLWSvAgzfOnkV8r7vOTwG5Sz6ZWO4MluCxl20zLYbng+IUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763301; c=relaxed/simple;
	bh=Pgl5mTcqFOqWGOQn2TZduStirxwuSm2pRwIjZSucJwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHMVTW7cdAcUCYZuKCRj8qP17Mo6e5TWcl9+fNJ2FN449VuFVvlLw+EmJA959UkxbT8UECvDxD/Oqq2Zd+v4wOWdjouqnC5Cb2P2T7Mx7x15y8C8HkqkmivqEwtosmP7yrFGUTL2afShqoKHM9XS/aUfXnNYfKL1vidFtKhX7SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvxRm/Zc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvxRm/Zc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so2507357a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2026 06:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763289; cv=none;
        d=google.com; s=arc-20260327;
        b=iFepkPxIY7a3BIpFUeHVGU2UXS6I2vQjcLp7O2dy45GVDgYIqvcdrDalq+ZG4zVYSw
         EJf3gUDibztZXVMh61St/hcQGKf9arjFm3pc86wU1SxIClWklCfwYC3yopAme9B+ZsG3
         hTmwiXnA9do/obWOey9Nif5KtoPQO1RxB52L3+OofEgliKfqW6/GEpWWysd8cA5ms0v6
         xKoqsUsOGUCsml5vIPhPgDglgIHIeEi++NmrRE+0AL6xPL6smZE3rFvaen74dJ1FER2Z
         hqumTiq/SfD6If6gV/WBuIDULg7CiDpdDS65yvrAczm/g2Qsa9CiWoXwn5a/YNhQHjz5
         s6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        fh=3/KXODvoFn6pmw6OHFwOQwv0gezhEMZkTcQEDGdMlfA=;
        b=XzInyo3MMZ5V0hSSJLTIz3+W1toUT3CIqH5lSYtVlUTJk0vz4yOIsiv3bCGAy66EMu
         ZTVXfK2o5IpgJ71mFITJ458Hnldi8XxC3ZmEO26ebZYzrn5htgPxuFu46TNmeLQDNf/H
         uRJMN++dT9Qtvg4wBYabiVSwv7b4F75J5PogQl2QIWQVCMMbjg80lpQFr72vqgDI+CmH
         i7T37Yc+8QRxqZJ3NcMz/tRlgLEUY7ER0Z42v3aXPe60RMiOb4sspaKJDLao6Qz1Mht+
         +g8ojAfLEY6wSu3DsP5jMDgINfToeQWWi4UIc8pT7tZraFXAnHgDsFUpeU0H/+0nNldD
         Tbog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763289; x=1786368089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=dvxRm/ZcGYR2VElqHNvrbIbP9OvHsQkpvLJObV5wRx/fXOfUt29OLPtE+JvxWK2AOQ
         3VhaxWdK9wr8VU9F7OpdHh93UyXYln1zJIFeKxpY8byuq8uH5aOk6evZeGjO9IkqTptd
         6pqSXC4iIsTM5Q5hI3ihgFCpFYQmHAIH17jBmK2nWesFrnXCN+cLlB30cVLoPE7iBxPq
         YNZUhtvw1JycZThdfbfdyNVwsIyNlqZahx8PqEto4vhXRgRne7m4fkHUxVzQMxB0N/A0
         77oJ0UDkdALZBQIED3QKAmbqVImouGpGGwdcCJe4RsLDjGD4I5xyy4Jr8+HbjvOIgaqa
         GxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763289; x=1786368089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=MNkx2iMNqHj7eyd27/wClOkjUZodAiFDLKA9MRtCEf4Lj0UCyBlEBUtECKB6//QHdk
         kAkIe9+SuO86ic7grrT6JuXwYLJg0Pi9d1WKaZ3Rkw5a3bL/JWj3+nRSH2faLWxYDIFZ
         s5+zruDfTv84mMtLe47HqvAz93ovHuCy6OyXea6JIEvOcZ9t0xVh+C5BS9Pytt5TZkqe
         hMljoI8ulbCMsxOJNLJ3T+f6DkbSUtwZOV6D3fwcjiVLacIND4d5oGPmve9y4HZscq5D
         fxhDU/3fFvJtOoD33/TsB54f5AWn3LpfxGgLV2remEHTqMaxEkn1Nx2scf6A8lDn5g7T
         GCAQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIMxjp4la14mP5keS/PwiFghG/2FmUt8yLqj0hYo7hY3Vrfv2WYKWAGzbWtQML0OfpCpgYMLQ2u/mo@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOysBP+bN0RTS4ogS1BNC4FFftfD3ptmt7F0rjBilBpPeb/dD
	QClZAEJE8kFZqKWojYwwmVIoXJgMSkuemi+07uB5vquMEggs7Uier/Y10Ceb/WOkIxYRtNHey0A
	D5k3b7YgWNsDpgT3aBljDIYVodIsG5Q==
X-Gm-Gg: AR+sD10D6pKhT3HQHQfN+OiWtEqiaUnmO5O8dw5Q8BHm6aKmn96r+TphefwB4IW6A/u
	WbheEXgKX4kEvUzNJ8rZcXs2SYbWJQYwF2Rn8mLYrV50MJAuOBngN4kI/VMmjarMltgKDE1/9zo
	UFmPtVXhXwBrMfywFZGnQkyjemeP7dGb7m+xfPBAo274uJOyXteqG/AJuSXzEbBVOpz0lQFOgUH
	ep/XN65A8jXcFDfj4BV7EhOpoRDiCk9f1spmVjyaH/ijierLGE1JB1iO5G+MSfiUUYnPmoc4fLv
	3E5uW9cTtAAcoroIZPGzVL3gSvZKCwxA2wXvl41CupUdXfskMkybedpFbLzosAhsGsSaac7Di4n
	R880hU4UdfNtfC5o=
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr7875783a12.7.1785763288576; Mon, 03 Aug 2026
 06:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785596451.git.asml.silence@gmail.com> <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
In-Reply-To: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Aug 2026 18:50:50 +0530
X-Gm-Features: AUfX_mwnLWCAPfRurFp37qU73Xc2KDpD6en6Q3cA2kgelroMq6uNFVC_YKEZqSE
Message-ID: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 9:19=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const st=
ruct iov_iter *i)
>
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -       if (likely(iter_is_ubuf(i))) {
> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>                 size_t size =3D i->count;
>                 if (size)
>                         return ((unsigned long)i->ubuf + i->iov_offset) |=
 size;

dmabuf_map shares the same union slot as ubuf, so this reads the map
pointer as a user address. gap_alignment() below already returns 0
correctly for dmabuf - this should too. Checked the rest of this patch
(advance/revert/restore) - none of them dereference the union pointer
for dmabuf, so it's isolated to this one spot. Doesn't affect the
current series, nothing reaches this with a dmabuf iter yet.

> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov=
_iter *i)
>         size_t size =3D i->count;
>         unsigned k;
>
> -       if (iter_is_ubuf(i))
> +       if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>                 return 0;
