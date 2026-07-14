Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774832D7F1
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051182; cv=none; b=bRvbAyOB6qXILmF2wiN3TUKvWevrq1PmKiHNWi6kcrS7QM5yG5Sr+Dnzd88jdM/0WiJCRn/UpNTwQfbpdKpHWRw9EXvcJeEtZahKA7RPpWZCqjTV/N4rIrwTKyf004NlcHaT8tJ3boFN+BUPr1sYoQkwyn8Ae8FvLFUGOsaYeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051182; c=relaxed/simple;
	bh=pqgiUQ8Aree+HXnmxytV76FdOcu+NjbYsQ5Sqga17zg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QL3Y591TRLIIe03lzFgde5K37CUjk141fa6IwK2zcrGI0ozYKLYjFRRjcK82niNwfwIUVdFbNF9jcImGPtE69Z2kpdwaojlSSfc25K41/IEZkk3BSFgodKYGGEAcuRox9KuidH8wN57Xh6WcVvOT8IG9kvMqu9DRuD8hCSermUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=K0qYntzP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="K0qYntzP"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ead20e4a0so13775207b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784051170; x=1784655970; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=auOM2in7FUxpk9Gq8+vuwppWS4BPHDL3/0AxxfS0YzI=;
        b=K0qYntzPk070f9+WIroen4HdH+CNsSKhETQfRKGycewc15jRk5jAlVcvl+iU7yQmOD
         TN9hye4HymUV23i6gI4/pJfIoQan4DUaBZTykI0hFGrAk4ML9AU3Fhhyr2GUp7sknTef
         /jRh8WLoMHRtulPDAVObKtchuE9X9ckWJ1AHZiynjR3sk2BB82AFdNxEGDqeq3CJ4YL9
         oPpyf52eGcay4b1C9IPdPhMGi6ucqvwwDW3RYMblQUrDEm2B4GE/D+pwvbAsI/CorvbG
         ZNnjEHut/nw5KZRrZwiIt+dghNMPFaIUqfamB/TuZ89HBV9SAG8emQ1ol990ECPBxJn8
         uDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784051170; x=1784655970;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=auOM2in7FUxpk9Gq8+vuwppWS4BPHDL3/0AxxfS0YzI=;
        b=RStI0PUwnvwvlx9ZUlkaa29S3QUQqzFT/JrXsZCW2zSZoJkzpEThFSbBKxQtOPgJ2L
         QEe7ybwhmnB33kLi91zDHU06jZoBASZ0BpdczqbboMDBjrUPCKl9Tn1dXIhcrPBmS9bc
         TiM4KSA536Hos/AAyxIdvsuooiiBnJHt824eCcqBAAawLklf0VkJ3kUtnWCKU5CyqhqP
         SzPY/TFI+BXzGdZ056/rbzLp//yAhhvauJnubTxmzLIjcR3zaisoBcMBO6xIOvxCKMKa
         qih83MbZuOGWJRc2zZjlwQ6ktS9bVYzct7AvuhUjhBB5C6CZPi/0x8e/jMYSG5MuAZHP
         /vFA==
X-Gm-Message-State: AOJu0Ywe1BmP8dLHO1hsGUl0lFHQFjMOPHIf/1cbOzFp+B24FKCjFwjO
	cKF0ycHYtLiupH5hNrh/Q2ncaiSaV80lzwomICbhLGpoQUOM4bv1tr38hci9WMfYSug=
X-Gm-Gg: AfdE7cmM+KfXFAzZ3CI9y48Q1bueKuxjlAxxbqm1VL680/4JMC3JD+nbuJe3g/L2GQH
	JnHduDyupGRvOi/xdYWmMOyTYjlHq/oHc4X2wTh50W6cqTEk6lI1MGe2+yWbBlOi9w8lhctYQE6
	C/Oj6dBwDhBIwTXpjdxiKskGjfMtg9dEkkmSt3wok2tre1rEgVKAxoV9sUNPXalY+dQOeWsPoMe
	hNk+oHC3oDxnjYDw9VjSAkJbYrsjcxCo/xh71OkbIBO1CrTLPkN6lLp6kKnYJd/qHqGDer4FdzZ
	NrkHEtcvdcirhzBfrehuzXv8Tl4148zonRCyVPH8GDPPseO5qNB+FKc7cidexRiA/pWaeCt/Hri
	g9ZhcO/eSuTBPGRvE/4rCxkS3WdiUka7Nkezfp0Eb7Zd24ihx5yOYiWYmwXQkYoH2npYp9L1zlN
	arRUrqCQP6abynTQo1qX4c/ixLGoSyZ9s2P9EX7DSGmUVsbZO4ubteJritlFm73Y5kd5K7VxK7+
	Rz6MnrCEt1iZDcrJdCLSOfk8CNGoh4+hJbvDxQxqtogHCo1VbuedDRHbX4GEwPu8qou8uMNF/qp
	gWPQbQ==
X-Received: by 2002:a05:690c:6706:b0:81d:489e:8847 with SMTP id 00721157ae682-81e8ffe88b7mr103966577b3.2.1784051169576;
        Tue, 14 Jul 2026 10:46:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b87:2209:14fb:1802? ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a44e1sm149844887b3.29.2026.07.14.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:46:09 -0700 (PDT)
Message-ID: <581f04a3a5002e496a76888edddf69a30512aeff.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix use-after-dereference of NULL ci in
 __ceph_remove_cap()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 10:46:07 -0700
In-Reply-To: <20260714-ceph-fix-remove-cap-v1-1-27b5bc6ee2f6@clyso.com>
References: <20260714-ceph-fix-remove-cap-v1-1-27b5bc6ee2f6@clyso.com>
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

On Tue, 2026-07-14 at 14:20 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> The NULL check for "ci" in __ceph_remove_cap() was dead code because
> ci was dereferenced via &ci->netfs.inode before the check, and
> cap->session was dereferenced via session->s_mdsc->fsc->client even
> earlier.=C2=A0 On a double-remove, both cap->ci and cap->session are set
> to NULL by the first call, so the second call would crash before
> ever reaching the guard.
>=20
> Move ci, session, cl, and inode initializations after the NULL check
> so that the early-return actually works.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/caps.c | 17 ++++++++++-------
> =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index f8d898ad091e..8568edf494b5 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1154,18 +1154,21 @@ int ceph_is_any_caps(struct inode *inode)
> =C2=A0 */
> =C2=A0void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
> =C2=A0{
> -	struct ceph_mds_session *session =3D cap->session;
> -	struct ceph_client *cl =3D session->s_mdsc->fsc->client;
> -	struct ceph_inode_info *ci =3D cap->ci;
> -	struct inode *inode =3D &ci->netfs.inode;
> +	struct ceph_mds_session *session;
> +	struct ceph_client *cl;
> +	struct ceph_inode_info *ci;
> +	struct inode *inode;
> =C2=A0	struct ceph_mds_client *mdsc;
> =C2=A0	int removed =3D 0;
> =C2=A0
> =C2=A0	/* 'ci' being NULL means the remove have already occurred */
> -	if (!ci) {
> -		doutc(cl, "inode is NULL\n");
> +	ci =3D cap->ci;
> +	if (!ci)
> =C2=A0		return;
> -	}
> +
> +	session =3D cap->session;
> +	cl =3D session->s_mdsc->fsc->client;
> +	inode =3D &ci->netfs.inode;
> =C2=A0
> =C2=A0	lockdep_assert_held(&ci->i_ceph_lock);
> =C2=A0
>=20
> ---
> base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
> change-id: 20260714-ceph-fix-remove-cap-cf7d8a7a242a
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

