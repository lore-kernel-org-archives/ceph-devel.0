Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF13A542B
	for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667061; cv=pass; b=nrncmBPVN2hbTENre1lQZml1JkQR6VyvdpZKd6p8/T4180VOIimOE0vUIhQDqbcXhGfnS5TNLKLOtX/wtHQEzSYXZ0xgefCef7XcRR/3/59yoy5mWJnq3NreidCQtYjx3h1TXHFTIkMdqjSgAf6cjBFmY//V/hdF5ZlOuNkrrT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667061; c=relaxed/simple;
	bh=I35gDNGA4fpIsc0ElTO4/D3swmmdD1nD0eRHXQrQQRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLIxgTcb8qLY4WaJeK46bwxanaE6WCYIBlQMra2X5CaKFN5ViAM2KUh/gYbSctBK6SwBQjaN9HOx2kHkkgcpvbXQELn/lbzM7qId1h+Tr90F/fJw2azKC8mAFInM0En9kHqHPgMk5ivyDaMR0Yni7U8X5BE+eo4qrbQ6K5MK7IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEz6fVnT; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEz6fVnT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcb5cb1so46894866d6.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Sep 2026 00:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790667059; cv=none;
        d=google.com; s=arc-20260327;
        b=S2QQkeTe7OXrnnG1c3sLp1ZZSjI6GOxR95qSFoBTXq9eXmHIiIJiT4otLu5r7gaJ2U
         xUyexI7TJNfZyJ5H7CRsiAEDBIlv5jIqsDnNxQgpKD32VXuRTYd+qi+WhDeL3BWzJc83
         nymCWKrLAqxCMSYR21QTc6438GdjhwiGi4l+9n6WtzXdwQEioWr4I5SbEsVxBxgsxFyE
         Cx7jxwxx5WTLkAsSoDiYuZPNnt+Npfw3EFOjXuiByO6QtsjEBC9zypBvAe9USV2m05ge
         p8pNM7AT4yyOFwe8h9dT5/HkY9aXsYl1XZiBWoLLQTsXFKgiD7FoBdWcaH7ORphlKOPo
         2Pcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        fh=2OSi4suY7pEVyj5vv9+oCRKdGreiwPt5wwlx5I8WCL4=;
        b=Sq6iPxtspqkL8rNHPAvQZetCO1T7XjfpohxwjbzDwTqnjx4uRteEIoOzRWPIODjxd8
         FQoBXq1vBczvfMWK+0VojJ37xCHkfEwgLIwVBVEYeovq22kcFePu8RLewemzEFMYiBSF
         o0azfic5wrfHB9BWWw1M32okx7ONvfozkwehIr1IAeNNYVtAzu0DZ0trg8iQZSvL10Wc
         kdkUSGPXRs6GWw0QOrU5IS0yIDbn3MxhUCnCj6r/QEMHTdaOOFDk+mRLZDSD1HD6Y4BT
         3Gp3mqFDFiXti4o1CtSbW1NAoW5b5KMb5Bst9zlxSRozSHjfQPDX2MG6O1ySmDxCwAFi
         WHEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790667059; x=1791271859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=bEz6fVnTttyL2gBz5ZoudIT1eHaMMJx80l0ZTmCNvha+RTrwZxHgvV3QMIQn8Cn8xv
         8bUrnAAi6r2V7RmxeFvFJVUF7VpyFhwU0LMs25betgMEwF5uUU6bdk0uNnrIqO8nFrev
         cCPrOjMAkVTgcX4veZuXyjiyZIdMlx/mDUCCt/3XKU2rhfkMEoZXtaOANWGfSkNhR9Cv
         eAZbKbH7uFEfLN4ldYH8J81qVTJTSqqH4AXb1q7WUHqFVg/ZG5BD8eOO7WpaebhzBNcf
         LY+0+0lShac65S9s/ZOZjxDsIou4uYvOPHBQ5aXfxRCozB9TRuowm7BOfav0d6yyoNGG
         GrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790667059; x=1791271859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v/Z0GcKezXBRqzYvyQ4v0b98G06dRHjg36qbCp+fss=;
        b=zjqVELHOinTSvNR+422YO1W5mj1+45fn0JCyx742EHtJVvvvSTxcfN2Y/QCf31lujg
         DO+pGJLEmitic4sf2XF+5jZHWWRrSAPrvAYDQGL5DZA2InhJHdJnc76mlRORnFFJrlec
         JBiN2RVbxMVdjL09AOJBX+5ZbdIfNQv5du02bss7kA0FoT104I9ZhZV1ce0mD7JGfl6Y
         Qm6MGiQqv0XkkqXdW370ecNB+TyJlxjkWhGneaRyXbsZvdAEDBYX9RMRsNeGL0aqdsEX
         CMPgalcj2IUrQ2oxbzEXpjBunoLvw8MWlkEVs4Ph6DF6VNWG4zX35tRoBahn4dtLjM88
         NnHA==
