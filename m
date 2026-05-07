Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030BA3101B2
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182700; cv=none; b=GXzGjNczmcj5ii+IwlWPB4kZ1Upi/DNh/JCMLa5f5KwS94QpEZXK8vHMb3XIOtRNNvShRokTiNyTGU4YEdhyHjw6Lf5cXZvi2a8TVjieHNAc+8E6Cr9YbT+WdJQtHfY1d+ThTaL71dHBhbxSsX3+wjhnUey5lFhyUx1+7nVP3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182700; c=relaxed/simple;
	bh=lmBVhPiXNWdotA2XbPDP/Uw2gHEZnGNmD8+LSFxYSdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APV1MdsfuEF5NW8XZ3CoK2rO0GNnCvEO+1hOeMcBRuUY+QZFOE5mM62l+1REnfRF0DmI0Ob9ywgTbolpIYppRHS0ZpoPLPfOUSBPQ3973/acKcZoobp8A6OBIpD9qpqZXDRfqXErOWmV1Ip51omROEbyZdhU5GKldM7i+HLBIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/Mx0t/x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pj6/7a/i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/Mx0t/x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj6/7a/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778182698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnEc44kIOHQBJpfHu8p9w5K8K4zb1TfoMK/e6e0NibQ=;
	b=i/Mx0t/xTzxCJlpvMAZPG2GNe+s1L9y8qIYB7QQlKOqFRveEfDStKFNoePYSeHOjiHw3fs
	s2622DFVEZ6NLWNiWWjZR41UbIqK1euaz8yIRzTF49Ot0YqVIRroEpxhjXJzkY1WU78T3X
	qzcU+CmEFnDtx0Do9zTJCoo70kTzPwU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-G1ooABF5MSSVeDLaxwOBsA-1; Thu, 07 May 2026 15:38:15 -0400
X-MC-Unique: G1ooABF5MSSVeDLaxwOBsA-1
X-Mimecast-MFC-AGG-ID: G1ooABF5MSSVeDLaxwOBsA_1778182695
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7bdf99ee592so37442327b3.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778182694; x=1778787494; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wnEc44kIOHQBJpfHu8p9w5K8K4zb1TfoMK/e6e0NibQ=;
        b=Pj6/7a/iPxGgLVqIvfGHHj/N87tEs93aYcvNKvd8xTtgJC7aogeimhZT8RERzsvZr8
         pHoWmWBO56O3Yumw6nZbzODExq/V5G1pVc1Xif+zHL+uEeDR1FgVGKsvF3VM7XNVVbvF
         fLLhXeHV2coTPHEaneYENURR3ycwG+zCAkq/SNXNBjFRKchhtUAKlNxQ7Leozk6QUSHn
         WP+qrtBQIN5/PugtndDJQuWfUWtlW7uZITtVLLD6pRyFdUZq9+ktUzDXexY44mloiyuM
         hY88yafBCZTm3NDPC/7tSXz4PFIyVSVPGicRkyiAUpAbRGM+YjnZTOeGa7SDKG4dnwBH
         P4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182694; x=1778787494;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnEc44kIOHQBJpfHu8p9w5K8K4zb1TfoMK/e6e0NibQ=;
        b=elNisT/jKMGSh7vQyzDjk0GGsyMbF/H70kZ/IxJyQ6Lh9YIUFqtok4JG72ASD6qHxx
         1VgcAXV+1Pg6k1irvY4dFqGXZvEs5LFnNpv/Ixtf2zjckh5POZu0L+Tcik4MqKFXqavQ
         NnXHoB4Qyms7oN/OkjFoAkLqQWCYftomUFCtFPyTuF74J8pHgkqdgRmFQh9Iy6odELAn
         SaVWuSTMLE/tBDh6Nnj9tFHD0azZ2/BHRlAlM/TTHZ84ceMK6ekHDk22BNKKhOz7nFlD
         B3IXbcJpA7y4RMBarfp5VqtcicNGx8rkElYQBHCh608IRR6cQKxbk5LsR9AzJb6+vjp3
         Y+Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+ehL4zunBXtThTym4PfnX0YhyV3Y3Tz/m3Dyn7cWStafROXd2wRBSVKm/cysBxuiFbOPuil36z4bx8@vger.kernel.org
X-Gm-Message-State: AOJu0YyYX6UCpPE3rFXet10YPUjoQyYJVMO5s3Hk4bJp8SltaCtJIvd9
	boR+Yb9WXppaBMlIviUNdrJH9i+d4LWReVgoSm436wcfTWcI7lgD1A7ZvlqxS6gNF4r5I7ehp+2
	nXsDU87x0785CWWfyT+ojHRR2ioGR3nwUEIZ2wZBDN9WlWDmPYgrJLp1cr1sNZ02wu2Cv/8A=
