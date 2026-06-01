Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F5340401
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339737; cv=none; b=qfUHzklLB6ZeNAmUPO9JDFBSnGlS2eL0YSUtONLTPS0VYGvOFeFgEnBGag/rKv938jKdOvn1ulFSEtnPQ2R8UEjJgbLQZfGd7bsuhUeV29SUA4PZgtzr2Ecwol63kpMW3R8QFzdPoZKdEO7L+7iv7NVmSO8O2TdWDUGBuLuBe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339737; c=relaxed/simple;
	bh=SEDAX8kH+0Ds9fUaic49LXpaezHfqpt1iaHb4yoRQIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGLmN8/Fe5IzP7r1fPlxwptmepMhE5yCq1QGGQ1spqEsFMQN3zFg3KXL4taOz3TXYQnXDDQTt685CUcepsqfEFaqB0+Ib4erVqd2Vy20vqY2M4uqlnMx/sjPwieIqFQlLwqDLefej0dvmimr23mic1ad2kjGCYpyLuFkXfUG9N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PzZw7wj1; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PzZw7wj1"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-485621336easo4046955b6e.2
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2026 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780339734; x=1780944534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0L50cSK1nxdDSHByZeIkMXSHhk2AeadI/Jprs9UE4Ks=;
        b=PzZw7wj1uICyRl4Z62RDWM5mpNYfPxVhvLPmlvncvsQnVjerevHqDzf1A3GLZVxyKB
         BaNwJ0Vf2V3GbTiWcfSAZvou9qvW9dnb+P2iVxTOyLAn3mrO21OVe9z9O/HmYlkdTv+T
         E/iCN3xWEVOojddnZMMJjZN3Izx8WOCv4eJLywvJa/JrrD8FNCZQAYVGRADx27WAtlhM
         r5WMECX0mWISWPp7aV2cLwu9eX59vpl7QdEGGNq5LebyN7RrkV7W2ziqw3OwCnLV/7se
         tL0ZH6ETeGLaSon/cGC8iNsWa4I1IZAqjSl6Awkz5HXYh+uVEgttU3WLEGBCwT7FWiJT
         kvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339734; x=1780944534;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0L50cSK1nxdDSHByZeIkMXSHhk2AeadI/Jprs9UE4Ks=;
        b=aQg9W60UoSvpNu23RXHvAPT4U0J2pw6oKQ0/5HOEGoJ65msOWYUHKdDcX6JELAwjMR
         yzg06btnkM9jE/9Pt8JjeXiK7VLT3RSqAXB4yyVp/7+p3v1DNeQdFsHb4pnQl2rQDHve
         SFbwWjJjOi3V7WwhVgfjcOO3vNtgtmNCE3zQ0/lBEEcpJ4rhRFG5Vru0Eg+ha0GgNHAC
         tiYAN6J0WaZBCa/AEbeWOQUiaL7Ohs3m+zZRDqh39Tuu+7mpCugMlUibzDPJjd9If9KD
         k7P7NGY6T79vlPD55xkpKk2CTQTyHraYB37T1Y5CEWqTlo1CHBe+Y5GlbcQd0RKUuQbH
         w8fw==
X-Gm-Message-State: AOJu0YyVR8D1XcbDCoaxNsK9mrWjQPJLLxZ6A93KPm5vHum2bN5ckA+0
	b7WQaDcjyazdonlXPv04Yeu6dM8QW8kebdsrb2yjQNJll2188aOR4DlYeFlQJuzIgxF6VMR+czq
	TRh0HjpLwdw==
X-Gm-Gg: Acq92OGIdwqFWnW7/zE9rJrj0auh9VfE4pJ31xNdiQOBXNvSebXn8+Gr+m87oDtCu+e
	WyIS6RrYT6uMuDcL5ObCH3ahLZtw7nHcqKbyT8fIw6mZzeX6MAoUxiE1b6EfXcmt/hjm7+s+ecH
	t7pWMSnaWJWSUuo/6ZvuRGSLwLCmetNsXQFNqUe6386byLSZbgWZxUFxf0YEZ9q9Z/umzqvgUrK
	5Fk9SGET7Y0dBLp8c3at/vVT1lOT+mLNlSSgEYHiUipIZ4/T7rc1QRIX3LdQJxN+8KPJF41ERqB
	sZE91SRqpAkC05Ov5xLUpQ1zkakIgpr+XzzJX76sU2tZJKwq4gGTxxKiVI0UbIjOyaGM0pyC8gn
	sC4u5nlbBKmM0teglk1jnwJ0uiwy+aM9sc7DE2Y3XlTopgQT0ZgPKMpV4xZaX8yLHEi2x99axeM
	Wz88vXb6Vs95Wi7KqxoLbUi6/G9+QTS8TiYkUhFLxdpW+vkDKFy2SeeDiiKODS0egU1fPnxkkO2
	e4j52KkYj4hPd832AG/aNBxmKOAkeeEf2Nda9339w7HjGJPY8cWv1j5TiHfjoJD6KEtzslvD9er
	pzs5Yg==
X-Received: by 2002:a05:6808:221d:b0:479:ffcf:52e7 with SMTP id 5614622812f47-485fbd5cfe6mr6378574b6e.45.1780339734541;
        Mon, 01 Jun 2026 11:48:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a2c6sm4784623b6e.3.2026.06.01.11.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:48:53 -0700 (PDT)
