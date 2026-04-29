Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83044175A81
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491071; cv=none; b=QGp4aTGZO/LJRw/wIprVq+ogAdLiirRsdcbJAz6vSG14+OWaGS1D2cB1oorn7V1SVRxLB/OzwMuvPgMIEynqLgk2t3n+yKafbo4rOWi5v/N6RU58wjirnFaLhjeP1N27aYu/UBTE2sl5YHjeIG3Cg0f0VSGkg1a8ybjf0/cpgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491071; c=relaxed/simple;
	bh=kXYGMvt1rhykfXQpnEH1UzW5gDV3m1ghchtdMwu8nIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMsiOmPLftnPABgipcpJy6ylW4hAz9/XroDP/6HoVDtx8+Mf8uLP30lCZADyyprF8jqCbTLWjGc0VrcdokZWpHztcGoDRDUhHlr3w3uQ2Vi4cy4wrwzezYeuu2df7+gAoD2JpR/AJXJ91lkOCXuzlZunnjf9YbHJY6PKOKfTDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drPRMox0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fsl22IV6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drPRMox0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fsl22IV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777491068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAorgokiyXcdKZvLEWEV9aRso9IqXESGmbQbGoVLsbc=;
	b=drPRMox02nX2o7lLYITJY352nN6zHMlPCzgzqupSS7jFLTx2FheGXF01RuYLrUTMKToxgY
	oVnmOwVBpvxu0uRAVSrch8LsBVU4WIAfrTpHV/Wc5PRqEF3A/8ZL7Idfj2DP9Ke6E3DvCO
	bckuMvtltDzhy2xRc6krH+eFxsrkYok=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-eh_eWgBlNciapNhT3SgUqw-1; Wed, 29 Apr 2026 15:31:07 -0400
X-MC-Unique: eh_eWgBlNciapNhT3SgUqw-1
X-Mimecast-MFC-AGG-ID: eh_eWgBlNciapNhT3SgUqw_1777491067
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd49a24683so3735297b3.3
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777491066; x=1778095866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pAorgokiyXcdKZvLEWEV9aRso9IqXESGmbQbGoVLsbc=;
        b=Fsl22IV63NPNy3BOecdKeVRewq95EJyK0XWBojginTFamXw9aYaV4AiMutg+ItCIxW
         qQRaPWmAOgSp8/yo/hsHIBS+MD7ubcY/ssFWdUyKzZIzrvIQlXekf6io7Glen1JqdkPY
         ezC62gvlMMPq3lnb25HALNJthEGqaMkRZC9JN+4EWk2BELbAaHIMftOg55/koNS2XJJJ
         o6R7h3MPwlv/UyWtrDguOwqupraWnlJmykvC/H0jOzLixRdaZuqWBfrozTmSBZRpD9In
         yeBX3nmhMB4w6qI3LZeQCXkfHUnB3Er6OKmEVs20GV7yvy4fgRXrljeIjWeOMNfgawkx
         OxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777491066; x=1778095866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAorgokiyXcdKZvLEWEV9aRso9IqXESGmbQbGoVLsbc=;
        b=oViQVgd9oZrsowAXjrk1b5V+SgA+0KuV8t9lFppld6pf5h0bgs5128rRctp0ApbnyJ
         Um/FGM87Aacb5kNFmtnXBCXvQlZwdMjxJjqsFTiXoWVTE3NlodBQkDTtmTfyOkyEDqdj
         eb/o80HdB8cflLi5nR3Cv05zfX59lJ4hDg1OMZXfNAgPEOhQYtyPWWKatwxb37+0fsmx
         lTwGwM/aYdTyx+ooe6GrNXFswtmXsup8SPzNXHQ94KjhxOmVNQBzP5qiXsNiVgEns/ed
         JHpu75PS2IHG1aqxYrbv7yxhiuxeJlm1ZQR5EfcR4CsO3vX2N3aw1s0J9oOapQj5q/eD
         Epyw==
X-Forwarded-Encrypted: i=1; AFNElJ8L+oYO9p+LUDmKyGu1aqttjRZSvxrL+BWqf9Vi88s4SFzfcywmO00EIrTXwKlZHQUfVevQC6ZWjhEH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5BiknDGwhx9cyYMIUmC8t4qGppqNC7LKO/fEB+owoMMXcbwF
	D+mTlxVeSh5BlXk2ryuLx4dUsE7UdGywKZJX3dtoo3Yr4RdfJQJwjo4xfHCvCrXySKh/tXevXhq
	ApOSnswD1QbKEybuYd0Fy2TTTQCKKjbZbc2m0ajl5KM6qq4ram06zJjzZtJaX7oli8789qF0=
X-Gm-Gg: AeBDietbdH7z5RdE+5+EclrxLqcG+wAjP7Niz/YgwR/KAf4BWW2e2fGbIrW+LbFiLGT
	JgJTmIQHCFZEkGinJv5PxAhl88RvytOLJCbGs18NavZVekmnpNkprqkup1S0ZdlFhrJq3uE/kBf
	4myEEFB85PL3dB/QkoLVRLUaKOXkRKzLyAvQo12v7uXmWh9b7+vOP6i54OSsndUZzuCIsU9+ZGH
	Et7Y5hSLD0pKVNLEA1c0l9nvnV926awZbmkpNw4V45p+euQv+5NNIOaCRWXXGD0FaNXYY2hpjHi
	bhun49076gJs1pQjNkLfckk5T6/ix8f+XYlS7fFB4ejp0olEpGJyyUp6bRLIVZxc/cmyPGCg2cU
	hCK4okAI3onqcBszGJA5FmF5+7bfhSe/OjcwpDAufXsuPnb7JlS1AizvQxfsuAHE=
