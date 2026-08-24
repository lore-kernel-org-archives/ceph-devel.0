Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFE248F72
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557068; cv=none; b=ntnGld4Trz4QuxPuSShtklgy3mYojDamdXIeSD+GVb26AzkaV9p+CFjuXcl4mp9xSlwP0t33sBHzJJsyThrKKl8dRCT1d8lSaS7hNhoMO7NEeOw9fZBq0QYqqjFDRjoWTgSXgf1CaeqR1AvX2PHdlIUqPLxJLTXTI25BBDobkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557068; c=relaxed/simple;
	bh=eH/CRn8pTriAv/xw+tni085AJUEM/S6XKpx6nMCDA+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tp6XU+Ia+o8KOd2VMAvCoWvcYSfnwGIUzlKCaCpFPZL5wRe+CBDQVS2WEU8V3tmVa8vhqVdS9cLIuB3B8WJQHiJEHNVyPP5i7o06J8W+82k54y5DrUz7iveDYLSu4KpEe7reh2lIiKJT3KXP3pRHRvcHZ6pwMrFtlGJ/IEDPz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kn1cN2Lm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBGhEOLC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kn1cN2Lm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBGhEOLC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787557065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFNot5fCY/DCnFogO52jCXzbABO9SDwb0K+zyyvI+CQ=;
	b=Kn1cN2LmsQOCZk9snGWEvY8BVgTB0sd6M/TqFd/Pr0vDpYvO2VCKueFqct8NkDA6bN+sLK
	1cBh+X3gaFxE7JtXkxh41T1mrBnmgMdESGlrBTkSLHOr9D2ARFIghBEYM6t9wWRvaGRq8U
	EI9d5n8LjISwef/9bya4l1nOvMUJYpg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-wN3wVeWkOaWUahD8zY99Sg-1; Mon, 24 Aug 2026 03:37:44 -0400
X-MC-Unique: wN3wVeWkOaWUahD8zY99Sg-1
X-Mimecast-MFC-AGG-ID: wN3wVeWkOaWUahD8zY99Sg_1787557064
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so554132985a.0
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787557063; x=1788161863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UFNot5fCY/DCnFogO52jCXzbABO9SDwb0K+zyyvI+CQ=;
        b=aBGhEOLCT+XnLb9bTzZhbwKLyzZaulS6hv2LaE7fDSX6n16BTuniIzykCrUGuhelq7
         stYgjCPhUrzU1RyYfxYBS39yaPHkk54BZngkRRXJWE1PJdEFW2oqelar2IbLGl/BPkVv
         DFfsM9msmUlJQLIgsntztl7knfYoNGGn20OG9hDW3ixr8s/cRzKvVMAu2YjgBa+7Y1Nv
         pRlqibcrgtxMZ6xdCLc97vajIqzV3oCMRaepQ0A8X4vcRrDfwMW8baNAiK+HABfJTvWD
         qUVaqGMOiIanmQZQ6TpyD/YWi01Ms3YP+srSzGsfVpUneoCL9MD2KSCvN51eaLIkP8kJ
         VZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787557063; x=1788161863;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFNot5fCY/DCnFogO52jCXzbABO9SDwb0K+zyyvI+CQ=;
        b=Z8fdaFbn5P8m7VnqdZP66X2fxfx1M9drqVJk3jkUrZx3Ie4YQC/CMum6+ADniQV4sJ
         LdrD6mAZim4/RjWiUM7urg6Pcefl0MKcSNO+eA5UYzpZ0IVqCTWgzd92ym82gR+4Hry5
         vhLlciPQWCB613w+eSr8RBMuXVgQhfen7ppIkwXfZzDLgAZfiDh5DtTcW8hp8AhHo6Oj
         +VZbBwlksb5qUfikvNo+z5pUQ9gD8fcr7FZ6Vx5XFrxQ0zGKVfmRj4m49LTsrGpoPsv9
         lUigNMfqsRwZQa8CXx9AvmdmlP0/0BeAb5mXx6fyJgM902pt7MMbUv+/FST2Qi52fjkN
         eJxw==
X-Gm-Message-State: AFuF++lpq+Na35JIYHH/I9mr9sehb4UeaKylsInqetsCNXe3190d7C9B
	6q88SJhA2YPJ/q1lAX07WbRKrwihb4OrEzZ3MdWOtFXDNELbHHywHgS6qsJd7KsTjuViRejCDwB
	G+toXBI0HUic/evphrmCmy7d+FhSiG2mhln0Asrnj/AZ1ykb71np2C1Yrqckqc/wUUyei+7WAow
	==
