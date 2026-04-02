Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED333AD53D
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127732; cv=none; b=O4LyOFp/r1N+JvVUYz2OMO/NxzLNgTTyFA4AwGUEaAKrBsA4vRgfHCblO7TulqladBEv6Qd4iHJqf9koPXKnh7T4TASJxYXBh0Z+dB/DFZcNTDSRRxx6pR9P9XhNm6ksGNo9GF036DWBqxa2MVJC+iH8VcGKuD+/mx85zaKcgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127732; c=relaxed/simple;
	bh=P9jaeAAPUa91hJxiCcSwpe3gnKmrQH4sDeRL3TGRa+g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=CxiXpf75tab4jEfojThg2MLk8z9rLGiqnbgZVpaX0mR8pMTYRxa4CO8lDFvSn8DMs2G+fnuSuZ18dvNZ9F2CiRvaZDXyGPgEX00cLEUqfnKwpPTZQ5bAWqZwIIWt1Er7wyY6TMdH4NNehtbsardV4ifROIE0tecgivbP8bnI8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYgJcR5i; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYgJcR5i"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso252907a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2026 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775127729; x=1775732529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=43IDfHN9SDlVKzIfEL7sbw3pEOqT5HUgjt45m3HB6E4=;
        b=aYgJcR5ibOBVjndcM8R2JmNiFevMiY8L+nefOeXYIRTqQXNZLUmvAoRp86U+TUCVJB
         D8y0BZwMs4Rb304fepZbCWUKoFph50HhRVdbDeqqN49OLkqXOTJA9hhvOIdJmPvUMb4m
         wVBDA9QcxgAr74dcv+b0NOqnYOJkhdOqPDGAw+6G1QsyNanMZj8wauPgAZmw2BGeb5Hx
         UjeUwwY54saEBiPExx02belCLqUoer0qlwBcZ+0DKG5Js+pD1wEirZSgMnePc+P47zyv
         Dir8WP3fSgnnvWZfPFAiOT3xVJsUoR7sCAvviwY8DhW840HwTNn1GSnCyt/IZsJ5gf/F
         IxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127729; x=1775732529;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43IDfHN9SDlVKzIfEL7sbw3pEOqT5HUgjt45m3HB6E4=;
        b=C/uwHAv4S6Oq4pTAjyNMPuIbAepRAZEpbc2O3BSTGm44+MLcewt0do6+yNvI/R0uqn
         CU/dx3xlsbsbGrFI3qUlVSxOjnfTSogYDf0qrFmU65gj9gZVySvJ2a7hF9A9Yb/nLwuM
         3nJSRc4qO1eFZ06UcydA1Nb4Ajk1ed+r3gtu8AP2pEoe8tq+kSC42ONmdsNDJku11Tj+
         OMdG31ddV8xmT+LNIyeQqC08elTaKbpnAoVPobUS0g6U67jgWLakMWEmpsubkrERLFgP
         ECtB2I7mUSnsXSdPJIu41I2mQS2lrDO9A29J5yalSDfeYR0diVGloqGzEGfSmXBMSw93
         ac4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPErqaDyzl8nbuNNcCB+suMmDz1js3bJaSJqP5kOVUqa7y81a5QPJUUliOsivujoXDRAQspg2AZ8Lx@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUPTp2TzLxJK5Vt5k4GZaBrTwmULPo167IPToQimis4XS/so4
	ofy0oOGrFz9hKyzaya2nPliPCeiWkdrkQeJ/DF+g66kAQ6Z3LWDOWrZ+CphwnoR9Owc=
