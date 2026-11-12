Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494203;
	b=ROPyxrz4f5b5nxQy6CUhvW2xr136C9jDnqR5qM8DaQ06J4Z2tj0e5T6bH3F/VFBK3Lo3
	 toR7qfNzWOs3lyFJc1bygAawwpazl8qvOnF9iGziXRtvXP83/pINgBOZPql8vZUwoTDRy
	 DLkrIOrZHvjXroDqc+1ydEUeTG8+b4uRQ5+NtSBH5bze5Oi16k2oxbPpO8RVpMYGt8fTI
	 o0Fuopqq6pHFR5sAIi9JLLe1UQVq7Kwfy28gtbDkq70T9lHoxR94A8TsLycBxhn17nX6L
	 NUl5AAxgoLx+0g78Fulb8NDxDDshEVz9I5zYIDMUtFpPOZHZXOIcFDWqIhqP+mSMTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494203;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UkEBDXWZEMwDbszUgsfrG97wOOCOR83J/+o9Z+vJcJE=;
	b=ggmAyHxz5I3qvSUTl7vvTj41qdxSBaiwRx1yboq7UI2cvC0PiiOPlJ5YNaHOsESODrkG
	 vO30/B6VddMVMXrXUupbxv8p4H1rNX6K97pafttdclNTX3Gqh4cW01K/EmJCZE6BGwPgs
	 S1NhYZ9PZKJh7uYWu6zEwTnjiawJNTaZSv3ALn6446EN895vIjBI4KsoY62PItgzlHrYW
	 IchDsP6/Esv/exQBgeEHs2huOhXqys2cSY9FNLDilWiaWKiEhswdr+jOSbjxZEZaQ8Uuh
	 Oy+8ucOlR16fRi9eOF1zi2ZBCvqU2hK9NObU5TenkybuW/UoqVU/E9841/f59iyHx6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp3FlLVk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a6yH5bE5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FF606A327
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 14:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C9FF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cp3FlLVk;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a6yH5bE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794494202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UkEBDXWZEMwDbszUgsfrG97wOOCOR83J/+o9Z+vJcJE=;
	b=cp3FlLVk8CySVhpvRM4dfrYqt8UvV5jXQ96NC2a+tNXCwgMqKGx7UjkEscfsbWUr/gPj1e
	CkrWCg/E8e/Hz0GEneB4uKuf24CwVVlJTSo+c9qb7EDwiMFjRVg5WUnLkJwu4XmZTgO0oo
	6ek+yBnrKfZnacwyWthZqXTNA0XBSLw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-7a1pcP5IN1anVQonzFG9gw-1; Thu, 12 Nov 2026 09:36:39 -0500
X-MC-Unique: 7a1pcP5IN1anVQonzFG9gw-1
X-Mimecast-MFC-AGG-ID: 7a1pcP5IN1anVQonzFG9gw_1794494198
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c5079a4a21fso28881766b.2
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794494198; x=1795098998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UkEBDXWZEMwDbszUgsfrG97wOOCOR83J/+o9Z+vJcJE=;
        b=a6yH5bE5mSDskc86W4IkXdc3vx3Tl+7do4gEY5DRwR7v+I2mbrG9X5DS3d8uSk48yy
         cJE4UiG/fjwe3l1MC1NZJg5my5YI5wrgtsRtVsN3vwjGMsAT9LuNrWU3hKkaadG84mmJ
         sVaWZ6Uvcf1vG3Eqt+zTqqQskEqeIDbynSKF88glMYCgalAmexZ7DfjWIizHC3m5XDLB
         LTD2RuAQ5ZZ9wIJZcU9uSOmL1Fnk2EJFQowPM+VOksWBfB0o7KWaWONjUCL45/4XeCx2
         kGIb/r/jgJwzZ3QLUt0tfTOj7md157J8ZUeqGu5HHnSYEg4K3/qHWMEGYHkFZ3FvDG0m
         Jnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794494198; x=1795098998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UkEBDXWZEMwDbszUgsfrG97wOOCOR83J/+o9Z+vJcJE=;
        b=0sueZTQfJUC1kov1maSK+8Mu1BhekpIlpiXIQyqHXTFk5mWSsWwJDfbC3WqxZ7aAcI
         tP3WJtUtiXorh5QxFT5WVpNGfOCzhMDTwCJPQxUC1nhIh5MwENo0sj+zQBla3JE3ZAh3
         oH8cnFtOKjsjaKowozDwLEEm/Mo2/kMHFNENf75ZKiglJAxrOgrsB9XtDc+WS87U9R80
         0NJq8U+lWpGfuBzIE2P4oow69mO39zMcGQpkDzbngSo6x6PccGQiwqKcRpV+qeSN7/PV
         WFQmtNygn9SZJq7+e+11RgrBo9URFqAn+oNCsuWRZmqxR2VF8GqOk7bf7V2ydQK1ACdX
         wK9A==
