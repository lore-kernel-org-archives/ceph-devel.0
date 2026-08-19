Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7936A02F
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134389; cv=none; b=oF3WAGuIVgZ2v66YBkjHYBbh3rVJX6QUghADqEogQDW8TLPftbPeUI3+68VTK7PoTpC2Iz/Y1GjBdtm3u7K+kZUPg+3c61dkK+YGFRjI3jw/dKWrZ9pIOKBN7L9iargfEuR+qkAE8j/7fafErDNWb1SlpvXBkq9bgvas4DPb04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134389; c=relaxed/simple;
	bh=WUIYUULjpCxnvWiinwm799rxT6V2Gvfqwu+v9EnI9wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDGGYqaCpOd9XChIoWZoSFfCxv7RMyZcy5n2gduYDChvc5Hze/u7we7EUmbizKHR2+RtiTLcTLGP5gPgpEfkgNHU4+ZzJ9SXtGGYN1xpUBxnbUvv+aiaBXxiqNLDm9uC6VUU4Dpz7AT8pTuMOvSq8e9DXmiaHHU37NzIgMuvW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUXKIiVJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7mU+Pzl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUXKIiVJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7mU+Pzl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787134386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUIYUULjpCxnvWiinwm799rxT6V2Gvfqwu+v9EnI9wM=;
	b=dUXKIiVJDZi5tUr51+97utHfTC+XR+3KktYmDWOpwnp4IN8uAzvDlDvrZj5NGLiP1k2Alw
	ekyEM2Hp9zCJZL+IjDmXCh4TgftzxWDk19dm+zaEwYsU9HGQrM/MBLXzwhOAPpgFjEfczc
	LXhff4Xr8J2U9n82mcoYBD9yzgu4DKU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-9JQAC2XdPa2mVDaLiHtEhA-1; Wed, 19 Aug 2026 06:13:04 -0400
X-MC-Unique: 9JQAC2XdPa2mVDaLiHtEhA-1
X-Mimecast-MFC-AGG-ID: 9JQAC2XdPa2mVDaLiHtEhA_1787134383
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15f4732dfaso68076266b.3
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787134383; x=1787739183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUIYUULjpCxnvWiinwm799rxT6V2Gvfqwu+v9EnI9wM=;
        b=f7mU+PzlTnQEi244bBdkXruHr9i5x2ltrIeknWz9cgvwBGgiDNT5HekZ12hzXHUGlm
         3R0fD5NwxK9MBU9wsLhYQbJapLwroPBs5Gy1vSxJDHOoLZ6CbVHK0igZcej2QXQlY9HU
         ADDUTZX4BUgmwYYNKusZddv6wwTcfKmCkkuCxl/vgjWt5dCj+E+YFzdueAElULp8KN1b
         kmxnhONvIP3jHs1CiCna/0eSAkB2/iE53b7fEOTTd2CdJ1DRu4ek44hYgv8FvFv22Mg7
         yia6S7GfOSFk3/NhEYKpPmu8AuGCov9xRuqG/9vKoL9XTgAxC6JeiQmNRlBga6uaTBDN
         j8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134383; x=1787739183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUIYUULjpCxnvWiinwm799rxT6V2Gvfqwu+v9EnI9wM=;
        b=NMeaixtpoRKLkar82utgvJasbT8xeNJEpxvOADXralSmQuRldo4exx0rC0Guz+2EoN
         +YgNuhS5DIoc6t1CVLymfqnwEQ2qGyKgc2Fhb6j+/lRFWLUBctl+lJBHYNQDQ9aHkCik
         xrStGQEoKEEGPMo6Ms4ROC0NFESD+pW8+bbVbr1z3UCDtqexjOE8MxiaFxjJxoIdl5+o
         5n4VPGQOA5N5WWG4MjQX9Wy4yI8tgQFDHmbFKopohZTDYUv75VwzzvLmi5G1Ao0FMNVd
         U7vImXrIq70DI+pcJxip6v64NTlgaz+5Eeb20MkDB0pxa/FuX+FvJABd5OA9uytduTTu
         ICEA==
X-Forwarded-Encrypted: i=1; AHgh+Roz+tNHk83waHrqeHcCufBqideVN47961uE3aA8wFpD5o2W7NvNWk5Y8wmIzf8Dt9jdWZjR7eJ4sFN6@vger.kernel.org
X-Gm-Message-State: AOJu0YyBp7os/1Koo/eVL079Ikl7DnR0r2l14jlyazzQKCX//kwbgr83
	6o1R8g7KQTZHFvEZEZcjwMahORk3RAX7KMkMmmdSNS2YHg7PxsCfV841cdnvKdJJ7s0Ad3qoiaF
	5QIexuCqxQiWgS2UfYApIR4+RCAIOWSnRA0RlTGI1MP31J2GR+tUR5baAqubL3eY=
X-Gm-Gg: AR+sD13RWB7gLasfgQNGZZ2+Skz4pVQgCyS21N5NF4TygWedbesqcpljrXBWt2zI6f0
	QE5Ch7TpyE4Fu+dmSddMPrV87pCi4E/dmckQKAO4Muegjlx4YHRUCaHGz3QJF2TSFspbOtZ+Tkb
	WJjHwv6nBy9DD2AqU3sP7witIJ0l111wI5ansKkBAlAY2ce4cw+Pcfx771b9asbwOLHLzahty1y
	8TZAJJ4B0oHV0px3rjdLrdnDZeQVyNH/Pigl5HkrP5O/nnUKgQdesPEoezEQnD8pckPiUfOFPOk
	lkGCJkJElfbzmUrN3UJ/ZwFxlkxotwajLcTUXFHUrUT0dd+yOZ2oEmtPtLPx5Y0whsA4qXo3Uac
	U7/mYwO7AWgtL5/8mHAqsG6pi2secaZNYcg==
X-Received: by 2002:a17:907:3c84:b0:c20:899:b8bc with SMTP id a640c23a62f3a-c23f9354356mr210749766b.6.1787134383228;
        Wed, 19 Aug 2026 03:13:03 -0700 (PDT)
X-Received: by 2002:a17:907:3c84:b0:c20:899:b8bc with SMTP id a640c23a62f3a-c23f9354356mr210748366b.6.1787134382841;
        Wed, 19 Aug 2026 03:13:02 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c5a0796sm53221666b.35.2026.08.19.03.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:13:02 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: idryomov@gmail.com,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v4] net/ceph/messenger: support IPv6 Link-Local with scope identifier
Date: Wed, 19 Aug 2026 10:13:00 +0000
Message-Id: <20260819101300.1266123-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812213657.1821175-1-max.kellermann@ionos.com>
References: <20260812213657.1821175-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

The core issue from v3 is still present: sin6_scope_id is a local
ifindex and must not go on the wire. v4 adds ceph_addr_equal_no_scope()
for banner comparisons, but peer_addr still carries the scope from
inet_pton_with_scope() and gets encoded into the msgr2 HELLO and
client-ident. A peer with scope 0 or a different ifindex will still fail
identity checks.

v4 also introduces new issues: the monmap update path drops scope when
installing decoded addresses, so reconnect to link-local monitors breaks
after the first map; ceph_addr_equal_no_type() still memcmps full
addresses including scope, breaking monmap lookup; and
ceph_addr_clear_scope() does an unaligned write through a cast on a
const-qualified pointer.

The fix needs a clean wire/local split: scope lives only in the sockaddr
used for kernel_connect(), cleared in everything that touches wire
identity.

--
Alex Markuze

