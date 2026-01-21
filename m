Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8E246BA7
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954745; cv=none; b=s8GthtZXgN+A1hHFvLtCCMPJaqsTwnKjvexlG050q3QKTVw5N+5/yCm7KGwPcd5s567AuY0Mnbguq+izB5UU+GDdegUPZVStbOGcu3Jt9Yp4PxvXmilXXACJfF83goVUKqwYRbkU/ONqjKzuJqC+9vXUUApNMr7sigw8veR2ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954745; c=relaxed/simple;
	bh=jFYinmLOkNV2Hyk0JgTy3PHHSXVZOu+E2gTIbh3BtQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MuC7IqjdMJr1U6/pmY+vrKosm50MkKY+DmaL7BdVjbsEtDNQ+jb23oBatj0iBWRhOKNIaPEhkVlnvpC7WLHUAmOPunPYRGvMZocpwTJ4MUxdJjIxYIjLwHa7k+4d2qHUT6E/3xKOhb/v0y/QgzrIhbLouMtoSo9II19s7E3WoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4vtsJ++; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqidwS/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4vtsJ++";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqidwS/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768954742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRA35aMlHXFgikhmtggi+w6dv31AZYFym+jxVzjkc6Y=;
	b=F4vtsJ++D2u7xDL4hV/MWtP50tAmFIlzZV8CVGlnKwnM5AXd//3JofijKlTnuG9kuPX51O
	xKlgxxP/ef0pAjexdnWq4oZyMhzHJ7jlz95yvx4eInhY/mkz+pGRExnoR87MIJE/R445ec
	4aRERZdthp1QS1DDrWZGkcNYX3Nb4WY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-7dRF05DWMpqoTq95efjAZA-1; Tue, 20 Jan 2026 19:19:00 -0500
X-MC-Unique: 7dRF05DWMpqoTq95efjAZA-1
X-Mimecast-MFC-AGG-ID: 7dRF05DWMpqoTq95efjAZA_1768954740
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7900ab6755fso79041407b3.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 16:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768954740; x=1769559540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cRA35aMlHXFgikhmtggi+w6dv31AZYFym+jxVzjkc6Y=;
        b=ZqidwS/EuMIr2H4V3NN8zXXsPLMoMfuDdv+g3hciXRvel2RmGjBpKBxS+PmcuveyvB
         DJHTv8OPRlIqNvM2hD7srRad41dmziFZdY2EiyywHKkwkJ8GRJzGzdEZV63IsDXlkICI
         cIieX1iFfPwpB0DBnzMcxTlHZWycdTdYKmjGJonBBX+bYZM1ZQdoxAY8Tuen/VGcGQPd
         LhAWZDVpADNQK7veqdOESTUhIeB1YVBPNFeCqAc3jo3wlec9EkFBjY8ulZrhi3rPp6fO
         PBOWQG7shFuGd7EtN9ESHEeOqMSkd1Ob04Eg83yUQ4blzRH4+1uWr6WaBm+phmI6oyj2
         i5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768954740; x=1769559540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRA35aMlHXFgikhmtggi+w6dv31AZYFym+jxVzjkc6Y=;
        b=gbzvUXBLgD4mNOiz6bL1dOy+lkSNtaolo41UV15rg9Kh5JJNIedb9hDYFqjCLufZ5a
         6DwGod62Nw5hQuM9Oa/cZnaG8FJ2TgAEcwqXxlkJSCD0awOaqdA1acvX1arXexP32xdS
         czk5pZE+E2QcsLtC7PNeLv1Hvf1sbCqHyBAA3KcXDQgfvzrcOPzZcKzvoajtzAb/u3NX
         qOUV4NF1evw7GMaar2aKWt6YfvsnSXJTpk8WpNyGAIIVw+uA3BswYfmhyNsrqW4NCRJA
         v/jlMCBIWusyRrHoawvbVYCoEzAchfimB4uIh1LHbPoqyhcl/o+JBZFa67iVsVJmWdqd
         3xqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQlM+RjXsmmrxR1KE6/VbZS/4bosA1cSD+TYi8Oxpc3d/3GdT02yp8x9iUr6s1pLXOOhoOTTkriV7H@vger.kernel.org
