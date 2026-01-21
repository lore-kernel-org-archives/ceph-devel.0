Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB830FC05
	for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768995861; cv=pass; b=bwXwJHWjsIWPjabVtOSlFxySGYiEELJwBG8f2tRnFYK3DTMMJe1ccDu7ToRyYMV6PauSOqoj1Y2qPbw7c07yKP0FFGDP09r+e1nVxo2EJDSzd/+UNtTug+HKqv1n7sJEYFOGLoTyh+LUJZe2BIeFheukF6GmEpezbR+688Xpgtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768995861; c=relaxed/simple;
	bh=hhGbc+OIWEfPbONatLXmqY6q7JwxqIGzS3znH81pCp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kd2MYN67eAOgNgkOB+wQKUpsicvuDWT2cK71r5BWV3GPPoj7W7S/vhnv1uyk8awq9kjKhgZHb6aFFx6nfWReSPyD3fg9xTpLWDwMXh0xVJ4FF7YTaWmH3IWVhLoCJAwnOx6XZ1DAWPjd5pVM1GzM3A+5Q6arGACiD2fXNZG27Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DD+B50MX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQe7gfUh; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DD+B50MX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQe7gfUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768995858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
	b=DD+B50MXsstlJ+asxNrbK7RfmwJz4Ps8KFi0MPIBHMM10gruymKW/kcixxLOhD310ZtD8m
	pRpJt/EGAohl4e05Pmzzb/xcxlXk3jA+0gMqZSNIPLdt7lHbmKH1TRo/EPK7JVm+b8zi1Y
	uyu7f58eDQim/rPimZL1nrM861EvaeU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-TPUUF-CbN3Gemnv7DltXQw-1; Wed, 21 Jan 2026 06:44:16 -0500
X-MC-Unique: TPUUF-CbN3Gemnv7DltXQw-1
X-Mimecast-MFC-AGG-ID: TPUUF-CbN3Gemnv7DltXQw_1768995856
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ed0a71c0beso5537891137.2
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2026 03:44:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995856; cv=none;
        d=google.com; s=arc-20240605;
        b=RIhhbj1WI0Ycj4woB/3/+WhLN9Z+EmiwqCmrCd3IvrVVB4eq43lrxEY8mc91gzfBjc
         XPCIy/pMwgwakYCSnGNoA5b6theYhmr+YJA5Z7L9XK5VB8fx5S3hVve+YG7XdsH4Q4DT
         ZRabJ6GYSa3FlVkWAwLe4K38zUrzL6pYn+pzTz4jdMtwSa4SWYIwrQCysMOuqSpNFGLn
         pIPIwKWM0NsIyiwF05je08PIR07DzGBd02VtVqo/qNRjuFS9NJIxcOEQvgRWSNadVpCR
         ic9+0kfnKR1PIIWfetftusW4UyzZxrBCnCrfibcKwijhKCxlDFMy2+v5fzFP5SbZCINl
         9NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        fh=8l0u/IMevTe27ybXs5OlkEsvMOknoS1EIIe0cqMmo1Y=;
        b=KoLLZlimC5e7ZKi4rEcWjFJkvKdnSL5KYDC7HaMMaeOtgj+yCGlWpfFalIZr53Fnbl
         aOPCqqbqmcAAmysYTJfhmPUwjisuosQ00b4w1X+Ntm2fzLz85H8V167VfZoW7RC4PHc0
         sjEfTZc6N6EY09rSTmMX3ORLHHCgqlYtDR1iXtoke4fRXI8BN/2mbCqzjtw5mKl5hqPW
         HvXL4+fhZNe1cFxkNb0ckf5xAs+Z7H0nNbMSChRx+KKKb9O+1y++V6G1l35n6FohtKVm
         2AJa32BA/dqjDVkyGURqaB+7TnvGnquzRzsNv8XC80MPThkMPuj9xMa5TCJ9ehhISm2u
         Qp2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768995856; x=1769600656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        b=EQe7gfUhcymFIxtGDX1ePOhwa9LrhP61qq1i4pWFD7f1zzZ36Hhzbwt6bD8qAOL1ho
         vKMrVP1cXLvAKEZuIt0/FqKiyY1dM7thzK+KkviMPv4hXG92FOUy7LQRiEEgPDyJpf5j
         VEZ0HI1hbwfsYP5nQ4P1yXcucLpgJpdaS6/qw4NpH0A6wMMF1WoGVXUWKOuzvV5Ml8mY
         TLkzBBGvqFEIhoZ9T1FRoK/aJkOUnHd3ru6+cMyGm3Wl4A0yjSPvMQ9U7KXqr54iqQ55
         JCWCoq3Ia4RzeBQqvP9/jGS781LpL285ZKmy3dJMVVe9B3mdlDfWOEX9e8y5kUgqvi6p
         SHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768995856; x=1769600656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oZsWBF3suT4vQaUZt0zT5ll7sVtHhnyQaXi5InAKqFM=;
        b=bSqaaEXhbfWGYxp5/wqMEy+quB7t/Spbn7svjwQKGec/5ULDFqsGVLibic2HHwIpq6
         Tzi40pO/sOYRUh072woxNn3dY304cw44oEk3i7QEBkoV/LRh4WT4FgPASnUgzEw5RngP
         fDGX8qs+nq3iQ5Bf69ld0KNm/944XEDnn0Oqq4MzmGZnOcTqtFJWD1fyuK1rdDyYhU/N
         6DGnDDScYv+fWoNddjlYpBNQ0sW3JbbrlcoKxO+ju3IMgtGcerFcEq+EwRBTZ5xgkiy2
         ZVVlTSWKiaQWYHoNgsvR1QeSBR+qxkn6Frha9Gsxpes7MzWTBaNR/J+qgP6FIO5VqNp0
         GQIQ==
