Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0C3DBD60;
	Sat, 26 Sep 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790423833; cv=none; b=l2azr5mt4EdX0eozxLBPZUwHzSaHCt6nduwGNFV9V9GiUuBKbDiHWuiAyhWqNcS7lzdgdG1y25lPYVS86hekL6uNAbsyaqdXzmh3q6eJzUCziW8t/7dueutPzXYuUSsruglXNwwOHMJ+ydR4inKKU3VLAvNiE5+1FJAchHaDgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790423833; c=relaxed/simple;
	bh=t6E88IqgE+Rvxq0rBaTh5tuLhTctJhMf5dKeHs4MLLM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=iFYQO8EQuiyN+S3Ft4An2XQv6v3mkhVT+UAdTfFXrbOatdiHzi+YdKAW/wYFgIpmXJu9+IbXgfjTHq5gw7ZfavFXmo8cUfEFNR8v2nkXuUuhGxkonis2umRbX7jWHSl/gto5lu0nLWXT/eZ1twq3+VLyszBFfvU48izgHOocmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=GiuK88Sr; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="GiuK88Sr"
Received: from smtpclient.apple (unknown [IPV6:240e:305:1b9d:c000:acd6:7a4f:a990:f7d9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f30e1e7a;
	Sat, 26 Sep 2026 19:57:02 +0800 (GMT+08:00)
From: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: [PATCH] ceph: clamp MDS reply result code to the errno range
Message-Id: <40EB50AF-762E-46EB-BA7F-2227A407ABE5@stu.pku.edu.cn>
Date: Sat, 26 Sep 2026 19:56:51 +0800
Cc: ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
To: Ilya Dryomov <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-HM-Tid: 0aa0dd936f1203a1kunm5037b6b6180a57
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8eVhpCHhlLH0pLTB1LGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0seQUhLTkFKGUIfQRhLS0tBGhgfTUFMGk8dQRpCQktBHU
	wfQllXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=GiuK88SrXAYS1hvj4oIJ02N+wrRz7zn8fDZL1is2lnV1VjyrfIs48x1WiZlJfetdQEOpkhkzeEcGgwEHwhQ1Xs7hW+jwfS6Rhvs8tcbs1Su0d1H1Y2sQZOEBXOSaylZ1cMKjn4H71acibZCsT/M1HuQEckSNuDb3tv/z8PyeA+A=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=yrrursyaE8NbhcLufwavKV8I8YVLBtMKGeRZ2WkdnfE=;
	h=date:mime-version:subject:message-id:from;

ceph_mdsc_wait_request() returns the reply head result code of the MDS
request to its callers as a plain int errno.  The value is a
server-controlled u32 and nothing checks that it actually is an errno;
several callers pass it straight to ERR_PTR(), e.g.
ceph_finish_lookup() on the atomic open path:

	err = ceph_mdsc_wait_request(...)	/* e.g. +0x50fc00 */
	...
	if (err)
		dentry = ERR_PTR(err);

IS_ERR() only recognizes the [-MAX_ERRNO, -1] window, so an
out-of-range value is not caught anywhere and survives as a "struct
dentry *".  On the open path the positive error travels
ceph_finish_lookup() -> ceph_atomic_open() -> ERR_PTR() in
fs/namei.c's atomic_open() wrapper -> step_into(), which dereferences
it as a dentry and oopses (mainline 7.3-rc3-135-g4982d3552a3b, the
value in R12 is the server-supplied result):

BUG: KASAN: probably user-memory-access in range
[0x000000000050fc00-0x000000000050fc07]
RIP: 0010:step_into_slowpath+0x3e3/0xe60
R12: 000000000050fc00
Call Trace:
 <TASK>
 ? __pfx_ceph_atomic_open+0x10/0x10
 path_openat+0xf41/0x2440
 do_file_open+0x228/0x480
 do_sys_openat2+0x103/0x1d0
 __x64_sys_openat+0x141/0x200
 do_syscall_64+0xe8/0x4f0
 entry_SYSCALL_64_after_hwframe+0x77/0x79
 </TASK>

(0xdffffc00000a1f80 in the full report is the KASAN shadow of 0x50fc00;
without KASAN the raw value is read.)  Values with the top bit set fare
no better: 0xd8000000 sign-extends through the int conversion into the
kernel address range and takes a page fault instead.

Clamp the result at the single read and return -EIO for anything
outside the errno range, which is what a malformed reply means there.
net/9p does the same to server errno values with safe_errno().  This
is the path the reported crash takes; the other readers of
head->result, including the ceph_async_create_cb() and
ceph_async_unlink_cb() callbacks, are not covered by this patch.

Each of the six crashing opens was run on a build of
7.3-rc3-135-g4982d3552a3bf with only this change applied: it crashes
the unpatched kernel on the first openat() (verified on the same
tree without the patch), and with the patch the open fails cleanly
without an oops.  A few hundred normal file operations on the
patched kernel also completed without a crash; valid errno values
pass through unchanged.

Fixes: 2f2dc053404febedc9c273452d9d518fb31fde72 ("ceph: MDS client")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>

---
 fs/ceph/mds_client.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 085ae0cfb5f7..3598099b1978 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3985,6 +3985,14 @@
 	/* only abort if we didn't race with a real reply */
 	if (test_bit(CEPH_MDS_R_GOT_RESULT, &req->r_req_flags)) {
 		err = le32_to_cpu(req->r_reply_info.head->result);
+		if (err > 0 || err < -MAX_ERRNO) {
+			/*
+			 * The result is server-controlled.  Values outside
+			 * the errno range are turned into bogus pointers by
+			 * the ERR_PTR() users among the callers.
+			 */
+			err = -EIO;
+		}
 	} else if (err < 0) {
 		doutc(cl, "aborted request %lld with %d\n", req->r_tid, err);
