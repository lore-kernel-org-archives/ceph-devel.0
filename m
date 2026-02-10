Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F3132E68F
	for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750675; cv=none; b=RDxGU16rLM51QD4YviZSm4zphRKGM3W8sjFaCIe4LO5OISzhD5awy5i7+Q/YCOtVBYmbtDxzHMA6KdEGBmr2mGAIM6JXouo+iTgLH3rQsSuFfyEnNYnDeoH6tf+Ob8fWABLzYtv98FMdN/4nKtbW8ChoD0rgasUQ3NJmYjwuep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750675; c=relaxed/simple;
	bh=LNepzJNE9SpWEJXOZCqzpCs5MJEzTXNt49WjAzgCuY0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZecS92YzaqFaOQkoXN3vNy/Qy6zrnV2kA0BhlBKA6uofqWYZs2nhEGkJvpAdcFHZkWdRFIKvMoI1b2FH/3tPiwkMOZPc6XI7WRl6lIO+97Pi6H5PEzKCRc4BPo32nxDAMAJkVyaHRgxiMccwSYoWVGQQj1USUjH2/dBd2ihZNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lr1Q7RGF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPGKDW4l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lr1Q7RGF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPGKDW4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770750672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
	b=Lr1Q7RGFPVzzZWKdrFp178tWqMAznbhiUglllM5FBOTOjw3NNQKV2DXB4MLcndDuxKLTL/
	7aqeYDwrIgFHEHxWcd7Sk/nZlS389Tmn0LAz7ga2/ZBDlwpMzK6onNcRb2bSfkUBsDU/F4
	AYhnH081rTeLXQnljYTJLxH9uEtbj50=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-a9X-83INMhqSAl67-ylIGQ-1; Tue, 10 Feb 2026 14:11:10 -0500
X-MC-Unique: a9X-83INMhqSAl67-ylIGQ-1
X-Mimecast-MFC-AGG-ID: a9X-83INMhqSAl67-ylIGQ_1770750670
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7943aea6515so71021817b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770750670; x=1771355470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
        b=UPGKDW4lokmgUNo99h0u9T4B4Hro1Zm3oGixpj/t+I65Vrsdb+4JgzO9ghhHp9YzIw
         f9cxQvm6mIj+yDqCR+jCtgW2xEsVM3L3/t6laSaOLTqFtbFSBHv177mQm+uPrWYBvd21
         x6fs/zNsCdkAfpbVUB6JaOqt1ZScpyGwF7oopV2yJ9XN9zh0TDd1YNZ2y7wr6hWIYTxX
         IkKGAgiUG94CBktEK/vbPFXCgmdkMlAueITXhIEwJscU3GX1z53uLQK0J+jKGo7eF8Rx
         as8kmJPAEl3J2jPv8vUc4CO7o3+GlTPjDWUemj5qUT5yXvtkxQIviDpvjwodk3xzUY5S
         pFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750670; x=1771355470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2Xf2m5pmbcGyim1nBI0IEwxlrJ12JH3NSxVXcGIlWo=;
        b=Jy1t7Wrjke5XLpNkqMurJKHIm6ZsQ5Tdx0Ni+eUziIAGCDOWsMlAFYtTOYrJndH551
         3PvIBrwe9JIBcTtixukctncV2md17v7d0zKsNgYACqFJW6Zu51yztqwkfKBb1EyHRBOB
         IAOzvBNt2pSNOSQvGaqvTT68PGxX8yVadC5ho2sbLjz4tBQghV4LR9hj2cKYWxtMgDn3
         ZYkxlV1175CCnC93WoUYaASlx83Ahn5yL9N73F922CElFJSpMZv47kVCOYuNIGtK9tPH
         lgH2mQS9d6dxwuXICWyR4dikF3sY5A5Ys9jpiXf94VMrTObtxbFz11HduxPbFCbtySqG
         Ji+g==
X-Forwarded-Encrypted: i=1; AJvYcCUDtLI/AdoYS1ie2YTbwysgPpTLinGmQ7QJreuaKxNbuldQgrODDYKa6GFvjbK25w0si1GeYQjO8/V8@vger.kernel.org
X-Gm-Message-State: AOJu0YyOVOlDCkt0mWhb/kdDU1aTy4/6SS1KTG9AwFM+PakJHF4xOb+0
	zqzM7VGg74w+KugJ5H4PuOAy/Ui77jwfgEfx/okxU61V7f9gvIXR7AsZJLYL3nK2XAZsb9i9S/y
	WuS38k4yWj1C2vsTWO58B00OLESx2Fmo8p0KA4sxKew6X45BX5QsW1yFSNkuHmpA=
X-Gm-Gg: AZuq6aKeyUuZw+JI+uuclpc7GcJmbVN6g+264QFQVJJhM/Jf7vMO3LbkMVjYqKUCpmt
	CMa25Rip6UlwxcJQM6IVfFecP4jchwsuBZsTFchw4+TufppDz4Vca14HpthdoVTIyXJ/dUrdSjq
	ZouD7Za/463NrY2o5YYi8WLPcRXOv45eEyAC/YydJA1kNjNYp5/KQWC/3867oC/IUjvJDo8DEs6
	VwzZglQMS27zD7D7oou0QESmfXlm6xIysf8xIXhsnpYPHaM6DAia8FUwqtYQCZaPbAG0kZgCBDf
	HFKQCnsbXTheaqrt4j5umOE2AFTCZA3pf34RIL8YhslrIdwVA3dpZls5ek7R1KkpPFCTU/UxaA0
	6EoPkmeJ6AoePRh0xnjLIDQbNNY+Y/PbVwNLtZqsfTOXyajAnMjyd
