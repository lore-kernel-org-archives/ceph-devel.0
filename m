Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FD348898
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837855; cv=none; b=FeZ+h5z9jNPInni0SVEeWIaHEXCYj/MeXqqLeJ326iMB6VxhNHt4xptjS409jk73N8XcOk0oEEtNrWctWZJuw00Hl7WVgRIVeFpFJ+shwPK2JCj0ECb+AfTHxzAJs/UhiHbWReWNpwpVw7hGuqBTB3XpBWKIqmGWE3L7gzl/irQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837855; c=relaxed/simple;
	bh=ec9O/N1I06mbVpy5gL7xjryGRVigHlS4TbPU7/qGHGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NCrUJeLvWOaBJ7hW8AgXC79cDrJue3bi8WJqUCY9oR2i2HoR5I6d79mcXg5pjdq05W8AP9zc0hfXGXOCmJp28mK3xG3Z7V7AbTqfxf9yQoZOZYOpN+YpcwKSbr63lWxJoEDsZ2xNqmHDslvuy+UFpIWopuRpEjElrpq/VlzOLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bToiIs5O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSzSVVc6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bToiIs5O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSzSVVc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770837852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGkftO7dITkD0LW3tcr2wxPHLD2/j9EiWabtVaa/7Tw=;
	b=bToiIs5OHBxPkbELOFNSvxh7+9GByIci0H3jAmVj02hy0D5kdpv75SgkHC1TVe5gJNN0Ty
	iCk8wBwtxKit9kGAxlXkSzn5mZsuVB0z+VK9I63hX4Vu+F19nadh2NqqgHHz+3ApAYH0UW
	E9VnBQ1fBOmfhdnmXDk65PO2YRG0B9Q=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-xOsSrPzBN0-IP3WVUDOTLw-1; Wed, 11 Feb 2026 14:24:11 -0500
X-MC-Unique: xOsSrPzBN0-IP3WVUDOTLw-1
X-Mimecast-MFC-AGG-ID: xOsSrPzBN0-IP3WVUDOTLw_1770837851
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7962a21167dso84257847b3.3
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770837850; x=1771442650; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gGkftO7dITkD0LW3tcr2wxPHLD2/j9EiWabtVaa/7Tw=;
        b=DSzSVVc6p5I1CPLhDjIDXVU92GiCugLepQZWqW36DWdjqt5mSwUXkWgqukCRpgMj2x
         pVRS4OQqFsW2xLW9KF1Hpu92NiuqVbNUoKPA5nW9FAKAQHzUVfWdOWw3hxlKU1npNP7o
         H8WSgt2VmkCDHLZffsQkjqgXOq1r9EIjnyQAOFVu8Y3v77fhw2awHLW/9pwGwn24ULnv
         lVCmJ9/VkHiyJmUGBI2CdCWBI9gCbA4jea9KH3mjV6xqdYVOuerORZVkmohWNT2tNzmA
         +7FZ+iAA5e6bkjix+hpkSKiz3sUqdzYyZ57i7/SE8F1gh0Bb/+p1dIiMoW03stM2Vn1I
         I7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837850; x=1771442650;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGkftO7dITkD0LW3tcr2wxPHLD2/j9EiWabtVaa/7Tw=;
        b=DfAmV7BHV3aT7JnkjJUAeDT/7Q4Qx45o4fK++0D8cql1rRPa9FpJ7Bsa3Y0vpyxjKz
         fYWE26sofZr5xCx0JY4a6y0cqWz53RyrEiVHXG7Aa+BFA1mRdjWEv+lUA85Nw+hDtFQG
         HcUwFItPym/zJdRq9PBJs5dSWbuX3ld1/vlHBVntrf8CRhsXkim7WxXYXkwHZu4dhEPH
         7NwaU2C4uy11RlnVNOfciysbnHXTVZKoMbRK62nV3Ea7kbECqr4Ry9lYHp7zv9F5aNWa
         WnJXkY7meG0isd1LNXhRybl3hLRAq92HpZqM1QYH98Y/zVlIHQv1kseslKJgzeCM1Q0k
         3OiA==
