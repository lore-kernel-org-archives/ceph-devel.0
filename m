Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48A3093C1
	for <ceph-devel@vger.kernel.org>; Fri,  1 May 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659111; cv=none; b=o9uXeaqIEuFC5C+bdTikhp7wJeZa3q8+valR2300+h94RE64/p0ZR75btOm6lAk0TXsQ4y86P0Ads5tC9UrBcgV1/NeTA4+yga4BLor6RYFJjs5rU585ZarPQa2ncmqHGY7QboedwnggpIbIfWjoK2JanAUCEDEtuekk2MliMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659111; c=relaxed/simple;
	bh=YpyUviP3isZKt9JroCZjvCHPJSXii8406daT7SwG1D4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2HO+znmxPeTl5H1h4XsEoCoQRYJdTXAIRUA+lAitXWc6pJjjYaeAuUgXzrittZ+frMXCdfM0hpSr9YChCzqSfPh2KRs+ufQFtw4cFAx7U5Toyb9+g5wbPyz6C28MmZptKiT8eTvwoXUG2/qa9tlfkv7P5MSXVgwUa6nuyR6jqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=G+6uRZQx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="G+6uRZQx"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bb0d18c7f9so23448647b3.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2026 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1777659107; x=1778263907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YpyUviP3isZKt9JroCZjvCHPJSXii8406daT7SwG1D4=;
        b=G+6uRZQxEwyfeM+d/U9sMLBJuXbNXE3Nq9LYevbiGlyUOLyDWGwpMBUNchFmPLVxQ8
         LbJ/HfhkoADCWD7Xrma8g5hu8q/dNZQ6n9WyXYKWnwLdG15TcDjJX8kXMt/fVCbMKuav
         TtlLhTWVdC2ZMQFyNaIFpvx4/WKS2vN5xROG6qDNeqRGaXzPAPqd1y0UiP7oDwXMUtbW
         uO0cEEQC7Ng06gn6KlYsvzJGj8Uuk44zQY4eARKjMXj+N9+G5DKvlxuQbOJzaHcwGfvq
         0qt1DS0g2oCkaOMNqwa1vqCK0b4aRah3ISwWZYrSwbjgfnuEpzAZMwhT+RSWNYJX9Wt5
         RCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659107; x=1778263907;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpyUviP3isZKt9JroCZjvCHPJSXii8406daT7SwG1D4=;
        b=FtbWgE/EU2hrxtMNMA4kh6F8vKudvCgjuFIw/fNkn3iREG/UdkXUcyHug4YVuTYHpu
         5rqbo7G9x0ct581SWYMoX1yCWKnbmipWTmdDXtI1TjzjFY67HGIDUwtoqAH6bJynHHJL
         0kmfJ5hQfGcA9zd43D1HfJRWHcMnR12kbkVNu7jx2vKPlOa+SmOXs2c4piBabCQnn3LL
         vi1OEOnuaNx0P1BjaNRrXVkSaiJnzeOnmdojaRKJY5MwiE7IreNRYKoQLArxTw+S3DqC
         tEbjBLUYUNPpJzsM+Kl36PoZgw+OgRu/os+LbiKLS6gMRF3v41rz4DmCm2GSddU1/90/
         OSLQ==
X-Forwarded-Encrypted: i=1; AFNElJ9faqfhZmdU+X6vaNKl2G1RpvpPrt8OlyH+dZor059uLJzwUyu1ONiD7+zsvZxlLprigSnSjsBnca31@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFL2GJT6FNI2fyILK2sVn2pFOqWW/7K+xZJZOp0TWvJKtMWAu
	VOtKtZ8g0YRXu4B8iWupk1BwFscX81F2iOQTQMVlkixYRU7gSQ7yrNTCWhAGfRL5RLQ=
