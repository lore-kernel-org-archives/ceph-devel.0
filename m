Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675575;
	b=xbtUBmnNs0k1JYT7HnMmbOdgCVz9+reAjPgnBBFvEBfDu0sKsswbC1HbDFDxSGRXuiel
	 YJn2S8H0Qgb0KAxvo2zVRIn1phoPDpBtXVYtBNlHxnWgZk2BuT3DQLkK2VvlCPXGO1MG9
	 Qj0JtCHojdnJge7zurk6ibcdt84zuZB8AUpJm/Qqa07BCPy1OEJ129yewgixN/KBtNg7f
	 mnn30E31RyoY7su6DWUwUC4ea7qzA6kddRT2+tmrrhkJpfmwhDcgutuAnq5LyFkWLk2O9
	 AI7m0a64cUa9UvSikVwvY57H1BQPWFPP9ROkPVSJuPe4EgFy9YLR+4VJ1ltAeZX6kVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iEdrgxs/YidBZzZOj+WIohy33aH+C5/pNi1p+tZ06Dk=;
	b=FdTslNJMQKyPveBHDQVueld0iymqWGoEh//iCH9ZSusRWTEvaRV+HhM/A0MsMFsghhAT
	 XYGf3Suu2b6g57Qds8nV/xXoPd/dVIh9KQKlksYIKlsrHUrpbZdUnAqn3yyW+lCdL4xwd
	 oOcf3qov3bbl1e0gAWW+il+5+Uk0TnQY8oQ7QVeZhcq3ZgTvQFM9defQzo5VJbZK/sfXX
	 f00SKumMXd1uLYHwrIjC/0Nzy2WcHSYMG3G1JWLCExiWXjlh6LcyTpr42tijukW+U6bkr
	 lSYjhunQb2NaeUdptR1YUBMRrmtyRQXDI54cj18ShZz70S8KpLfQrHTJlOqNDUE30/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b="MBOwL/Pe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0C606A321
	for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 06:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC0C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=MBOwL/Pe
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c516a574bffso137414366b.3
        for <ceph-devel@vger.kernel.org>; Wed, 25 Nov 2026 22:46:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795675568; cv=none;
        d=google.com; s=arc-20260327;
        b=mPz5uzMMWHM1KtsX2waLZYLNwIS47WapiPdC3hfh54LQgSIl9kkda/06bVXzeXEvVP
         7gujSqJuEG1LKr6IY1QBu+kHtbKVj1cFavRM+PwfNpBTL9ywH3ThLXyqjoc8ZL0DQqBZ
         DggaxMyIXUCRZa2NRvwoN8rriBUcU1avj8YX2Bu9uO4cuh4+MapdOyGtDR6SaycooFur
         xQ9L09nmqJ4mjDqSH05u6hkmm92OljdySOj/DKk57K+dC7SQ7m/Gb0lo3M2P2tGgqk6M
         iKrcdtvd+IXoQPiDyA14YGLuSIsbOnhfG6QPUUwbA7seK++lq80RVhGvv8f88JSGe1eT
         Ddgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iEdrgxs/YidBZzZOj+WIohy33aH+C5/pNi1p+tZ06Dk=;
        fh=PU5a9S05lBDNFlMn3iPMXQssMrhsNWnOsWF2DQJIn3M=;
        b=K9bkCIddFcK1O9jc9qfKDXnGVIRDdOIOFdjr3oBdwJaIxk1CUI2S4Kb6jsU0lYtvQq
         Pg0xDOhWwqIUzmTlMKYhLXC7OJMXNCeu19QFiaqXENL1tA4yPPOFvIzwsbJ0HYLALdp2
         igumve0X1j7HRloxUzldiWC0hfAcwaBoA0sG0Se0t+r+7RhYWthmi01xy8rEZp/nVARQ
         VmUVULUXgPy2Sd+AsjidMdKymv7GGlcUi63MYwIFVIxbLfi6siXjjz+7U5VqWrpjYX3e
         chP2hPzdw+aIJzDDYRbi4yqd+GtQeOQXLWZEYccblni7W8Q7bO5ryOzqAxgSMgEVs2af
         ZGsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795675568; x=1796280368; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEdrgxs/YidBZzZOj+WIohy33aH+C5/pNi1p+tZ06Dk=;
        b=MBOwL/PeCNHQ7FOu/L9RROUabJft0BnoDu395QAGcFsOvj4kjrYXJxGfwd8q20f2Gy
         B4GMY0d74+o9zd0SqXig8YVHtqG2hEqPwQeVKolPrzB1UF9omYWhowNS/Z3S98J05sGS
         weQw7NxLczGTe1kxPLNGBsPAmmohuXAmsPv6G4Cy8sZa6q6hICOeVGQL6writsH3EFOe
         4zERMOBZilDaQnmL0c0dD9QJBBbsr6EXOd0U1wc3MyxIMh1NYDxUADF0c0NmN/tdeMo+
         0mIZYfiYiGlT9VKxaukoeYHFJ0zUzoMeh4VTd2W/vNVa7ftsXMmz4AhSj6l+AxLpbXWh
         ZnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795675568; x=1796280368;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iEdrgxs/YidBZzZOj+WIohy33aH+C5/pNi1p+tZ06Dk=;
        b=VOJYuEJM0n3yNySHrauq8TTmYWjFvdgSqRr8ALrXHLA+cJlQak0HZVKNLuCbomAZc4
         /U0zEyOoyzNvtWEHxwjDxx/QfBkIqHKDKuK8B8VwWfqzpD7j5I+hG4CpZgDbRrWcXmVw
         ded65WIDakExZa66K/5lOZPt788uKsFTHo98xRxPjCUP0aJUhGVqJzIhcdyP1ybCpuoG
         xnnUHmGH8YaoQW9ZDQ07YVamIgGR34Mr57ZJjklM4bITZjGuP/5/qm3dCba2rjNugmEc
         oTCfpRMbWocTvjXwCcjQ2XlKE288641VsnWWXb6y6uNcE5DMlF4iBDKwpATBJCRKPWxa
         S7VQ==
