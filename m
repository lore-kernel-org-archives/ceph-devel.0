Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CA23E32B
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224443; cv=none; b=lRo0wy6X/YoxNEUsR9keDdKP2ErieKX5dg6c7pOZwerrej9FMtxIVKAwJzbI9LYT39VNJ2pz5t9xkxeHuhTkdj83wGlH20KIZ9lEyN+tDq85PRDu6Au0Lru4YxvQtVuHoxOr4ZxaFKUtGnGKAoKBscW51nWELi0FxxXC3rBkR8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224443; c=relaxed/simple;
	bh=hx277u65/fzGNUl+wVDdWk92PAb2Koe4lYjW7etulnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEMYlj4hUTNyI3NyI16EMKHzFCGHnaDAPqNQG7UfktovXOieEr+lvV3FwVgHwlGgu5dheDkyRkO+nq4EGAaZU69wYenNy/6fw4fRKMPOcLI4+c0knU/M6DlglH7REFyMFuyEhq+iwaOw6ezos9koBkT29TBjDC3QIafkeGko6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjLC2/Ii; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjLC2/Ii"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d7fdb922a5so4999469a34.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Apr 2026 20:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776224438; x=1776829238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5QrcX++J0nRyJXYFuEZ6avVXz1u4CwVJN9SMD/1CtM=;
        b=fjLC2/IiW4wn3WUK29YN5vvBxXvrGqfDiqUTh8vNJQvCPDj3Hqq0I8/DA7UxWNIsCU
         0jrVvLT8JndPObJWTkwTrFAV/s2A+JQ7ABvKsUcu/39EwE0WZljx5NfVAeTMff5W1oWK
         FrU8b9KZ9uDMWpvSPTcbQnCxUfDvW2owYNqgYey7R1SmMIV4kMWb3ohBvMhgciKJIWgg
         1n/cSZrnEcIlrAAMyTkG38Qyd0CxUcCvkCiLJCEei7iwbKQr3sXNCvrRXHVmfDhxvX6m
         gm2aY4YNmn3UVt1hEzPXkB4reHgSE+VpbgfmyzefV/xAsoQf5jEwMUAcBfXrAAolaLF/
         sVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224438; x=1776829238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5QrcX++J0nRyJXYFuEZ6avVXz1u4CwVJN9SMD/1CtM=;
        b=j+xFZymZ9cRgHVgJdug3Q0uSYbNOZEQK+poj8rztZFE9lRiXVMl3SRf5ahQmIT9l0u
         qGnxQKfqiW4YyZrJ8/T/fbXkoRk1zEPPJqTAPOnvX6rJwrApgx9KTFM9V3zt2t5yhSD7
         vFJarIdD1kaWC0VcYIaBf1CYgOSA5crshoCn/+3mTYhG2yONjonzUTYWBazy97Tm5GMT
         1FxVMnsHF2zFIujxvck4yrzS0far5DZ/NX6fWLA+c2rxUvq0jmdaSe9x6rZaparQAWwH
         mhNIJ6qLvz666ITg0PQinKOJo1CFoGrWNr8fqbh8s9ZUFZovFrQU6gNhpBmkCXqeSWqt
         fFwg==
X-Gm-Message-State: AOJu0Yx1fpI4LV3t4xlbIrbLUIEOJcj80YKldHH+QjuMA3KhymjIRYdr
	UD0YfwH0r4lf1jFYo7DYgji4oTR3Fsl7WiDgLN1UbyZjlo5WX72kjiNg
X-Gm-Gg: AeBDieuj7964euCm6efi/cmGl7HdoHo6ob/pePCtfIKak9iKqukkrBYZn+yUJQF74/f
	iwojyouOqGi5hz6lkJmYyG2ZmuVf6AUzGfs6LngyThqn2HuxhM8KH+XWakCyB99yc9YmdSgkpcQ
	d4AqpJgy+BAoD1IPfn3A7WiNEih41wy9kkPVL/cVpUXlYDUPoxK50ZhhqoQd78hkporf/1xWZ1+
	osUvO0sg5+y6wOJqb2f8MZ80NoO3Yz9A5h5OLD1lclQRm7zppFfCejkvZys/x3OisSZi1tE2rLL
	xP/oqz+5PVXi2kIOIazLIScs3P3YTl1dALkuaOJ6XLG1vkq6qihf6T1bdltAkrlWb2v3kEPn+3c
	txGY8FgUgPoVmN5w8dRwEy9z3jZ4vNdNF+G9t2V7IO2fhvkEipXeuGuhiiog08SFmQOuSfIQJq7
	gsHoNDFNLcJjsXZroXCOKr0CmnilAq7iLW2vZQIp6hrhiFhNltKBhlZodntusK7rJlNoYMyhGTR
	2oO42GW