X-Gm-Gg: AeBDieuCstIwNzXnrc9nKVtdURvswMeketvMRzsmEqzo0wgXOh+97Ad12iLScRxXP4d
	k+F9aqaG4oCthrqKLASmy7m9lGFj0WJaj8Gnf62bSnzhIok5Qvemw02nlxa/70njPTvE5D2zbAJ
	eAcZmbeW+ECQvFIrSQCiVPuEeQuOM6Wf9ZO8MxXm9f6uemULkrccArpMhy7lxASXjD9DJYeDyo6
	7+wckVHP9A7XAG4us8nLcm0rwXeXmG0aTwiP9w4+EZrFG5XkwY930zZpZBELdorxTYF8jRFks3H
	7i5/eCPTs5J6O3xmL25IcRd1lRHcr+mXrwvijuJNgALyXUOiSwzr+TtCe0bIDQ2m4wdHit0/Pyn
	md3z/f41WrLylbEvnS0UuvKRWqvdcLtuvrhyv8G9RkY/rqVTJlqTLXJWtVWG5DjLyXoX904g2Rl
	UbED8xWMc6CIJ8sGMl4uXeJeZK4RKRaldZrmPy6IDpYWegstqUoQJLfgAJWc0tr8Q1Y8KMSlFKD
	LRG3+ogrsn4A3bA+8J+A7l7zoCEGZwwk8OJznC4ipt3lHgl2/AKmacbJKkzZyhK2e/w6qkE
X-Received: by 2002:a05:690c:10c:b0:7bd:7039:f2e8 with SMTP id 00721157ae682-7bd77128336mr4877307b3.42.1777659106745;
        Fri, 01 May 2026 11:11:46 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm14092737b3.23.2026.05.01.11.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:11:45 -0700 (PDT)
Message-ID: <c247520dd5bfe49e22b29d221967d0fd569c2e6a.camel@dubeyko.com>
Subject: Re: [SECURITY] ceph: msgr2 monitor data_len mismatch can trigger
 client kernel panic
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <gregkh@linuxfoundation.org>, 
	idryomov@gmail.com, amarkuze@redhat.com, security@kernel.org, 
	ceph-devel@vger.kernel.org
Date: Fri, 01 May 2026 11:11:44 -0700
In-Reply-To: <CAG8b5tTm6XMXOW3gycj13PU4=jRvsvYtNKYzMzg7mQO2h+E85g@mail.gmail.com>
References: 
	<CAG8b5tT0cqjS3D-q6Z=ufv73W69ZXfRA0FTm85uf9OEL34=-GQ@mail.gmail.com>
	 <2026050111-comprised-unreal-7b2a@gregkh>
	 <CAG8b5tSZX4OtkwLDgBCtWJPhWSoQgh9rHDzxW3bja9GkrciG0A@mail.gmail.com>
	 <afRoFf4QVANv3i-T@1wt.eu>
	 <2a70150e66ab67106ec9196eb7cd2ccbebe771a7.camel@dubeyko.com>
	 <CAG8b5tTm6XMXOW3gycj13PU4=jRvsvYtNKYzMzg7mQO2h+E85g@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-05-01 at 21:53 +0400, Dhiraj Mishra wrote:
> Sure noted, here is the patch.
>=20
> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00
> 2001
> From: Dhiraj Mishra
> Date: Fri, 1 May 2026 12:45:00 +0400
> Subject: [PATCH] libceph: reject monitor replies with oversized data
> segment
>=20
> Monitor messages can be allocated from preallocated reply messages or
> with ceph_msg_new(), both of which may provide only front-buffer
> storage
> and no data items.=C2=A0 The messenger receive path copies the wire heade=
r
> into the selected ceph_msg and later uses hdr.data_len to decide
> whether
> to initialize a data cursor.
>=20
> If a malicious or compromised monitor advertises a non-zero data
> segment
> for one of these front-only replies, the receive path can call
> ceph_msg_data_cursor_init() with length greater than msg->data_length
> and
> hit its BUG_ON() checks, crashing the client kernel.
>=20
> I verified the issue against v7.1-rc1-123-ge75a43c7cec4.=C2=A0 The msgr2
> trigger path is present since commit cd1a677cad99 ("libceph, ceph:
> implement msgr2.1 protocol (crc and secure modes)"), which is
> contained
> in v5.11-rc1 and later.=C2=A0 The monitor allocator pattern is older, but
> I
> have not tested older msgr1-only kernels.
>=20
> A concrete trigger is a monitor connection over msgr2 after
> CEPH_CON_S_OPEN
> where a FRAME_TAG_MESSAGE contains a monitor reply type handled by
> mon_alloc_msg(), a valid front_len for that message type and data_len
> =3D 1.
> CEPH_MSG_MON_MAP is one such example: the message is allocated with
> ceph_msg_new(), leaving msg->data_length and msg->num_data_items as
> zero.
>=20
> Reject monitor replies whose wire data segment is larger than the
> data
> backing allocated for the selected ceph_msg, mirroring the existing
> OSD
> reply hardening.
>=20
> Signed-off-by: Dhiraj Mishra
> ---
> =C2=A0net/ceph/mon_client.c | 21 +++++++++++++++++++++
> =C2=A01 file changed, 21 insertions(+)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d2cdc8ee3155..7f2293122bba 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0 struct ceph_mon_client *monc =3D con->private;
> =C2=A0 struct ceph_mon_generic_request *req;
> =C2=A0 u64 tid =3D le64_to_cpu(hdr->tid);
> + u32 data_len =3D le32_to_cpu(hdr->data_len);
> =C2=A0 struct ceph_msg *m;
> =C2=A0
> =C2=A0 mutex_lock(&monc->mutex);
> @@ -720,6 +721,16 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0 dout("get_generic_reply %lld dne\n", tid);
> =C2=A0 *skip =3D 1;
> =C2=A0 m =3D NULL;
> + } else if (!req->reply) {
> + pr_warn("%s tid %llu missing reply buffer, skipping\n",
> + __func__, tid);
> + *skip =3D 1;
> + m =3D NULL;
> + } else if (data_len > req->reply->data_length) {
> + pr_warn("%s tid %llu data %u > preallocated %zu, skipping\n",
> + __func__, tid, data_len, req->reply->data_length);
> + *skip =3D 1;
> + m =3D NULL;
> =C2=A0 } else {
> =C2=A0 dout("get_generic_reply %lld got %p\n", tid, req->reply);
> =C2=A0 *skip =3D 0;
> @@ -1499,6 +1510,7 @@ static struct ceph_msg *mon_alloc_msg(struct
> ceph_connection *con,
> =C2=A0 struct ceph_mon_client *monc =3D con->private;
> =C2=A0 int type =3D le16_to_cpu(hdr->type);
> =C2=A0 int front_len =3D le32_to_cpu(hdr->front_len);
> + u32 data_len =3D le32_to_cpu(hdr->data_len);
> =C2=A0 struct ceph_msg *m =3D NULL;
> =C2=A0
> =C2=A0 *skip =3D 0;
> @@ -1544,6 +1556,15 @@ static struct ceph_msg *mon_alloc_msg(struct
> ceph_connection *con,
> =C2=A0 ceph_msg_put(m);
> =C2=A0 m =3D ceph_msg_new(type, front_len, GFP_NOFS, false);
> =C2=A0 }
> + if (m && data_len > m->data_length) {
> + pr_warn("%s data %u > prealloc %zu (%u#%llu), skipping\n",
> + __func__, data_len, m->data_length,
> + (unsigned int)con->peer_name.type,
> + le64_to_cpu(con->peer_name.num));
> + ceph_msg_put(m);
> + m =3D NULL;
> + *skip =3D 1;
> + }
> =C2=A0
> =C2=A0 return m;
> =C2=A0}


I assume that the email has been sent not in plain text and
ceph-devel@vger.kernel.org simply rejected the email. Could you please
follow to the common practice of sending patches [1]?

Thanks,
Slava.

[1] https://docs.kernel.org/process/submitting-patches.html