X-Forwarded-Encrypted: i=1; AL+hErHnOmjG1qnE5y1Y70hP8GTeqD/TAuuqEutEWkAbYGGDiAp1B+mAceCB4vFWqq6fOij17oRXKN5vqoEs@vger.kernel.org
X-Gm-Message-State: APuU4Z+ckdGwFb2zUoHTS+nHpD3SftfXvcxnLQvAnxXt+ScClFe1xqux
	+90mT6oLY7DpL7VqeLQPR49F8sp7Fv8tvUHJUs/OkzacuOISR+ai1HHIn4za+GI+zlS/6w2p6jh
	N2Nhk3XbdrvEV3Mas0Zus7FflthigFj4kDo3aO96VSg==
X-Gm-Gg: AZFdTZcOhL1+5vRcnwOaLgAngqjlmswYD2E7YKUbTEJYRXOrPOpVWKOoUfV05IhK7U8
	9P8ig3ytOUBd+LheKq91apPvXhMWqvR7raAmt1ZKZtMYxoyPmWoG1s9qLiiTXs1zw8k6uGzhuHM
	nYSbV44IVuADZtUVfjxJJlox2JwWwwn3A/08/OjcgsSWRDjnfRIUrf8rk1Lcq/+3Uj5N+pwzBRz
	EF4rnGKR6yj5OBflvQULyCSdO8vvx2u6kAmgqJmM7vsuKLKJSFHO62kKNm9LGbxTQ5WrG6rTHYh
	zJhQYg+YPoGLWALo9R5OB9ont1AkSv6666GEyrvgge+aqEVQMWtkGsVx8xPtpWxDxpZ6R4aImii
	NM0r1e7K6JOrJOLoFtZSkAbHlE5eTNBBA+ErW0FbuHgEHIA==
X-Received: by 2002:a17:906:c1d3:b0:c2a:34fe:ea4d with SMTP id
 a640c23a62f3a-c513aafb433mr1233685566b.25.1795675567751; Wed, 25 Nov 2026
 22:46:07 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com> <20261122182549.1297448-1-amarkuze@redhat.com>
In-Reply-To: <20261122182549.1297448-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 26 Nov 2026 08:45:56 +0200
X-Gm-Features: Aa3M54qS842e194_v0RfNFp9kMvv1asDtn4xiKKG2lxOtvBrpkvTvksVsDe3Yko
Message-ID: <CAOJNxRKotmAGPhYjM8APGZq7Qzp=iSpoO_gM1qBnS1u9GEawDw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ceph: serialize O_APPEND writes across clients
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Anthony D'Atri" <anthony.datri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Good catch, thanks.  I reproduced it with two active MDSs, one of them
hiding CEPHFS_FEATURE_APPEND_EXCL: once the directory was exported to
it, the waiting append never got Fx and the writers hung.

In v2 the waiter rechecks the auth session on every wakeup: if the
auth cap is on an open session that does not have APPEND_EXCL,
try_get_cap_refs() fails with -EOPNOTSUPP and ceph_write_iter()
retries with the existing Fw-only path, and ceph_append_kick() stops
asking that MDS for a turn.  With that the writes go on after the
export, with the same behaviour as with an older MDS.

Thanks,
Xiubo

On Sun, 22 Nov 2026 at 19:25, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> The feature check happens once before ceph_get_append_caps(). If an
> append starts waiting on an MDS that supports APPEND_EXCL and the auth
> cap migrates to an MDS without that feature, ceph_append_kick() keeps
> asking for Fx. With another writer active, the older MDS can stay in MIX
> and grant Fw without Fx, so the append keeps waiting while holding
> i_rwsem.
>
> Could the waiter recheck the current auth session's features and fall
> back to the existing Fw-only path once an open session is known not to
> support APPEND_EXCL? That would preserve the existing older-MDS behavior
> instead of leaving the write waiting after migration.
>
> Thanks,
> Alex
>