X-Gm-Gg: Acq92OEjH9/H/xATsSjOPKKPooWF+b4fp7YFzbPOBUBz1qcfUwsklXWjwedJuw6eRHY
	1q9pcHDn5iRdioA6UXRueOQhbDltAHsdd43gLy7aiVDCkWvwGspOeMM9y5+cimHcyLUGVdBkRSL
	dNj0E/M+4yK/T0Yau9pk+V8ElMzj6UQZRSCTB1VSNSkw9fGPyXB1aYK6SD6ZveNpN9oRPWy/1bg
	kxQXs3M0qNCzSsozG7wgpRGbC8/bChOq5WYxFgR3nzWm0gGpY3GHl5TmiovHYeo6QfrYiZo/cOr
	KEhAyKATZxyEWPlX3WxKeft7lslhLxrX2OA914VXncJ4QsuIBV5aQyGK4941OO+1YKuyaKFQSTX
	kNKHnUSw3V2SvVb/cJM/7RTq3b9CcJ6URZKi/uZQlTibMc1I2dyam
X-Received: by 2002:a05:690c:6e86:b0:79f:3b8c:a7fc with SMTP id 00721157ae682-7bdf5efb295mr100666027b3.39.1778182694111;
        Thu, 07 May 2026 12:38:14 -0700 (PDT)
X-Received: by 2002:a05:690c:6e86:b0:79f:3b8c:a7fc with SMTP id 00721157ae682-7bdf5efb295mr100665767b3.39.1778182693608;
        Thu, 07 May 2026 12:38:13 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6688c99bsm98849097b3.45.2026.05.07.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:38:13 -0700 (PDT)
Message-ID: <56056dd82f7b34f04dec8390fe62305d98d5cbe8.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 11/11] selftests: ceph: wire up Ceph reset
 kselftests and documentation
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:38:12 -0700
In-Reply-To: <20260507122737.2804094-12-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-12-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> Wire the CephFS reset test suite into the kselftest build:
>=20
>   - Add filesystems/ceph to the top-level selftests Makefile.
>   - Add the per-suite Makefile with run_validation.sh as TEST_PROGS.
>   - Add the settings file (kselftest timeout).
>   - Add the MAINTAINERS entry for the test directory.
>   - Add README with prerequisites, usage, and troubleshooting.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  MAINTAINERS                                   |  1 +
>  fs/ceph/mds_client.c                          |  3 +-
>  fs/ceph/mds_client.h                          |  1 +
>  tools/testing/selftests/Makefile              |  1 +
>  .../selftests/filesystems/ceph/Makefile       |  7 ++
>  .../testing/selftests/filesystems/ceph/README | 84 +++++++++++++++++++
>  .../selftests/filesystems/ceph/settings       |  1 +
>  7 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/ceph/README
>  create mode 100644 tools/testing/selftests/filesystems/ceph/settings
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..bf6d973ac3fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5905,6 +5905,7 @@ B:	https://urldefense.proofpoint.com/v2/url?u=3Dhtt=
ps-3A__tracker.ceph.com_&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AX=
Mzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DcRBv-UtfmhjOUGCI7KVnj0A4bykzGklT8Ys=
3gWPOvguS8dyEz9b-bde2xdqTEBZi&s=3DwjFho6C-M1GiaFvcMzhan3RRBQEA-dyFGR2tqxUoJ=
y0&e=3D=20
>  T:	git https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com=
_ceph_ceph-2Dclient.git&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXM=
zc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DcRBv-UtfmhjOUGCI7KVnj0A4bykzGklT8Ys3=
gWPOvguS8dyEz9b-bde2xdqTEBZi&s=3D77jK11z0NzRQJxZXDRsicogOgD_d9u7-XA5-bhb99X=
A&e=3D=20
>  F:	Documentation/filesystems/ceph.rst
>  F:	fs/ceph/
> +F:	tools/testing/selftests/filesystems/ceph/
> =20
>  CERTIFICATE HANDLING
>  M:	David Howells <dhowells@redhat.com>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index b16638ebff7f..3b6560da8c4e 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2359,6 +2359,7 @@ struct flush_dump_entry {
>  static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
>  {
>  	struct ceph_client *cl =3D mdsc->fsc->client;
> +	int i;
>  	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES];
>  	struct ceph_cap_flush *cf;
>  	int n =3D 0, remaining =3D 0;
> @@ -2388,7 +2389,7 @@ static void dump_cap_flushes(struct ceph_mds_client=
 *mdsc, u64 want_tid)
> =20
>  	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
>  		       want_tid);
> -	for (int i =3D 0; i < n; i++) {
> +	for (i =3D 0; i < n; i++) {
>  		struct flush_dump_entry *e =3D &entries[i];
> =20
>  		if (e->ci_null)
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index b1a0621cd37e..731d6ad04956 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -121,6 +121,7 @@ static inline bool ceph_reset_is_idle(struct ceph_cli=
ent_reset_state *st)
>  {
>  	return READ_ONCE(st->phase) =3D=3D CEPH_CLIENT_RESET_IDLE;
>  }
> +
>  struct ceph_mds_cap_match {
>  	s64 uid;  /* default to MDS_AUTH_UID_ANY */
>  	u32 num_gids;
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 6e59b8f63e41..ab254ae793a9 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -32,6 +32,7 @@ TARGETS +=3D exec
>  TARGETS +=3D fchmodat2
>  TARGETS +=3D filesystems
>  TARGETS +=3D filesystems/binderfs
> +TARGETS +=3D filesystems/ceph
>  TARGETS +=3D filesystems/epoll
>  TARGETS +=3D filesystems/fat
>  TARGETS +=3D filesystems/overlayfs
> diff --git a/tools/testing/selftests/filesystems/ceph/Makefile b/tools/te=
sting/selftests/filesystems/ceph/Makefile
> new file mode 100644
> index 000000000000..4ad3e8d40d90
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS :=3D run_validation.sh
> +TEST_FILES :=3D reset_stress.sh reset_corner_cases.sh \
> +	      validate_consistency.py README settings
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/ceph/README b/tools/test=
ing/selftests/filesystems/ceph/README
> new file mode 100644
> index 000000000000..eb0092b38f80
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/README
> @@ -0,0 +1,84 @@
> +# CephFS Client Reset Test Suite
> +
> +Test suite for the CephFS kernel client manual session reset feature.
> +This trimmed set contains the single-client stress test, the targeted
> +corner-case test, and the one-shot validation harness used during
> +feature bring-up.
> +
> +## Prerequisites
> +
> +- Linux kernel with the CephFS client reset feature (this branch)
> +- A running Ceph cluster with at least one MDS
> +- Root access (debugfs requires it)
> +- Python 3 (for validators)
> +- flock utility (for lock tests, usually in util-linux)
> +
> +## Test inventory
> +
> +| Test | Script(s) | What it covers |
> +|------|-----------|----------------|
> +| Single-client stress | `reset_stress.sh` | I/O + resets + data integri=
ty on one mount |
> +| Corner cases | `reset_corner_cases.sh` | EBUSY, dirty caps, flock recl=
aim, unmount-during-reset |
> +| Validation harness | `run_validation.sh` | baseline + corner cases + m=
oderate/aggressive stress + final status check |
> +
> +## Quick start
> +
> +Stress run:
> +
> +    sudo ./reset_stress.sh --mount-point /mnt/cephfs --profile moderate
> +
> +Corner cases:
> +
> +    sudo ./reset_corner_cases.sh --mount-point /mnt/cephfs
> +
> +End-to-end validation:
> +
> +    sudo ./run_validation.sh --mount-point /mnt/cephfs
> +
> +## Stress profiles
> +
> +    baseline   - no resets, 1 IO + 1 rename, 600s
> +    moderate   - reset every 5-15s, 2 IO + 1 rename, 900s
> +    aggressive - reset every 1-5s, 4 IO + 2 rename, 900s
> +    soak       - reset every 5-15s, 2 IO + 1 rename, 3600s
> +
> +## Key options (all scripts)
> +
> +    --mount-point PATH   CephFS mount point (required)
> +    --client-id ID       Debugfs client id (auto-detected if one)
> +
> +reset_stress.sh additionally accepts:
> +
> +    --profile NAME       baseline|moderate|aggressive|soak
> +    --duration-sec N     Override profile runtime
> +    --no-reset           Disable reset injection
> +    --out-dir PATH       Artifact directory
> +
> +## Corner case tests
> +
> +    [1/4] ebusy_rejection       Second reset rejected while first in-fli=
ght
> +    [2/4] dirty_caps_at_reset   Reset with unflushed dirty caps
> +    [3/4] flock_after_reset     Stale lock EIO + fresh lock after holder=
 exit
> +    [4/4] unmount_during_reset  umount during active reset (destroy-path=
 wakeup)
> +
> +Test 4 requires creating a second CephFS mount instance and SKIPs if
> +the host cannot do so.  See `--help` output for details.
> +
> +## Troubleshooting
> +
> +**No writable Ceph reset interface found:**
> +Kernel lacks the reset feature, debugfs not mounted, or not root.
> +Check: `ls /sys/kernel/debug/ceph/*/reset/`
> +
> +**Multiple Ceph clients found:**
> +Use `--client-id` to select one.
> +List: `ls /sys/kernel/debug/ceph/`
> +
> +## Files
> +
> +| File | Role |
> +|------|------|
> +| `reset_stress.sh` | Single-client stress test runner |
> +| `validate_consistency.py` | Single-client post-run validator |
> +| `reset_corner_cases.sh` | Corner case harness (4 sequential tests) |
> +| `run_validation.sh` | One-shot validation harness |
> diff --git a/tools/testing/selftests/filesystems/ceph/settings b/tools/te=
sting/selftests/filesystems/ceph/settings
> new file mode 100644
> index 000000000000..79b65bdf05db
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/settings
> @@ -0,0 +1 @@
> +timeout=3D1200

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