X-Gm-Message-State: AOJu0Yyrxs4BO0stgsD68KOGteJeh/BqkUqGNx7xf92Re7223HyNVb4t
	tBIaoGzhMqzVHPmY8UiE48jZfBIAnvNPOdUpIhZr7Zwx7PRlmvTRpKt7hLo7/wRcHqXqRilwSMM
	TuPUP4G6L9rncGkz2eUqVR91I6uHck3FGfwrpPjA4npWW2ei3GYHlHBzP2eLot+Pr78pTvC8yvG
	lY4C3GeDSE+XcuJsND/oHPZMswfgLEKjpDw/tGvg==
X-Gm-Gg: AZuq6aLw59tuAYPYmY0S8RM2u/zrIpV++s/ZZhN3+3L1Luz1fThZjYkt104beio7vp8
	ZzoHBFUMKydRz4/52YlK1U7Mv/6YCBZH2SQlphJGGtMIt6c/glAKsjnyLa9XAc6vTeWUNGXtAiy
	1acgRImXsamRgSUYpyWa6HfSG1wDWcBa4wkxqhO6B1TgIet9ruoQeX9KjHsk7JQ1Da5TXyqWbSt
	4Ht38HCVhH84PX6XeDdV7dj
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id ada2fe7eead31-5f1a4dc26femr4866859137.10.1768995856291;
        Wed, 21 Jan 2026 03:44:16 -0800 (PST)
X-Received: by 2002:a05:6102:f10:b0:5ee:a309:6684 with SMTP id
 ada2fe7eead31-5f1a4dc26femr4866853137.10.1768995855823; Wed, 21 Jan 2026
 03:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118182446.3514417-1-amarkuze@redhat.com> <721bc15d532ea4dd03e079bd516f332208fa48c2.camel@redhat.com>
 <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
In-Reply-To: <8dce90cb96a33a123e5baa1613fde06658523495.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 21 Jan 2026 13:44:04 +0200
X-Gm-Features: AZwV_QjaXNZnvDFd1zoJ-6DaOBDmAwtKnhuBVtW5WB_ZlS3FgKD5dJuAgdRFWVw
Message-ID: <CAO8a2Si0hRbY0=w7sbBGn212hg4CD5=CxNsKjmr8jwEgTUmziQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5 0/2] ceph: add subvolume metrics
 reporting support
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Local tree seems to have lagged behind, I'll rebase and send an updated ver=
sion