X-Gm-Message-State: AOJu0YxfM0rUTN4uWAQSBh3x5P9zlE+c5RN83iVs7VhFBv0ly0WNYpsY
	eq1PDJJIzbfmXAyNhDl33zLyoTf7qhBod8GQTfpZ5YOj8iRV8u2QglWpWhW+UGBrasRMylx0oxw
	OLSKC/2G9KRAXi59A/KzpQJjboZfo3pywihofPxSzkEFP1kbdgwz2LRaFtGjpuVx20wtcmHQ=
X-Gm-Gg: AZuq6aIChuGk6t+tpatFK8HgVJ4q1todLDnpjCzNJa6yW0NypUPXMKe6efFCBSS5nVa
	7pt9wtQcj6n/tn2gGtcGvZcLMwY2c/7sxTXDHOszg5Uz04zT+D06JnZ/zguZRdzFdeRBJ/5S92/
	qSJcZ8oGWgABkbeHpYmsiiHfnk1dpX8njvPIOloU8kS2jT6kgo5yK+mZ/VI6MGBxd++QNRcjusf
	6r85+gMxudpcBkEVmbHe1e88Fci/DlF3I12UO9CHcxq2dKfRacpIHXSIjv+kRHnmS+DPp6e5w8o
	EQ1hQ8dHDKfYAfg+4xfxYvYoYhfYhBSEf/c864z0MNQcVacdKtn/HHNgl3qQOZx69O4rNS5ck+q
	7ir5OZWcmMKacX+ACzdefo3abxRT6cBQExMBqWdqa
X-Received: by 2002:a53:ca8e:0:b0:63f:b0c7:849b with SMTP id 956f58d0204a3-649176e5a6dmr8588025d50.36.1768954740001;
        Tue, 20 Jan 2026 16:19:00 -0800 (PST)
X-Received: by 2002:a53:ca8e:0:b0:63f:b0c7:849b with SMTP id 956f58d0204a3-649176e5a6dmr8588018d50.36.1768954739638;
        Tue, 20 Jan 2026 16:18:59 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170ac7a1sm7086672d50.14.2026.01.20.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:18:59 -0800 (PST)
Message-ID: <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
Subject: Re: [PATCH v5 0/2] ceph: add subvolume metrics reporting support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 16:18:58 -0800
In-Reply-To: <20260118182446.3514417-1-amarkuze@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
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
> Note: The InodeStat v8 handling patch (forward-compatible handling for
> the versioned optmetadata field) is now in the base tree, so this series
> starts with v9 parsing.
>=20
> Patch 1 adds support for parsing the subvolume_id field from InodeStat
> v9 and storing it in the inode structure for later use. This patch also
> introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
> state and enforces subvolume_id immutability with WARN_ON_ONCE if
> attempting to change an already-set subvolume_id.
>=20
> Patch 2 adds the complete subvolume metrics infrastructure:
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
> Debugfs additions in Patch 2:
> - metrics/subvolumes: displays last sent and pending subvolume metrics
> - metrics/metric_features: displays MDS session feature negotiation
>   status, showing which metric-related features are enabled (including
>   METRIC_COLLECT and SUBVOLUME_METRICS)
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
>=20
> Alex Markuze (2):
>   ceph: parse subvolume_id from InodeStat v9 and store in inode
>   ceph: add subvolume metrics collection and reporting
>=20
>  fs/ceph/Makefile            |   2 +-
>  fs/ceph/addr.c              |  14 ++
>  fs/ceph/debugfs.c           | 157 +++++++++++++++++
>  fs/ceph/file.c              |  68 +++++++-
>  fs/ceph/inode.c             |  41 +++++
>  fs/ceph/mds_client.c        |  72 ++++++--
>  fs/ceph/mds_client.h        |  14 +-
>  fs/ceph/metric.c            | 183 ++++++++++++++++++-
>  fs/ceph/metric.h            |  39 ++++-
>  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/ceph/subvolume_metrics.h |  97 +++++++++++
>  fs/ceph/super.c             |   8 +
>  fs/ceph/super.h             |  11 ++
>  13 files changed, 1094 insertions(+), 28 deletions(-)
>  create mode 100644 fs/ceph/subvolume_metrics.c
>  create mode 100644 fs/ceph/subvolume_metrics.h
>=20
> --
> 2.34.1

Let me run xfstests on the patchset. I'll be back with the results ASAP.

Thanks,
Slava.

