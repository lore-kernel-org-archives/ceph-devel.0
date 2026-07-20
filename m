Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFB3B4EAC
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569093; cv=none; b=ESZA0wFJdhtpYZqAEX3UdZt7E2GZNcwPqz+7ZCPNXHYBWqj2Nq5jXa2Pd8d4yx/PZU5GTd9Kv5Y2vrqmUZbhAjV1AtPxzLhvxBkYoBhNodE/lgpmhGWW5VzdZr8SYPJjFL8yZjuilRHoOQYK8cRzGDrKg4uVz3cwpFqCa1ATOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569093; c=relaxed/simple;
	bh=CSEC6Pm3CSlP5tDpScoIlJAy/Baj5EKFSblk0Fhcpz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZc6JA7kUpVfi8xleRxv6L1ERlN67ULFU7XX1RAaPVqaJxH1gqyBTk1YlTx/CYR8p4KVQgE3DWGyqj9DBv4G5o02WmcR5qKMjoqENFAxmEHVe881FRXVtJzPZgQ0f9bGMNP24TKHSJCCsGH4pk5cGJedK1m/XyEE6WhlTjBdfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=GREwGdj9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="GREwGdj9"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80cebd41372so95787657b3.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784569091; x=1785173891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O0yGcVDb87rrM7h1K0dsNYhDE4499bGWbxYvohTMH2A=;
        b=GREwGdj96e9anosed44Cw+gPHam663GTrJ3FUabx3Q/4GlSvnABoCrFR3Z3vd04gCD
         Luk5A9XWKiqvv3DUVFSnndDp+THfcYqhK/5vF3y3EXSgl5kVSJIU/aQMQ99UHMLFCvHw
         igiVVJDNpSiYRxxZm4B4XSRw1oNOoKI3g+A0HycQDlZr2F5ZsrTvlvoeDDkm39R4Rh0t
         QJIHB+BsQRh12N1TxRMbaa6UswUKsIWF4BoElWj+uzBx67HOXnGRFCVOYj5brRHgR02z
         v4H60QHrLqsOQMrTZA4vX3FmP77dXUSNlZ8kO+GBd4WWMZa026l+EHz3bkLINZ9wur6q
         u12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569091; x=1785173891;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O0yGcVDb87rrM7h1K0dsNYhDE4499bGWbxYvohTMH2A=;
        b=PIesWO1JS4qZOiEtYfDhV2jt5RRTkQ/IRljYO09wl9tVBEG8XXyAn4X66uU0HXiltA
         sNFE6x11pgVzjxKR5c3cR39UiWOkXg3oIJH+W8iLuLe4SXQlM9fvPUOHhW1IDm5Is08F
         c6RwxJcJaYV1doFgP7q/8dgKlqnEh0sNfLcJVAiCIeFMYqne4C+388YPXgrgoSlta39t
         erfuDq5ADdmy0gkL+CUfQYbyF8A+T/LfKk8cqgRTiCoxj75pXzbpl7BN3oTS7TJUBhzx
         npW3T0YPfpaWRkdghTTGPoIN+mzz3Hj2XMg1JMxSSKVNZwFeeC6BKt/6FRlyafDT5aGt
         z7ZA==
X-Forwarded-Encrypted: i=1; AHgh+RqG/43C6KA4F5717+a8ZWCiW9stZASriNOZD0O5J9lTegcny76RtpbNxgJuXHqAZpps48HPMY6tqxHN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dqzhoBKSWXSiJctsVM+jBPt2DbUy0XaguFDcjGknLOycY+yI
	opfDdGpvLC0XjbI8uJL8mQDZ1PQtHGcGy6ftSf3GLpp7k8eByhPmKh7EMRGDg2aQIzA=
X-Gm-Gg: AR+sD10l/hD099l+laZuraorCWpx6MZiUQnzs18HT2UfgQXTcwvEH6HvIuvkqCi8z2r
	K6fGDhQa22Z3KxLpn3mt8uMBrdDpX7mlrM+da+/98MOTcQ/OjUdyzo+GJb+TTHYmYhwavfYCGI1
	B93YNNaEsk02KnhzLaLls1kIDgQTm8ZMPFNtQv4J68atRO8J2WSLuzEqisw4rtKj85JmP+Z/H/l
	6U1eW68lmJ4eglpTbBhOmGQSJsxOQrf16xs5iqCC93/zLtNJBuGeaZ1aTvKR7G6FOoaF4VndViz
	mkAYDXsPJu9SDwUWoDmfr4ZdFordGxWUoOo3l8Fy9a4uB1eCPIso1ss+L4uK+MwneNO408oylIW
	kB3EJis09533mQWSNl9bHHTpRzoOc82y4/BddpinuhCUTB8TXvTjmHQCHeOGNRWzlfeDY4tb4PZ
	NrDYPcqgfrXfOviZL21jZofR5mthGCN0Ro/ZiBQokswUvc0ig2SzVH26wxdq2uKVm1TdWMFr9zT
	GVHlKLtfNLVadkqY1by52D4yHGgQxA/kv57Valm8HDoqhFS+LY0YOOfVB70vtVhyO3Y