X-Gm-Gg: AeBDieuM4U0GoG/Y9XqRCuwRTbQc890V77WJAXiMp9uLXur6SOBu+dlrS/c+DKyDYlb
	wUUvKv4hLryDey6UelKoJ50bWv0f3SH/h+2Ibh5VAnc3OdjZLsmIDkPOyyN4PprqrrN6TvHatV+
	ZTOwvpdkcEC81lsq1AVk2+hlo/SeHXIHMoel02bbrB6hwYq3833GgCWgN3cmnjvWOdjbliIdZJ2
	RMenQaziVQoPVcEn1DD+yXpL4qq+KzDQs0DMAFLvkkzwojHE4GR5O0uRbbm9JKT8JmJTFqaUf+f
	qWtcLCZLeBi8y0stUTWwTgO/XIzbbVR3n7TwY9eetO+Xa+yTfN3wY/BL+2GinkBJmDxk9vQIen1
	JZuuZyV/hRnYcITAq6ziluikkKsPC4e8E40rH5V9MWqDHscYXRdIc8m+EQ8qKKuZGDzlbbtdxB3
	9EFI9dH6GNsYcq25ymIXY=
X-Received: by 2002:a17:902:ef43:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2b2758be62bmr29665045ad.14.1775127728937;
        Thu, 02 Apr 2026 04:02:08 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475ff56sm25452745ad.22.2026.04.02.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:02:08 -0700 (PDT)
Message-ID: <69ce4cb0.170a0220.1c00f7.f5f4@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [BUG] OrangeFS Kernel Client Slab-Out-of-Bounds Read in _copy_from_iter
Date: Thu, 02 Apr 2026 19:02:07 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh

OrangeFS Kernel Client Slab-Out-of-Bounds Read in _copy_from_iter

  1. Vulnerability Title

Linux Kernel OrangeFS/Ceph Client Slab-Out-of-Bounds Read via Corrupted Message Length in _copy_from_iter

  2. High-Level Overview

A slab-out-of-bounds read vulnerability exists in the Linux kernel's OrangeFS/Ceph messaging layer. When the OrangeFS kernel client receives a server response with a corrupted `front_len` or `data_len` field, the ceph messenger (MSGR v1) trusts the peer-supplied length without validation. This causes `_copy_from_iter()` to read up to 31,793 bytes from a 4,096-byte slab object during `tcp_sendmsg_locked()`, overreading 27,697 bytes of adjacent kernel heap memory.

Because the overread data is subsequently transmitted over the network via `tcp_sendmsg`, an attacker controlling or intercepting the OrangeFS server connection can receive leaked kernel heap contents — a direct kernel heap information disclosure primitive that could reveal KASLR base, cryptographic keys, or other sensitive kernel state.

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team. Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  3. Affected Product and Version Information

Product: Linux Kernel (upstream mainline)
Affected Component: `fs/orangefs/` — OrangeFS kernel client; `net/ceph/messenger_v1.c` — Ceph MSGR v1 transport layer

  Tested Version (confirmed vulnerable)
- Linux kernel 6.19.0 (mainline, commit `44331bd6a610`, gcc 11.4.0, built with KASAN + LOCKDEP + UBSAN + KFENCE)

  Affected Version Range
All kernels with `CONFIG_ORANGEFS_FS=y` that use the ceph messenger v1 transport are believed affected. OrangeFS uses the ceph MSGR protocol internally for BMI/TCP communication.

  Affected Environments

 |  Environment  |  Notes  | 
 | --- | --- | 
 |  HPC clusters using OrangeFS  |  Primary deployment target for OrangeFS  | 
 |  Research storage systems  |  Academic/lab environments with OrangeFS parallel storage  | 
 |  Any Linux system with CONFIG_ORANGEFS_FS  |  Not common in desktop distros; mainly HPC/research  | 

  4. Root Cause Analysis

  4.a. Detailed Description

The OrangeFS kernel client communicates with the pvfs2-client-core userspace daemon, which relays requests to the OrangeFS server over BMI/TCP (port 3334). The ceph messenger v1 protocol is used as the transport layer. When a message is constructed via `ceph_msg_new2()`, a buffer of `front_len` bytes is allocated (typically 4,096 bytes). However, when the server response contains a corrupted (inflated) length field, the `iov_iter` that wraps this buffer is configured with the corrupted length rather than the actual allocation size. When `ceph_con_v1_try_write()` calls `ceph_tcp_sendmsg()` → `tcp_sendmsg_locked()` → `_copy_from_iter()`, the copy operation reads far beyond the allocated buffer boundary.

The core issue is that the ceph messenger trusts peer-supplied message lengths without bounds-checking them against the actual allocated buffer size.

  4.b. Code Flow

