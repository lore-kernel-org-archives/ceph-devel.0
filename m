Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68C358D27
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825795; cv=pass; b=UPDbF5Qs7A/bi0fgjOCHaZH3VYyQldYugs3ZLg78xEvZtOrz0DwSvSelL1WRYZ3qD5EZL+CefbAEmrKUogLj9gvMXFY+SlQbjWL5R8pb+RkWV19pdJfqphEDXkukBXBcvxzEO5Rk6H+M1O1K9RvytukKjCluNnfwid2Sd5vB6ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825795; c=relaxed/simple;
	bh=Qqa7plR3DgvMxHWqVtzzh9cdHeguMCRYeLiN/vCoUMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh5X9O+/DN5gK+xRI8JDEI30LWJQPpq5erEA5zf0MGrsNtjYA+m6tpVh8+hdxywrOlUf8vhrRdO8mB4pn9u2CcUW4r96Pzu95TACwEZrIm33HM76ITRzXDseOy5hihpRPJ56vtvoEM4JtcE2l37eWIJKBncSNyiR72V9qH6Qju8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=Tv/HyKRe; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="Tv/HyKRe"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1600d040e4so128568766b.1
        for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 03:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787825788; cv=none;
        d=google.com; s=arc-20260327;
        b=VoiZIqakxSggoRmZipieOw9DdXhayXECpDwdXZXmnOTR/rvFP598bBRRzp/0NNgTqh
         yJW3R0EaumSJBLAbW99NX8tTX4XF8kHE7PWleDenuup4Yci0amA32Djf3E4UQLUHpHQU
         H6Ad3ATdH0jZFf4R2i2b3ZA/s0z5ueVoond7P0fia2j6NC/08Sv3E/t6JgBxw6fYcVgg
         4bUTLJ/Js8/VpP6NxD/rYTw2/tAJDvLp8w2XjTcuxvh4VpDxVaJnNk6JfhOsEQ6I7VOQ
         1JxCTFY1UZHkSQN6GeOh19Grv2yNFOlxKOf4zyYlg8XnBgHsrk6Mb9yB/ZjL900Qf0XR
         e/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V/R9XdMzOE2Wo3EuNdZVeUYyBELBttwS5KAlv2sFGA8=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=FIXBsn9JTzPpHH+kZM5ScLid1+78oubGRd/F26Q4AEyAc25jdGcQ8Xyt5XC8LmL5gm
         y/yNl/u497MYnoMgYiwDyWLHPc8yG/ieNjN39q9inUONMZwYQ9X2cHv9HbH2SnruliV4
         P7//WQ7Lsd8kN02n0KK64PakEsnBZKHf7ncYasHyOhjzZb4LAcSVWUYNa6kVxvnQnhDN
         63XNp/qNVQUU2CBxbsbjta3LcetfzY/f6Z68yxEPpLCkRE+VYfsbDLx0j8uHOiPUQuCE
         lkp4ShBK5v9zyHltq/OL0EpM5Kwr2pU4z7ofBfZ60bgdyRXi2otJWewQtHZcX3ZwY2DX
         SE8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1787825788; x=1788430588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/R9XdMzOE2Wo3EuNdZVeUYyBELBttwS5KAlv2sFGA8=;
        b=Tv/HyKReTymCcWz1W0cvckj5rzDaaoHqkF7OEMvyMgqYlN3pA/lDn+XYAlitNZWB0T
         2wPH0awXnaeP8BPbni8jHdeNvID9NZKRGti/ejOWsbgjQIzdH5lMMuG+9ClROiyojqcY
         g0Is1aii4x4fy0expf1gkOdvxhOd1he+XGIgsDpdNPGeUHyexKYQCXI5N0mFhbrC51vB
         a3kZj713l2agUj/0a9fO9ZroyeZ0vonLJUbqdYXe9r1chOZe43oTGFpDUMQMyes5/83c
         kTk9PNJbCrYrVLSOz6WlRc0nyKwvHKtvTcYi031EuYvoLIySsHg1LEy7fH7RH3eIbuZc
         Lzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787825788; x=1788430588;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/R9XdMzOE2Wo3EuNdZVeUYyBELBttwS5KAlv2sFGA8=;
        b=QWylnjB+ML1YOXjW//OadNWp/xsRZWV58godsxzJst3lv6EGkmVOeiEo6NYtq/Ms0L
         VA+xhhttEwyaxS1EQ9/oaIGv5VHjQ9veIwoA+nYFnp7DwmWJV6um/O3m0feLRY8yxLJ+
         a916OVMrOFvG1YdUUFJQxXPbjsI3bpUpIDAqg2EeN1miUDXBaowgjcQAjrFvcoLx0nVv
         kQy1m+7l+xwceoX3PD8X4ifErg9XMn7KFqO39o+LDhJC4Rkoo0RuKO7votNcGx08tbv8
         N2w5G/AqRMRFLQ6aqLJ0rdxkFMSgl3rMe1Ri97UQLjk8o+6dH3O8/iDM6/HFY66isitV
         T4kg==
