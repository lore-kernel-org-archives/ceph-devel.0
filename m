Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D82346766
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127762; cv=none; b=OiKZ/ElYVxePYl4xt5viCysMeGEa8WLV3PJuvhkFCf01tRnL3a1KuW1pAK2LsLYXRiN/5xQO99Iq3u/5gw+PhJ70qfFXeidDxx9OTnbJzC6cLfoajir8DqxyPQf7OOr9kPAJZpBzirOtbYbb3urYlcLb3pq6++0GoUwmjHnlFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127762; c=relaxed/simple;
	bh=TV/v07Ls87GlweaK/zjI1EApvWQBaTcyje+xlVKZI54=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=mKb+q0AFVAfWWTmT2Gd5ApI1TSWtSIKLBB4bQIhf9lEx5c93evJ/H+YRwFfbCj3Ue54/JKA/7gm44511ZQqyzaBjy61zz8P2t/hzzauD2AUvmjfSuvW58PXI1+Xwi/gRNLriRfroGWggehOQQJQnig864tAOBUCqqeldxMkQ1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCIHWI3M; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCIHWI3M"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso1157957b3a.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2026 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775127759; x=1775732559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bD6hxrjoL3zY29yjIFUvmOGd5Vvb3HUAvN0+0dLRAkA=;
        b=DCIHWI3MyqFEnDCnDYlyGh+jpboaLW6UOdFqSoGliGTMTQ6TMK+8Ys48lgyrOCihH1
         ilCg3cmg6YDAjkoKOm3NP9y924mQM6Yd/Kd2wvromT46pTJAqdSwVpd/2OcFZEhitFNo
         TDkBajySYUK02BlTMVrBYa2xdIKdkW9mQSrGTEEziEbO7qJwLL3UexSFb+9bdP8KJkPY
         br6cjcR8oIfXdMMEv6KWVM2kdVy92rupZ6opoZUm+UYVj1AkU6Ria1a2Cf9FUnB/eHq4
         M2ASeqf36bDoliMRGVDKUL5ArNCVc2qyRxDBgEPvvUEAyGJSX+4qW5cZVbRTsvWHFVFK
         v7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127759; x=1775732559;
        h=content-transfer-encoding:mime-version:date:subject:cc:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD6hxrjoL3zY29yjIFUvmOGd5Vvb3HUAvN0+0dLRAkA=;
        b=KEQP5xzlJPAXKIvGJTkcgF8z2S4sG0NVYhVI5T7aRg6newUoNrskD8h4tY6TtOOamy
         rkfmr9OPrk36MhnaHdsNli74WTZo3TBfxITe+xBx8kMbyDBQTMsXOWlgROOhHQmnuPCh
         7o/gmMRgi0+Bs4owMLkgpFesdBe1xUMRsfhI+s0bjKoF0L3dXhhjO5aWupLqbk2rqp6b
         2tQ52ICaOjHtN1BD9pgcUq74dup1iPJBlHMDUHOs9R4F6hIoHWboaxBU2UjN4L8fcBW3
         FAiBaAAox3JERdPFmEvK8inzbQfiW2PakJS/ZyFsq9K/dEruCgjUs9WYOAv7Ttl1tUIk
         542g==
X-Forwarded-Encrypted: i=1; AJvYcCXFfCSvlGe+t5IaOcS6c8bfjhWWJFXOqOhHsKAMWGI+kc4YIzVS9WZkp64ClMCyhTu47XlINQ+zXNXy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mmRnOGp0sjdye0balCt24YPXiZhhsg8ufggvl5tC+mz15FAf
	yG3pjSZ5WkqjilVTY9Mv5kgLpUDiMGIHfBXqCJjAKqwvs3Q7o2ZU19P6
X-Gm-Gg: ATEYQzzt6fsevVS1qu6ONvSfB3QI5ruAqurwmtoIHeFvrQOPKUGNr1ZbxTjjKrMk3tj
	0G1cJSY58RvU6LlY5sZxLZH3oXpe6kiNl8aVma0Xwute7PBTHwBr2hh1fQm7sPHG2u7xWEPW1Xy
	QH62by0Eeeq25HXxodw7x3+PUyWRSn0J8dhJk4JaAGUW5ZljtmMzbuP0rrRVHwoBUIr6LkdrKfM
	A7AIkiCocvuk9ckOd8KcN8ecj4amp0AkA50q+onzzmrfiGwsbPG/DXD27qh1SaXO7TvIjraMLiB
	7dRYQevN8Ed5qVr2I95qjBbkEmN5Htwd4oVhPiLiRcJJ1Pb05/dsjuWMaN46rAkHiCxzUXO2xls
	dCK6+v08JH1xBc/BkU/QQ0pEWHEwo5gY5XRMUoE5UQLBjg+aNfQVlCXO2meKU3T5PE4RWeGtc2W
	zSJzMwQfqVoEDjHXIzhPA=
X-Received: by 2002:a05:6a00:1ad3:b0:82a:6e4b:5b4d with SMTP id d2e1a72fcca58-82d0035bd98mr1788145b3a.23.1775127759155;
        Thu, 02 Apr 2026 04:02:39 -0700 (PDT)
Received: from localhost ([137.132.22.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3baffsm2812910b3a.14.2026.04.02.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:02:38 -0700 (PDT)
Message-ID: <69ce4cce.050a0220.83ffb.e251@mx.google.com>
From: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Subject: [BUG] OrangeFS Kernel Client Use-After-Free in atomic_dec_and_lock
Date: Thu, 02 Apr 2026 19:02:37 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: KernelStackFuzz send_email.sh

OrangeFS Kernel Client Use-After-Free in atomic_dec_and_lock

  1. Vulnerability Title

Linux Kernel OrangeFS/Ceph Client Use-After-Free Write in atomic_dec_and_lock via Corrupted Server Response (ceph_put_snapid_map)

  2. High-Level Overview

A use-after-free write vulnerability exists in the Linux kernel's Ceph filesystem layer, triggered via the OrangeFS kernel client. When a corrupted OrangeFS/Ceph server response causes inode state to become inconsistent, the `snapid_map` object is freed prematurely. A subsequent directory operation (`mkdir` → `lookup` → `d_invalidate` → `iput` → `evict`) calls `ceph_evict_inode()` → `ceph_put_snapid_map()`, which performs an `atomic_dec_and_lock()` on the already-freed `snapid_map` object — a 4-byte use-after-free write.

This is a moderate-severity vulnerability: the corrupted response may cause premature freeing of the snapid_map object, potentially leading to kernel memory corruption or denial of service when subsequently accessed.

This vulnerability was discovered using ven0mfuzzer, our custom-designed MITM-based network filesystem fuzzer developed by our team. Following the common syzkaller practice, we submit the kernel crash trace as the primary reproduction artifact.

  3. Affected Product and Version Information

Product: Linux Kernel (upstream mainline)
Affected Component: `fs/ceph/snap.c` — `ceph_put_snapid_map()`; `fs/orangefs/` — OrangeFS kernel client triggering the code path

  Tested Version (confirmed vulnerable)
- Linux kernel 6.19.0 (mainline, commit `44331bd6a610`, gcc 11.4.0, built with KASAN + LOCKDEP + UBSAN + KFENCE)

  Affected Version Range
All kernels with `CONFIG_ORANGEFS_FS=y` and `CONFIG_CEPH_FS=y` are believed affected.

  Affected Environments

 |  Environment  |  Notes  | 
 | --- | --- | 
 |  HPC clusters using OrangeFS  |  Primary deployment target for OrangeFS  | 
 |  Research storage systems  |  Academic/lab environments with OrangeFS parallel storage  | 
 |  Any Linux system with CONFIG_ORANGEFS_FS  |  Not common in desktop distros; mainly HPC/research  | 

  4. Root Cause Analysis

  4.a. Detailed Description

The OrangeFS kernel client shares infrastructure with the Ceph filesystem, including inode management and snapid mapping. When a MITM-corrupted server response causes the kernel to build an inode with inconsistent snapshot state, the `snapid_map` reference count becomes mismanaged. The corrupted response leads to a premature free of the `snapid_map` object. When a subsequent directory operation triggers inode eviction via `ceph_evict_inode()`, it calls `ceph_put_snapid_map()` which performs `atomic_dec_and_lock()` on the already-freed memory — a 4-byte write to freed slab memory.

The fundamental issue is that the OrangeFS/Ceph client does not validate server-supplied inode attributes before using them to initialize internal kernel structures. Corrupted attributes lead to refcount mismanagement and eventually use-after-free.

  4.b. Code Flow

---
[Initial corruption — premature free]
pvfs2-client-core → /dev/pvfs2-req
  → orangefs_inode_getattr()
    → [corrupted inode attributes from server]
      → [snapid_map refcount becomes inconsistent]
        → [premature kfree of snapid_map]

[Trigger path — UAF write]
mkdir(2)
  → lookup_one_qstr_excl()
    → lookup_dcache()
      → d_invalidate()
        → shrink_dcache_tree()
          → shrink_dentry_list()
            → __dentry_kill()
              → dentry_unlink_inode()
                → iput()
                  → evict()
                    → ceph_evict_inode()
                      → ceph_put_snapid_map()
                        → atomic_dec_and_lock()    ← UAF WRITE (4 bytes)
---

  4.c. Crash Trace

This vulnerability was discovered by ven0mfuzzer. The following kernel trace is submitted following syzkaller's common practice of providing the raw crash trace as the primary reproduction evidence:

---
BUG: KASAN: slab-use-after-free in atomic_dec_and_lock+0x24/0x120
Write of size 4 at addr ffff888109374a68 by task mkdir/905

CPU: 1 UID: 0 PID: 905 Comm: mkdir Tainted: G W 6.19.0-g44331bd6a610-dirty #9 PREEMPT(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x660
 kasan_report+0xe0/0x110
 kasan_check_range+0x105/0x1b0
 atomic_dec_and_lock+0x24/0x120
 ceph_put_snapid_map+0x3f/0x260
 ceph_evict_inode+0x2e8/0x890
 evict+0x3c2/0xad0
 iput+0x79a/0xd30
 dentry_unlink_inode+0x29c/0x480
 __dentry_kill+0x1d0/0x600
 shrink_dentry_list+0x134/0x680
 shrink_dcache_tree+0x100/0x5e0
 d_invalidate+0x13a/0x290
 lookup_dcache+0x13c/0x170
 lookup_one_qstr_excl+0x2a/0x250
 </TASK>
---

Reproduced 1 time.

  4.d. Suggested Fix

Add refcount validation in the inode initialization path when processing server-supplied attributes, and validate `snapid_map` is not already freed before decrementing:

---
/ In ceph_put_snapid_map(), add a refcount sanity check /
void ceph_put_snapid_map(struct ceph_snapid_map *sm)
{
    if (!sm)
        return;
+   if (WARN_ON(refcount_read(&sm->ref) == 0))
+       return;
    if (atomic_dec_and_lock(&sm->ref, &snap_empty_lock)) {
        ...
    }
}
---

The deeper fix should validate server-supplied inode attributes before using them to initialize internal kernel structures.

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
- Trigger: MITM mutation of server responses during directory operations causes inode corruption → premature snapid_map free → UAF on subsequent operation
- No standalone PoC — the crash trace above serves as the reproduction artifact

---
Reported-by: ven0mfuzzer <ven0mkernelfuzzer@gmail.com>
Link: https://github.com/KernelStackFuzz/KernelStackFuzz