X-Forwarded-Encrypted: i=1; AJvYcCUD4wUPvB8TuPICPWtbjDEpg9iNf0GA3hVb8som3y+QGPvC7lfqD/tQ0hceMIdsk0Q3MH1X+xedAjQ9@vger.kernel.org
X-Gm-Message-State: AOJu0YwUEIfzbp9BacMO0++vz2VfVitTbI28P2oH1amndqFK6Z1HKBe0
	67BGkthGNS8UXHY4gGA6rUYhJnLU26yy6179x5tL+qNjUCok9thrCeFCG+6k8AEf672VTnRs5N7
	O1RIJlLcApjzdBpyLasMrT3nymWM0Y6JY0FRqeMBSBFCS4079z6d4wVho2pGAmveRai2Gkew=
X-Gm-Gg: AZuq6aIRwJ544Oe5cMMvxIWG67LWEEekruDBydyawK3pHvnXgAUr7SEoaPLNHCkn6YR
	y/EhfXjn3VIuqAFPeNdYKEXmeN34CmnRMZhIHH0tvJkNmAR52VVojqgtQF9mH5CewDoCFoeT7wK
	hP5j8YOJNFqnfjFAGq+fsO5/X4kRra08S1ccPe4+0kNVsAZ3bHtyG8SdLsyoXAUtMHupBJGOx2I
	ltI7qN6jVuhVZWbf5KeLBOBEmsZB3ldZPXORs4lda6NL0YbMjwh2kQS0c/vUXHNiW83yVFYmyfe
	2u87v0dvhjWgpRRAh/tgoIAPdY9XokII3Wocg9EmhANYgBpyxxu4oGOCDKuGKF9+DRfKAh8g080
	lU8oyvyoEXl2R640a3y4ggljnpFn44IXllLaQKFJWFl00hjSKcELJ
X-Received: by 2002:a53:b202:0:b0:649:d54f:dfeb with SMTP id 956f58d0204a3-64bbaafb8c7mr276881d50.56.1770837849640;
        Wed, 11 Feb 2026 11:24:09 -0800 (PST)
X-Received: by 2002:a53:b202:0:b0:649:d54f:dfeb with SMTP id 956f58d0204a3-64bbaafb8c7mr276856d50.56.1770837848991;
        Wed, 11 Feb 2026 11:24:08 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc9b5932sm2798015d50.21.2026.02.11.11.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:24:08 -0800 (PST)
Message-ID: <06944673552556f8cc2ee17ad7d009b286faba32.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v6 0/3] ceph: add subvolume metrics reporting
 support
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, linux-fsdevel@vger.kernel.org
Date: Wed, 11 Feb 2026 11:24:06 -0800
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


The xfstests has hung on generic/426 test case. Probably, this patchset is =
not
the reason of the issue. It sounds like we have some regression in 6.19 ker=
nel
version. Let me check your patch with earlier kernel version and to check 6=
.19
version with and without your patch. As far as I can see, the issue could b=
e not
easy reproducible.

Feb 10 17:56:04 ceph-0005 kernel: [20523.985931] watchdog: BUG: soft lockup=
 -
CPU#5 stuck for 2895s! [sh:244706]
Feb 10 17:56:04 ceph-0005 kernel: [20523.985945] Modules linked in:
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_co=
re
pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
kvm_intel kvm joydev irqbypass ghash_clmulni_intel aesni_intel rapl input_l=
eds
psmouse vga16fb serio_raw vgastate floppy qemu_fw_cfg i2c_piix4 mac_hid boc=
hs
i2c_smbus pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_ps=
tore
Feb 10 17:56:04 ceph-0005 kernel: [20523.986000] CPU: 5 UID: 0 PID: 244706 =
Comm:
sh Tainted: G    B        L      6.19.0+ #3 PREEMPT(voluntary)=20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986004] Tainted: [B]=3DBAD_PAGE,
[L]=3DSOFTLOCKUP
Feb 10 17:56:04 ceph-0005 kernel: [20523.986005] Hardware name: QEMU Standa=
rd PC
(i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
Feb 10 17:56:04 ceph-0005 kernel: [20523.986007] RIP:
0010:pv_native_safe_halt+0xb/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986019] Code: 20 d0 c3 cc cc cc cc=
 0f