On Wed, Jan 21, 2026 at 2:30=E2=80=AFAM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Tue, 2026-01-20 at 16:18 -0800, Viacheslav Dubeyko wrote:
> > On Sun, 2026-01-18 at 18:24 +0000, Alex Markuze wrote:
> > > This patch series adds support for per-subvolume I/O metrics collecti=
on
> > > and reporting to the MDS. This enables administrators to monitor I/O
> > > patterns at the subvolume granularity, which is useful for multi-tena=
nt
> > > CephFS deployments where different subvolumes may be allocated to
> > > different users or applications.
> > >
> > > The implementation requires protocol changes to receive the subvolume=
_id
> > > from the MDS (InodeStat v9), and introduces a new metrics type
> > > (CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
> > > statistics back to the MDS.
> > >
> > > Note: The InodeStat v8 handling patch (forward-compatible handling fo=
r
> > > the versioned optmetadata field) is now in the base tree, so this ser=
ies
> > > starts with v9 parsing.
> > >
> > > Patch 1 adds support for parsing the subvolume_id field from InodeSta=
t
> > > v9 and storing it in the inode structure for later use. This patch al=
so
> > > introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unse=
t
> > > state and enforces subvolume_id immutability with WARN_ON_ONCE if
> > > attempting to change an already-set subvolume_id.
> > >
> > > Patch 2 adds the complete subvolume metrics infrastructure:
> > > - CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
> > > - Red-black tree based metrics tracker for efficient per-subvolume
> > >   aggregation with kmem_cache for entry allocations
> > > - Wire format encoding matching the MDS C++ AggregatedIOMetrics struc=
t
> > > - Integration with the existing CLIENT_METRICS message
> > > - Recording of I/O operations from file read/write and writeback path=
s
> > > - Debugfs interfaces for monitoring
> > >
> > > Metrics tracked per subvolume include:
> > > - Read/write operation counts
> > > - Read/write byte counts
> > > - Read/write latency sums (for average calculation)
> > >
> > > The metrics are periodically sent to the MDS as part of the existing
> > > metrics reporting infrastructure when the MDS advertises support for
> > > the SUBVOLUME_METRICS feature.
> > >
> > > Debugfs additions in Patch 2:
> > > - metrics/subvolumes: displays last sent and pending subvolume metric=
s
> > > - metrics/metric_features: displays MDS session feature negotiation
> > >   status, showing which metric-related features are enabled (includin=
g
> > >   METRIC_COLLECT and SUBVOLUME_METRICS)
> > >
> > > Changes since v4:
> > > - Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
> > >   into patch 1 (previously split across patches 2 and 3)
> > > - Removed unused 'cl' variable from parse_reply_info_in() that would
> > >   cause compiler warning
> > > - Added read I/O recording in finish_netfs_read() for netfs read path
> > > - Simplified subvolume_metrics_dump() to use direct rb-tree iteration
> > >   instead of intermediate snapshot allocation
> > > - InodeStat v8 patch now in base tree, reducing series from 3 to 2
> > >   patches
> > >
> > > Changes since v3:
> > > - merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor
> > >
> > > Changes since v2:
> > > - Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset sta=
te
> > > - Add WARN_ON_ONCE if attempting to change already-set subvolume_id
> > > - Add documentation for struct ceph_session_feature_desc ('bit' field=
)
> > > - Change pr_err() to pr_info() for "metrics disabled" message
> > > - Use pr_warn_ratelimited() instead of manual __ratelimit()
> > > - Add documentation comments to ceph_subvol_metric_snapshot and
> > >   ceph_subvolume_metrics_tracker structs
> > > - Use kmemdup_array() instead of kmemdup() for overflow checking
> > > - Add comments explaining ret > 0 checks for read metrics (EOF handli=
ng)
> > > - Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
> > > - Add comment explaining seq_file error handling in dump function
> > >
> > > Changes since v1:
> > > - Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
> > >   using ceph_decode_skip_8() instead of ceph_decode_8_safe()
> > > - Added detailed comment explaining InodeStat encoding versions v1-v9
> > > - Clarified that "optmetadata" is the actual field name in MDS C++ co=
de
> > > - Aligned subvolume_id handling with FUSE client convention (0 =3D un=
known)
> > >
> > >
> > > Alex Markuze (2):
> > >   ceph: parse subvolume_id from InodeStat v9 and store in inode
> > >   ceph: add subvolume metrics collection and reporting
> > >
> > >  fs/ceph/Makefile            |   2 +-
> > >  fs/ceph/addr.c              |  14 ++
> > >  fs/ceph/debugfs.c           | 157 +++++++++++++++++
> > >  fs/ceph/file.c              |  68 +++++++-
> > >  fs/ceph/inode.c             |  41 +++++
> > >  fs/ceph/mds_client.c        |  72 ++++++--
> > >  fs/ceph/mds_client.h        |  14 +-
> > >  fs/ceph/metric.c            | 183 ++++++++++++++++++-
> > >  fs/ceph/metric.h            |  39 ++++-
> > >  fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/ceph/subvolume_metrics.h |  97 +++++++++++
> > >  fs/ceph/super.c             |   8 +
> > >  fs/ceph/super.h             |  11 ++
> > >  13 files changed, 1094 insertions(+), 28 deletions(-)
> > >  create mode 100644 fs/ceph/subvolume_metrics.c
> > >  create mode 100644 fs/ceph/subvolume_metrics.h
> > >
> > > --
> > > 2.34.1
> >
> > Let me run xfstests on the patchset. I'll be back with the results ASAP=
.
> >
>
> I have troubles to apply your pathset on Linux kernel 6.19-rc6:
>
> git am ./v5_20260118_amarkuze_ceph_add_subvolume_metrics_reporting_suppor=
t.mbx
> Applying: ceph: handle InodeStat v8 versioned field in reply parsing
> Applying: ceph: parse subvolume_id from InodeStat v9 and store in inode
> error: patch failed: fs/ceph/inode.c:742
> error: fs/ceph/inode.c: patch does not apply
> Patch failed at 0002 ceph: parse subvolume_id from InodeStat v9 and store=
 in
> inode
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Which is your code base? Which branch have you used as base one?
>
> Thanks,
> Slava.
>

