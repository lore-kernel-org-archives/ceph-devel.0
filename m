Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF7231836
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623200; cv=none; b=Gyx60nAwTQUFBb3C6W7aCmbdOh6XirxWXlIw7h/E+hFmo3UNqDNID9KMzaw35H5WJY/I6Oc5BM3G/sB1GbjIcu3f2g3lIdozh9MWm28kjjxC5i84wO/TyWyXHN5T4rCsX7C2fsyoZ5V4qSsvQTQrCnjQRuqagwu4nViXKJy9vjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623200; c=relaxed/simple;
	bh=xNk3pk/BOj5d/OyLBnR3qhLyGSwRXzYsl5pcbyymzp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBDMs2FnBBVbRajLQMiqzd41IF/LLsOSllf66abGcQALSo80wtN+JU5ADcuziowUo1ya7wnqMr98LjzLJLIYfYJFEVuAoyTQQDTC3j8LAj8TDXsU1euV4altlm/tlwvCcX2qcsNuixccgPcMXfXbvUDiZ6Nby5xgqzHuciCNfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUb9UGJU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxBc5PLc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUb9UGJU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxBc5PLc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788623197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0CDuJEczfjojyDJGBLEWGAC+f23ncRM9slRESLpvgg=;
	b=aUb9UGJUf31fUQrj/NHNsNmnmzGsXrGe2lqz8VAXRuXU6z5bG4pEqR/5Px7wsWho0tImac
	SltbjHfI+cbRI5jJCF2KMK5b/uiLR4t2SKDxW3X5osKeFkSJhjlzVA6rbSLS9eg1UlXCf/
	Jj5LtLTJkY6Dsw/oWNrUpZfRgY5xhJI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-OsQLZWO_P-OBnDhOoUtRaw-1; Sat, 05 Sep 2026 11:46:36 -0400
X-MC-Unique: OsQLZWO_P-OBnDhOoUtRaw-1
X-Mimecast-MFC-AGG-ID: OsQLZWO_P-OBnDhOoUtRaw_1788623195
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c251c140b41so133702566b.3
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788623195; x=1789227995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0CDuJEczfjojyDJGBLEWGAC+f23ncRM9slRESLpvgg=;
        b=BxBc5PLcciBN/wEwS8w1/KZX8eZPfTK2hNZlUoaFdix8S9D5yLIoJzEdheMQekHXKG
         rwIq4WFvDwZzIx2Qc3QHlS9T4YtkKKV8ssvKwE4IqRcHYmrBOBVaySG77LCTOGV02teO
         9rylQ+obvJy4kGTltvrQ789FgP0+2k4WHF2R+Dc2tfGzNhwRhWX10HNMOh0HicncgVAl
         6X5DPfUI2xWqoioU0OGZxZFfgiYdhlWELnxvKiilVdn7nc2iFeafNzZrEpbKlihU9sDQ
         0LDP7LDgyoZCTH4oSRjdl0uKUeHHoWStOlcz1n5BUl3tsqh7O3m1Qq80NRmdRDBl0rM0
         xfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623195; x=1789227995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0CDuJEczfjojyDJGBLEWGAC+f23ncRM9slRESLpvgg=;
        b=oYPaMthRIBZoTL6ANfUjnLQyVzPw9MuwReCEqCBQDPhoqkT5J8BtJVZzwMPzeyj7on
         U+xJRrk5eikWlQpZ215ShEMjyM9TqKyOIlFUfFXW0zo6zGieV+btZHauC+dL0vWumu3h
         jDyn3XQKFfGQOtIkpEfv+3p0X7HQ3tkTWGhliIS0Sg9JI46py85XPSe6fwoS/AuYK8nr
         oRRf64lMOjYB14Bwyx9NIfKQOdIPix5+s+JOH61HY5/U5ubjUOoWGQdR+eJqOdKJRktz
         w5J+MtHcTD4P7B3M3hUtQW3yBa//xnXo7HLPiVdU22+tPbzPyc6mUht/sFaxwIvR+FCe
         uVFw==
X-Gm-Message-State: AFuF++lqKkHowUGLqYRY+YL3uiVrL62fNqEor1RkRSPKWBmKpB93v015
	Xb9VGDt0sPkyGDSDJRkLhGw7hyDzSoxmxHy+45ZHDNGc0LS4GwB4weEeXfnoGv9CUuZ3Y4x+EjL
	EhOc4xaT+UL/pMKbb3oVQt85h4m+6O06Kl3eag6RChdc28d790WRxsVZHt8fJkBY=
X-Gm-Gg: AYBFou22DSiNGNPmT7YDJYdkxrH85vsoKuH6v8wAXLe/I3SSHAerUtDEkeCYfHlc3U0
	qn6b+ja96cnKChJdX9Ow6wInjxwM+NjNOCJV06HfYPC0YKqsik3R8vEN+/aOWTqrsw/1G2lEJzr
	l6JyMb6sxTb8SawkpxWyzuUo0Bs75HMMCKYGm1eY55yrU0KQ4SkFDELHz2hW+RQoKizkXYO4fbg
	/1dsS14Z3ToUMNs8Yarwg33NQYAcDKVUaxT1R7Qabu5UHPvUE2jjsEmkm1L3mnfkjSGLYfJEg0Q
	+pnYH4DkRejptX4Xz0WF6qkGg7uxj9EDzOC6paP6+cXu6r7n8kfQjPywkouB4xHVe5y56oKv4m0
	wHLYloKGiEh9TKFUnSywHsr2IykQZj5+cArYaRS0bl5SIiu9gazszkUwykRs44i5KMv3du7Lbyv
	SrJPU5x3cX5CMDqQ==
X-Received: by 2002:a17:907:60cb:b0:c25:848a:4a8d with SMTP id a640c23a62f3a-c260c6696b6mr497555866b.5.1788623195086;
        Sat, 05 Sep 2026 08:46:35 -0700 (PDT)
X-Received: by 2002:a17:907:60cb:b0:c25:848a:4a8d with SMTP id a640c23a62f3a-c260c6696b6mr497555166b.5.1788623194703;
        Sat, 05 Sep 2026 08:46:34 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5b371esm242803366b.54.2026.09.05.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:46:33 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2,2/2] ceph: don't wait forever for undrainable dirty refs in vmtruncate
Date: Sat,  5 Sep 2026 15:46:32 +0000
Message-Id: <20260905154632.3446719-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829-b4-ceph-fix-null-oldest-snapc-new-v2-2-71fb4aa49968@clyso.com>
References: <20260829-b4-ceph-fix-null-oldest-snapc-new-v2-2-71fb4aa49968@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin.

  1. fs/ceph/inode.c:2357: Skip-flush fires while live cap_snaps still have dirty pages
     Xiubo, `i_wrbuffer_ref - i_wrbuffer_ref_head > snap_dirty` only
     proves some orphaned refs exist.
     Skip only when there is nothing drainable, i.e. `snap_dirty == 0`
     under the existing `i_wrbuffer_ref_head < i_wrbuffer_ref` guard.
     If `snap_dirty > 0`, keep the flush and retry.

-- 
Alex Markuze

