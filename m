Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D636604B
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570202; cv=none; b=CVczcgvzwg8H7G+CAhSmkf41EkWh6g985/7r96NU2rUiNdIMM7CG9IbRqXtBkyDn0AJ3/3dVuQz+O7C0DC7u0Z8AZR/CEmyv2wKBNk9gXNzzzsJxCm8uNFEHUee17jJ5j9alUYDu/stCBQNR2nvGVuaGwrEcxOK5CTHIBPE0GhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570202; c=relaxed/simple;
	bh=CxpG9Jy/R7orPAb60h2iDcvP1QAq+5XuPgSENjsVHPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLYsrk/GvI06OAtPYHdoRhpeETWwlnp0x1+AOC+tUGeqdshOmJ2sjI9VByRBLxFtFcoHrcM2/07Rm2bNkKlmK/nPYrylROX9SedrcLmlnMkgTaMUo2tH7qKiCSGT/9UmY7GPyswKnmOqjQL1H+5zZSpu8zdt+Fmi5A+jgpWNVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWxGcEsl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=feeIuzRV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWxGcEsl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="feeIuzRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787570199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93DJO2pZN/VacKDBxcdKfEutLUHoARAo5qEFKUEtcOY=;
	b=jWxGcEslYAIzIvXyYK3sUIKcwHRoHuq+DJ3TCREeSFbatMZTkrGWDIhSF2Eo8vA8U9ZWFY
	G7I5csoiKlmrnNTHSrt1SfhqjnQpHaBaf/6KrRG1LzF22Sk2N9MtmDEmFWcKUynE7QrvsP
	In9q4ZsZeyVyYT7zl3125J+c1ru4O94=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-q4_8gFklNNeHgWJ5-Q2LZQ-1; Mon, 24 Aug 2026 07:16:37 -0400
X-MC-Unique: q4_8gFklNNeHgWJ5-Q2LZQ-1
X-Mimecast-MFC-AGG-ID: q4_8gFklNNeHgWJ5-Q2LZQ_1787570196
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a17c89d8c1so1250882a12.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 04:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787570196; x=1788174996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93DJO2pZN/VacKDBxcdKfEutLUHoARAo5qEFKUEtcOY=;
        b=feeIuzRVZ0s0hMgyLISY3T6h3cZftfbvh8vejRCS06HxptcbjtsJL/TD0sqdvuNHJS
         KujpLt0ONLVao5auYR34BfsF5DYqBqFGvZSboPdbjEzKGa4RAzI6YYIVGxnB3n4+298R
         HkUVXk7pDJJQ1RXarwOXuNX36tXMvIQ7+/5uzJfUUhwLYWOCBU1jbSRVoejYFpMr4nCR
         TVMLOhlKC9qkFqHTex33+KYAKUQGk71SB/b5ZIkBul4H2fW8rVzDHswdSqxo7D8Prx3l
         mZiVcn43QoxzUSfydhQ5yO3DHQEIykiI8EF5CKJCY9zPfFkHZrMBbMboFZRwH3wQ1Kes
         WN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570196; x=1788174996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=93DJO2pZN/VacKDBxcdKfEutLUHoARAo5qEFKUEtcOY=;
        b=X9/lXGl6w90yGeXmA3ZLH7vu9CiUyloApXN/9LzmBjbBK0h7KJWpE9t3pVEYyTFGlI
         pkD4WSA3sgvml5Ej7y/G2prloRE8kswdxe7xUr10qdRh/mRAyh9R16/c+h4gGRuvfWeO
         yQde1gn6tvml0fi23itGkMX9Uu2aHA5VLBKGrOg+C9WKWtT5fR5asIvMrq5108+ZWO3g
         ZMdlZJYYpcSIoqXx/3XSDHlLm4SdPVAs+GM/fL3FzAo+tshTJ5yJ6cnGbJOwRFRzFsXH
         rQKFySunbY+YgqZJAS85HiOjgVVyQr7nwrgGBqxVy306i/KIHCF6wm0fZC7aCc3CcqAD
         qnmw==
X-Gm-Message-State: AFuF++knW5LkopOBk5JGHc05/p6cWEdCB4uExfe/IpjUbNimUiJrPRNk
	pCWZBMo4eoOhEfklctWOvJNuBKXC+t/ONkCS6tqBWmRpy2tzT4cnoY/gc711/4Ju/qxWMeMC364
	9SZIjHYYrOJpM4SJhiKCBfRNs+A1PAWdehSHj2yeyrXQScQVu/ccFzwZO30akikMVWINaaoIdWw
	==
X-Gm-Gg: AR+sD12X6v/CJ2+63csPwyENq7mC73IuYoTSD7h9osNDtqbolJsNl50IU/SsMjC0xHq
	Lb1n5VKxoFCPEGlUVyFPfSxBrXFu1wZr2iuQorZ7cxmzdHfKlywnf21M8JvGMU13ZAfR12Ra2st
	GU3g25Rowo5IEX7JfeeKgDky2Rt9qWy1JnxpYfCB9iN5icreVYZutCY0VL/9ll9rMp4ZQ472CSG
	sQISUyp3fdVDLkYKNRGkLKiVPW2i5BANitbz14tjoEaL5oGSW8CSb5rCWGV1FXsV6/JMjGeWeud
	zayj6EeNiTJj09Jzt/pGXQhzhzku0Ca1fg9fBmgr53aI+QpzxhxZ42UfVOsSGS/OTgsbrMmmQ3B
	2gAXclzwfy0y88JypUw97bLL8NzPN8OjYNA==
X-Received: by 2002:a05:6402:3807:b0:6a3:849b:aa48 with SMTP id 4fb4d7f45d1cf-6a582b39dc9mr20716951a12.7.1787570195898;
        Mon, 24 Aug 2026 04:16:35 -0700 (PDT)
