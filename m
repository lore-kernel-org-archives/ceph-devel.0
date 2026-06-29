Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F282426D1E
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749527; cv=none; b=YGm1WAS1ZVlSAd9mBGDuDTq3hpqsGH+F6t8sKyEWKSPzYTO20H9+7bFXV2WhcdnDSkKSr04rrQWjKtwsA0TiiIRpYX6SVVoxl6cJZDGtqaTAfRO5TyHazI2O7k34WTDOQ+pBXpXhm/QcIUtui1aE2B8y262fybO5FpeCsTzPvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749527; c=relaxed/simple;
	bh=rA3HPknBKonb2xiP0zBDChSBqI1xuKdsI08Lj5Ywo28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=re02u53kNBz2MX2OqYXAAgWX8oOUBE2Hp5P+CXwvmlviY6W7Gs52i3GTiT0/OGcCQSeD2EfmscfCbzIPERWz1g4lO/AwV3w7vE9+gXsH9n1tByKlJ0UAelA9w/i3JEfW/oA9zBTqwwunh6lKwrSFEr7BzuadfucZSDjh6YAHrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=uSFCiPzk; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="uSFCiPzk"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80ac88a3948so11832667b3.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782749525; x=1783354325; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rA3HPknBKonb2xiP0zBDChSBqI1xuKdsI08Lj5Ywo28=;
        b=uSFCiPzkF8m8jk9BA9oPZk3aIb7nhkBc4UzeOxOoeDoBT07yhAYExcUKMeHUJM7v/t
         fyRpdhz0C2THv/LFU3CKP/YK2wwoDnRV1LkqNukmcca5XtX6caO/JKSpBWfmc/+ACqOd
         p9oXx6nm/VKFxYFz36XzaYYPhTAntdGCdnkn7T13n/vA+jtAAReOFwVpdGxtlP6GrFm+
         a1qFcIANx2/er7+v0MqbnV5EwnPuKgPwkCps8qO9ZBefbuVZJKG2CpyvFJ9pxK5I52Fh
         gWmairswXfw0n0aCYVh0IY/VHRciTw4+JlMaRnyydOPTgQejzbHZCnfuB19Bie0JL9Jh
         MccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749525; x=1783354325;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA3HPknBKonb2xiP0zBDChSBqI1xuKdsI08Lj5Ywo28=;
        b=r9PlR2sNYSAIzgH1Ldd3R6CJ1yu5483FfMLrQcinqUqbhhMhw5sgDi7/dMvLlP+jgo
         8Veb9MSFc+zMsGV1mhyNBXr4SrNt+GllOQewxbdzLzNRPjZXyZ2Nf/ZGI+gnCDXcExDY
         hsCIKHplii+eoYzkMQhoPtzkrOryqRK49Fbk7OptcVPh2wC9S2DjQEbGzm/ZPFkbikE8
         mhcobzHkm6CEWknOQFVHn5hLcdRp+Dz4nIT/1K1EZ65+2WXH6Ps8riPk5R4yKx0EgS7v
         xAEIK65RF0PddgSmKZfNJJpJNyxpV8B14gdmp4U5RmJA+Qxs3HE+02VkjlLCQMYrUK0r
         VfDw==
X-Gm-Message-State: AOJu0YzmWPHTZlBSuMU/tHZT9w8JXlgbyUncDGHsnQiKoa63rwu+Fw7+
	ZoGO7RAD6Glpy14hkK1uJfzUG8l3LQNeMcj02Dt+Ugm7WUuwYVaprjhWsYD+I/kHEl1yIscKsny
	vKaoUZvw=
