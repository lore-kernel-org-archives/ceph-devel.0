Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAC408636
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686111; cv=none; b=ljwn5xz9tEosePwJ6r1fOybrjt4kdE/futPqsoh4MleGrU5eIgLCSdWx8cmTujLvsK2cti/moR2eO/6+juSHjnOlCft0vjXesiIBWjfN9r0A1e55MMp5xmGiiLIh4HWeueBhrjX3FAcT4J/0RLD5zlkaUWQ3OWdBhYc7NfMOMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686111; c=relaxed/simple;
	bh=1dTWrh4pGsNZ+JGRbzvSJiImulLwNjT/ZqA5Vytu7zY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPJZfWtqGJOgNaCRAJGaUwQ97qYSCHfPYN0ADFPY711iyOQtBL4nkNJkElwPQSOHXKQRNkOVlLrb7NaoNDVbbINiUjPvgk7CDsJ5K1N6TGwlHmrxmZnjqvxGWou58CYOAfp8amql3yrjX7x+GjxP8nPlHtCwG8IHUm9j7WteqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=d9EwjX3u; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="d9EwjX3u"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dbcb505578so29137797b3.3
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2026 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780686106; x=1781290906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PhNimQrLDJyKzqH57WP3dLTcmuaF7X/GvXNpg6zA4Es=;
        b=d9EwjX3uQLR1VGc1X2uX4BxQvoOgD1sl+UPTmA6th2TUQi107Llk7mrTekhTn20z9F
         NN7m43aSFDR1DHv4kmvGBIhpMYu7sk+V4PLcnxXV8BewtdM3topehx/9rzHOsnem6fef
         vGU5eRap9rZsAV380byG44B/vi3L9xjvXrjD7uh72YokDQmr+o3xWhfH+sMI20YjXIVz
         rBUV2SpHlNQ1lkcuHbUtLjCra1Y3M2t0lC0PcHtXvgcVLzjR1KwaZqYfcFiVipYBtsrz
         4pjX1+gueFjiZeKaJMVHcCaewn3BixzbTClo5aDDmU1tgz2mjLEcDIxTjby3klXsCZDp
         uwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686106; x=1781290906;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhNimQrLDJyKzqH57WP3dLTcmuaF7X/GvXNpg6zA4Es=;
        b=VYRV8RciGPdxAt2Gt5g/jW4TdFCoioX7OxTQJvbG+TyYgdPRI3IkS/s1i8ea64ZxKT
         ebWqfboUqaV7bCHNatCf8GawqNy/ebPgBwgSbUdJw49ZJ5k7Iw87LjrM0IxKW+uGzcr0
         yT2unasDub27NyddbMU9CLzpXpTS16WspgNBZwmNLMp4GfGDLGr8RnE+qEukVye2enwW
         qOtKLZpidE/wdy0VHhbAh0zxfOvOqDgY38NARtjyJaJRebkjGjIo3nPblh/kS5yiYx1O
         +MRR6FZk7/1WGQa+DTJLqMsNSFv3EGYzb0jsnwbR9FDG1IvEnUto/tT4inuQgxzI6CgQ
         /DTA==
X-Gm-Message-State: AOJu0YzumYq5EMj+K+ULCmID/lQx4kKTcjYFW50kZdAuwg1bEQtjGgxA
	MT9IaYMRLBKz5EsRAaO2lGPQkwMUCxwMRQOdHqWBK5yomkOzmjjFPjBv8swdJcoVX8w=
X-Gm-Gg: Acq92OGOgs9CA3ZVwimyXuhSA/nwRH9XP1mkZD1gHb0DYDs/D09iGdTrp/w1KbZuvC2
	1i8/5WJUkxYHHkbPaJzttr0W6lmk/4lWHQ7/7yAS8HxrDikpM4jicAPQocJ7WoO87GnKU/dzbU+
	bzX2RGDoM8gpv+EuQfQWSbo8JWwGndJScoyV9V0UcU8bdDOlNMqMYS/5cRPAj8JtGWOOa1zEi9T
	0OstfINlaqIFMLuQ79a2wFvk8Jv/nOQkbfl5v/ppcFWmZlTBXl1LhIYMTwkxnXC/C+yEl0yl9YQ
	KwxY1fQEW0uf1RPB06fxAskBh35aiAy5sfhldesk2KFEeoqCHdouKZKe7spjEtzHEUdte6pwUK1
	VOzyG4n0Upra8b48LzGuLycbEb8OIhiKn+7Dl30XqPSOoPPw65MvYxdsN7Xk2Arj1QCHV9kBkUm
	li9cve0SxbgiA0hv75xkcSPrHAEMM6gaexFGdzSujTjzlysWcGIPCnmd0NqGtNFnN2+4WrrvY0o
	hZmhS39fmN2M222dHre4gkeD+rmSN3C/WLl982r9BkZT17K1L6J1KoLzCXVbjooTow0