X-Received: by 2002:a05:6830:4c0c:b0:7d9:b2ba:a35d with SMTP id 46e09a7af769-7dc27e878a0mr12102180a34.29.1776224437509;
        Tue, 14 Apr 2026 20:40:37 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7dc76b2c5ccsm518036a34.14.2026.04.14.20.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 20:40:36 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [RFC/BUG] Use a bounce buffer for mds client decryption
Date: Tue, 14 Apr 2026 20:40:20 -0700
Message-ID: <20260415034020.11530-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ceph list,

This is a combination RFC and bug report. I'm holding off cleaning up the patch
until I get confirmation that this is the right approach. There are some edge
cases stemming from complexities in ceph_fname_to_usr(), making this patch into
more of a shotgun bugfix than I'd like.

I have thoroughly tested this patch: In my live (AArch64) environment, certain
workloads would trigger this particular oops->panic 3-5 times per day. Since I
applied this patch ~2 weeks ago, I get no further panics. I do not think my MDS
contains any base64-only dentries, however.

Bug description
---------------

On architectures that implement flush_dcache_page() (most of the non-x86 ones),
scatterwalk_done_dst() will attempt to flush each page of the destination when
a skcipher decryption completes. If passed a destination buffer that isn't in
the linear region, virt_to_page() yields a bogus `struct page *`, leading to a
kernel oops/panic.

For this reason, sg_set_buf() requires a linear buffer (and will assert it with
BUG_ON, if the kernel is built with CONFIG_DEBUG_SG). By extension, that means
`fscrypt_str`s must only point to kmalloc() buffers.

The MDS client's parse_reply_info_readdir() invokes fscrypt in-place, reusing
the message's `front` buffer. However, ceph_msg_new2() allocates the `front`
buffer with kvmalloc(), which attempts kmalloc() (linear region) allocation
first, then falls back to vmalloc() (vmalloc region) if that fails.

This means that: when physical memory is fragmented, fscrypt is enabled, MDS
responses are rather large, and the host architecture implements
flush_dcache_page(), the CephFS client will oops/panic.

Reproduction steps
------------------

1. Build the kernel with the following configs enabled:
- CONFIG_DEBUG_SG
  - This enables a BUG_ON() to confirm that only linear virt addresses are
    passed to sg_set_buf(); this is necessary to see the issue on x86
    (on ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE archs like arm/64, MIPS, RISC-V, etc.
     the oops will happen on flush)
- CONFIG_FAULT_INJECTION
- CONFIG_FAILSLAB
- CONFIG_FAULT_INJECTION_DEBUG_FS

2. Create a directory in CephFS, encrypt it with fscrypt, and populate it with
   10 files:
```
cd /path/to/cephfs
mkdir fscrypted
fscrypt encrypt fscrypted
seq 1 10 | while read i; do touch fscrypted/file$i; done
```

3. Enable fault injection on kmalloc, so that 1% of kvmalloc() attempts use the
   vmalloc() fallback:
```
echo -1 > /sys/kernel/debug/failslab/times
echo 0 > /sys/kernel/debug/failslab/interval
echo 1 > /sys/kernel/debug/failslab/probability
```

4. Repeatedly retrieve/decrypt the directory listing:
while true; do ls fscrypted >/dev/null; sysctl -q vm.drop_caches=1; done

5. Within 3-10 seconds, expect an oops like:
Oops: invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 1474 Comm: kworker/0:2 Not tainted 7.0.0-rc6 #79 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
RIP: 0010:sg_init_one+0x88/0xa0
Code: [[[SNIP SNIP]]]
RSP: 0018:ffffbb730042f618 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffbb73001591b7 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000020 R08: ffffbb73001591b7 R09: ffffbb730042f638
R10: ffff97e7c42cc630 R11: 0000000000000000 R12: ffffbb730042f638
R13: ffff97e7c42cc630 R14: ffffbb730042f658 R15: ffff97e7c3937000
FS:  0000000000000000(0000) GS:ffff97e865a61000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe46ff2f000 CR3: 0000000003bb9000 CR4: 0000000000350eb0
Call Trace:
 <TASK>
 fname_decrypt+0x10b/0x1b0
 fscrypt_fname_disk_to_usr+0x14d/0x1b0
 ceph_fname_to_usr+0x1df/0x2f0
 ? __pfx_crypto_cbc_encrypt+0x10/0x10
 ? crypto_lskcipher_crypt_sg+0xf7/0x140
 ? ceph_aes_crypt+0x1d7/0x2b0
 ? __kmalloc_noprof+0x19c/0x570
 ? ceph_decode_copy+0x13/0x30
 parse_reply_info+0x49d/0x9c0
 mds_dispatch+0x890/0x2000
 ceph_con_process_message+0x72/0x140
 ceph_con_v1_try_read+0xaf9/0x1cc0
 ? put_prev_task_fair+0x1d/0x40
 ? finish_task_switch.isra.0+0x90/0x2c0
 ceph_con_workfn+0x2e0/0x6e0
 process_one_work+0x192/0x3a0
 worker_thread+0x1aa/0x330
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xde/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d7/0x360
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

