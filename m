Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734633168EE
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632112; cv=none; b=Wr93Wb8KsPZT4bUAPNeT7ijhM8UH0Pr0bh/SC4vL9ggAQHKXMPTTgBkhAF8/sW6M7s475t3Kqe2/coPbWlRHqYwt0E/CrzmirBUZlwDfKwOz5LoAylFErvxucvxNSoxeskNmk9VHefhTBWrdJ12LPatV/447iKLgIjJ5aOPUkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632112; c=relaxed/simple;
	bh=ol03wwTtn588hwQV3WRglXiHF05rKgyagHneo3aiiw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUwifNk2LQnVtQaDlyeKKCLhAtKJRQd+Q0TJF+N3E400yebVfBDgqRSDAF5FDOjaVBNw/R1jICia5SexvuDWJqWrz36wUCg7d0ntm8HMqwfht3VCNC1rmHLdfcKs/pIE6FBAnwhc8iZ8ABxSDXZ7U5bLs7+tKypfpmVbOhcICPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMwESupt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAUzyQ9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMwESupt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAUzyQ9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788632110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Muroh2zxhm22hBlIZlViLWOTeT2Fy9zQxs2oZXSkuJ0=;
	b=aMwESuptoLEhZxTWSzfGJda45jUu2rCYd7WYvkpTN4JLh5JXr8nBOemusbWj8Mi2jXkine
	1N+KlMZGNXuXZRJLVpGp8urZVTC+4leyBbYuu1yuF1pIAMo7nfknRhZ3uvNZugkS30tzNi
	d3kRZpwO5b+9OESv2D0iKocwtOujai4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Yob9EIHUOAuqc65dt-dJsg-1; Sat, 05 Sep 2026 14:15:08 -0400
X-MC-Unique: Yob9EIHUOAuqc65dt-dJsg-1
X-Mimecast-MFC-AGG-ID: Yob9EIHUOAuqc65dt-dJsg_1788632108
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c25501f4aa2so263533866b.1
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788632107; x=1789236907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Muroh2zxhm22hBlIZlViLWOTeT2Fy9zQxs2oZXSkuJ0=;
        b=MAUzyQ9C87//812tCBeOc4Z4Oe5/YbczNnSyzUuHcNXQCYhkKg/7BNTGjS+XAL+ms1
         m2qi2zfQjw5KrnlkiDwjuK4lpNeOthnWvyTzQmYYOAZPfXjUeIUv6DbrEr/JPx33ioa8
         IVjwjmfe3PnScRpDPk239q5HA0xyxCipoP94n5NJTG1M9siFV4Dyt80U7xjJFH4QhS0R
         jLfCVg3pJ9ZUG+Osk1cqe7cr4FMUb9fU+NK1m3p6njwp/KtI5mlEvuBQ0clQVcN0z/e4
         AxZ50Z4E4HuqkPq6VkcvVDwTuP4svPS4FSXek+xRGTySWO+6osT4w2KBL2h2ZFydwk3w
         RQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788632107; x=1789236907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Muroh2zxhm22hBlIZlViLWOTeT2Fy9zQxs2oZXSkuJ0=;
        b=llscqNfukb5BaYc0OFY/yTAg6Hk+A0IxudN/Of71B1+FCEKHlHwU/TzXfv3Ow/BQ/K
         U7k0pTUUOaRC/w1RyPnn4hZBUFZWdKZ5CruF3DRtYp9IXbVlA5jZhzVaULq9rcEtOevZ
         MkEw36ScPBW9gP3lPccEV2EBS8erYILhTlS9bt8vi0Rq38/7umIrsVSb6GFwUlV5muJ3
         mG/Z10++nBn52ildoYfguXrRrw2r+HwBgrz9Z1AsO1MpGfxUJYy3LYmpBMhVko0bIwKf
         Rfsgonx6jB98Fk+YeyPrdQTRX9Pd+s8wJU6UZrNoQd/RLLZp62QgxEORZgQIuEICudTJ
         eoXw==
X-Gm-Message-State: AFuF++nZxG5yo7HRjPPQngJNQ1sHd42JTLyUzkcMGtDSpW4kr2jenhK4
	sqY31q0tQPI1W2anCbTGWlN3MgRByLho16PHTfubWinNzt53CTvtLP3nVxgGJi9MbJ6gzTOFxP8
	0e5gkqEk2vJpex+vXV+524kzsEI4nqEbDGeIgQGC1Yri69earxi6C/Atm/OC3Gt9BmFlvgeiUOw
	==
X-Gm-Gg: AYBFou1GXCRrzMvEB0rk1Gdub93hrmCQh20VAYOrjetTG3yL6pbKHztTpIYB46XP7iL
	wVYwurr+u31BsOmxaZFiSPKprKUnBRezE4CU7RNtSZYm3eQ4j231JpnDBTNy1BJZtGdv1QE3cjF
	yslaKXBxSakCM4dFJtPAZDhX8RmhXdIdI57/eZ3dGkij8ORvET485Es3Cr8rvS9+gQ5nqFxkR7s
	1Pl0QMBRQTSkdG2py6s7xIIFGcc0n8Ky+f8zoug1MrHt+FQoF6jJRXgSDLbSaF3HSyNkT8C9C3S
	/ObMRXwYHtc2m44UIUcCN9VQppiI69wPh/nLKtE91aToyW3QOqeOv3SgbqlpgPONZV+lDzIgEY8
	IS6bNzPJphXYgrS5F9j1rHezuh3JtIxNe7G7e2j2wuomW6hRB2SSfk5YIbdOnlHy4adUEmggmtU
	YKmpMym/U3LxLpng==
X-Received: by 2002:a17:907:d2a:b0:c25:f7db:4bf0 with SMTP id a640c23a62f3a-c2610747c3emr470279266b.22.1788632107655;
        Sat, 05 Sep 2026 11:15:07 -0700 (PDT)
X-Received: by 2002:a17:907:d2a:b0:c25:f7db:4bf0 with SMTP id a640c23a62f3a-c2610747c3emr470278066b.22.1788632107309;
        Sat, 05 Sep 2026 11:15:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d52d149sm253614966b.28.2026.09.05.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:15:04 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: offload readdir reply fill from the mds connection worker
Date: Sat,  5 Sep 2026 18:15:03 +0000
Message-Id: <20260905181503.3454131-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902-b4-offload-readdir-reply-fill-v1-1-4b74fe27c841@clyso.com>
References: <20260902-b4-offload-readdir-reply-fill-v1-1-4b74fe27c841@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin.

  1. fs/ceph/mds_client.c:5539: send_mds_reconnect never drains in-flight fills
     Offloaded `handle_reply_fill()` never takes `s_mutex`.
     After clearing `s_fill_offload_enabled`,
     `wait_event(session->s_fill_wq,
     !atomic_read(&session->s_fill_inflight))` before
     `atomic_inc(&session->s_cap_gen)` and
     `ceph_iterate_session_caps()`, same as
     `cleanup_session_requests()`.
  2. fs/ceph/snap.c:1016: SNAP and QUOTA skip the fill fence
     `mds_dispatch()` still runs session messages in order on the
     worker, but the fill (including `ceph_update_snap_trace()` and
     `__ceph_update_quota()` from `ceph_fill_inode()`) now runs later
     on.
     Wait on `session->s_fill_wq` at the start of `ceph_handle_snap()`
     and `ceph_handle_quota()`, the same way `ceph_handle_caps()` does.

-- 
Alex Markuze