X-Received: by 2002:a05:690c:b18:b0:796:3515:3aa8 with SMTP id 00721157ae682-7966aa83f07mr78467b3.43.1770750670182;
        Tue, 10 Feb 2026 11:11:10 -0800 (PST)
X-Received: by 2002:a05:690c:b18:b0:796:3515:3aa8 with SMTP id 00721157ae682-7966aa83f07mr78187b3.43.1770750669655;
        Tue, 10 Feb 2026 11:11:09 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796211d1b81sm114096987b3.16.2026.02.10.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:11:09 -0800 (PST)
Message-ID: <3ed63c65a6f6910ece96a88b71f37ff1547b68c0.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 0/3] ceph: add subvolume metrics reporting
 support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 10 Feb 2026 11:11:07 -0800
In-Reply-To: <20260210090626.1835644-1-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 09:06 +0000, Alex Markuze wrote:
> This patch series adds support for per-subvolume I/O metrics collection
> and reporting to the MDS. This enables administrators to monitor I/O
> patterns at the subvolume granularity, which is useful for multi-tenant
> CephFS deployments where different subvolumes may be allocated to
> different users or applications.
>=20
> The implementation requires protocol changes to receive the subvolume_id
> from the MDS (InodeStat v9), and introduces a new metrics type
> (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> statistics back to the MDS.
>=20
> Patch 1 adds forward-compatible handling for InodeStat v8, which
> introduces the versioned optmetadata field. The kernel client doesn't
> use this field but must skip it properly to parse subsequent fields.
>=20
> Patch 2 adds support for parsing the subvolume_id field from InodeStat
> v9 and storing it in the inode structure for later use. This patch also
> introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
> state and enforces subvolume_id immutability with WARN_ON_ONCE if
> attempting to change an already-set subvolume_id.
>=20
> Patch 3 adds the complete subvolume metrics infrastructure:
> - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> - Red-black tree based metrics tracker for efficient per-subvolume
>   aggregation with kmem_cache for entry allocations
> - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> - Integration with the existing CLIENT_METRICS message
> - Recording of I/O operations from file read/write and writeback paths
> - Debugfs interfaces for monitoring
>=20
> Metrics tracked per subvolume include:
> - Read/write operation counts
> - Read/write byte counts
> - Read/write latency sums (for average calculation)
>=20
> The metrics are periodically sent to the MDS as part of the existing
> metrics reporting infrastructure when the MDS advertises support for
> the SUBVOLUME_METRICS feature.
>=20
> Debugfs additions in Patch 3:
> - metrics/subvolumes: displays last sent and pending subvolume metrics
> - metrics/metric_features: displays MDS session feature negotiation
>   status, showing which metric-related features are enabled (including
>   METRIC_COLLECT and SUBVOLUME_METRICS)
>=20
> Changes since v5:
> - Rebased onto latest kernel (resolved conflict with inode_state_read_onc=
e()
>   accessor change in fs/ceph/inode.c)
> - Re-added InodeStat v8 handling patch (patch 1) as it was not actually
>   in the base tree, making this a 3-patch series again
>=20
> Changes since v4:
> - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
>   into patch 1 (previously split across patches 2 and 3)
> - Removed unused 'cl' variable from parse_reply_info_in() that would
>   cause compiler warning
> - Added read I/O recording in finish_netfs_read() for netfs read path
> - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
>   instead of intermediate snapshot allocation
> - InodeStat v8 patch now in base tree, reducing series from 3 to 2
>   patches
>=20
> Changes since v3:
> - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
>=20
> Changes since v2:
> - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
> - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> - Add documentation for struct ceph_session_feature_desc ('bit' field)
> - Change pr_err() to pr_info() for "metrics disabled" message
> - Use pr_warn_ratelimited() instead of manual __ratelimit()
> - Add documentation comments to ceph_subvol_metric_snapshot and
>   ceph_subvolume_metrics_tracker structs
> - Use kmemdup_array() instead of kmemdup() for overflow checking
> - Add comments explaining ret > 0 checks for read metrics (EOF handling)
> - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> - Add comment explaining seq_file error handling in dump function
>=20
> Changes since v1:
> - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
>   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> - Added detailed comment explaining InodeStat encoding versions v1-v9
> - Clarified that "optmetadata" is the actual field name in MDS C++ code
> - Aligned subvolume_id handling with FUSE client convention (0 =3D unknow=
n)
>=20
> Alex Markuze (3):
>   ceph: handle InodeStat v8 versioned field in reply parsing
>   ceph: parse subvolume_id from InodeStat v9 and store in inode
>   ceph: add subvolume metrics collection and reporting
>=20
>  fs/ceph/Makefile            |   2 +-
>  fs/ceph/addr.c              |  14 ++
>  fs/ceph/debugfs.c           | 157 ++++++++++++++
>  fs/ceph/file.c              |  68 +++++-
>  fs/ceph/inode.c             |  41 ++++
>  fs/ceph/mds_client.c        |  92 ++++++--
>  fs/ceph/mds_client.h        |  14 +-
>  fs/ceph/metric.c            | 183 +++++++++++++++-
>  fs/ceph/metric.h            |  39 +++-
>  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++
>  fs/ceph/subvolume_metrics.h |  97 +++++++++
>  fs/ceph/super.c             |   8 +
>  fs/ceph/super.h             |  11 +
>  13 files changed, 1114 insertions(+), 28 deletions(-)
>  create mode 100644 fs/ceph/subvolume_metrics.c
>  create mode 100644 fs/ceph/subvolume_metrics.h
>=20
> --
> 2.34.1
>=20

Let me run xfstests for the patchset. I'll be back with the result ASAP.

Thanks,
Slava.