X-Received: by 2002:a05:6402:3807:b0:6a3:849b:aa48 with SMTP id 4fb4d7f45d1cf-6a582b39dc9mr20716915a12.7.1787570195435;
        Mon, 24 Aug 2026 04:16:35 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1ccf69sm8645595a12.25.2026.08.24.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:16:35 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v5,1/5] ceph: use READ_ONCE/WRITE_ONCE for oldest_tid
Date: Mon, 24 Aug 2026 11:16:33 +0000
Message-Id: <20260824111633.2517174-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818-ceph-mdsc-mutex-optimization-v5-1-7d335a3a1d0b@clyso.com>
References: <20260818-ceph-mdsc-mutex-optimization-v5-1-7d335a3a1d0b@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [critical] fs/ceph/mds_client.c:3746: Session OPEN can lose a waiter
     `__do_request()` still decides to park by reading
     `session->s_state` under `mdsc->mutex` and then `list_add()`s onto
     `s_waiting`. `handle_session()` sets `s_state =
     CEPH_MDS_SESSION_OPEN` under `s_mutex` only, drops that lock, and
     now calls `__wake_requests()` without taking `mdsc->mutex`.
     `SESSION_OPEN` uses `wake = 1`, so there is no follow-up
     `kick_requests()`. Interleaving: `__do_request` has already
     observed OPENING; `handle_session` sets OPEN and splices an empty
     `s_waiting`; `__do_request` then parks. The request sits on
     `s_waiting` of an already-open session until some later unrelated
     wake. Requests with `r_timeout == 0` wait forever. Previously the
     wake path retook `mdsc->mutex`, so the park could not land after
     the splice.
     Suggested fix: Serialize the state check with the wait-list splice.
     After parking, re-check `s_state` before dropping `mdsc->mutex` and
     self-dequeue if the session is already OPEN/HUNG; or collect
     waiters under `mdsc->mutex` onto a private list, drop the mutex,
     then dispatch. Session-open is not the hot path.
  2. [critical] fs/ceph/mds_client.c:3886: r_aux_item is not exclusive once kick_requests() drops mdsc->mutex
     `kick_requests()` collects matching requests onto a local list via
     `r_aux_item` under `mdsc->mutex`, then drops the mutex and
     dispatches. A second `kick_requests()` for the same MDS
     (force-umount, `mds_peer_reset()`, `check_new_map()`, reset work,
     `handle_session` CLOSE/REJECT) can still see `r_attempts == 0` and
     `list_add_tail()` the same node onto another `kick_list` without
     `list_del_init()`. `replay_unsafe_requests()` uses the same
     `r_aux_item` for its walk lists, so it can steal a node already
     queued by a kicker. `r_aux_item` is a single `list_head`; it cannot
     be on two lists at once. The `r_attempts > 0` gate in
     `__do_request()` does not help: the corruption happens in the
     collect pass, before either collector calls `__do_request()`.
     Suggested fix: Claim the request under `mdsc->mutex` (skip if
     `!list_empty(&req->r_aux_item)`, or set a dedicated flag) so only
     one collector owns `r_aux_item`.
  3. [major] fs/ceph/mds_client.c:3844: r_wait walk vs. splice is unlocked, and list_add() is not idempotent
     `__wake_requests()` splices `s_waiting` / `waiting_for_map` onto a
     private `tmp_list` and then walks it with no lock.
     `kick_requests()` still does `list_del_init(&req->r_wait)` under
     `wait_list_lock` on that same node, and `wait_requests()` does the
     same during umount. Those `list_del_init`s mutate `tmp_list`
     without its lock. `__wake_requests()` also never takes a request
     ref, so a concurrent `__unregister_request()` can drop the last ref
     and free the object while the splice walker still holds it.
     Separately, `__do_request()` uses bare `list_add(&req->r_wait,
     ...)` and the `r_attempts > 0` gate does not cover parking paths
     (`r_attempts` is only bumped just before send). Two concurrent
     wait-path `__do_request()`s both pass the gate and `list_add()` a
     node that is already on a list.
     Suggested fix: Make `__wake_requests()` the only splice/walker of
     `r_wait`: pin with `ceph_mdsc_get_request()` under `wait_list_lock`
     during the splice, and have `kick_requests()` skip any request that
     is still on a wait list rather than deleting `r_wait` out from
     under the walker. In `__do_request()`, `list_del_init()` (or
     `list_move()`) before every wait-list insert.
  4. [critical] fs/ceph/mds_client.c:1856: r_attempts no longer protects an in-flight send across session teardown
     `cleanup_session_requests()` still resets `req->r_attempts` to 0 so
     the following `kick_requests()` will resend. Patch 4 now drops
     `mdsc->mutex` immediately after incrementing that field in
     `__do_request()`, then builds and sends the message. A CLOSE/RESET
     path can run during that unlocked send, clear the in-flight marker,
     and let `kick_requests()` start a second `__do_request()`. Two
     threads then race in `__prepare_send_request()` on the same
     `req->r_request` (both `ceph_msg_put()` a live message, then both
     `create_request_message()`). Previously send and cleanup were both
     under `mdsc->mutex`.
     Suggested fix: Keep a separate "send in progress" state that
     teardown cannot clear until the sender has finished, or keep the
     one-active-sender part of `__do_request()` serialized under
     `mdsc->mutex`.

NACK: v5 still drops mdsc->mutex around wake/kick without a claim protocol; OPEN can lose a waiter, collectors can corrupt r_aux_item/r_wait, and teardown can double-send. Needs v6.


-- 
Alex Markuze

