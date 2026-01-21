Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B9288D0
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955436; cv=none; b=Fl7B1LD89qAPsPO0OW+xwRL94h0tQE3EXhfb1vKGr2i+dBrNDfHTHq74uiHfxXgaaGfBjfLW/7nEzd5lPDpGauThBy0k0kpplqwHz8aZoEBZnfxjyZNcFeMzZOJ/fMQTBjZUPRPHWDSi0Rm1f5HXayyxwV5ZuNEvwlB5jXuN+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955436; c=relaxed/simple;
	bh=kqA7hFp0b5pOlAT5k4slsR0tFyV4F1zhBk7jCl4+Sk8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5F2dXaGCP8xngbY76vKJgVajUv24wd/sOiX5vMzGxNAdgOJ5ert192RlgfFaY+c/f7TDAxDfkX6kvQVd63gKvR33UlKwEs2TjCEsXL5gGG/xfcnDCr1tsmZYUi3dfO150JbVreNnJyD5OEm/XAUGJSFcZxx6OSBrotOQnew3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7fRy6X2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ishrvz1Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7fRy6X2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ishrvz1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768955434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
	b=b7fRy6X2pvkrqHnNA6r6mc+VdqmrciH+MoD3SwdwphDTo+5qUQrfONjp45eXrSBPxYFZ6J
	+q3tUEsYgWJnKW11+Lbf5nTSPh1NFb9gQSztvlCGOPMFW/2FUeE9nJ/IW4nNlRzFlP/w/v
	fr3bklVC6m1isW7l++z1SqocDKM6T6M=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-sOTeIDCkMLGg5iZ_lMGIIA-1; Tue, 20 Jan 2026 19:30:30 -0500
X-MC-Unique: sOTeIDCkMLGg5iZ_lMGIIA-1
X-Mimecast-MFC-AGG-ID: sOTeIDCkMLGg5iZ_lMGIIA_1768955430
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-792738a717fso69641057b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2026 16:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768955430; x=1769560230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
        b=Ishrvz1QqY2yHzLGZxecr21latunvaF3VSBorqdACzmeit3PAUHt5Div/GTiE4a6R+
         M3js5Q1XQU3OjwQjY7f4I73y6HeYZ3sigDVtfavneElIB+QGDqQ+nsYN/lf/63jbWGa/
         AkR1QpsHYDdWObUR5El0F4rhclAYiXWGJ0M/cVmkpMBIGNI2iBy8z4gLxtnvBcS4FXS4
         jGi+i/tSEcHQk4kdd3KvKKde1+iuv8rSgxb6oZEwzY9bXrLKv7b07GQ2Rw5quAAC6pkq
         wycMrBSXZq5W0wI0ERgGam2EwtE9ZTfn7L5+JZcj1f0tD/Gq2MvOyV+cN8VlUtoKfyBY
         ViJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955430; x=1769560230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nxjbXT0xnBHhhZgM6DIUEflr+8xamjmOI0ttVCQ4KI=;
        b=ZB4VnsLvJOvEnO7twc3ZQuW8JXxSoSw/DM5EsF42jncHmbQQUuv48cOzxqUcD9tN7C
         Pl3P1q7MiMV7Ly3wSf8J4blVG+ANxy61lFuCHCc1qeuHDsIehxj1pjrEWJ/lhGV2o4TS
         lMiI5o+yvyKgXd0t1yuONBDFQpjw+gSVfDpRTYyUNdcTwcZDGqe13DukDWAlOWxkKcy2
         B46oXl4izqoMFpNmlpxkmEL2S3fTyCnJ/Fu1qCLmYLKUcjnPFl8LysY5cpb9Yc/9sMgJ
         hKTRX01AEHyCw6o4hPtKEW84K7iaDjuuCXVtJFDkO/dfH7A7CxKiQK421lgUVFxVHHeQ
         ME7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrncsBoEaXr5E4Nh48uhvenNO8HNpnsGX+idAnY+y7ovAf/FgRpCiWGIT2BqNTX3wEeXi7LqVLYX/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yymj+n0x8UMIMaorMDjbwVu2RRYF6/OK6AonkvVwf1iR/amJ9wt
	uF9FuxDkadG1SN2JSizEAH76OOiAvMKIIcMiWWU+guDyXclOo7QOVijlDPYocs7UsnqsxKqU4dN
	m2RQkb8oBHke2N1eVarBTHRipdolRXyn+ISm4r+o0syT3Wrofk5ZA4/wjqsUqvxs=
X-Gm-Gg: AZuq6aJh0thotcjgDwyNuaj20tw02waOhIWpux6d+P/v+2NLcQ5mEpwKbDxoOVNtt14
	jNMtMXmWdimcasPJR/6qdPabVfP+uI6TXp77Jqc0iY15In0QQxFC8iNnKz+lYYGUf6Xy8hsyc6G
	SQ/WPuD+qOLVOAWwQ6kQ021XDXkO/rVTRYaCewF/aR8XqOLtLqbK/4FWRXV1ck9S4gg8EsMrhx4
	M2j0ogX05BQcxSQb73DyejJmQQoa6CdUZYj+mXsi8r6VSnPJ7ZWhOXwPAH1YafSjd8zKtDMd8qc
	jhgFkYP2g4+Ky1ik0F4gGVbHDXvGXDVjwdRmpj7MTBkV0gMumBf5Iv/SoTAczy04Dd2zcZcuZJm
	stzjSHgkftssv0Ln6QJ23Mmks0XNPD9v0+Yz+2Mgy
