Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32873F4DF3
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420525; cv=none; b=lJUQ9jh4rnzpKuAJDbrRoqDF6znEih3eu3Ek+DZeyXxavFCehFqZTC+HetQWzCcMcT4FnRjsx3TDNRX4RMbX6vr3hnpac6u7NBzwHsx3IJYJTRkS7ihaKyQEBBWtMsk4gKTzqqaz3Y+hNXVR6Ex3wp+OTr17PYo1hxGGZl5t6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420525; c=relaxed/simple;
	bh=A0+lm0dDHWU1wbZQUROQDMPr/62FPKccAqKYcpfw51o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/EnL/4KR9NlrYKfxPjZwbajmwYkxkPTGZ9lSrhYXTatCSbfunpY2K4rJ0YWsf4ce+2kaNkbm6wk+rDo+xdX7XFdGZ2weEqzdoFy8saFCObrQDYmS073T206ePY4Jy/bk8boGOxuc+2AVKEH5Ks/xdK3FdyeFENaiiBLaFgZETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ZzS06TMp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ZzS06TMp"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e61e25199bso4212150a34.1
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2026 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780420523; x=1781025323; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s10iaWznmozqSUv2b4joAOXgh4H4JNnwXdmB6d45Dio=;
        b=ZzS06TMp9h8elPusUMwhVa07n1qQp/hQf6LpCWljoACQNYu6c7JeQoQyowHobTCErc
         6moASQI7rfFnIatiiPIrYGS6BxEzKFyO9jj3Hi/paEl7bPc0TSkXUuQ4Ogxn5BsGUq0c
         6bCr/A7RahAjeAG1YUenM7mKGsx4sfQ1qGFIoy75iZktf8dzLnmFy763SpTNAY2+MWV/
         R6Af6iMFC6wPskGQ86JRVDbQDfe39Pj0IHoI6HnmTMfykTOURtkB9m5lcB/nbH6wE87V
         1pR/+22s5EfFl5EDZmnUlFNw8D7rTQNRQCGOIdewvAlUYUTIDEC6aRVMzzDbckU0QH52
         /pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420523; x=1781025323;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s10iaWznmozqSUv2b4joAOXgh4H4JNnwXdmB6d45Dio=;
        b=jJ71wVGD0KlbQY5udjO0NjcINEyEGAXBobF88x4GXGa56BrXSWFdOw0LwTu3JFRVvf
         i+tJ4Z+IRl8ZzAQNEy69a8uTa4MHcltrwqJUdyw8iujhuA0QCKw4opej0kbBou+Guu4N
         NwNsePhO7X4/OXT2PDC5kAfhoV0kvtQivG4biC2J72zQyPhK4GCpXjmTYaRCj0F7TavN
         rR17GPgZTNM1poHvigUQteWvV4GcC4dnJlS8aAeumRVe0scjIUJkzfukE5dOv2Se2Xje
         Itv44CtcWeRdOjYk3n2IfqIHgNnwIFT56cAb46VuojGmT9+vyJV7XC85Pvjb6hmp1fik
         r8Lw==
X-Gm-Message-State: AOJu0YwGXacKpWZ3muUdxJW0tp0Vui3PbTXN5za3z3JSeNbYRB5fIb7c
	Fl+wYwxhNTEjCWs82Zpqhw3tNJmCn+ajWxF+aZDMu6ZwrX3mV2wgdIV6pJlLu9Pn2Z8=
X-Gm-Gg: Acq92OGj7deXJVqsGN3n7MhYMzCSHstazMCFQBYEnbj6rOmcjAjq60cZlraDQS9m+Fc
	hTqImnb3/YhZm2mvtnff0cdHo8ilJt7v+xOM3YD1wKEicbaXHeIt4xrAKDhfoLlCqAvmBaRt8C0
	lysKpB1VNTqhzLS9W3VqUDL6x30MmH8607sooONXcWgHCuGc95KwSsjMushK4B6+MMRqTCtUwx+
	t6RrVhlZxq+qKewez985Y1HnsmW99tXZTrt2FY1YSgHHdIYJcjrxA5daV/COAxmXlL48yRLfUn1
	ptpBXdME7LxoCegQynP9t+6kHrq4WqD6CAW4PJy2UOWi9CEsXPmxBh4TabDL5bNRgGnYVOzwttP
	nPqA1O6l45YJLExDd78rIEupFKP9h81CUWMdSZopW4QGQucea+WFpHs8XVTNPLmD0cK8oC4ABgk
	Dxa/Bcg+KSmexybkNzX3cDS5ku1aFYZRtAl9XOc3fmL6OppF6m72ROm88HXlHYQNXJ3MjxHX8R+
	ZCEswQQF0nSWQ/+DfnRWp0ILtSdxqYtMRFn5gR6Ezcxt/tPvEOa0vMmEG51lW0L6EMvI4s=
X-Received: by 2002:a05:6830:610f:b0:7e5:6c74:b295 with SMTP id 46e09a7af769-7e6e639039dmr188512a34.14.1780420522602;
        Tue, 02 Jun 2026 10:15:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d918cfsm10477438a34.26.2026.06.02.10.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:15:21 -0700 (PDT)
Message-ID: <0d6480e8c6c64dd13d45781bccdb097d8025438f.camel@dubeyko.com>
Subject: Re: [PATCH v4] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Tue, 02 Jun 2026 10:15:20 -0700
In-Reply-To: <20260602151025.4145216-1-raphael.zimmer@tu-ilmenau.de>
References: <20260602151025.4145216-1-raphael.zimmer@tu-ilmenau.de>
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

On Tue, 2026-06-02 at 17:10 +0200, Raphael Zimmer wrote:
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
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>

What's about Fixes here?

> ---
> =C2=A0net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
> =C2=A01 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 66c0d6d6b33d..b33ae17546f8 100644
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
> +		m =3D ceph_msg_new(type, front_len, GFP_NOFS, false);

Does false is correct here? If we provide can_fail =3D=3D false, then
allocation failure results it:

	if (!can_fail) {
		pr_err("msg_new can't create type %d front %d\n",
type,
		       front_len);
		WARN_ON(1);
	} else {
		dout("msg_new can't create type %d front %d\n", type,
		     front_len);
	}
	return NULL;

The can_fail =3D true would suppress the WARN, matching the intent of a
graceful degradation path.

Thanks,
Slava.

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
