Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AE326D55
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763118; cv=none; b=gtES+KehBDHed4pBdDVfJ77JVB5erquyPJByGoUXcmI1e2JgI6TBB2Ai/x3J2aujj1yorIq3kcx63ScC+Atlamoliqy1l/iDh2N59BIuhUCH0OjKjU3brjdc6BXiowBn7fhGBo3dRr5135JsweIuzGBXVEqCibh0KELrB3UPwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763118; c=relaxed/simple;
	bh=XLbWT42s5jMVDd41l9hqaQmtfhCIbmLg/bfNwccVs7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5QDhVFA+3N1FmnOrA0jk6VemkdL10NQeY5sAH/INSYVcLVn7wngJHDIe9rMbSmJYfUHclgWtfr4dXGj0jyXZt5yBVQg7qp6+0YdSPo3D9oEGZOli3tNYnGSKU8ttmxA6aB+o6RfbD6VGXWrfqpqyK94tCe4GUB/pjzzbpJ0b6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=zV4Ct7yW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="zV4Ct7yW"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80cbb0688c8so23560757b3.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782763116; x=1783367916; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fD5aKMYp4Qwrn1hOn5bhFZzVA1pvZ9IswZhVGBhFTN0=;
        b=zV4Ct7yW3xnTIImkzBX3r+r8/PjaLxMgmm8xl9KdV/QS09Q2xnfBqH+RGsgJQlDI3F
         UkXYPmbf4JAHtra0z6YAoSqZoxBy7zGjOx7mY+f1t0Ha6qSTNzeeiVZ41YpMKi8bRmbG
         VUeBGiPylhKZo5+w/ABSeJyrQDzBDFdlwB3D1IoiAeX8+/LbrIaUjakv3QPSjIiHQS7z
         kkoAYv96AARXydpX7TsZ79UAaMEssSNrx9zETeZ3wQdPAYauvqnmAQDeg3HhU0Hv16Vq
         b1yrf5ru4OTBkghY+BBdFn4kjKQfFL6/nVwtbBR/H73KGXAskAKaySFCUpNscEjgYrrC
         QlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782763116; x=1783367916;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fD5aKMYp4Qwrn1hOn5bhFZzVA1pvZ9IswZhVGBhFTN0=;
        b=jW4Yi5bbiMpKP0FLfN4YdC/Adr77ywPpIE7dFyYJxmnyT3rD6scQ4gtFIuXMnwxo6X
         HVnliacr/pEucllrEdccq7Euw/nNSuOWUgTcP6f99/hRLz4FVA7uGPIh1johN1inSJAa
         MMtIxJyeqkqA957e0ozGhACfMrE9gxIPCtiaBNUqTI4mrRnKYOntvgYNPE6vmw2e3YCj
         gddajg3IA9jywUGTrIypMdSEpbjjfkZeqiXWc98WfgT+YRzT7uitymdmgnv+vDMHIHhZ
         i5n3FPLOF9Ijfi6FsF8R9oLa9pYzUPc45FVQGBmwMEu5PAoN44UK91LKru1jYA2QE7Uq
         CVag==
X-Gm-Message-State: AOJu0Yx+UrR60bL7ZKDVFZbm6V8yK8UrTtBDP1u8k8XQS8f7DIFhWnN6
	M2lHr++yOGZtMHFCQCCn5T6DiHXaH5QZHC65cUVQl85tw9z5gBd2ldftH1YTF9q+0GvgZMDzeOU
	IiHFRS7b6KQ==