X-Gm-Message-State: APuU4Z9ukzGfozcaS0t/FHvJ8Ezud5toA5onYU0xKFj5gxvfA9vHW18s
	X1Bnna1gc62qkxuzFfrqfQiN+thm9D5plTF0Rkt1BeYV4ijUuYs+1Mc4sigtm6xGyc0sLnZPIFJ
	nJHLZRPc6vCiqKyf26HEC8M7OYetXSASuTGPpmsyUkV5GgGx+zW/kSWTypBkef4x40rpk+GI=
X-Gm-Gg: AYBFou1obe9pQOY9EK6rhUPKHXiDMl7kqPzLkcbwAzrWUqqEZoCTt0eMF8MP5xDCp6J
	A8lpcHM61aip6z2Umc7tOyGhx1qao2/e3Yy928MnRf1GzNsXVf6t6quEh2IMZJ4a+pRbtusJH+B
	rR39h9WdqK/YFtWM1E5llDXXEyObH5R5UtkuDZpJZiSZrK9q8mvQ/gQWU1Vx0Zy0dol/pjlQqf/
	6yEH0UFxKIHu4WzgC4fMjadz2TLVcmBpu+i8m7BYTdLctfmNnDaJ38QPJ51f2pbPSN7qexXmxcz
	pwr6qWcbQy77A47SYVl7ACYnU1QJy2Vwl9a0vZYrPVtXFk0aEMgvFMRT3/ISRA6VqdjtCvOnN60
	zVG5O21cd6kZREko6nMQScnkAGn8xf3/hSFBbqoFSe9wH/3c+aprAZXLQFGGr/mKitaN4i2U2xm
	pI6dn3GCa7OUrSdfwHST2yqifxz86aomdn+CUw1pThyK5AlG0uGWzeJSrqkDRSdwuZVbltExmBm
	m8/iK0nG7YXHWDDEOiAbAF/VDQDHHJt/lFBbUL/8F+ZgWufRPex
X-Received: by 2002:a17:907:da2:b0:c4d:167d:dcee with SMTP id a640c23a62f3a-c5066b7cdb6mr462137166b.40.1794494198519;
        Thu, 12 Nov 2026 06:36:38 -0800 (PST)
X-Received: by 2002:a17:907:da2:b0:c4d:167d:dcee with SMTP id a640c23a62f3a-c5066b7cdb6mr462136366b.40.1794494198119;
        Thu, 12 Nov 2026 06:36:38 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a3a6909sm366314166b.1.2026.11.12.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:36:36 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] ceph: reduce mdsc->mutex contention in the cephfs kclient
Date: Thu, 12 Nov 2026 14:36:35 +0000
Message-Id: <20261112143635.3608632-1-amarkuze@redhat.com>
In-Reply-To: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
References: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

The two problems from v4 are fixed. replay_unsafe_requests() leaves the
request on s_unsafe, and ceph_mdsc_create_request() initializes
r_aux_item.

Patch 5 still loses a request across MDS reconnect. __do_request() holds
CEPH_MDS_R_DISPATCHING across the unlocked section, including
create_request_message() and the async-create wait_on_bit().
send_mds_reconnect() holds s_mutex and calls replay_unsafe_requests()
during that window. __do_request() does not take s_mutex, so the two
overlap. Both loops in replay_unsafe_requests() continue when
test_and_set_bit(CEPH_MDS_R_DISPATCHING) fails, and neither sets
CEPH_MDS_R_RESEND. That request is omitted from the replay.
CEPH_SESSION_OPEN only wakes s_waiting, and a request that already has
r_attempts > 0 is not on that list, so nothing sends it again. The
caller waits for a reply that does not arrive.

replay_unsafe_requests() has to wait until that dispatch drops
CEPH_MDS_R_DISPATCHING and then send the replay itself, before
send_mds_reconnect() finishes the reconnect message. A later
__do_request() sees CEPH_MDS_SESSION_RECONNECTING and only parks the
request on s_waiting.

In the same window, cleanup_session_requests() and handle_forward()
store r_attempts, and handle_forward() stores r_num_fwd, while
__prepare_send_request() reads them into num_retry and num_fwd. The
legacy num_retry field is a u8 and ext_num_retry is a __le32, so a
concurrent store of 0 becomes 255 and 0xffffffff on the message already
being built.

Thanks,
Alex

