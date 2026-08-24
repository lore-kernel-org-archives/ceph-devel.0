Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983A3E9C0E
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554125; cv=none; b=V+j+Kbat5GcJsg2qqeuqlJUcatwWwP6dQMNNLRv4I5wq+5RM48OJpQ6tUpUR6QvFpUeVBkAGwj/Jz7y9IG7bG+PcMMQOLQiMJVcY0FnyAWOh1O2NTBmouwGJ+10Gi28LfgN6NaIIv2Yj+z4j8DFkLduvzU69aN6IRw5Kq2xGqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554125; c=relaxed/simple;
	bh=SeRSKX9qUQAICue+ts05HWTIeIEbe2do9nFpvfD3tfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IniPJW+yQ/l3EU+uPn3GfvwogOXEH7sB1W9iOQ7F8E/JWYtZgNRPZd1OQr+vTjFYfM6w0m8mXQY6BmeN9LFPxOvnpby+GgGowDH5VXsuUW1GR69ZZ+wmCMCIcAVMpu6sFK7exIgxknJBKRBP+an9qGQTGmrTHToBrKm44Ha0HtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3/VB2t8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sUmT262C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3/VB2t8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sUmT262C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787554120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPGn2wKG/yEJLAmesYBIpLBSoVzTJ+frh6BH7s5dxT0=;
	b=Z3/VB2t8c0mh8zHxXpsbhagamcX3sseoUPqgSq+K7QaDDyW6inDj5q54++OT5yNwr+5Gwz
	r+WhpZSd9/5TVPvXzpbd/MuRpaVRByNjHumoQgksintEh3qgOwZ50/n86F7Gb2gZjXTgGj
	QSli9Iaznfst8Dgp63iHb7wCFkpmnho=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-jczPbPRKP_et6CRXUIkaTA-1; Mon, 24 Aug 2026 02:48:38 -0400
X-MC-Unique: jczPbPRKP_et6CRXUIkaTA-1
X-Mimecast-MFC-AGG-ID: jczPbPRKP_et6CRXUIkaTA_1787554118
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso59435401cf.3
        for <ceph-devel@vger.kernel.org>; Sun, 23 Aug 2026 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787554118; x=1788158918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPGn2wKG/yEJLAmesYBIpLBSoVzTJ+frh6BH7s5dxT0=;
        b=sUmT262Cixva5tpOC6oojHtaR2PdW6GS56zVFq9VTLkf+aSdBSEE8qsmMVu8hGGdxY
         AQcvoRIB3tVR+/IQkpjYnTRvEDh6N1+cxjHSTlnM4eM08o5k0X9iL+6LKjMyZ+R32kHY
         RfLY185XZST6SfCYZSWEmnTMUxd+ME4xnYYd0JOkmhvyHcTy9y3XdnnJXCi9XoBvJ+ZO
         +GlA6AVDcle+Td23oPIwYfIz/s0gzr3QJJbgL5yC5ZQCRcsl/CI/rPA0JafVRiZXEPCv
         qjJjGGiHNRzDZV0a0cdH7mQNJxF7gBB7gq+OIz3r1kWfFd9Bkb1DFqOfmldxzRiHgi8a
         rUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787554118; x=1788158918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPGn2wKG/yEJLAmesYBIpLBSoVzTJ+frh6BH7s5dxT0=;
        b=LAR94iyiIvW/rQH9IF7XkLcl5PmLcEuafc3GhgeCwzAMFsK+Oz5nv+frlbkAi//DQo
         vhp1KMa+7B0MGet+/txVyD3V9nMLQl+UY332ZfeAo57f/42YFWRKmeRYymkQrAVne3dm
         ZpQGM0g5jM3cUjIGt/E1YmPGZZlteg9FG8ms8683HcKmxCLPN4VSwIy8h7p5jY3ya/Fw
         DdcNCuxD46QDfLkkGSQJ6gHI0p+WibCba/i/Sc7lOGIgBj256+zS+Ca/qElzbxe7exjP
         3r3t97NubZJm5msHNTUHS91+yWr9AJvOiHpAQKaGSheXbOoe1vC3rbFV0O/GrFS+LEcx
         vb1Q==
X-Gm-Message-State: AFuF++nTb3bubRNlYiofz/bkcc1FMltacuBsxVxXwDD/orFZYFNp+kc8
	xa4cMysMnN6gGJAHljiqB3iePY9RFDDUmXwliX18Mcevsbc6qgeoAL/qIwji+lTwfRnLr37eDqu
	m+YPyCAMSSfPJpsJB4NdG4hqbhlncNbUZQC6s0mANWRUZsKGwC+Af+SydnUTCgEy/TrAgYhQ=
