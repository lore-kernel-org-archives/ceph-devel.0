Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E241DEC8
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576108; cv=none; b=kGrgZ9bBSyG/j1i47WOxqoQAYZUOzNqwKISSqWE/ygJh9XZYcCbgy6uTJqXrDfIjnDFDIb4gooE35hwvtTPbh50SLTr1xLaixkEWrP+BZDr/nKp4chqlgLkEoUM7jWC+YhOyFlo9tXxWY6wROP189nHT4b0LJBydh0ZyX+WncpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576108; c=relaxed/simple;
	bh=r1WKVVEP+nkSPcOxDIDA+HSsjghPv4XxVceBKtV2Nvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGTDVqavQyrWX6ieAcJ+dAkBOezm7Xh9EQgTBGOl8/WnB4VrMnju69Sy+Tx+JnCq5VmWH5Z3x4aTxJ55YoglCBGs8rW5P6Mw0k2hSbEpFYmtTbNpPpJEBwemHShlWaamWDxAHLqYdcHsSCIkndrCMwzico+Syq7jSML/A40pSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAfrf1/M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZDOYxm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAfrf1/M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZDOYxm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787576105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxO9Dd4y/rFt3RfUj5uX6O9iLJHcBwInL23r9ZaVyh4=;
	b=NAfrf1/MsEGVUuUcGlh4fCaeBZNQLCJJK1ceCVYYGowBIso7OoeUtyX0pDoT/0GUpzNG0a
	zVklmSfmLvGk1jN2umtVqGN1MMmPsvpoSDfSVBqmEBuzH4gPW7sMmbqeejOvXnth2qss1D
	V5MJ8GSLyF017WlUeTupmJHUucoQvlM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-tfuuSZ2fO8e_p8l_C-6XbA-1; Mon, 24 Aug 2026 08:55:04 -0400
X-MC-Unique: tfuuSZ2fO8e_p8l_C-6XbA-1
X-Mimecast-MFC-AGG-ID: tfuuSZ2fO8e_p8l_C-6XbA_1787576104
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so417172085a.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787576104; x=1788180904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxO9Dd4y/rFt3RfUj5uX6O9iLJHcBwInL23r9ZaVyh4=;
        b=bZDOYxm24dVD8Uh2Qm0WQPTgVRbDxPWGz3fsNe7FdpJKa5f4lL9lu/wfKi/0UYEEXz
         SnXHwsO6xGM8+AGfr5FJM1A7nJkbzQyQpbIe59fG4KW2FNu/FIvO+vUPeVi6muaW41YW
         dKYihd8wTA1S9Pf0NWu2811/98BLXS+FahpHivnfc8R0ALXuudzaCVRktFcVlTGFLZFg
         q4FrluVYqp47iu6RvsjtM9QKQ0S71ZI/37sP89J2pHI4tV+uctIQkXOx+ekn+h8t78Sp
         qVlz+K1ud7+BFiInZvsdf+YR9kzEfxLLnKFGaviAVMWY1Hd04fikOBS/LR+T2yKacGGc
         RcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576104; x=1788180904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxO9Dd4y/rFt3RfUj5uX6O9iLJHcBwInL23r9ZaVyh4=;
        b=OCwpKfAPnct85xSaPrLpFTXAEthbvsWZbDiVRuqe7d77a/U17cN74qJEHJYryQrLFz
         Y7WkB1SWIeGO35ekj2BYghkXYU74aIqwz9hsl8Ka8b7DKDZAgTKghGRRtOLc0g4nUDyr
         eHf4eJo+lzfC1V2y4cJ3AM+nrW1szKkBdahpPKr6jBVzI56/WDoTN6Qy0+qwa3NQgAKp
         dOpt2p9W1kF5qEvKiB9I+Nt4ZTn3wIOJdOPoQhcIdTYJDmEI7lCL1LyhuKycSjwaTjGW
         iHAQeaL6TUWtJaM6ZUdAdHwHIuG1hXqPt50Ti1w4lrE+ediHLHNbtG8nS3bftdl+7H9g
         n2Dw==
