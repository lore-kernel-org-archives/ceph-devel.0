Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C865126BF7
	for <ceph-devel@vger.kernel.org>; Wed,  3 Jun 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507003; cv=none; b=pd1VmI8Yx7rw85ElbpVV173KdG+0DxdWQGplnsjh6PXsg1qrE3j+XqboNPqS8g2NL3lKD5U2Bydd6o3FP2Lad5nxKMC/7Wo2oouHNZ3zvQhj+VPgLUyVnjz+JlhZ8C3zZHcoDbsOS+9Q8aGNaUqGLGrscswhjebM6sVfw86815o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507003; c=relaxed/simple;
	bh=ngTCR9eiwJrkT1f/GsreUaKcuCcRtO+RjsZzwv67e5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RjWh1vFQXCYT+eNVEfz0/3ZDXlFzjnLFWD+K0zThQo4/tZt9GANiLa+94uUcvBwKze3wxcOO8I23uSxHShOReY4Rs1o3xRwTDra1/uxO4snEG5koL8llxvklI7gi/r066Nrh8DWtNNiaw1BcsqZ2Oq5wK0fScpNKYVFNUa64PDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Cj1T0J9S; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Cj1T0J9S"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4854166e1efso11518271b6e.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2026 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780507001; x=1781111801; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJNX1h2gxcWdqUcCrra8ZK/3LsYoZmD7kJVoNn5llxU=;
        b=Cj1T0J9SevtYp9VFMKBLu1ZnYoCxCsLmWIyHy6naOzdWXH4j3So6sJMP6cqO7vUZci
         IkahU3P8mc6MoFjKUUzlJJkw43EyZHPKVc3V2YJtBFfhtS1a+oIXZBOdBrCLaVEfyWdn
         u1+BuMUzj0HapXTFVzMF2CGBxWKA0ZSzLj5tuNp0lQjfqDZ95aRdGDADuAzFPDiUSTw0
         aA4kR030Qk3Edk52MzfHue2qXOqcgLbfGxiCkYMvdVQ1wC7EXt6l8BCNunDQQXkEnehI
         anzcEfkHfNpYYaNinyd9lLXDgmGaajPZZKEuQMAVKPv/bZRtsj2TtrTN3dmrcXkzkV5S
         MX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507001; x=1781111801;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJNX1h2gxcWdqUcCrra8ZK/3LsYoZmD7kJVoNn5llxU=;
        b=hB+MTjVAeA5Z0scbr12o55/bCM5iTNjdujNl/JCJ5+7pD0UMztGpIvNgUy7q8MDXRF
         m/Ak/2AE8jXHgSyQOk7hDIQFWq2sLpk+SXL5c7aAi1611JvvHSICVc/O9Rdy/27jCvKY
         /wrnU2RWZ4MYsv0L9rI413A1glP52A8/4UptG3ljkBqj9axLZyXcKvzl+nJUxpTo/sXd
         EWiPEFd7ADUjNTMDmO6y7p+1J8sz10JjRtaagOoJ2+7fVmcueiw4nVT5xLlhwtgf+npc
         HfPMFEaZYvIlpLLfRdFjOhIzgTWWqhDadeo+cRpliQJEwORK3ZBvBaCOmeK69l9+tnyv
         axww==
X-Gm-Message-State: AOJu0YxeSB4ZL4i5kUPY9hH79BGYCX2K7uoQEO++rff6f0ejgo9wcBQI
	UNQzH95lzA2FWPZgdSYWappv54/5fv3DKu0Mq7etjPvoiviI0n91rMFeaBqDId8DtbI=
X-Gm-Gg: Acq92OGPeYRSC0icfCdT5w98MXqIrVNTSsXzdX/5tAV8FX3AUk2hTyTrlOvemWNkaPB
	c88WuitZs4T0nzmN0UAiSZaBDWmVZNfKpKPHBcUNoK8VOrs8/5X5nSCf7Kl9kgSkHIDIpSIduVZ
	uBZYmOHgsCNwOXwiX9WCv3xIPra7jhHYoNtQZjONirYaOjXcHmqiby1+PTlbHm3PkA9gmW5agTP
	6ImW9B5R59gBonrRx+N6myVMQlgFx/deyfMoDxGUDb1u+PgG0RSGAXO92TuR1T6QQzHWQU4Woqy
	uzrYjH7msJqeOhL67y//0uI+aUsdAGl+j7OPHYPN4mQajkoGMdoO15HOb4YGuGH2XEZeS9yAq3J
	j0kBgrB37bztHHUX7WjSkERnahEG/ECqMrOhig31SgqoILUaTzmw8jOJbFfF/pSsguDRTHGGWX3
	/JI8wYoEi2mlLqtJRq5bkrwTne5KrCxOZqdXnww7RY3mnqydBGzm+DYOIiztCldP8/GphdPYOza
	yUE5HGnBxHPTM//gqjZkRcxVSqQjJEoAjFHD3HIBYDWYioESPVbGs1kP9yCKiOv2YM0
X-Received: by 2002:a05:6808:17a2:b0:486:5115:6c0 with SMTP id 5614622812f47-4865aa254f0mr2609366b6e.14.1780507001253;
        Wed, 03 Jun 2026 10:16:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9912:77fa:9c5:3949? ([2600:1700:6476:1430:9912:77fa:9c5:3949])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b91f944sm2184557b6e.9.2026.06.03.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:16:40 -0700 (PDT)
Message-ID: <7973116eb155a81f8e886028318904c3ce5b7524.camel@dubeyko.com>
Subject: Re: [PATCH v4] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 03 Jun 2026 10:16:39 -0700
In-Reply-To: <9dbe4363-85cc-47da-bc16-abe6dd8d7d07@tu-ilmenau.de>
References: <20260602151025.4145216-1-raphael.zimmer@tu-ilmenau.de>
	 <0d6480e8c6c64dd13d45781bccdb097d8025438f.camel@dubeyko.com>
	 <9dbe4363-85cc-47da-bc16-abe6dd8d7d07@tu-ilmenau.de>
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

On Wed, 2026-06-03 at 10:57 +0200, Raphael Zimmer wrote:
> On 02.06.26 7:15 PM, Viacheslav Dubeyko wrote:
> > On Tue, 2026-06-02 at 17:10 +0200, Raphael Zimmer wrote:
> > > When processing an incoming reply message of type
> > > CEPH_MSG_STATFS_REPLY,
> > > CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on
> > > the
> > > monitor connection, an already allocated reply message for the
> > > given
> > > transaction ID is used (if existing). Such a message has a
> > > preallocated
> > > front segment with a fixed length of 64, 512, or 32 bytes,
> > > depending
> > > on
> > > the message type it was allocated for. The actual length to
> > > receive
> > > into
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
> > > a
> > > new
> > > message buffer with the needed size is allocated to replace the
> > > previous
> > > one.
> > >=20
> > > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> >=20
> > What's about Fixes here?
> >=20
> > > ---
> > > =C2=A0net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
> > > =C2=A01 file changed, 22 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > > index 66c0d6d6b33d..b33ae17546f8 100644
> > > --- a/net/ceph/mon_client.c
> > > +++ b/net/ceph/mon_client.c
> > > @@ -712,6 +712,8 @@ static struct ceph_msg
> > > *get_generic_reply(struct
> > > ceph_connection *con,
> > > =C2=A0	struct ceph_mon_client *monc =3D con->private;
> > > =C2=A0	struct ceph_mon_generic_request *req;
> > > =C2=A0	u64 tid =3D le64_to_cpu(hdr->tid);
> > > +	int type =3D le16_to_cpu(hdr->type);
> > > +	int front_len =3D le32_to_cpu(hdr->front_len);
> > > =C2=A0	u32 data_len =3D le32_to_cpu(hdr->data_len);
> > > =C2=A0	struct ceph_msg *m;
> > > =C2=A0
> > > @@ -721,14 +723,30 @@ static struct ceph_msg
> > > *get_generic_reply(struct ceph_connection *con,
> > > =C2=A0		dout("get_generic_reply %lld dne\n", tid);
> > > =C2=A0		*skip =3D 1;
> > > =C2=A0		m =3D NULL;
> > > -	} else if (data_len > req->reply->data_length) {
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (data_len > req->reply->data_length) {
> > > =C2=A0		pr_warn_ratelimited("mon generic reply tid %llu
> > > data
> > > %u > preallocated %zu, skipping\n",
> > > =C2=A0				=C2=A0=C2=A0=C2=A0 tid, data_len, req->reply-
> > > > data_length);
> > > =C2=A0		*skip =3D 1;
> > > =C2=A0		m =3D NULL;
> > > +		goto out;
> > > +	}
> > > +
> > > +	*skip =3D 0;
> > > +	if (front_len > req->reply->front_alloc_len) {
> > > +		pr_warn_ratelimited("tid %llu front %d >
> > > prealloc
> > > %d\n",
> > > +				=C2=A0=C2=A0=C2=A0 tid, front_len,
> > > +				=C2=A0=C2=A0=C2=A0 req->reply-
> > > >front_alloc_len);
> > > +		m =3D ceph_msg_new(type, front_len, GFP_NOFS,
> > > false);
> >=20
> > Does false is correct here? If we provide can_fail =3D=3D false, then
> > allocation failure results it:
> >=20
> > 	if (!can_fail) {
> > 		pr_err("msg_new can't create type %d front %d\n",
> > type,
> > 		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 front_len);
> > 		WARN_ON(1);
> > 	} else {
> > 		dout("msg_new can't create type %d front %d\n",
> > type,
> > 		=C2=A0=C2=A0=C2=A0=C2=A0 front_len);
> > 	}
> > 	return NULL;
> >=20
> > The can_fail =3D true would suppress the WARN, matching the intent of
> > a
> > graceful degradation path.
> >=20
>=20
> I chose this to be consistent with the handling of reply messages on
> OSD
> connections [1] as well as the handling of other messages in
> mon_alloc_msg() [2]. I'm not sure about the graceful degradation
> path.
> If this allocation fails, it's an unexpected out-of-memory error.
> However, it's no functional difference and only affects the
> logging/WARN_ON(). So both options would be fine with me. If you
> think
> it's not a problem to not be completely consistent with other similar
> code paths, I can change it to can_fail =3D=3D true.

I already lost myself in all possible combinations of various
arguments. :) You set *skip =3D 0 and if it means that we would like not
see BUG_ON(), then we need to set can_fail =3D true. Otherwise, can_fail
can have false value.

Thanks,
Slava.