X-Gm-Message-State: AFuF++lrJmTFX0zHBpcINih1/UM368mpxyAgrY2GkfGlTJdkh0tPmwJ1
	Q7Wm1jyYkgU5uBnBw3RR9ilZzMxp48lQC27xbPqhVCqzCKeXUDbtAHsHDBtYq6oA/LGVz/jl5sb
	LuCfvKRUsVEt/nciXZhdyQPe7QpZUlfH3mfPQKAehU2AickOgWMGHtyw=
X-Gm-Gg: AR+sD128eFvBSfeaeFvd+uHU5QAF/rHsoc0q7JUwlpeJz+Buu5LYP9Cn6CsmCPXFPhf
	ojl3yYiUoO82onK40cpU/UXQmCKC/v5GhMDYNxOQHsJH5mRPw6+yHr2ML3+alKXvARHD2RvwSlo
	Kr9Z6kFmoXlEyjz5MLR77k8Zj1XBsjOwdUuRxjB3/QzxhKa5/OtnTcq3rJQFqD2G3ltXzFF1RnS
	F8h6CBJRr5Z7611UYrnLz/uu0pr9mr1oxW5VjOyNMF3V6UMJl+WAk6UTucCwtQHbxkqENSrz2n5
	xGjgPKnwN5Cz66UiJTXs1GBDS4Ak++p6LAFZvXHVVclM5w==
X-Received: by 2002:a17:907:1c03:b0:c20:7166:cc16 with SMTP id
 a640c23a62f3a-c253611b00dmr397245066b.15.1787825787893; Thu, 27 Aug 2026
 03:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-lazyio-v5-0-65118679d6fa@clyso.com> <20260827092208.2741445-1-amarkuze@redhat.com>
In-Reply-To: <20260827092208.2741445-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 27 Aug 2026 03:16:16 -0700
X-Gm-Features: AcwNN1UU7e3RKg-5zrPxFtAFGTMkuxQN9Da6NFnwTpZoDtEOU09RhVhiHZHUK80
Message-ID: <CAOJNxRJn5-EnU5UyWN4AUxu3gjSDimb7FF115uk6YBF_1SwZ1A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] ceph: add 'lazyio' mount option to kclient
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Good catches. You are right.

I will fix the bit collision and the -EBUSY handling in
ceph_filemap_fault, then respin as v6 rebased on the current testing
branch.

Thanks
- Xiubo

On Thu, 27 Aug 2026 at 02:22, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK. Please send a v6 rebased on current testing. Patch 1 looks
> fine; the series still cannot go in as-is.
>
>   1. fs/ceph/super.h: CEPH_MOUNT_OPT_LAZYIO (1<<18) collides with NEARFULL_SYNC
>      nearfull_sync is in testing now, using bit 18.
>      v5 still defines CEPH_MOUNT_OPT_LAZYIO as (1<<18), so 2/2 does not
>      apply (conflicts in super.h and super.c). Use (1<<19).
>   2. fs/ceph/addr.c: ceph_filemap_fault() ignores -EBUSY from invalidate
>      The new non-lazy fault path calls invalidate_inode_pages2_range()
>      and ignores the return. That helper returns -EBUSY for a dirty
>      folio (ceph has no launder_folio). After CACHE is revoked the
>      page cache is only kept for LAZYIO, which is the state this check
>      is meant to catch, and filemap_fault() still maps it into a
>      non-lazy VMA.
>      If invalidate returns -EBUSY, do not call filemap_fault(). Flush
>      the range, retry the invalidate, and only then re-read.
>
> --
> Alex Markuze
>