X-Gm-Message-State: AFuF++klphMYIVppo7ep9Ctv/pECXbGBUJ4fhtIOO5FRR03G3PgmUPVy
	dcQKBvtHoV8a0A3ksuaaPaC3kv3TqYyrmJOlyHqYCgk33FhuJT6XsyyoWq3MVrDFNvsbT2omICi
	pRMI8GEaaYq10KWlqIcohZkb/g2CMS9yREcEeGoXZ9k8aXzQ0u+Cb3h095/GFPtqK+hzSI4QqLA
	==
X-Gm-Gg: AR+sD13M7cBiy2tTFzQr03iuOi7O/IY8pUBQM/T89RUHjy7ggBjqZxrsnGucW42lUcN
	n/zPuTpWcZvgfSDT5BuiPhCA+N5WYkfyfMax/lDKm9mqPbb2sBFjY6d71LpKLguv8FCsJejfz5p
	e/Tk/Wqcz9IDX9u2eIMTQO0yBX3VfLkz+naHongfHyqCLEYJzGOj9+PRDJGSwulDFj9JqRHSag0
	MTwTOUXpmA+95YJ4Ycy07g3puK0vdM+lKv2FOAKGUqcAg0MKMnL5+GkNy1dY6NEDhY4m7XtCsmS
	4IhUekwiaLSqOAmMgK3gmE9V2fKUdsoRuwa2SL3cW3sw0YNSu69UTF3sY3goQecGF9lnsdC18Mi
	4tq4GUHpTmiBVkKfzAmgJEEMY+9T6QUtCKg==
X-Received: by 2002:a05:620a:404a:b0:936:cd76:4d4b with SMTP id af79cd13be357-937395d4298mr2201321885a.42.1787576103705;
        Mon, 24 Aug 2026 05:55:03 -0700 (PDT)
X-Received: by 2002:a05:620a:404a:b0:936:cd76:4d4b with SMTP id af79cd13be357-937395d4298mr2201315285a.42.1787576103270;
        Mon, 24 Aug 2026 05:55:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749da9ba1sm491395085a.33.2026.08.24.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:55:02 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4,01/12] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Mon, 24 Aug 2026 12:55:00 +0000
Message-Id: <20260824125500.2520017-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818181144.3541770-2-max.kellermann@ionos.com>
References: <20260818181144.3541770-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] include/linux/ceph/ceph_fs.h:72: Truncates RBD data-pool IDs via shared ceph_file_layout
     Patch 03/12 shrinks `ceph_file_layout.pool_id` from `s64` to `u32`
     because the MDS wire field is `__le32`. That struct is shared with
     RBD. `rbd_init_layout()` assigns `spec->pool_id` (`u64`) or
     `header.data_pool_id` (`s64`, decoded from `__le64`) into the
     now-`u32` field with no range check, and both
     `__rbd_obj_add_osd_request()` and `osd_client.c` copy it to
     `req->r_base_oloc.pool`. A data-pool id above `U32_MAX` truncates
     and I/O can go to the wrong pool. Parent setup already rejects `>
     U32_MAX`; the main image path does not. Ilya widened this field in
     2016 so RBD would not be stuck at 32 bits. v3 already flagged this;
     v4 only fixed `ceph_d_prune()` and the 32-bit unused-`vino` build
     break.
     Suggested fix: Keep `pool_id` 64-bit in the shared layout, or give
     CephFS its own MDS-facing type. If you narrow the shared field,
     reject out-of-range ids on every RBD write of `layout.pool_id`
     before shrinking.
  2. [nit] fs/ceph/super.h: Multi-line comment style in patch 08
     The comment uses space-indented continuation lines instead of ` *
     `-prefixed block comment style.
     Suggested fix: Use the usual kernel block-comment form.
  3. [nit] patch 01 commit message: Questionable Fixes: tag in patch 01
     Removing a field that was never used is dead-code cleanup, not a
     behavioral fix. `Fixes:` will pull this into stable for no reason.
     Suggested fix: Drop the `Fixes:` tag.

v4 fixed d_prune and 32-bit Werror; shared pool_id u32 still truncates RBD 64-bit OSD pool IDs.


-- 
Alex Markuze

