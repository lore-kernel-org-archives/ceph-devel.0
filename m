Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAB3C9EE7
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384684; cv=none; b=ozgmkk61afaLIZ4OUoM2pnAKDwhWPZNJ1SOWKEWjumipmpbFJakF5dTWLrRTuQATIdjMjwCeHM4c3pqOvICGm27JMudAMMhYbLWekJWb9yqMRYwiyQMlTtmZXn+rHwgPpChlk1n/35SzhsWjD4+kuSWGBNo/DsPt6OBvMYz1jgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384684; c=relaxed/simple;
	bh=GufpzLwA7MO1L1gABeb1NYq8uOcCubKIH1JT2LlYWaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9k/nadZcPRlPYHwpMAA8dbWrchhg7sst4JHjk76z64H7Kp/9x2PdTka+mT/4XFBjZzltvmU0nBESDvQA2YLdRJm38pouvBynDwlkEJZvsR8yGE81cnoD0w8eqyIo1VYB2J5AlUcTkJ6NA6w7fQmfjIi4vvFXFY1UAmrDjL8QJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQ3MNvVD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea5s6Gl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQ3MNvVD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea5s6Gl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789384681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzRLHZ6b5/nsJoK3AwYMMZ4oghl5RLc2DfHQ8Jy9YmQ=;
	b=DQ3MNvVDHHjnSu91NNMMWT5qsbwgXmRyHqoGUcIqA6m7W7PXG0KRZPZowa1SNlrgNTsZE8
	WU3KElK/XoekJH4v07p99EcAz1hDpU+UL7mwgTlcRf3Bp+dW6Qfesjjn5F5bQ4iGkZSnCL
	g2eiezXrCaL15wMB0UO76y9OCI42jAE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-yMQ92kbjNVGCjM0b8ca6bQ-1; Mon, 14 Sep 2026 07:18:00 -0400
X-MC-Unique: yMQ92kbjNVGCjM0b8ca6bQ-1
X-Mimecast-MFC-AGG-ID: yMQ92kbjNVGCjM0b8ca6bQ_1789384679
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c252634bc4dso278148966b.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789384679; x=1789989479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JzRLHZ6b5/nsJoK3AwYMMZ4oghl5RLc2DfHQ8Jy9YmQ=;
        b=ea5s6Gl+//eYnWj/M5bbplkPJfXiAXWJZHiRF3htv9QtnC9wYhKuRtCEklDOyEVyRF
         ntFltykDfHNuLw5yYWNv4VGo/3p8T1mZT84G4VcQWCPhu8PUQ1GR24EKBetoKqMQqQbD
         G0JRBANMj+4asYl78EgnZiNuOJWpW9J8MWXt4kd/tyfKSMNhB15OUtWZq5NYJbvCSo2+
         aX2T1hjR3hNKpnFu89k87X+ZP0TUznBCyyxPcWZPyuopVRIVTF12kE9ebzTavJkeafie
         rZVGVGjDNOFg6eRj0d6iXvOTuDGBNea9PaL/wrjv3excbKhWiAUUoADgpvXk1Ss47eXn
         TuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789384679; x=1789989479;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JzRLHZ6b5/nsJoK3AwYMMZ4oghl5RLc2DfHQ8Jy9YmQ=;
        b=gacY74pqsEM/xrVNvYAe61XXN2/SaAiK93oDKVr1FOdPK3c7Hz6Jga0fvT430shw71
         Ri3fiLToDSVJ2zRgYXNiYfLRetBRpEnkA9Auiien6Oz4LWvywHpXTrx9P0bNhWTX0MP5
         lL9Zv1iXP7XIqQFBxt3802hM4zZgVEiUgtVfJT+Kevu+GGuPnsbAytpscXU4sCmq/l5i
         tjhiNrES6tThhO/Z5cf5lryQL6qhU6C7hnbqZ0IyAewKG8VttUku2l+KziPODTgHiM1S
         CCJ+6O8pbxvWGzsONNiD4G67v5vX4e8++vBIw8rAB/doHK5HNCGQjOHIr1o8CX9JkoC4
         wXiA==
X-Gm-Message-State: AFuF++n02OF2FhNXK0jDDibk3Bu/WMychQsvoHm6KRL9pS3I0G/+8Dkb
	CCSwG6BZd48rcGY1QG2ysE0cRaDV83ZlWT/y720q54yl+3NeGEuBJZglgeTLQG46AK6LVgeAss0
	h+V6N6FysSkGjuATKQBI/PWp/McB38KvudzCyhtyAh0bfW22HRS+M9hpM+dMSEsM=
X-Gm-Gg: AYBFou3XeyVGb6Ee8iOKABzz/jDylcPvnmZMparuzbef9RPrFjoFLZGe7wo+m798meF
	ciz4r9JpISVXKA7qX/qwsxgnqgCIUgQ9GWoW4l7DleXneQ0U9ugasfHUr0pKxN08joklLROBGoV
	S6A77YEhv0Ww6QCKg/v9ZXLPeqGDWzdsKkSOKb3fND5fVnGM9p3tV+gDa1JeWPWQFMw2N5uw2ZG
	Y+pxLSzGgR0hL+51Qxg0G8YEA3AAjot2X6GAepVsoQgKwiBJMVIvMojZLs044pBneChnQCYG0oO
	KDF455/hbKcap+K7+ecSDmW3cPnUtEC1VsRff3MD1j8J3n/FxETXYx85o8Az/blsz6nLjsS+DnJ
	FduNqHA++0lieRNcQbFQQCCIjbYSM7ULehRhfLuFwsOV1Gvcdj23eaSikURIbfME02kiPc9eJzO
	EdBeRg26tZrZEYeg==
X-Received: by 2002:a17:906:7954:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c29b7ff89aemr277099066b.0.1789384678941;
        Mon, 14 Sep 2026 04:17:58 -0700 (PDT)
X-Received: by 2002:a17:906:7954:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c29b7ff89aemr277093766b.0.1789384678491;
        Mon, 14 Sep 2026 04:17:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660f9b23sm410522566b.50.2026.09.14.04.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:17:58 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix NULL dereference of filelock_reply in ceph_lock_message()
Date: Mon, 14 Sep 2026 11:17:57 +0000
Message-Id: <20260914111757.152553-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+0ovCiUaccnL7U89TZs2GOBGxp2E6OCfU_KMwre9Fnfv4BE4Q@mail.gmail.com>
References: <CA+0ovCiUaccnL7U89TZs2GOBGxp2E6OCfU_KMwre9Fnfv4BE4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Farhad,

NACK. Please respin.

  1. parse_reply_info_extra(): switching the extra decoder from
     info->head->op to req->r_op is the right rule. Extra is a union
     (GETFILELOCK / READDIR / CREATE; GETVXATTR writes xattr_info
     beside it), and the rest of the client already consumes it via
     r_op. Keep that hunk.

  2. Wrap the GETFILELOCK filelock_reply NULL check in unlikely().
     Empty extra on a successful GETLK is MDS garbage, not the
     normal F_GETLK path.

  3. ceph_readdir_prepopulate() still keys LSSNAP vs READDIR off
     rinfo->head->op. That is not just a dout: the else branch calls
     ceph_fill_dirfrag() and primes the leftmost-frag readdir cache.
     Same echo-vs-request split — use req->r_op there too.

The RMSNAP head->op in handle_reply() is only a debug flag in
ceph_update_snap_trace(). Leave it.

-- 
Alex Markuze