Message-ID: <59e4398323951683b891eb82274a4d5a14240519.camel@dubeyko.com>
Subject: Re: [PATCH v3] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
From: slava@dubeyko.com
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Viacheslav Dubeyko
	 <Slava.Dubeyko@ibm.com>, "idryomov@gmail.com" <idryomov@gmail.com>, Alex
 Markuze <amarkuze@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Date: Mon, 01 Jun 2026 11:48:52 -0700
In-Reply-To: <f331e0cd-9b09-49db-a17e-f80a3bf64339@tu-ilmenau.de>
References: <20260521121424.2869056-1-raphael.zimmer@tu-ilmenau.de>
	 <41e9c36c9a05c8239177cee688cfddcebfd6455f.camel@ibm.com>
	 <f331e0cd-9b09-49db-a17e-f80a3bf64339@tu-ilmenau.de>
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

On Mon, 2026-06-01 at 12:22 +0200, Raphael Zimmer wrote:
> On 21.05.26 11:58 PM, Viacheslav Dubeyko wrote:
> > On Thu, 2026-05-21 at 14:14 +0200, Raphael Zimmer wrote:
> > > When processing an incoming reply message of type
> > > CEPH_MSG_STATFS_REPLY,
> > > CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on
> > > the
> > > monitor connection, an already allocated reply message for the
> > > given
> > > transaction ID is used (if existing). Such a message has a
> > > preallocated
> > > front segment with a fixed length of 64, 512, or 32 bytes,
> > > depending on
> > > the message type it was allocated for. The actual length to
> > > receive into
> > > this buffer is read from the message. If this value exceeds the
> > > allocation size, data received from the network is written beyond
> > > the
> > > end of the allocated buffer.
> > >=20
> > > This patch fixes the issue by adding a check that compares the
> > > needed
> > > front segment length to the previously allocated length when
> > > retrieving
> > > the message buffer. If the needed length exceeds the allocation,
> > > a new
> > > message buffer with the needed size is allocated to replace the
> > > previous
> > > one.
> > >=20
> > > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > > ---
> > > =C2=A0net/ceph/mon_client.c | 13 +++++++++++++
> > > =C2=A01 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > index 66c0d6d6b33d..852ed0cae660 100644
> > > --- a/net/ceph/mon_client.c
> > > +++ b/net/ceph/mon_client.c
> > > @@ -712,6 +712,8 @@ static struct ceph_msg
> > > *get_generic_reply(struct ceph_connection *con,
> > > =C2=A0	struct ceph_mon_client *monc =3D con->private;
> > > =C2=A0	struct ceph_mon_generic_request *req;
> > > =C2=A0	u64 tid =3D le64_to_cpu(hdr->tid);
> > > +	int type =3D le16_to_cpu(hdr->type);
> > > +	int front_len =3D le32_to_cpu(hdr->front_len);
> > > =C2=A0	u32 data_len =3D le32_to_cpu(hdr->data_len);
> > > =C2=A0	struct ceph_msg *m;
> > > =C2=A0
> > > @@ -721,6 +723,17 @@ static struct ceph_msg
> > > *get_generic_reply(struct ceph_connection *con,
> > > =C2=A0		dout("get_generic_reply %lld dne\n", tid);
> > > =C2=A0		*skip =3D 1;
> > > =C2=A0		m =3D NULL;
> > > +	} else if (front_len > req->reply->front_alloc_len) {
> > > +		pr_warn_ratelimited("tid %llu front %d >
> > > prealloc %d\n",
> > > +				=C2=A0=C2=A0=C2=A0 tid, front_len,
> > > +				=C2=A0=C2=A0=C2=A0 req->reply-
> > > >front_alloc_len);
> > > +		*skip =3D 0;
> > > +		m =3D ceph_msg_new(type, front_len, GFP_NOFS,
> > > false);
> > > +		if (m) {
> > > +			ceph_msg_put(req->reply);
> > > +			req->reply =3D m;
> > > +			m =3D ceph_msg_get(req->reply);
> > > +		}
> > > =C2=A0	} else if (data_len > req->reply->data_length) {
> > > =C2=A0		pr_warn_ratelimited("mon generic reply tid %llu
> > > data %u > preallocated %zu, skipping\n",
> > > =C2=A0				=C2=A0=C2=A0=C2=A0 tid, data_len, req->reply-
> > > >data_length);
> >=20
> > Looks good.
> >=20
> > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > Thanks,
> > Slava.
>=20
> Hi,
> I noticed a problem with this patch. I based it on the testing branch
> of
> the ceph-client repository, which contains commit 2b79b1b ("libceph,
> ceph: reject oversized mon and MDS data segments") that is not yet on
> the master branch. This commit adds the lines:
> 	} else if (data_len > req->reply->data_length) {
> 		pr_warn_ratelimited("mon generic reply tid %llu data
> %u > preallocated
> %zu, skipping\n",
> 				=C2=A0=C2=A0=C2=A0 tid, data_len, req->reply-
> >data_length);
> 		*skip =3D 1;
> 		m =3D NULL;
> that check for messages with oversized data segments and discard/skip
> them. Due to the use of multiple else if statements, the current
> patch
> shadows this added logic in case where both front_len >
> req->reply->front_alloc_len and data_len > req->reply->data_length.
> Therefore, this patch needs to be adapted to the other patch by
> either
> reversing the order of these two checks (since skipping the message
> makes reallocating a new message with a different front_len obsolete)
> or
> reworking the logic to not use else if statements.
> Would one of these options be preferred?
>=20

I think it will be better if you share your vision of the corrected
patch and we can review it again.

Thanks,
Slava.