1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 =
0f 00
2d 87 05 11 00 fb f4 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90
90 90 0f
Feb 10 17:56:04 ceph-0005 kernel: [20523.986022] RSP: 0018:ffff88817b36f780
EFLAGS: 00000246
Feb 10 17:56:04 ceph-0005 kernel: [20523.986024] RAX: 0000000000000001 RBX:
ffff8881ef8c3f80 RCX: ffff8881ef8c3f94
Feb 10 17:56:04 ceph-0005 kernel: [20523.986026] RDX: 0000000000000004 RSI:
0000000000000001 RDI: ffff8881ef8c3f94
Feb 10 17:56:04 ceph-0005 kernel: [20523.986027] RBP: ffff88817b36f798 R08:
ffff8881ef8c3f94 R09: 0000000000000001
Feb 10 17:56:04 ceph-0005 kernel: [20523.986028] R10: 0000000000000000 R11:
0000000000000000 R12: ffffffff8c4c9fc0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986029] R13: ffff8881ef8c3f88 R14:
fffffbfff18993fa R15: ffffffff8c4c9fd4
Feb 10 17:56:04 ceph-0005 kernel: [20523.986030] FS:  000070ca48cb8740(0000=
)
GS:ffff8882633fa000(0000) knlGS:0000000000000000
Feb 10 17:56:04 ceph-0005 kernel: [20523.986031] CS:  0010 DS: 0000 ES: 000=
0
CR0: 0000000080050033
Feb 10 17:56:04 ceph-0005 kernel: [20523.986033] CR2: 0000000000cf4101 CR3:
000000010d771001 CR4: 0000000000772ef0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986036] PKRU: 55555554
Feb 10 17:56:04 ceph-0005 kernel: [20523.986037] Call Trace:
Feb 10 17:56:04 ceph-0005 kernel: [20523.986038]  <TASK>
Feb 10 17:56:04 ceph-0005 kernel: [20523.986039]  ? kvm_wait+0x116/0x170
Feb 10 17:56:04 ceph-0005 kernel: [20523.986046]  ?
__kasan_check_write+0x14/0x30
Feb 10 17:56:04 ceph-0005 kernel: [20523.986051]=20
__pv_queued_spin_lock_slowpath+0xa85/0xf80
Feb 10 17:56:04 ceph-0005 kernel: [20523.986054]  ?
__pfx___pv_queued_spin_lock_slowpath+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986056]  ? __pfx_down_read+0x10/0x=
10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986059]  _raw_spin_lock+0xe0/0xf0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986061]  ?
__pfx__raw_spin_lock+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986062]  ?
__kasan_check_write+0x14/0x30
Feb 10 17:56:04 ceph-0005 kernel: [20523.986064]  ? _raw_spin_lock+0x82/0xf=
0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986065]  drop_pagecache_sb+0x134/0=
x270
Feb 10 17:56:04 ceph-0005 kernel: [20523.986069]  __iterate_supers+0x1df/0x=
240
Feb 10 17:56:04 ceph-0005 kernel: [20523.986072]  ?
__pfx_drop_pagecache_sb+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986073]  iterate_supers+0x10/0x20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986075]=20
drop_caches_sysctl_handler+0x8f/0xd0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986077]=20
proc_sys_call_handler+0x467/0x6a0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986081]  ?
__pfx_proc_sys_call_handler+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986082]  ?
apparmor_file_permission+0x1c/0x30
Feb 10 17:56:04 ceph-0005 kernel: [20523.986087]  ?
security_file_permission+0x53/0x150
Feb 10 17:56:04 ceph-0005 kernel: [20523.986091]  proc_sys_write+0x13/0x20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986093]  vfs_write+0x53c/0xf90
Feb 10 17:56:04 ceph-0005 kernel: [20523.986096]  ? __pfx_vfs_write+0x10/0x=
10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986098]  ? set_ptes.isra.0+0xd3/0x=
190
Feb 10 17:56:04 ceph-0005 kernel: [20523.986102]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986104]  ? fdget_pos+0x1de/0x600
Feb 10 17:56:04 ceph-0005 kernel: [20523.986107]  ksys_write+0xfc/0x230
Feb 10 17:56:04 ceph-0005 kernel: [20523.986109]  ? __pfx_ksys_write+0x10/0=
x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986111]  ?
__handle_mm_fault+0x134e/0x1da0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986112]  ? do_syscall_64+0xbf/0x5d=
0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986115]  __x64_sys_write+0x72/0xd0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986117]  ?
__pfx___handle_mm_fault+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986119]  x64_sys_call+0x79/0x2360
Feb 10 17:56:04 ceph-0005 kernel: [20523.986123]  do_syscall_64+0x82/0x5d0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986125]  ?
__pfx_css_rstat_updated+0x10/0x10
Feb 10 17:56:04 ceph-0005 kernel: [20523.986130]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986132]  ?
count_memcg_events+0x25b/0x3e0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986135]  ? handle_mm_fault+0x38b/0=
x6a0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986137]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:04 ceph-0005 kernel: [20523.986139]  ?
fpregs_assert_state_consistent+0x5c/0x100
Feb 10 17:56:04 ceph-0005 kernel: [20523.986143]  ? irqentry_exit+0xa5/0x60=
0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986144]  ? exc_page_fault+0x95/0x1=
00
Feb 10 17:56:04 ceph-0005 kernel: [20523.986146]=20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Feb 10 17:56:04 ceph-0005 kernel: [20523.986149] RIP: 0033:0x70ca48b14907
Feb 10 17:56:04 ceph-0005 kernel: [20523.986153] Code: 10 00 f7 d8 64 89 02=
 48