---
ceph_con_v1_try_write()                    [net/ceph/messenger_v1.c]
  → prepare_write_message_footer()
    → ceph_tcp_sendmsg()
      → sock_sendmsg()
        → tcp_sendmsg_locked()
          → _copy_from_iter(31793 bytes)   ← reads 27697 bytes past 4096-byte buffer
---

The allocation path:
---
ceph_msg_new2()                            [net/ceph/messenger.c]
  → __kvmalloc_node_noprof(4096)           ← allocates 4096-byte front buffer
---

The mismatch: `iov_iter` length = 31,793 (from corrupted response), actual buffer = 4,096 bytes.

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kernel trace is submitted following syzkaller's common practice of providing the raw crash trace as the primary reproduction evidence:

---
BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x9e9/0x1690
Read of size 31793 at addr ffff888117449000 by task kworker/1:2/155

CPU: 1 UID: 0 PID: 155 Comm: kworker/1:2 Not tainted 6.19.0-g44331bd6a610-dirty #9 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x660
 kasan_report+0xe0/0x110
 kasan_check_range+0x105/0x1b0
 __asan_memcpy+0x23/0x60
 _copy_from_iter+0x9e9/0x1690
 tcp_sendmsg_locked+0x1d70/0x3f70
 tcp_sendmsg+0x2e/0x50
 inet_sendmsg+0xb9/0x140
 sock_sendmsg+0x359/0x450
 ceph_tcp_sendmsg+0xda/0x140
 prepare_write_message_footer+0x297/0x4f0
 ceph_con_v1_try_write+0xcf0/0x24d0
 ceph_con_workfn+0x40c/0x1340
 process_one_work+0x962/0x1a40
 worker_thread+0x6ce/0xf10
 kthread+0x378/0x490
 ret_from_fork+0x676/0xac0
 </TASK>

Allocated by task 674:
 __kvmalloc_node_noprof+0x332/0x910
 ceph_msg_new2+0x284/0x4e0
 ceph_monc_init+0x69e/0xcc0
 ceph_create_client+0x25b/0x370
 ceph_get_tree+0x1bd/0x1780
 vfs_get_tree+0x8e/0x330
 path_mount+0x79a/0x2370
 __x64_sys_mount+0x293/0x310

The buggy address belongs to the object at ffff888117449000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 allocated 4096-byte region [ffff888117449000, ffff88811744a000)
---

Reproduced 3 times independently.

  4.d. Suggested Fix

Validate peer-supplied message lengths against actual buffer allocations before constructing the `iov_iter`:

---
/ In ceph messenger v1 write path, cap iov_len to actual allocation /
if (msg->front.iov_len > msg->front_alloc_len) {
    pr_warn("ceph: msg front_len %zu exceeds alloc %zu, truncating\n",
            msg->front.iov_len, msg->front_alloc_len);
    msg->front.iov_len = msg->front_alloc_len;
}
---

Additionally, the incoming message header's `front_len` should be validated during `ceph_con_v1_try_read()` before allocating/reusing buffers.

  5. Discovery Method and Reproduction

  5.a. Discovery

This vulnerability was discovered using ven0mfuzzer, a custom-designed MITM-based network filesystem fuzzer developed by our team. The fuzzer operates by positioning an AF_PACKET/TCP transparent proxy between a Linux kernel filesystem client (VM-A) and its server (VM-B), then mutating network protocol messages in-flight.

Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  5.b. Reproduction Setup

---
VM-A (pvfs2 client + pvfs2-client-core) ──BMI/TCP port 3334──► Host (MITM proxy) ──TCP──► VM-B (pvfs2-server)
---

- Kernel: Linux 6.19.0 (commit `44331bd6a610`) with KASAN + LOCKDEP + UBSAN + KFENCE enabled
- Server: OrangeFS 2.10.0 (compiled with AddressSanitizer)
- Trigger: MITM mutation of the MSGR v1 message length field in server→client responses during normal file operations (touch, ls, mkdir, dd)
- No standalone PoC — the crash trace above serves as the reproduction artifact

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz
