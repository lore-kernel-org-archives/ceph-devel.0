Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0283CF96B
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053300; cv=none; b=F6ECgvi/wfFkfHENPtp/p27KdH9Hd0jL/5f/leFosra3D8Bgn/H4xLS8dw9CET6dTqA7Ls++kAp3tv/gNZGItBVHZ3exg9Bs/jzNC5dUmqUVMATnYJjBHTeg6cUSVvUHWQC5SzhAAm40ZyfFTosp6zkk6uRXurTTpiRndKaDkdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053300; c=relaxed/simple;
	bh=Ju18sMtQhBz3bKYi8jjqOv58ZPPj/Q+O5CEmEgFKF8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5WvmAT/6RdzDjl0Z+2f2hOEG3E0aGHLfrJmmokqIqOL/3yGcSQcuyDYG9uWPyVDplArFHUx1mka+LszR2DWerMz1pU23dcoX+a/aYWSIioDx0gmdbvW5LPCzrxh8ADm0fxZs3bujP/Wt9gvihQJ3o1ReaKCssaH7gM2dEzTJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=IlGJ5SYY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="IlGJ5SYY"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80e2cfe6918so11439547b3.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784053296; x=1784658096; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIpyRCJEO+murZwZ2HHOq1/GHssodeM+RHwwFHxBPt0=;
        b=IlGJ5SYYdrfGlb7P0Ulm7xdMYJoBSXG4Z8mRUAtingcbLilT8XYclyOSGjCkcHxEOm
         uYajyBoQXMzcUfU7+lLinqvpeZOJjIc5scYJYqyTfH00JLIY4maV1O7GYDqNzl7Tdaus
         b9oUlYtxGyncAvqlp9NKAafgOXvdwDTttcsoO8mR7lSHqA0OAVVUsUjJzM3SEaxSpH2P
         rv3LwHy5MVxSQW+0sypqV/y9Aq6hO7JXAMJBBo59Je/R6aMXkOtljWgL5DxMh+/nC5Vo
         eqpHh0hMbI1XbPMMfxUFYY+mDpmu4nXccFxNJHI5mlb7y70quZ1wcHibvFhMK3K4PYnh
         A/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053296; x=1784658096;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aIpyRCJEO+murZwZ2HHOq1/GHssodeM+RHwwFHxBPt0=;
        b=FMUBjKMWjAIIpD2PGqboZ9M9kJmLEPl0TFs5xLebNMhIoMOGMckaHK85gRhI04j1aY
         r4Pxwt1M2cZqPJU2VET4rdCKDteGa+tncpulEPisfnFcrh05KITLyz6OzbfAfpSLGJk9
         XdW/xMv2NRb4Rbw1t8jjFw3rnztfQUQj2jIUkLjqN8yTAjCwY5EejzrutPP2aCcKJjqT
         cdRSwn6B+NUWchp/U+ySc7IQBzfxCgt4iXPdSzeagwGin8VWKemYZ2CRI6151AGKNqeS
         vJAauQYTrWEJCSrX3Dk/w7E87Z1XpZDURO8HYd+l6LN2BSEBbYA5X6tCkygRrCeI27xK
         X/EA==
X-Gm-Message-State: AOJu0YwoB8IB9NCA0eLkQL2phmEoUhhAvZqYZrEjXUOMIHUJg1KyHtiC
	uB5HWQ3BiuieboXLoZyrgmXJNNB/NimKgEBf+0EKcJUnsqRchcH3686EioTwrsONeB4=
X-Gm-Gg: AfdE7clEDPEUOU+vspTj/XV88Ww69qyQmyJfgYdSSB6hVsis5QjsunYJNA+piaLVTTd
	FZxrf3PnTQvtSgNLJCgvbdR84ArqUKYzsWtaVQ2G5himm8kohKsRJnVf1xJ6bvLEEwV4t+iWZ4R
	eBJvgMqWSphtH3VEfylBcdrDXMftLmuMHdpqwHcNnTQ3+CWhA74CFC3pAVnglVCQrXWmsRo3x+6
	05iHopYTU3CKn1G49/nx5/tk/SxJa7WkKRqlUhAX49p+TVE9QwyGlFq67pJRdCpEfZNK+v4l7D+
	NZBrRHWiYhimlUFuJuPs+sjFwh5mqIH5pC2q0Dy6T8dxF4xtWCnJmxTn7963JatJROP57oYnUMf
	pz0sLNtm5WVNtxxHb+F7jn2S37ub3wwhgsfF/Eqhi6CdPpM5dgdQlioxnQplaLoQ4zd2L91bQls
	jrbtV3NJGQV94SoQ1aaBIZHxyT2M6Es/qD2KKfXa9GgX1esHAlIJwWBzDPFPnPuowPPwgiOxaSM
	6Ks3n1aqTZFFiylDRLGS5tap6d/1oOmk5JI0wonYAxGQQ==
X-Received: by 2002:a05:690c:6985:b0:814:5312:47bb with SMTP id 00721157ae682-81e902edf4cmr109419627b3.69.1784053295745;
        Tue, 14 Jul 2026 11:21:35 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bf7ab9bsm148299457b3.20.2026.07.14.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:21:35 -0700 (PDT)
Message-ID: <1cc1c984a02aa892a7edb67d82adde547778bda3.camel@dubeyko.com>
Subject: Re: [PATCH 1/5] ceph: convert oldest_tid to atomic64_t
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 11:21:33 -0700
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com>
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

On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> The oldest_client_tid sent in the MDS request header is advisory:
> a stale value is harmless -- at worst the MDS may resend a reply
> we already have, or skip one we still need (which will just be
> retried).=C2=A0 With the plain u64 read, however, the compiler is free
> to split or cache the load, which is undefined behaviour when the
> write side runs under mdsc->mutex on a different CPU.
>=20
> Convert mdsc->oldest_tid from u64 to atomic64_t so that reads
> are guaranteed to be single-copy atomic on all architectures.
> This removes the one remaining reason __prepare_send_request()
> and __send_request() needed to be called under mdsc->mutex, so
> drop those comments as well.
>=20
> All write sites (__register_request, __unregister_request) still
> run under mdsc->mutex, so use atomic64_set() for clarity.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 21 ++++++++-------------
> =C2=A0fs/ceph/mds_client.h |=C2=A0 2 +-
> =C2=A02 files changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 9f84ef2ac6e4..98d0a5baff70 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1235,8 +1235,9 @@ static void __register_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	if (!req->r_mnt_idmap)
> =C2=A0		req->r_mnt_idmap =3D &nop_mnt_idmap;
> =C2=A0
> -	if (mdsc->oldest_tid =3D=3D 0 && req->r_op !=3D
> CEPH_MDS_OP_SETFILELOCK)
> -		mdsc->oldest_tid =3D req->r_tid;
> +	if (atomic64_read(&mdsc->oldest_tid) =3D=3D 0 &&
> +	=C2=A0=C2=A0=C2=A0 req->r_op !=3D CEPH_MDS_OP_SETFILELOCK)
> +		atomic64_set(&mdsc->oldest_tid, req->r_tid);
> =C2=A0
> =C2=A0	if (dir) {
> =C2=A0		struct ceph_inode_info *ci =3D ceph_inode(dir);
> @@ -1257,14 +1258,14 @@ static void __unregister_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	/* Never leave an unregistered request on an unsafe list! */
> =C2=A0	list_del_init(&req->r_unsafe_item);
> =C2=A0
> -	if (req->r_tid =3D=3D mdsc->oldest_tid) {
> +	if (req->r_tid =3D=3D atomic64_read(&mdsc->oldest_tid)) {
> =C2=A0		struct rb_node *p =3D rb_next(&req->r_node);
> -		mdsc->oldest_tid =3D 0;
> +		atomic64_set(&mdsc->oldest_tid, 0);
> =C2=A0		while (p) {
> =C2=A0			struct ceph_mds_request *next_req =3D
> =C2=A0				rb_entry(p, struct ceph_mds_request,
> r_node);
> =C2=A0			if (next_req->r_op !=3D
> CEPH_MDS_OP_SETFILELOCK) {
> -				mdsc->oldest_tid =3D next_req->r_tid;
> +				atomic64_set(&mdsc->oldest_tid,
> next_req->r_tid);
> =C2=A0				break;
> =C2=A0			}
> =C2=A0			p =3D rb_next(p);
> @@ -1693,7 +1694,7 @@ create_session_full_msg(struct ceph_mds_client
> *mdsc, int op, u64 seq)
> =C2=A0	ceph_encode_32(&p, 0);
> =C2=A0
> =C2=A0	/* version =3D=3D 7, oldest_client_tid */
> -	ceph_encode_64(&p, mdsc->oldest_tid);
> +	ceph_encode_64(&p, atomic64_read(&mdsc->oldest_tid));
> =C2=A0
> =C2=A0	msg->front.iov_len =3D p - msg->front.iov_base;
> =C2=A0	msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
> @@ -2759,7 +2760,7 @@ static struct ceph_mds_request
> *__get_oldest_req(struct ceph_mds_client *mdsc)
> =C2=A0
> =C2=A0static inline=C2=A0 u64 __get_oldest_tid(struct ceph_mds_client *md=
sc)
> =C2=A0{
> -	return mdsc->oldest_tid;
> +	return atomic64_read(&mdsc->oldest_tid);
> =C2=A0}
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> @@ -3438,9 +3439,6 @@ static void complete_request(struct
> ceph_mds_client *mdsc,
> =C2=A0	complete_all(&req->r_completion);
> =C2=A0}
> =C2=A0
> -/*
> - * called under mdsc->mutex
> - */
> =C2=A0static int __prepare_send_request(struct ceph_mds_session *session,
> =C2=A0				=C2=A0 struct ceph_mds_request *req,
> =C2=A0				=C2=A0 bool drop_cap_releases)
> @@ -3555,9 +3553,6 @@ static int __prepare_send_request(struct
> ceph_mds_session *session,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/*
> - * called under mdsc->mutex
> - */
> =C2=A0static int __send_request(struct ceph_mds_session *session,
> =C2=A0			=C2=A0 struct ceph_mds_request *req,
> =C2=A0			=C2=A0 bool drop_cap_releases)
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 731d6ad04956..3b614b5df18c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -532,7 +532,7 @@ struct ceph_mds_client {
> =C2=A0	spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 snap_empty_lock;=C2=A0 /* protect
> snap_empty */
> =C2=A0
> =C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_tid;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* most recent mds
> request */
> -	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oldest_tid;=C2=A0=C2=A0=C2=
=A0 /* oldest incomplete
> mds request,
> +	atomic64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 oldest_tid;=C2=A0=C2=A0=C2=A0 /* oldest incomplete
> mds request,
> =C2=A0						 excluding
> setfilelock requests */
> =C2=A0	struct rb_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
uest_tree;=C2=A0 /* pending mds
> requests */
> =C2=A0	struct delayed_work=C2=A0=C2=A0=C2=A0 delayed_work;=C2=A0 /* delay=
ed work */

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