c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 =
75 10
b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 1=
8 48
89 74 24
Feb 10 17:56:04 ceph-0005 kernel: [20523.986154] RSP: 002b:00007fff41f65ba8
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Feb 10 17:56:04 ceph-0005 kernel: [20523.986156] RAX: ffffffffffffffda RBX:
0000000000000002 RCX: 000070ca48b14907
Feb 10 17:56:04 ceph-0005 kernel: [20523.986157] RDX: 0000000000000002 RSI:
00005bce02cab6b0 RDI: 0000000000000001
Feb 10 17:56:04 ceph-0005 kernel: [20523.986158] RBP: 00005bce02cab6b0 R08:
00005bcdfd1137ea R09: 00005bce02cab6b0
Feb 10 17:56:04 ceph-0005 kernel: [20523.986159] R10: 0000000000000077 R11:
0000000000000246 R12: 0000000000000001
Feb 10 17:56:04 ceph-0005 kernel: [20523.986160] R13: 0000000000000002 R14:
0000000000000000 R15: 0000000000000000
Feb 10 17:56:04 ceph-0005 kernel: [20523.986162]  </TASK>
Feb 10 17:56:18 ceph-0005 kernel: [20537.918623] rcu: INFO: rcu_preempt sel=
f-
detected stall on CPU
Feb 10 17:56:18 ceph-0005 kernel: [20537.918926] rcu: 	5-....: (3120077 tic=
ks
this GP) idle=3Dec84/1/0x4000000000000000 softirq=3D2067472/5144681 fqs=3D1=
345736
Feb 10 17:56:18 ceph-0005 kernel: [20537.919442] rcu: 	         hardirqs =
=20
softirqs   csw/system
Feb 10 17:56:18 ceph-0005 kernel: [20537.919718] rcu: 	 number:  3093012  =
=20
3120410            0
Feb 10 17:56:18 ceph-0005 kernel: [20537.919994] rcu: 	cputime:        0   =
   =20
