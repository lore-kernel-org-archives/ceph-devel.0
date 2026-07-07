Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086753D25CC
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417541; cv=none; b=ZZmXyL/zfyLmLDMnMahMWMACy8Ezbo+CFs20oZyXeuKWEFJrmwCrmuQBwWNxgFq2OCdGZOzPaKSU9v5RSoGTLCtSr5y/zGkrYV6I37ZIrwb3GT3wml/F4qpVW2DcumgBDIiN3dTPOUYspDlAhwVhv1qF1+xoGxEjoD8XqALYmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417541; c=relaxed/simple;
	bh=e9z0JeL6EP//fuQA+NcjSIl/ZOP2vuiMeaUWgr0/3Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7/d1tvlg9KNs5xYuzOovMTCTEzhA8soI8aDRITcgxqQ3Ws0eyO+ibv/8qJTDqxGRjivv31PWJvABNOU0kzwVKmMDam4tiTY78pIvqUeGi9LINE1eWCUkphPZ1qP77I5jrAeDuzdiU2jxqRrv9FF5zMBYwENDsNIUIukqURnOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzVJqqR0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/yHSDGk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzVJqqR0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/yHSDGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6svm4gRPpluBJqsnLenGToQGOxIzXIFCS2d5U4h9rk=;
	b=KzVJqqR0BE2WxCdBvZIg2TQzVn0dVgH8bVsoFejdFLo7eR3K5YVm5fJjhyBGq+/Bo82C90
	vwU+iW95W1JbS4FTheOWer72bZNoBE5S1KCv6YyhFOohQM0paHxrhqwzblrxgxFWORf6KC
	FOw0a52N87ZDf0wDa7+6j25UNvR9DKw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-zKaGESU3PkONqcTRLHbcOw-1; Tue, 07 Jul 2026 05:45:37 -0400
X-MC-Unique: zKaGESU3PkONqcTRLHbcOw-1
X-Mimecast-MFC-AGG-ID: zKaGESU3PkONqcTRLHbcOw_1783417537
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0f0a0760so79170521cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783417537; x=1784022337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r6svm4gRPpluBJqsnLenGToQGOxIzXIFCS2d5U4h9rk=;
        b=W/yHSDGkmSoX+C9hTqnq5Hi8A3c8OsYO/QmzJRbv8kBKet/P2z0u6de2M56ZrHoHn3
         tN7xpx5viM7ZVV83m1khbqr+7FyZ6+amuBO9MY2pwATiG58xzB+ICrV8Qwdkhm+PU59e
         QRpmjDKs4n6UiKWCvs0f37TbphkMYM33Rzej0g8VFavb8cmInuGmWq7hadn2N4ibd/VB
         cgDWes3eABP1ApYIKH63eyyr246fsfE1AsmU0/P9kxCY4AUEo8jSuS3E9mtSB5ojf50Q
         J0sR9Gn/6oyrzxxAePh5cbigXPRt+ckNfAbcEA1cwfmYVlWpCgrMvUiAeyEsi0AhD0sG
         RIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783417537; x=1784022337;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6svm4gRPpluBJqsnLenGToQGOxIzXIFCS2d5U4h9rk=;
        b=Lk3HW9NJtb8VcnfaXf/E0aGyiAr4HvqvHXwNkInfObWmRyDCjICRmNFyNyqTipaggD
         0hRSkYS8MI1gPuew23fUru7XLQJfpANHikIucMt7ARAvLPwJ3siqwwOD87eHII1dSKd4
         4ONR6F6+x7CktXif8jDhhpkDlIHA44WRJeifO2+x/gORPTcqJPyOLcQpu52Z2YF4mOWC
         16Tr8t5nihLDNvSMy7KHXnw9l8gbpoIzsroChPhfr/OLq8FFxdXLAQjgHU09Zz+CnYAF
         qJnXo2JLv4h/YLfUz7899U/ldIFYPn41cUwpktTNbQLu/Quo7cerk5J+eV0+yl7UKE/7
         Gr4w==
X-Gm-Message-State: AOJu0YxwEOeJMQdQJplperIha/FdmB65nujcKWa6KLhFON+BlNwQmCX7
	HJNPB51+YU0/n3aJ8ZxZ7yl8j54b81sgA2xgzG9VahT/d9zfUshOF/gBMZA06vogpEuGUFVDytg
	7W/4hCNsyn6m9S7sFY+TQgrsXYcR9BSkxrr9cc4vWgs6K8C/nezKCIAOTJfkHs/8af65WuEZG+A
	==
X-Gm-Gg: AfdE7cnZm+1k/VBqRrZgd9AuyOmSDF3eDLL7Dfrn1emljvJKC2o4FmlxE6w5FbXpaha
	zWSAVV3d2/2jeSb5zNaFEoPWRZq+pHAJAyyEbRpdMpHRmJzJ4050WJNvLUPO4jy85ldiQR3v4wc
	2duXC86eN1G2rJ/MCd/yuoq08mO8yke/MsKn6a/VJyO5B68JdzNYIVX/uiuZn9j463I1rIJpD+S
	KSO/2DEinynmKEdxP22L6vEYf12RIVOhiPc+It8z2GVyLqq6ngpkB8aebhdm5sU6DwDDEyin61M
	yKYgfjN0cLsW9rVF4LPdz9ZBMNQnPuixQZRKwcuRsSIOuTqyfsUHPowSmg40TSe57oVgs8UYkbl
	avBSL4FQf5uRaGaFfi9LGysI9c5FVFfkjgf9JbxxTtj4t
X-Received: by 2002:ac8:5a04:0:b0:51a:8c9a:8fb2 with SMTP id d75a77b69052e-51c748dfd57mr46474141cf.67.1783417536870;
        Tue, 07 Jul 2026 02:45:36 -0700 (PDT)
X-Received: by 2002:ac8:5a04:0:b0:51a:8c9a:8fb2 with SMTP id d75a77b69052e-51c748dfd57mr46474031cf.67.1783417536474;
        Tue, 07 Jul 2026 02:45:36 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41e084e8sm106627381cf.28.2026.07.07.02.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:45:36 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: raphael.zimmer@tu-ilmenau.de
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] libceph: Reject osdmaps advertising pools of unsupported types
Date: Tue,  7 Jul 2026 09:45:33 +0000
Message-Id: <20260707094533.2192497-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707082135.3901920-1-raphael.zimmer@tu-ilmenau.de>
References: <20260707082135.3901920-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Raphael,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] net/ceph/osdmap.c:1372: Memory leak: erase_pg_pool doesn't free the pool
     `erase_pg_pool(&map->pg_pools, pi)` removes `pi` from the rbtree
     but doesn't free `pi->name` or `pi` itself. The node is orphaned —
     `ceph_osdmap_destroy` won't find it, and nothing else holds a
     reference.
     Suggested fix: Use `__remove_pg_pool(&map->pg_pools, pi)` instead,
     which calls `erase_pg_pool` then `kfree(pi->name)` and `kfree(pi)`
     — exactly the pattern at line 2059 for old pool removal.
  2. [nit] net/ceph/osdmap.c:823: Missing newline in pr_warn_ratelimited
     Format string is missing trailing `\n`. Every other `pr_warn` in
     this function ends with one (lines 810, 814).
     Suggested fix: `pr_warn_ratelimited("got unsupported pool type
     %u\n", pi->type)`

erase_pg_pool leaks the pool struct; use __remove_pg_pool instead. Also missing \n in pr_warn_ratelimited.


-- 
Alex Markuze