X-Gm-Gg: AfdE7clJIwbLx+3rIw6M2RNgQgUyivqdH99fMPabITlv/TcGChgaJXK15AnhEe/hng+
	uoSiBvva6+ZuRfTaJ8K7Svq56J9ecuF5gtZNiKsKJ8vqTByOxhgC8Jjla1x3reLd8pPxGSYGKnH
	9ZtzmKloXsgPXxS/1d10xnmxRt8j7vAbS4/8ktEMoHTzTsZpV1WH4T6FbzN/JnTUdNvDPolqchF
	q2HugcJ7mpwaxIkfHV8ydgwMl6XiaO0Hz3N0RSVvxXL1MqjJxHq8psEC8foACIf31ee2CE0MbaV
	qseNKvOXij1TKypEXBbnCwLNU3fikK8hLMAgZ7CXqNEEk7p3iOk3ZxLvQxOsNHw+6hKo/VnqHGf
	yvrcjmyMPfjkJvt2mBkmyBRL+xXzpWYrkJGuV2IanX5FfBZS5XsI0+cpVY6+/BrtXr3Qy8ELt9n
	loXdDpl942d2aXXSG8Vbso6BCih/qYixiCz9DdPrwSEKP1ux2AnJXoBhDvxz+b1GMKiIf7DjBGr
	Ozgg/nRUQzLJF8GA4btS/dqswZATYvR+rfccfmmVpzRk/iF8NDYgL3WkLLpbn47sAxXsu+Bnndz
	O81XYthi8blKcvYyZQ==
X-Received: by 2002:a05:690c:64c6:b0:80c:629f:d63b with SMTP id 00721157ae682-810d7bac608mr2351277b3.8.1782749525133;
        Mon, 29 Jun 2026 09:12:05 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80f236425b5sm14530137b3.15.2026.06.29.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:12:04 -0700 (PDT)
Message-ID: <8ba14425aa4e70de2aba657116a84040811be452.camel@dubeyko.com>
Subject: Re: [bug report] libceph: (linger) requests not removed from
 need_resend/need_resend_linger in error case
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:12:03 -0700
In-Reply-To: <34799e8f-a24d-4967-beb6-4b7f51c3efc5@tu-ilmenau.de>
References: <34799e8f-a24d-4967-beb6-4b7f51c3efc5@tu-ilmenau.de>
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

CC: ceph-devel@vger.kernel.org

On Wed, 2026-06-17 at 15:12 +0200, Raphael Zimmer wrote:
> Hi,
> I discovered an issue in the libceph module. It may lead to a
> stack-use-after-return and, therefore, overwriting stack memory, or
> triggering a BUG_ON() assertion. The behavior can be triggered by
> messages of type CEPH_MSG_OSD_MAP from a Ceph monitor or OSD.
>=20
> The problem is as follows:
> When receiving a message of type CEPH_MSG_OSD_MAP, it is handled in
> ceph_osdc_handle_map(). This function creates two local stack
> variables
> that track (linger) requests that need to be resent. For requests,
> this
> is an rb_root variable named need_resend, and for linger requests, a
> list_head named need_resend_linger. Subsequently, handle_one_map() is
> called, which calls scan_requests() for each osd. In scan_requests,
> the
> new target is calculated for each (linger) request, and, in case of
> CALC_TARGET_NEED_RESEND, they are inserted into the previously
> created
> list/rbtree. All requests in these structures are kicked off to their
> new target osd after processing all osdmaps. When doing this, they
> are
> removed again from the list/rbtree. If an error occurs during
> processing, e.g., because an osdmap is corrupted,
> ceph_osdc_handle_map()
> jumps to the bad label and doesn't call kick_requests(). Therefore,
> the
> (linger) requests are still inserted in the list/rbtree, which now
> doesn't have a head/root anymore. This leads to requests having
> invalid
> pointers to stack memory. Subsequently, this can have multiple
> effects.
> If the (linger) request should be inserted (for resending) the next
> time
> a (valid) osdmap arrives, the respective structures still have values
> that suggest they are inserted. For a linger request, this results in
> not being able to insert it again, and for requests, a BUG_ON()
> assertion may be triggered in the rbtree insertion function.
> Furthermore, if (during processing a subsequent osdmap)
> recalc_linger_target() returns CALC_TARGET_POOL_DNE to
> scan_requests()
> for the linger request still having a pointer to need_resend_linger,
> list_del_init() is called, resulting in accessing the invalid pointer
> to
> stack memory.
>=20
> I suggest fixing this issue by removing all (linger) requests from
> the
> list/rbtree after jumping to the bad label if an error occurs,
> similar
> to how it is handled in kick_requests.
> I will send a proposed patch in reply to this email.
>=20
> Best regards,
> Raphael