X-Received: by 2002:a05:690c:6189:b0:7dc:605d:7a93 with SMTP id 00721157ae682-7ed0a013c04mr50334217b3.0.1780686105713;
        Fri, 05 Jun 2026 12:01:45 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:80ee:99ae:6c1:509d? ([2600:1700:6476:1430:80ee:99ae:6c1:509d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a95b77sm53777277b3.34.2026.06.05.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:01:43 -0700 (PDT)
Message-ID: <4104963e7d55beae3357049e0b50f0423fee2594.camel@dubeyko.com>
Subject: Re: [PATCH v5] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Fri, 05 Jun 2026 12:01:41 -0700
In-Reply-To: <20260605081000.647658-1-raphael.zimmer@tu-ilmenau.de>
References: <20260605081000.647658-1-raphael.zimmer@tu-ilmenau.de>
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

On Fri, 2026-06-05 at 10:10 +0200, Raphael Zimmer wrote:
> When processing an incoming reply message of type
> CEPH_MSG_STATFS_REPLY,
> CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on the
> monitor connection, an already allocated reply message for the given
> transaction ID is used (if existing). Such a message has a
> preallocated
> front segment with a fixed length of 64, 512, or 32 bytes, depending
> on
> the message type it was allocated for. The actual length to receive
> into
> this buffer is read from the message. If this value exceeds the
> allocation size, data received from the network is written beyond the
> end of the allocated buffer.
>=20
> This patch fixes the issue by adding a check that compares the needed
> front segment length to the previously allocated length when
> retrieving
> the message buffer. If the needed length exceeds the allocation, a
> new
> message buffer with the needed size is allocated to replace the
> previous
> one.
>=20
> Fixes: 3143edd3a185 ("ceph: clean up statfs")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
> =C2=A01 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 66c0d6d6b33d..b299f6016eb4 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -712,6 +712,8 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0	struct ceph_mon_client *monc =3D con->private;
> =C2=A0	struct ceph_mon_generic_request *req;
> =C2=A0	u64 tid =3D le64_to_cpu(hdr->tid);
> +	int type =3D le16_to_cpu(hdr->type);
> +	int front_len =3D le32_to_cpu(hdr->front_len);
> =C2=A0	u32 data_len =3D le32_to_cpu(hdr->data_len);
> =C2=A0	struct ceph_msg *m;
> =C2=A0
> @@ -721,14 +723,30 @@ static struct ceph_msg
> *get_generic_reply(struct ceph_connection *con,
> =C2=A0		dout("get_generic_reply %lld dne\n", tid);
> =C2=A0		*skip =3D 1;
> =C2=A0		m =3D NULL;
> -	} else if (data_len > req->reply->data_length) {
> +		goto out;
> +	}
> +
> +	if (data_len > req->reply->data_length) {
> =C2=A0		pr_warn_ratelimited("mon generic reply tid %llu data
> %u > preallocated %zu, skipping\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0 tid, data_len, req->reply-
> >data_length);
> =C2=A0		*skip =3D 1;
> =C2=A0		m =3D NULL;
> +		goto out;
> +	}
> +
> +	*skip =3D 0;
> +	if (front_len > req->reply->front_alloc_len) {
> +		pr_warn_ratelimited("tid %llu front %d > prealloc
> %d\n",
> +				=C2=A0=C2=A0=C2=A0 tid, front_len,
> +				=C2=A0=C2=A0=C2=A0 req->reply->front_alloc_len);
> +		m =3D ceph_msg_new(type, front_len, GFP_NOFS, true);
> +		if (m) {
> +			ceph_msg_put(req->reply);
> +			req->reply =3D m;
> +			m =3D ceph_msg_get(req->reply);
> +		}
> =C2=A0	} else {
> =C2=A0		dout("get_generic_reply %lld got %p\n", tid, req-
> >reply);
> -		*skip =3D 0;
> =C2=A0		m =3D ceph_msg_get(req->reply);
> =C2=A0		/*
> =C2=A0		 * we don't need to track the connection reading
> into
> @@ -736,6 +754,8 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0		 * at a time, ever.
> =C2=A0		 */
> =C2=A0	}
> +
> +out:
> =C2=A0	mutex_unlock(&monc->mutex);
> =C2=A0	return m;
> =C2=A0}
> --
> 2.47.3

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