X-Gm-Gg: AR+sD12zEH7CWZahR7MtVHJnvUx7xl12X9k75Nq5wUMniN7uXNGT6jbE2ZAVQTEYG6I
	A+BmTbsbmQ4Y0XdN1slbLVcE9tL+gyqTWjS692NsZAINLPaa6atS5HHobcoBwtPVkgTxVmckNjs
	IINVDhvQ/3wYa7cnrzu2C8WTrjgeQFY/QheBUJ4znU0BnDMRkc8vTEkaEL72fd1Djg8NWY+1Fpp
	+494ZipeLaRw4rVsTPL3rsET8SP89yfY6akXuNBfGfbWvv0Dyhi0df5afZ4g0I3NJlRz+xGzlR8
	WBsdTpt4yjM2Uof5lj7F7rWk/i8seDPDybrEJ7UY7qzINmbRHfz3paZ5UPTWhgLEOfbX/nmJON3
	Knq8R1oVJPJpxXYQZ+ziZpT9pkKOMm2bvyQ==
X-Received: by 2002:a05:620a:4722:b0:936:583a:dd75 with SMTP id af79cd13be357-93739479b86mr2111555285a.17.1787557063593;
        Mon, 24 Aug 2026 00:37:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4722:b0:936:583a:dd75 with SMTP id af79cd13be357-93739479b86mr2111553785a.17.1787557063092;
        Mon, 24 Aug 2026 00:37:43 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749abe86esm443915585a.4.2026.08.24.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:37:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: keep dentry in cache when inode still holds caps
Date: Mon, 24 Aug 2026 07:37:40 +0000
Message-Id: <20260824073740.2510594-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821-b4-b4-ceph-dentry-caps-v1-1-ff9b77511c97@clyso.com>
References: <20260821-b4-b4-ceph-dentry-caps-v1-1-ff9b77511c97@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. fs/ceph/dir.c:2105: Expired names stay hashed and still feed MDS cap-auth
     Xiubo, `ceph_d_delete()` used to unhash an unused dentry once the
     dentry lease and dir lease were gone. That is what kept a dead name
     from remaining a hashed alias. This patch keeps that dentry solely
     because `i_caps` is non-empty, and the commit says that is safe
     because `ceph_d_revalidate()` will check the name on the next
     lookup. Lookup does; several other paths do not. `ceph_open()` and
     `__ceph_setattr()` call `d_find_alias()` and pass that pathname to
     `ceph_mds_check_access()` (`fs/ceph/file.c:427`,
     `fs/ceph/inode.c:2593`). `d_find_alias()` returns an arbitrary
     hashed alias and never revalidates. After a remote rename, the MDS
     will not revoke a lease that already expired, so the retained alias
     can still be the old name while the caller is operating through a
     new valid path. `-EACCES` comes back immediately and the MDS never
     sees the real path; the other way around, a stale still-allowed
     path can let a local-cap open or setattr skip the MDS for a name
     that path-restricted auth caps would have denied. The leftover
     hashed name is also what `d_obtain_alias()` returns for NFS
     filehandle conversion.
     Suggested fix: Do not keep an unused dentry once its name is
     untrusted. If the goal is to preserve the page cache, pin the inode
     some other way (or stop using `inode_just_drop` while caps/pages
     remain) so the stale name can still be unhashed. If the dentry is
     kept, the cap-auth callers need to use the dentry from the
     operation (`file->f_path.dentry`, the setattr dentry, etc.) rather
     than `d_find_alias()`.
  2. fs/ceph/caps.c:2131: Delayed release does not turn these into ordinary cached dentries
     The commit says extra retention is bounded by
     `caps_wanted_delay_max` (60s) via `ceph_check_delayed_caps()`,
     after which the dentry is just an ordinary cached dentry. That is
     not how this check works. `__ceph_is_any_real_caps()` is
     `!RB_EMPTY_ROOT(&ci->i_caps)`. `ceph_check_caps()` never removes
     that last cap from a still-cached inode; `retain` always includes
     `CEPH_CAP_PIN` and, for a closed linked inode,
     `CEPH_CAP_ANY_SHARED` plus `CEPH_CAP_FILE_CACHE` while
     `i_data.nrpages` is non-zero. After the delay window, `i_caps` is
     still non-empty and `ceph_d_delete()` still returns 0.
     `ceph_trim_dentries()` then cannot drop these either, because it
     goes through `dput` → `->d_delete()`. The dentry sticks until the
     shrinker or MDS `d_prune_aliases()` trim, while still holding caps.
     Suggested fix: Drop the 60s bound from the commit message, or
     change the keep condition so it can actually become false after
     delayed release. If the intent is "keep until reclaim/MDS trim",
     say that — but then the hashed stale-name problem above still needs
     a fix.

NEEDS_WORK: keeping expired names hashed breaks d_find_alias cap-auth, and the 60s delayed-release bound is not real.


-- 
Alex Markuze