X-Received: by 2002:a05:690c:4b85:b0:793:d0b5:9bcb with SMTP id 00721157ae682-7940a153cf5mr30151077b3.24.1768955429900;
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
X-Received: by 2002:a05:690c:4b85:b0:793:d0b5:9bcb with SMTP id 00721157ae682-7940a153cf5mr30150937b3.24.1768955429529;
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c70f4sm59096427b3.7.2026.01.20.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 16:30:29 -0800 (PST)
Message-ID: <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 0/2] ceph: add subvolume metrics
 reporting support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 16:30:28 -0800
In-Reply-To: <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
	 <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 16:18 -0800, Viacheslav Dubeyko wrote:
> On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> > This patch series adds support for per-subvolume I/O metrics collection
> > and reporting to the MDS. This enables administrators to monitor I/O
> > patterns at the subvolume granularity, which is useful for multi-tenant
> > CephFS deployments where different subvolumes may be allocated to
> > different users or applications.
> >=20
> > The implementation requires protocol changes to receive the subvolume_i=
d
> > from the MDS (InodeStat v9), and introduces a new metrics type
> > (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> > statistics back to the MDS.
> >=20
> > Note: The InodeStat v8 handling patch (forward-compatible handling for
> > the versioned optmetadata field) is now in the base tree, so this serie=
s
> > starts with v9 parsing.
> >=20
> > Patch 1 adds support for parsing the subvolume_id field from InodeStat
> > v9 and storing it in the inode structure for later use. This patch also
> > introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
> > state and enforces subvolume_id immutability with WARN_ON_ONCE if
> > attempting to change an already-set subvolume_id.
> >=20
> > Patch 2 adds the complete subvolume metrics infrastructure:
> > - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> > - Red-black tree based metrics tracker for efficient per-subvolume
> >   aggregation with kmem_cache for entry allocations
> > - Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
> > - Integration with the existing CLIENT_METRICS message
> > - Recording of I/O operations from file read/write and writeback paths
> > - Debugfs interfaces for monitoring
> >=20
> > Metrics tracked per subvolume include:
> > - Read/write operation counts
> > - Read/write byte counts
> > - Read/write latency sums (for average calculation)
> >=20
> > The metrics are periodically sent to the MDS as part of the existing
> > metrics reporting infrastructure when the MDS advertises support for
> > the SUBVOLUME_METRICS feature.
> >=20
> > Debugfs additions in Patch 2:
> > - metrics/subvolumes: displays last sent and pending subvolume metrics
> > - metrics/metric_features: displays MDS session feature negotiation
> >   status, showing which metric-related features are enabled (including
> >   METRIC_COLLECT and SUBVOLUME_METRICS)
> >=20
> > Changes since v4:
> > - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
> >   into patch 1 (previously split across patches 2 and 3)
> > - Removed unused 'cl' variable from parse_reply_info_in() that would
> >   cause compiler warning
> > - Added read I/O recording in finish_netfs_read() for netfs read path
> > - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
> >   instead of intermediate snapshot allocation
> > - InodeStat v8 patch now in base tree, reducing series from 3 to 2
> >   patches
> >=20
> > Changes since v3:
> > - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
> >=20
> > Changes since v2:
> > - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
> > - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> > - Add documentation for struct ceph_session_feature_desc ('bit' field)
> > - Change pr_err() to pr_info() for "metrics disabled" message
> > - Use pr_warn_ratelimited() instead of manual __ratelimit()
> > - Add documentation comments to ceph_subvol_metric_snapshot and
> >   ceph_subvolume_metrics_tracker structs
> > - Use kmemdup_array() instead of kmemdup() for overflow checking
> > - Add comments explaining ret > 0 checks for read metrics (EOF handling=
)
> > - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> > - Add comment explaining seq_file error handling in dump function
> >=20
> > Changes since v1:
> > - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
> >   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> > - Added detailed comment explaining InodeStat encoding versions v1-v9
> > - Clarified that "optmetadata" is the actual field name in MDS C++ code
> > - Aligned subvolume_id handling with FUSE client convention (0 =3D unkn=
own)
> >=20
> >=20
> > Alex Markuze (2):
> >   ceph: parse subvolume_id from InodeStat v9 and store in inode
> >   ceph: add subvolume metrics collection and reporting
> >=20
> >  fs/ceph/Makefile            |   2 +-
> >  fs/ceph/addr.c              |  14 ++
> >  fs/ceph/debugfs.c           | 157 +++++++++++++++++
> >  fs/ceph/file.c              |  68 +++++++-
> >  fs/ceph/inode.c             |  41 +++++
> >  fs/ceph/mds_client.c        |  72 ++++++--
> >  fs/ceph/mds_client.h        |  14 +-
> >  fs/ceph/metric.c            | 183 ++++++++++++++++++-
> >  fs/ceph/metric.h            |  39 ++++-
> >  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  fs/ceph/subvolume_metrics.h |  97 +++++++++++
> >  fs/ceph/super.c             |   8 +
> >  fs/ceph/super.h             |  11 ++
> >  13 files changed, 1094 insertions(+), 28 deletions(-)
> >  create mode 100644 fs/ceph/subvolume_metrics.c
> >  create mode 100644 fs/ceph/subvolume_metrics.h
> >=20
> > --
> > 2.34.1
>=20
> Let me run xfstests on the patchset. I'll be back with the results ASAP.
>=20

I have troubles to apply your pathset on Linux kernel 6.19-rc6:

git am ./v5_20260118_amarkuze_ceph_add_subvolume_metrics_reporting_support.=
mbx
Applying: ceph: handle InodeStat v8 versioned field in reply parsing
Applying: ceph: parse subvolume_id from InodeStat v9 and store in inode
error: patch failed: fs/ceph/inode.c:742
error: fs/ceph/inode.c: patch does not apply
Patch failed at 0002 ceph: parse subvolume_id from InodeStat v9 and store i=
n
inode
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Which is your code base? Which branch have you used as base one?

Thanks,
Slava.