X-Gm-Gg: AfdE7ckl7peiA8E6UIInnmBHXzayve4hDF3RWYfF7pLkghKRPkNEb750kdLu7B/J3ZF
	+VYHGTcrX9aEsyQgckzOgXvPq5Ve2xuBPcJ/VA0uEo2MJOmVshjRYcrm3hpJX6BL5oyW2u3Xb9k
	V9Xi0JymJMd9xv5fM8V9Pg3lwzhRpRh7dsLlSVzWB1O47MJiReARvFepE9CACMbkJ5Lf5eMEJYj
	iAN+RT6BCrEjgZpvjegdKcmr7E3UdT5xhSOz4IeJGcCuGPP90CVPNjsqKEmTkKQfx25iLMfDCq8
	s9lXruy+XP+BCOSK5k/FuEXcGXrwJwwuOLs1naPeUv+Hhc9BNDpSrnmaYHLX/PzmzKJ65zl0DYN
	06qioX2PYHDJabC4jBrGzpbgM+e4TEkAbq1hVj2VyJPSEkiWWmb5yLvCi15qNNItVsQi7KVSxKb
	RnZeSRtDxfy8San/VN3UGjboFllb/wVAwedPd9kRln8b1F9Li2JbuyXBguP2od1x1rkccrqOqXp
	eNn8Hlxwg/LU6p/YOdNeYFEYqkDVqHFF+2M5arAOcIjcutVXHHoLcE69aNeKcJcfLgnXvZ0d3sO
	ceJXOw8=
X-Received: by 2002:a05:690c:b18:b0:80b:cfb7:46a9 with SMTP id 00721157ae682-810d789b195mr10962187b3.13.1782763115507;
        Mon, 29 Jun 2026 12:58:35 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e9d4bcadsm2103707b3.29.2026.06.29.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:58:34 -0700 (PDT)
Message-ID: <490ac79fc66f9993ec77e0bc13218e29cd1dd1ca.camel@dubeyko.com>
Subject: Re: [PATCH v2 4/4] ceph: cap delegated inode count in
 ceph_parse_deleg_inos()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Jun 2026 12:58:33 -0700
In-Reply-To: <f1ae6f5a1b5ca0857f31b7b2cffcf899174f12ad.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <cover.1780766417.git.michael.bommarito@gmail.com>
	 <f1ae6f5a1b5ca0857f31b7b2cffcf899174f12ad.1780766417.git.michael.bommarito@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-06 at 15:00 -0400, Michael Bommarito wrote:
> ceph_parse_deleg_inos() decodes interval sets of delegated inode
> numbers
> from an MDS create-with-delegation reply. For each set it reads a 64-
> bit
> start and a 64-bit len with ceph_decode_64_safe(), which only
> validates
> that the eight bytes are present in the message, not the value, and
> then
> loops over len while inserting entries into s_delegated_inos.
>=20
> len is fully attacker controlled. A malicious or compromised MDS can
> send
> one huge interval, many intervals in one reply, duplicate intervals,
> or
> repeated replies that accumulate delegated inodes on the same
> session.
> The v1 fix bounded only one interval and still allowed aggregate CPU
> and
> memory pressure.
>=20
> Bound both dimensions. Track the number of delegated inodes currently
> held by each MDS session, reject replies that would exceed that
> population cap, and also cap the total interval length accepted from
> one
> reply so duplicate ranges cannot spin through an attacker-controlled
> len
> while making no successful xarray inserts. The counter is decremented
> when async create consumes a delegated inode, incremented when a
> delegated inode is restored, initialized with the session xarray, and
> reset when reconnect destroys the xarray contents.
>=20
> The cap is a fixed, client-chosen constant rather than a value
> derived
> from the MDS. mds_client_prealloc_inos is a userspace MDS
> configuration
> option; it is never sent to the kernel client on the wire, and a
> server-supplied bound could not be trusted for a defensive limit in
> any
> case. The constant is set well above that option's documented default
> of
> 1000 (a generous multiple), so legitimate refill behavior is
> unaffected
> while the CPU and xarray memory a malformed delegation stream can
> consume
> stays bounded.
>=20
> Impact: a malicious or compromised Ceph MDS can no longer make a
> client
> spin through an unbounded delegated-inode interval or grow one
> session's
> delegated-inode xarray without limit.
>=20
> Fixes: d48464878708 ("ceph: decode interval_sets for delegated inos")
> Cc: stable@vger.kernel.org
> Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2:
> - Replace the per-interval cap with a per-session delegated-inode
> =C2=A0 population counter.
> - Add a per-reply interval budget so duplicate ranges cannot run the
> =C2=A0 insertion loop without increasing the population counter.
> - Reset the counter when reconnect destroys the delegated-inode
> xarray.
> - Document why the cap is a fixed client-side constant (the kernel
> client
> =C2=A0 cannot read the userspace mds_client_prealloc_inos option).
>=20
> =C2=A0fs/ceph/mds_client.c | 51 ++++++++++++++++++++++++++++++++++++++---=
-
> --
> =C2=A0fs/ceph/mds_client.h |=C2=A0 1 +
> =C2=A0fs/ceph/super.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++
> =C2=A03 files changed, 55 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 4f36ac73305dc..ec5a80c9f86a7 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -612,16 +612,34 @@ static int parse_reply_info_filelock(void **p,
> void *end,
> =C2=A0
> =C2=A0#define DELEGATED_INO_AVAILABLE		xa_mk_value(1)
> =C2=A0
> +static int ceph_insert_deleg_ino(struct ceph_mds_session *s, u64
> ino)

static inline?

> +{
> +	int err;
> +
> +	if (atomic_inc_return(&s->s_num_deleg_inos) >
> CEPH_MAX_DELEG_INOS) {
> +		atomic_dec(&s->s_num_deleg_inos);

The atomic_add_unless() sounds like a better way to manage this. What
do you think?

> +		return -EOVERFLOW;
> +	}
> +
> +	err =3D xa_insert(&s->s_delegated_inos, ino,
> DELEGATED_INO_AVAILABLE,
> +			GFP_KERNEL);
> +	if (err)
> +		atomic_dec(&s->s_num_deleg_inos);
> +	return err;
> +}
> +
> =C2=A0static int ceph_parse_deleg_inos(void **p, void *end,
> =C2=A0				 struct ceph_mds_session *s)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D s->s_mdsc->fsc->client;
> +	u64 msg_deleg_inos =3D 0;
> =C2=A0	u32 sets;
> =C2=A0
> =C2=A0	ceph_decode_32_safe(p, end, sets, bad);
> =C2=A0	doutc(cl, "got %u sets of delegated inodes\n", sets);
> =C2=A0	while (sets--) {
> =C2=A0		u64 start, len;
> +		int session_deleg_inos;
> =C2=A0
> =C2=A0		ceph_decode_64_safe(p, end, start, bad);
> =C2=A0		ceph_decode_64_safe(p, end, len, bad);
> @@ -633,16 +651,34 @@ static int ceph_parse_deleg_inos(void **p, void
> *end,
> =C2=A0				start, len);
> =C2=A0			continue;
> =C2=A0		}
> +
> +		if (len > CEPH_MAX_DELEG_INOS ||
> +		=C2=A0=C2=A0=C2=A0 msg_deleg_inos > CEPH_MAX_DELEG_INOS - len) {

The len is u64. Should we use the cast (u64) for CEPH_MAX_DELEG_INOS in
comparison and calculation?

> +			pr_warn_ratelimited_client(cl, "too many
> delegated inodes in reply\n");

Should we show the number of delegated inodes in output?

> +			return -EIO;
> +		}
> +
> +		session_deleg_inos =3D atomic_read(&s-
> >s_num_deleg_inos);

Is it possible that s_num_deleg_inos could be bigger than
CEPH_MAX_DELEG_INOS? Because, ceph_insert_deleg_ino() should not
increment it bigger than CEPH_MAX_DELEG_INOS.

> +		if (session_deleg_inos > CEPH_MAX_DELEG_INOS ||
> +		=C2=A0=C2=A0=C2=A0 len > CEPH_MAX_DELEG_INOS - session_deleg_inos)
> {
> +			pr_warn_ratelimited_client(cl, "too many
> delegated inodes for session\n");
> +			return -EIO;
> +		}

I assume that it is enough to have the check for msg_deleg_inos. Am I
wrong here?

> +
> +		msg_deleg_inos +=3D len;
> +
> =C2=A0		while (len--) {
> -			int err =3D xa_insert(&s->s_delegated_inos,
> start++,
> -					=C2=A0=C2=A0=C2=A0 DELEGATED_INO_AVAILABLE,
> -					=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> +			int err =3D ceph_insert_deleg_ino(s, start++);
> +
> =C2=A0			if (!err) {
> =C2=A0				doutc(cl, "added delegated inode
> 0x%llx\n", start - 1);

Maybe, do we need to keep previous value in variable?

> =C2=A0			} else if (err =3D=3D -EBUSY) {
> =C2=A0				pr_warn_client(cl,
> =C2=A0					"MDS delegated inode 0x%llx
> more than once.\n",
> =C2=A0					start - 1);
> +			} else if (err =3D=3D -EOVERFLOW) {
> +				pr_warn_ratelimited_client(cl, "too
> many delegated inodes\n");

I assume that we already have error message from
ceph_insert_deleg_ino(). Do we need in this error message here?

Thanks,
Slava.

> +				return -EIO;
> =C2=A0			} else {
> =C2=A0				return err;
> =C2=A0			}
> @@ -660,16 +696,17 @@ u64 ceph_get_deleg_ino(struct ceph_mds_session
> *s)
> =C2=A0
> =C2=A0	xa_for_each(&s->s_delegated_inos, ino, val) {
> =C2=A0		val =3D xa_erase(&s->s_delegated_inos, ino);
> -		if (val =3D=3D DELEGATED_INO_AVAILABLE)
> +		if (val =3D=3D DELEGATED_INO_AVAILABLE) {
> +			atomic_dec(&s->s_num_deleg_inos);
> =C2=A0			return ino;
> +		}
> =C2=A0	}
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0int ceph_restore_deleg_ino(struct ceph_mds_session *s, u64 ino)
> =C2=A0{
> -	return xa_insert(&s->s_delegated_inos, ino,
> DELEGATED_INO_AVAILABLE,
> -			 GFP_KERNEL);
> +	return ceph_insert_deleg_ino(s, ino);
> =C2=A0}
> =C2=A0#else /* BITS_PER_LONG =3D=3D 64 */
> =C2=A0/*
> @@ -1056,6 +1093,7 @@ static struct ceph_mds_session
> *register_session(struct ceph_mds_client *mdsc,
> =C2=A0	INIT_LIST_HEAD(&s->s_waiting);
> =C2=A0	INIT_LIST_HEAD(&s->s_unsafe);
> =C2=A0	xa_init(&s->s_delegated_inos);
> +	atomic_set(&s->s_num_deleg_inos, 0);
> =C2=A0	INIT_LIST_HEAD(&s->s_cap_releases);
> =C2=A0	INIT_WORK(&s->s_cap_release_work, ceph_cap_release_work);
> =C2=A0
> @@ -4971,6 +5009,7 @@ static void send_mds_reconnect(struct
> ceph_mds_client *mdsc,
> =C2=A0		goto fail_nomsg;
> =C2=A0
> =C2=A0	xa_destroy(&session->s_delegated_inos);
> +	atomic_set(&session->s_num_deleg_inos, 0);
> =C2=A0
> =C2=A0	mutex_lock(&session->s_mutex);
> =C2=A0	session->s_state =3D CEPH_MDS_SESSION_RECONNECTING;
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 4e6c87f8414cc..3810b51ece2e6 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -255,6 +255,7 @@ struct ceph_mds_session {
> =C2=A0	struct list_head=C2=A0 s_waiting;=C2=A0 /* waiting requests */
> =C2=A0	struct list_head=C2=A0 s_unsafe;=C2=A0=C2=A0 /* unsafe requests */
> =C2=A0	struct xarray	=C2=A0 s_delegated_inos;
> +	atomic_t	=C2=A0 s_num_deleg_inos;
> =C2=A0};
> =C2=A0
> =C2=A0/*
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index afc89ce91804e..bfc26e4d83bb4 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -634,6 +634,15 @@ static inline int ceph_ino_compare(struct inode
> *inode, void *data)
> =C2=A0#define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
> =C2=A0#define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) +
> (CEPH_MAX_MDS * CEPH_NUM_STRAY))
> =C2=A0
> +/*
> + * Upper bound on the number of delegated inodes a single MDS
> session may
> + * hold. The MDS normally hands out a small preallocation window
> (the
> + * userspace mds_client_prealloc_inos option defaults to 1000) and
> refills
> + * it as the client consumes entries. This leaves generous headroom
> while
> + * bounding the CPU and memory a malformed delegation interval can
> consume.
> + */
> +#define CEPH_MAX_DELEG_INOS		8192
> +
> =C2=A0static inline bool ceph_vino_is_reserved(const struct ceph_vino
> vino)
> =C2=A0{
> =C2=A0	if (vino.ino >=3D CEPH_INO_SYSTEM_BASE ||