X-Forwarded-Encrypted: i=1; AKwUvBzBDpu/TGwLNRkQNr8pdioglEOdQJRuUHBgxZJwTKXckVVZjg5CLEU9+bLlXAvhRczrM3R1LjK0Nr3Z@vger.kernel.org
X-Gm-Message-State: AFuF++lkaPb043R7FOH9UzXTl0HwfADX1ySpoq0MNTJi1TkzNIYg5IDp
	3wjlBCqb2fMMUBTVnhVLmoxAyDELhTklT30kMgdzPRVn3jZExO1zu1tzRpdr0cTh9bd4x+9AEmk
	BX4vq9CxV7z0hrSNGh/PJRHeBB0D2RjdztNfgVwP9
X-Gm-Gg: AYBFou2ZDNqNsjTd9oqpIBubSYO6iqcGEMpXD4lKrMfCfLL4yOzjcukapCsH9hVURfu
	7LXmRWJ3mxVL0rt1gyi3VLvfoJXV1Ow0z+V80q12Eyfa/M9GSyb28blsAZnmMBBvdbyOLVUttIl
	tXxC02AeqcYBBxnT96CMNvZX/xXf+EkCaoFYfEcZtH+ZltpHHs5G40h+7ox/q6I2eeZsHHAxmGg
	92MExuhD9EMxC4WKoj2XdpFFTmfoA8j4yxDyR2mA8odrq/98l0gbS3vFUmYRGG9nMGZWQVJZSD1
	ys0jVauR8I/bCFPuo8obGUM8Q382WvOIOQeGAwgMF8rJA5iQgqlJOO+cp4dgI6PohvHMRn/kdPb
	EbUu8H87LHkxi3cXIePmYx+N6dka1cv66y4EKcdRUm9uOKBJ8NYgj9Xu+KnWghLB0pDyv
X-Received: by 2002:a05:622a:580a:b0:532:d3c2:165c with SMTP id
 d75a77b69052e-5330dbe7682mr252226541cf.5.1790667058017; Tue, 29 Sep 2026
 00:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929071743.23624-1-edumazet@kernel.org> <179066667444.31693.3326934466907750947@kernel.org>
In-Reply-To: <179066667444.31693.3326934466907750947@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 09:30:46 +0200
X-Gm-Features: AclHuK9CAnCUx8smImHilXsTcocuUN-fbbX48CMDJnYU9QbhFatMhZFb2tpvc_0
Message-ID: <CANn89iLUKHZVrUOEtqDwuAghCRAkddigPwSWj4uS=fKyWdk86g@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in tcp_check_space()
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Wen Gu <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Allison Henderson <achender@kernel.org>, rds-devel@oss.oracle.com, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	linux-nvme@lists.infradead.org, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 9:24=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>

Patch 1/9 fixes a bug found by code inspection.

Other patches are not bug fixes.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
