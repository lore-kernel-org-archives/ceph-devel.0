Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447081;
	b=TA6mcNFrgdaBmmO/6DrS3FowzljCCtuoStkBLMUxmqhLCrDCQYNM1du3Us7d/VUpqFG2
	 w1nuADp8EbnIvPtbMvOpH81m7o5VwOyX8mY4IMoRGxz/RjoA6SJ9DW2hFmomjpLIkTEI8
	 NOndUCnuf/i2mSVBjZcaN/1MBodakYGVQKDf0+MdCnTTrp3BjTmZmw02cQZX4P+ubAjKU
	 0nkVel2yo/nZH3j49eN99bmJTbtomBDDCs8+E5JlcZzojtDokmX2ahaN6CfZ5GGEARE/k
	 2Ou9ezi8GuAFmR4tnswWlLj7uZyjVpbUAk97d7Y+Zqk1RIptlniJsYrhaRbXfE1EW+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447081;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=tbAelE0MgrzBlqY6meyYnUeXwzPQQ8o74J39xWeGzMI=;
	b=aNR4h0coqfqTua/5NSesGQJ43uMQ9k/nI1Uth/L+dvSNhHILuWrD8NFXxygSKGI+kQp3
	 HdOXcybJfotb0JHUKuQ8aOkewg2tZh5WDNnDKSvm+bSEqduuu3Elbnhmm05n4A3qlRyaH
	 dtzt7AWHxO2yZlrgGZQaOYJLHX/pjATTEG/2uTXqhASRYFaEthZhVRZRZsf+atTND0XQS
	 GJaDvJ9KD99qblmxF3GZqL4duFeMRt3vOH8N4EX0sKmTd43t9lX70ovQgNkB37X+wNn1S
	 3GgI2Eg7IDUOA2ixbdZ7M8a0y35QjN0fmXyZv0cFh4XFq+4z+2KAygkrmdYo6Niq1mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAX1KQf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4305606A334
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAX1KQf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949AE1F00A09
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 01:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794447080;
	bh=tbAelE0MgrzBlqY6meyYnUeXwzPQQ8o74J39xWeGzMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cAX1KQf1Rzsl3baWjSeoL9KqFkTL1LmLNbp0E7qvwOM0SZG/F5dkudx/fNzxgDuMK
	 GK/I7Yw6HwlPiQQsj3ellpPk3FiAvNUAb+8kNfBwSkPOvSIjKy+Eicot9YEg0s3OPO
	 3c68Ud/AcuoSMRQcGVhTkxPtAYF2zG8Y855SXbuP6NE9e7yWaEK8/PxZniNNPDXHfl
	 HW5rJtHZoo3tPzKBs4DbPLKZbDYPi1BTOBK2pPoYbDVc0N7g/NJGX5L6VhpZ7W0WUK
	 TqwJBmB/5yyxNJJN/6g1OttGDgZ9sS/p46Mx1UFXCzfiPZW5xkagpHbky8bqUYNx71
	 YXOqfx3pBCcyw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5c102ad8420so3093455e87.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 17:31:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFiZHjHj/OnW4v9yCHEky/ua2I3VIdtCbuG/2ETsX3KWxqICeVktzaQ5/V+vXaeASZa7HQRKGrdmQFw@vger.kernel.org
X-Gm-Message-State: APuU4Z80SU9NYaCKfDSStTZB4kcu8Ql0mBcHBwxAW34/qS5dMahQ9vE/
	PU5ect3pfNpeeegjb6VxIvMogQhHAvHoN/XQW7TpL2nXXDHEaOxQ9ZkZuuO+TvsF9rcI3kN17Nm
	9J236SZIoGvrhtVFD/8ao7oo+25cA+CQ=
X-Received: by 2002:a05:6512:4011:b0:5c0:a57:2cc5 with SMTP id
 2adb3069b0e04-5c15d5459a1mr1246023e87.3.1794447079338; Wed, 11 Nov 2026
 17:31:19 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111033150.847104-1-kj2864@nyu.edu>
In-Reply-To: <20261111033150.847104-1-kj2864@nyu.edu>
From: Xiubo Li <xiubli@kernel.org>
Date: Thu, 12 Nov 2026 02:31:08 +0100
X-Gmail-Original-Message-ID: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
X-Gm-Features: AclHuK-2jkI_1P4f-3m0WBpZsZ-pjI-2oWTd2FJHzyQYsGPvJZ5SBMTR5ALOLsI
Message-ID: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
Subject: Re: [PATCH] ceph: Use unsigned types for snapshot split counts
To: Kaho Jiang <kj2864@nyu.edu>
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+408fcc361565713f@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kaho

Thanks for your patch.

The u32 change fixes the backwards move on 64-bit (I reproduced the
KASAN slab-out-of-bounds with injected split counts and it is gone with
this patch), but on 32-bit sizeof(u64) * num_split_inos is still a
32-bit size_t multiplication and wraps: 0xffffffe0 still moves p
backwards, and 0x20000000 leaves p in place while the split loop then
walks split_inos[] far past the front buffer.  Could you bound the
counts before advancing p instead, like b3bf89767e3c does for the snap
trace, e.g.

        ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);

for both arrays, and ceph_decode_skip_n() in the non-split branch?
Also, please rebase onto the current testing branch.