X-Received: by 2002:a05:690c:6b07:b0:81e:97c9:bd03 with SMTP id 00721157ae682-81ef2663192mr46240417b3.60.1784569090971;
        Mon, 20 Jul 2026 10:38:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8546:6986:b83:77a3? ([2600:1700:6476:1430:8546:6986:b83:77a3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42f0c31sm53503357b3.48.2026.07.20.10.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:38:10 -0700 (PDT)
Message-ID: <e9ce96c3edf6b91bbb316e1107e81eb8aa13c99d.camel@dubeyko.com>
Subject: Re: [PATCH v2] ceph: revalidate ki_pos for O_APPEND writes after
 cap acquisition
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 10:38:07 -0700
In-Reply-To: <20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso.com>
References: <20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso.com>
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

On Sat, 2026-07-18 at 10:29 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> For O_APPEND writes, ki_pos is set to the current EOF via
> generic_write_checks() after fetching i_size from the MDS.=C2=A0 However,
> ceph_get_caps() may need to wait for Fwx exclusive caps if the write
> extends the file (endoff > i_max_size).=C2=A0 While waiting for Fwx, the
> previous Fwx holder (another client) may have already extended the
> file.=C2=A0 When the MDS grants us Fwx, the cap grant message updates the
> local i_size, but ki_pos remains at the old EOF, causing the append
> write to land at a stale offset and overwrite data from the other
> client.
>=20
> Fix by re-reading i_size_read(inode) after ceph_get_caps() returns.
> At this point we hold Fwx exclusive caps, no other client can modify
> the file, and i_size reflects the true EOF from the MDS cap grant.
> No extra MDS round-trip is needed.=C2=A0 Only adjust ki_pos when the EOF
> has actually changed.
>=20
> After adjusting ki_pos forward, the write range [pos, pos+count) may
> now exceed the i_max_size that was validated by ceph_get_caps() for
> the old range.=C2=A0 Re-check against i_max_size and truncate the write
> if necessary to stay within the MDS-granted limit.
>=20
> Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel
> if O_APPEND is specified")
> Link: https://tracker.ceph.com/issues/7333
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> Changes in v2:
> - Re-check write range against i_max_size after adjusting ki_pos
> forward, and truncate if it exceeds the MDS-granted limit.(Viacheslav
> Dubeyko)
> - Link to v1:
> https://patch.msgid.link/20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso=
.com
> ---
> =C2=A0fs/ceph/file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 42 insertions(+)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 9d89d7fc1095..a2b4d261e23c 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2491,6 +2491,48 @@ static ssize_t ceph_write_iter(struct kiocb
> *iocb, struct iov_iter *from)
> =C2=A0	if (err < 0)
> =C2=A0		goto out;
> =C2=A0
> +	/*
> +	 * For O_APPEND writes we may have waited for Fwx exclusive
> caps
> +	 * while the previous Fwx holder (another client) extended
> the
> +	 * file.=C2=A0 i_size has been updated via the cap grant message
> from
> +	 * the MDS, but ki_pos is still the old EOF.=C2=A0 Re-read i_size
> here
> +	 * (no extra MDS round-trip needed) and adjust ki_pos to the
> true
> +	 * EOF.=C2=A0 Since we hold Fwx, no other client can change the
> file.
> +	 */
> +	if (iocb->ki_flags & IOCB_APPEND) {
> +		loff_t cur_eof =3D i_size_read(inode);
> +
> +		if (cur_eof !=3D pos) {
> +			doutc(cl,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%p %llx.%llx O_APPEND: pos adjusted
> %lld -> %lld\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode, ceph_vinop(inode), pos,
> cur_eof);
> +			iocb->ki_pos =3D cur_eof;
> +			pos =3D cur_eof;
> +			if (pos >=3D limit) {
> +				err =3D -EFBIG;
> +				goto out_caps;
> +			}
> +			iov_iter_truncate(from, limit - pos);
> +			count =3D iov_iter_count(from);
> +
> +			/*
> +			 * ceph_get_caps() validated the old endoff
> +			 * against i_max_size; adjusting ki_pos
> forward
> +			 * may have shifted the write range beyond
> the
> +			 * granted max_size.=C2=A0 Re-check and truncate
> if
> +			 * necessary.
> +			 */
> +			if (pos + count > (loff_t)ci->i_max_size) {

If I am not wrong, every access of i_max_size is done under ci-
>i_ceph_lock. Should we use this lock here?

Thanks,
Slava.

> +				if (pos >=3D (loff_t)ci->i_max_size) {
> +					err =3D -EFBIG;
> +					goto out_caps;
> +				}
> +				iov_iter_truncate(from, ci-
> >i_max_size - pos);
> +				count =3D iov_iter_count(from);
> +			}
> +		}
> +	}
> +
> =C2=A0	err =3D file_update_time(file);
> =C2=A0	if (err)
> =C2=A0		goto out_caps;
>=20
> ---
> base-commit: df47791ab9f12cd9144aca477ddae195f68072a5
> change-id: 20260717-ceph-append-fix-9820e3b1a78c
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>
>=20