31      3089846   =3D=3D> 3090095(ms)
Feb 10 17:56:18 ceph-0005 kernel: [20537.920366] rcu: 	(t=3D3120100 jiffies
g=3D2904357 q=3D583149 ncpus=3D8)
Feb 10 17:56:18 ceph-0005 kernel: [20537.920667] CPU: 5 UID: 0 PID: 244706 =
Comm:
sh Tainted: G    B        L      6.19.0+ #3 PREEMPT(voluntary)=20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920670] Tainted: [B]=3DBAD_PAGE,
[L]=3DSOFTLOCKUP
Feb 10 17:56:18 ceph-0005 kernel: [20537.920671] Hardware name: QEMU Standa=
rd PC
(i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
Feb 10 17:56:18 ceph-0005 kernel: [20537.920673] RIP:
0010:pv_native_safe_halt+0xb/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920680] Code: 20 d0 c3 cc cc cc cc=
 0f
1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 =
0f 00
2d 87 05 11 00 fb f4 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90
90 90 0f
Feb 10 17:56:18 ceph-0005 kernel: [20537.920682] RSP: 0018:ffff88817b36f780
EFLAGS: 00000246
Feb 10 17:56:18 ceph-0005 kernel: [20537.920685] RAX: 0000000000000001 RBX:
ffff8881ef8c3f80 RCX: ffff8881ef8c3f94
Feb 10 17:56:18 ceph-0005 kernel: [20537.920686] RDX: 0000000000000004 RSI:
0000000000000001 RDI: ffff8881ef8c3f94
Feb 10 17:56:18 ceph-0005 kernel: [20537.920687] RBP: ffff88817b36f798 R08:
ffff8881ef8c3f94 R09: 0000000000000001
Feb 10 17:56:18 ceph-0005 kernel: [20537.920689] R10: 0000000000000000 R11:
0000000000000000 R12: ffffffff8c4c9fc0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920690] R13: ffff8881ef8c3f88 R14:
fffffbfff18993fa R15: ffffffff8c4c9fd4
Feb 10 17:56:18 ceph-0005 kernel: [20537.920691] FS:  000070ca48cb8740(0000=
)
GS:ffff8882633fa000(0000) knlGS:0000000000000000
Feb 10 17:56:18 ceph-0005 kernel: [20537.920692] CS:  0010 DS: 0000 ES: 000=
0
CR0: 0000000080050033
Feb 10 17:56:18 ceph-0005 kernel: [20537.920694] CR2: 0000000000cf4101 CR3:
000000010d771001 CR4: 0000000000772ef0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920697] PKRU: 55555554
Feb 10 17:56:18 ceph-0005 kernel: [20537.920698] Call Trace:
Feb 10 17:56:18 ceph-0005 kernel: [20537.920699]  <TASK>
Feb 10 17:56:18 ceph-0005 kernel: [20537.920699]  ? kvm_wait+0x116/0x170
Feb 10 17:56:18 ceph-0005 kernel: [20537.920704]  ?
__kasan_check_write+0x14/0x30
Feb 10 17:56:18 ceph-0005 kernel: [20537.920708]=20
__pv_queued_spin_lock_slowpath+0xa85/0xf80
Feb 10 17:56:18 ceph-0005 kernel: [20537.920711]  ?
__pfx___pv_queued_spin_lock_slowpath+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920712]  ? __pfx_down_read+0x10/0x=
10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920715]  _raw_spin_lock+0xe0/0xf0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920716]  ?
__pfx__raw_spin_lock+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920718]  ?
__kasan_check_write+0x14/0x30
Feb 10 17:56:18 ceph-0005 kernel: [20537.920720]  ? _raw_spin_lock+0x82/0xf=
0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920721]  drop_pagecache_sb+0x134/0=
x270
Feb 10 17:56:18 ceph-0005 kernel: [20537.920724]  __iterate_supers+0x1df/0x=
240
Feb 10 17:56:18 ceph-0005 kernel: [20537.920726]  ?
__pfx_drop_pagecache_sb+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920728]  iterate_supers+0x10/0x20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920729]=20
drop_caches_sysctl_handler+0x8f/0xd0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920731]=20
proc_sys_call_handler+0x467/0x6a0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920734]  ?
__pfx_proc_sys_call_handler+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920736]  ?
apparmor_file_permission+0x1c/0x30
Feb 10 17:56:18 ceph-0005 kernel: [20537.920740]  ?
security_file_permission+0x53/0x150
Feb 10 17:56:18 ceph-0005 kernel: [20537.920743]  proc_sys_write+0x13/0x20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920744]  vfs_write+0x53c/0xf90
Feb 10 17:56:18 ceph-0005 kernel: [20537.920747]  ? __pfx_vfs_write+0x10/0x=
10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920749]  ? set_ptes.isra.0+0xd3/0x=
190
Feb 10 17:56:18 ceph-0005 kernel: [20537.920752]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920754]  ? fdget_pos+0x1de/0x600
Feb 10 17:56:18 ceph-0005 kernel: [20537.920757]  ksys_write+0xfc/0x230
Feb 10 17:56:18 ceph-0005 kernel: [20537.920759]  ? __pfx_ksys_write+0x10/0=
x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920761]  ?
__handle_mm_fault+0x134e/0x1da0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920763]  ? do_syscall_64+0xbf/0x5d=
0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920766]  __x64_sys_write+0x72/0xd0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920768]  ?
__pfx___handle_mm_fault+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920770]  x64_sys_call+0x79/0x2360
Feb 10 17:56:18 ceph-0005 kernel: [20537.920772]  do_syscall_64+0x82/0x5d0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920774]  ?
__pfx_css_rstat_updated+0x10/0x10
Feb 10 17:56:18 ceph-0005 kernel: [20537.920778]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920780]  ?
count_memcg_events+0x25b/0x3e0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920783]  ? handle_mm_fault+0x38b/0=
x6a0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920785]  ? __kasan_check_read+0x11=
/0x20
Feb 10 17:56:18 ceph-0005 kernel: [20537.920787]  ?
fpregs_assert_state_consistent+0x5c/0x100
Feb 10 17:56:18 ceph-0005 kernel: [20537.920790]  ? irqentry_exit+0xa5/0x60=
0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920791]  ? exc_page_fault+0x95/0x1=
00
Feb 10 17:56:18 ceph-0005 kernel: [20537.920794]=20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Feb 10 17:56:18 ceph-0005 kernel: [20537.920796] RIP: 0033:0x70ca48b14907
Feb 10 17:56:18 ceph-0005 kernel: [20537.920799] Code: 10 00 f7 d8 64 89 02=
 48
c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 =
75 10
b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 1=
8 48
89 74 24
Feb 10 17:56:18 ceph-0005 kernel: [20537.920800] RSP: 002b:00007fff41f65ba8
EFLAGS: 00000246 ORIG_RAX: 0000000000000001
Feb 10 17:56:18 ceph-0005 kernel: [20537.920802] RAX: ffffffffffffffda RBX:
0000000000000002 RCX: 000070ca48b14907
Feb 10 17:56:18 ceph-0005 kernel: [20537.920803] RDX: 0000000000000002 RSI:
00005bce02cab6b0 RDI: 0000000000000001
Feb 10 17:56:18 ceph-0005 kernel: [20537.920804] RBP: 00005bce02cab6b0 R08:
00005bcdfd1137ea R09: 00005bce02cab6b0
Feb 10 17:56:18 ceph-0005 kernel: [20537.920805] R10: 0000000000000077 R11:
0000000000000246 R12: 0000000000000001
Feb 10 17:56:18 ceph-0005 kernel: [20537.920806] R13: 0000000000000002 R14:
0000000000000000 R15: 0000000000000000
Feb 10 17:56:18 ceph-0005 kernel: [20537.920808]  </TASK>

Thanks,
Slava.