6. If unable to repro with 10 files, try again with 5, 15, and 20. The mds
   readdir reply's front section needs to be a particular size: if it's one
   page or smaller, kvmalloc() does not attempt the vmalloc() fallback; if it's
   larger than KMALLOC_MAX_CACHE_SIZE (2 pages), kmalloc() doesn't respect
   failslab (this is apparently an oversight in failslab).

Summery of changes
------------------

All changes are in parse_reply_info_readdir():

- Move the `inode`/`ci` declaration/initialization out of the loop; they are
  loop-invariant anyway, and we need the directory's inode before entering the
  loop.

- Add a `struct fscrypt_str bname` to serve as a bounce buffer.

- Any time *p is in the vmalloc region, call ceph_fname_alloc_buffer() to
  attempt to allocate the bounce buffer. This is very rare (it only happens if
  kmalloc() fails) and only does anything if the directory has encryption
  enabled. The bounce buffer is reused for all filenames in the readdir
  response, therefore I allocate it only once, before entering the loop.

- Let oname/ctext/tname be initialized normally, but if the bounce buffer is
  active (indicating it *must* be used):
  a) If there is an `altname`, then this is a binary blob of the ciphertext,
     and ceph_fname_to_usr() will use it directly; copy it into the bounce
     buffer.
  b) If there is no `altname`, then ceph_fname_to_usr() will perform base64
     decoding on `name` into `tname`. The bounce buffer need not be
     initialized, but it's easy enough to have the memcpy() in there
     unconditionally.

- Redirect all potentially-crypted pointers into the bounce buffer. The unused
  ones are ignored by ceph_fname_to_usr():
  - fname.ctext (ciphertext if `altname` is present)
  - tname.name (ciphertext if `altname` is absent; base64 decoder buffer)
  - oname.name (output for the plaintext filename)

- After calling ceph_fname_to_usr(), if it chose to keep `oname.name` pointed
  at the bounce buffer:
  - Restore `oname.name` to point to its original location in the `front`
    buffer (which survives past the end of this function)
  - Copy the plaintext back out of the bounce buffer to the long-lived buffer

- Finally, free the bounce buffer with ceph_fname_free_buffer(), which is a
  no-op if the buffer was never allocated.
---
 fs/ceph/mds_client.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b1746273f186..a583032c0041 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -414,6 +414,9 @@ static int parse_reply_info_readdir(void **p, void *end,
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
+	struct fscrypt_str bname = FSTR_INIT(NULL, 0);
+	struct inode *inode = d_inode(req->r_dentry);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	u32 num, i = 0;
 	int err;
 
@@ -441,10 +444,18 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto bad;
 	}
 
+	/*
+	 * `p` points into the message's `front` buffer, which ceph_msg_new2()
+	 * allocates using kvmalloc(), so the buffer may end up outside of the
+	 * kmalloc() region -- but fscript_str.name must be in that region, so
+	 * use a bounce buffer in that case
+	 */
+	if (unlikely(is_vmalloc_addr(*p)))
+		if ((err = ceph_fname_alloc_buffer(inode, &bname)))
+			goto out_bad;
+
 	info->dir_nr = num;
 	while (num) {
-		struct inode *inode = d_inode(req->r_dentry);
-		struct ceph_inode_info *ci = ceph_inode(inode);
 		struct ceph_mds_reply_dir_entry *rde = info->dir_entries + i;
 		struct fscrypt_str tname = FSTR_INIT(NULL, 0);
 		struct fscrypt_str oname = FSTR_INIT(NULL, 0);
@@ -514,6 +525,13 @@ static int parse_reply_info_readdir(void **p, void *end,
 			oname.name = altname;
 			oname.len = altname_len;
 		}
+
+		if (bname.name) {
+			BUG_ON(oname.len > bname.len);
+			memcpy(bname.name, oname.name, oname.len);
+			fname.ctext = tname.name = oname.name = bname.name;
+		}
+
 		rde->is_nokey = false;
 		err = ceph_fname_to_usr(&fname, &tname, &oname, &rde->is_nokey);
 		if (err) {
@@ -521,6 +539,12 @@ static int parse_reply_info_readdir(void **p, void *end,
 				      _name_len, _name, err);
 			goto out_bad;
 		}
+
+		if (unlikely(oname.name == bname.name)) {
+			oname.name = (altname_len == 0) ? _name : altname;
+			memcpy(oname.name, bname.name, oname.len);
+		}
+
 		rde->name = oname.name;
 		rde->name_len = oname.len;
 
@@ -537,12 +561,14 @@ static int parse_reply_info_readdir(void **p, void *end,
 done:
 	/* Skip over any unrecognized fields */
 	*p = end;
+	ceph_fname_free_buffer(inode, &bname);
 	return 0;
 
 bad:
 	err = -EIO;
 out_bad:
 	pr_err_client(cl, "problem parsing dir contents %d\n", err);
+	ceph_fname_free_buffer(inode, &bname);
 	return err;
 }
 
-- 
2.52.0