X-Gm-Gg: AR+sD111IM9lfAwP08TkjsKPgN1Fs+q5TefxlQV6JJCl3fd4L37/oo3S2JV4kYWsAu4
	hG2up6WzW9VevFoJJD30R7QwrOAkm7vFn3/8ypIAgdgocAWLgJmXl+Y/E399DlBOhSH73U1w2T/
	S+5Dd6bjgXuF/+HPdQoo1C9R0+6xixXjiui3S839fXMLdnWHxNWV47waVowWVWMLm9PZMwEz4kJ
	nAA/RwS4+zOzUQbwNnYdJRvZPro+kTjU13uviY00bC/kFLmGHf/696O5Keeg0IsqMPvCvzPuvh8
	QaP6+mxMDWuvrqf7m/jmCX8M9dxymT7oe4MFArxf4zI1H5ogX+DVt+qsn2scFHzJlIibKG1Pikm
	S0idZg9WAtXQ27q4f9c6FWtgXiAHEWu1kqw==
X-Received: by 2002:a05:622a:1456:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52df5692459mr226315261cf.12.1787554118135;
        Sun, 23 Aug 2026 23:48:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1456:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52df5692459mr226315021cf.12.1787554117611;
        Sun, 23 Aug 2026 23:48:37 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e099c38c0sm41184451cf.13.2026.08.23.23.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:48:37 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4] ceph: add 'lazyio' mount option to kclient
Date: Mon, 24 Aug 2026 06:48:34 +0000
Message-Id: <20260824064834.2509055-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com>
References: <20260820-lazyio-v4-1-601bee1ea2c8@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the update and the extra testing.

NACK for now — please send a v5 for:

  1. fs/ceph/caps.c:2354: FLUSH can ACK a LAZYIO revoke while pages are still cached
     Xiubo, `ceph_adjust_caps_used_for_lazyio()` is applied in
     `ceph_check_caps()` and `handle_cap_grant()`, but `__prep_cap()`
     still does `cap->implemented &= cap->issued | used` with the raw
     used set. `try_flush_caps()` and `__kick_flushing_caps()` pass
     `__ceph_caps_used()` straight in, so used is CACHE/BUFFER from
     `nrpages` / `i_wrbuffer_ref`, not LAZYIO. Once LAZYIO is gone from
     `issued`, that drops it from `implemented` and the FLUSH/reconnect
     message is an implicit revoke ACK. `ceph_fsync()` hits this easily:
     `file_write_and_wait_range()` leaves clean cached pages, then
     `try_flush_caps()` runs. After that ACK the MDS can hand CACHE to
     another client while we still have the old pages. That is the hole
     the v4 `implemented` comment is trying to close, and it still
     exists on the FLUSH path.
     Suggested fix: Run `used` through
     `ceph_adjust_caps_used_for_lazyio()` in `try_flush_caps()` and
     `__kick_flushing_caps()`, or once inside `__prep_cap()`. While
     `implemented` still has LAZYIO and CACHE/BUFFER are not issued,
     report LAZYIO as used so `implemented` keeps it until writeback and
     invalidation finish.
  2. fs/ceph/addr.c:1999: Non-lazy mmap can keep using stale page cache after a CACHE->LAZYIO transition
     The new revoke path keeps the inode page cache when CACHE is
     dropped but LAZYIO remains, and the used-cap rewrite then lets that
     revoke be ACKed. That is only safe if every opener is lazy. After
     `remount,lazyio`, `CEPH_IOC_LAZYIO` on one fd, or any mix of old
     non-lazy and new lazy opens, a non-lazy mapping still faults
     through `ceph_filemap_fault()` with `want = CACHE`, gets only RD,
     then calls `filemap_fault()` anyway because
     `!ceph_has_inline_data()`. Those retained pages were kept solely
     for the lazy fd, so the non-lazy mmap can observe stale data.
     `try_get_cap_refs()` correctly refuses to satisfy a non-lazy
     CACHE/BUFFER want with LAZYIO for `read_iter`/`write_iter`; mmap
     never got that gate.
     Suggested fix: Only let LAZYIO cover retained page cache when every
     opener on the inode is lazy, or skip/invalidate page-cache faults
     for non-lazy fds once CACHE has been revoked.
  3. fs/ceph/addr.c:2149: ceph_page_mkwrite() can sleep until killed if caps are gone
     The new lazy-fd path drops its refs and waits in
     `wait_event_killable(ci->i_cap_wq,
     ceph_have_dirtyable_caps(inode))` when it got WR but neither BUFFER
     nor LAZYIO. Session reset wakes `i_cap_wq` via cap purge, but
     `ceph_have_dirtyable_caps()` stays false once the caps are gone, so
     the waiter goes back to sleep. `ceph_inode_shutdown()` does not
     make the condition true and does not wake the queue.
     `try_get_cap_refs()` already fails with `-ESTALE` on shutdown; this
     wait sits outside that path, so a writable fault in that window
     wedges until SIGKILL.
     Suggested fix: Include shutdown/session-loss in the wait condition,
     and fail the fault once the inode can no longer regain BUFFER or
     LAZYIO.

FLUSH/reconnect still ACKs a LAZYIO revoke while pages remain; non-lazy mmap and mkwrite shutdown wait also need fixes.


-- 
Alex Markuze