X-Received: by 2002:a05:690c:9a84:b0:7b3:c611:7ef5 with SMTP id 00721157ae682-7bd527fa466mr1566967b3.6.1777491065619;
        Wed, 29 Apr 2026 12:31:05 -0700 (PDT)
X-Received: by 2002:a05:690c:9a84:b0:7b3:c611:7ef5 with SMTP id 00721157ae682-7bd527fa466mr1566587b3.6.1777491065167;
        Wed, 29 Apr 2026 12:31:05 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258a54fbsm19181917b3.26.2026.04.29.12.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:31:04 -0700 (PDT)
Message-ID: <9bd559bf25d2e4f7faaab94eb756755f75bb4eff.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v3 01/11] ceph: convert inode flags to named
 bit positions and atomic bitops
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Wed, 29 Apr 2026 12:31:03 -0700
In-Reply-To: <20260429125206.1512203-2-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
	 <20260429125206.1512203-2-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-29 at 12:51 +0000, Alex Markuze wrote:
> Define named bit-position constants for all CEPH_I_* inode flags and
> derive the bitmask values from them.  This gives every flag a named
> _BIT constant usable with the test_bit/set_bit/clear_bit family.
> The intentionally unused bit position 1 is documented inline.
>=20
> Convert all flag modifications to use atomic bitops (set_bit,
> clear_bit, test_and_clear_bit).  The previous code mixed lockless
> atomic ops on some flags (ERROR_WRITE, ODIRECT) with non-atomic
> read-modify-write (|=3D / &=3D ~) on other flags sharing the same
> unsigned long.  A concurrent non-atomic RMW can clobber an
> adjacent lockless atomic update -- for example, a lockless
> clear_bit(ERROR_WRITE) could be silently resurrected by a
> concurrent ci->i_ceph_flags |=3D CEPH_I_FLUSH under the spinlock.
> Using atomic bitops for all modifications eliminates this class
> of race entirely.
>=20
> Flags whose only users are now the _BIT form (ERROR_WRITE,
> ASYNC_CHECK_CAPS) have their old mask defines removed to document
> that callers must use the _BIT constant with the set_bit/test_bit
> family.  ERROR_FILELOCK and SHUTDOWN retain their mask defines
> because they are still used via bitmask tests in lockless readers
> (ceph_inode_is_shutdown, reconnect_caps_cb).
>=20
> Flag reads under i_ceph_lock continue to use bitmask tests where
> the tested flag is only modified under the same lock; this is safe
> because the lock serialises both the read and the write.  The
> remaining flags continue to use non-atomic bitmask operations under
> i_ceph_lock, which is correct and unchanged.
>=20
> The lockless reader ceph_inode_is_shutdown() retains the READ_ONCE()
> snapshot plus bitmask test pattern -- the single atomic load into a
> local variable is correct and avoids a second memory access that
> test_bit() would require.  It now uses the named CEPH_I_SHUTDOWN
> mask constant instead of an inline BIT().
>=20
> The direct assignment in ceph_finish_async_create() is converted
> from i_ceph_flags =3D CEPH_I_ASYNC_CREATE to set_bit().  This
> inode is I_NEW at this point -- still invisible to other threads
> and guaranteed to have zero flags from alloc_inode -- so either
> form is safe, but set_bit() keeps the conversion uniform.
>=20
> The only remaining direct assignment (alloc_inode zeroing) operates
> on an inode that is not yet visible to other threads, so it is safe
> without atomic ops.
>=20
> The dead precomputed flags variable in ceph_pool_perm_check() is
> removed; the check: loop re-reads flags from i_ceph_flags after
> the set_bit() calls, keeping a single source of truth.
>=20
> Co-developed-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Signed-off-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/addr.c       | 17 ++++++------
>  fs/ceph/caps.c       | 24 ++++++++---------
>  fs/ceph/file.c       | 13 ++++-----
>  fs/ceph/inode.c      |  4 +--
>  fs/ceph/locks.c      | 22 ++++-----------
>  fs/ceph/mds_client.c |  3 ++-
>  fs/ceph/mds_client.h |  2 +-
>  fs/ceph/snap.c       |  2 +-
>  fs/ceph/super.h      | 64 +++++++++++++++++++++++---------------------
>  fs/ceph/xattr.c      |  2 +-
>  10 files changed, 72 insertions(+), 81 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..35c5fdb5a448 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -2583,20 +2583,19 @@ int ceph_pool_perm_check(struct inode *inode, int=
 need)

I have realized that we have issue here. We declare flags as int [1]:

	int ret, flags;

However, we assign ci->i_ceph_flags [2] that has unsigned long type [3]:

	spin_lock(&ci->i_ceph_lock);
	flags =3D ci->i_ceph_flags;
	pool =3D ci->i_layout.pool_id;
	spin_unlock(&ci->i_ceph_lock);

I think we need to rework the declaration of flags variable.

The rest of the patch looks good.

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v7.0.1/source/fs/ceph/addr.c#L2544
[2] https://elixir.bootlin.com/linux/v7.0.1/source/fs/ceph/addr.c#L2564
[3] https://elixir.bootlin.com/linux/v7.0.1/source/fs/ceph/super.h#L383

