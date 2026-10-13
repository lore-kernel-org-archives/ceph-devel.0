Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBC417BD2;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933646; cv=none; b=Z7Vz87XN05E6O64hkg9YjyyT/A//Gqmfp0UtBiPlZ38W3LsEMITuJl16w2FEx/waJKmFmbu1HYepmtx268YdEr9OLbkgMQdvqsEu1bPru1MbqYa1jddvB/yNIDPzdb2MIgL0k3tu5vBrt+KyeFe9roqd4+W25nfEnN077SWVt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933646; c=relaxed/simple;
	bh=jswLlndUwvIJD4hLUM4C4P4iRpjAjyPosKHDox8DxEU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pULz2cNARlS9h+ZwKHkxgmndc4Oa7licbH+EBvQbJ0RqRFljSvIyUo2rPF4+f3bdGg9sfA6Aw+hQzhDKrm3jfOjT6xKGVBVD1LUerbM9cDb15xeN2AvXIawzQqZUa+opv1s5EMoHs+Zrf+f2EbHeqhoD3eFFN9gWkfRfvqFn3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxEL2l23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxEL2l23"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7686CC2BCFA;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791933645;
	bh=jswLlndUwvIJD4hLUM4C4P4iRpjAjyPosKHDox8DxEU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LxEL2l23GTPSKeg74sQZWksArKFmFEq7trff4HIKx3LdcaNhFx0t3YgLREssEbLhN
	 oGQKRIG3JLQJbfLevobp47Zm8DW3/5yyF9+qSnCu1Z/IiWCUhqmMsYa7hXBogY5VBK
	 1hY6IT+GM5qMGWhR7/SWfsqgxYEop9j1ghHyaMRfqPzkN4wAS5JpH1xjGqxbrW0CUT
	 vHmAb1DakJcRPvuMPHfyWKo6xh0bX3D8QsZcAwtASX0ax1B35L1g6gWIoYLZQ/9uCe
	 rjR7YCIgrhH3MdnGG3ik4P0qC9faOeo3hUmkV+ARUS8rurT0fUPb3OhIRGzem94pI9
	 8cBng35Dk+m4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD3CC6B19;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/3] ceph: fix the buffered read size metric and make the
 subvolume metrics per CPU
Date: Wed, 14 Oct 2026 01:20:39 +0200
Message-Id: <20261014-ceph-metrics-percpu-v1-0-38c5a24fec6e@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqCUBBG4VeRWTdwRzShV4kWOf3mBNllRiUQ3
 71bLb/FORsF3BB0qjZyrBb2mgrkUJGO1+kOtlsx1ak+SpKGFXnkJ2Y3Dc5wzQuL9m1quqGTNlE
 ps2Ow9+96vvwdS/+Azt8V7fsH2vk3m3cAAAA=
X-Change-ID: 20261014-ceph-metrics-percpu-1cb5047f7150
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Milind Changire <mchangir@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan van der Ster <dan.vanderster@clyso.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791933643; l=1732;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=jswLlndUwvIJD4hLUM4C4P4iRpjAjyPosKHDox8DxEU=;
 b=8JJ8JcvUZQzt7nzZVNTxcXjwcrXcpJCqroeEPTbVRcNSOzIdoqN+DpeHohtKVb4Ux9Bt77Rqi
 0P1l8rGdoExAa7juMgvLxcIZ0wSPpZbcB4s/aSZniHSgaU5p/EARci4
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

Two problems in the client I/O metrics, reported by Dan van der Ster
while looking at IO500 runs on 144-core Grace clients.

Patch 1: metrics/size has reported 0 bytes for every page cache read
since buffered reads moved to CEPH_OSD_DATA_TYPE_ITER, because
finish_netfs_read() still reads osd_data->length, which only the page
vector type sets.

Patches 2-3: every OSD read and write completion updates the subvolume
metrics through state shared by the whole mount.  Even with subvolume
metrics disabled it bumped an atomic64 counter that nothing reads;
with them enabled it took a mount-wide spinlock and searched an rbtree.
Patch 2 drops the unused counters, patch 3 accumulates the counters in
a per-CPU slot and only folds them into the tree when the slot changes
subvolume or when the metrics are sent or dumped.

Tested on x86_64 against a main MDS with SUBVOLUME_METRICS: 16 jobs on
16 CPUs writing and reading two subvolumes and a plain directory.  The
read sizes are now reported, and the per-subvolume op and byte totals
summed over every metrics send match the I/O issued.

---
Xiubo Li (3):
      ceph: report the requested length in the netfs read metrics
      ceph: drop the unused subvolume metrics debug counters
      ceph: accumulate subvolume metrics per CPU

 fs/ceph/addr.c              |   2 +-
 fs/ceph/mds_client.c        |   6 +-
 fs/ceph/subvolume_metrics.c | 172 +++++++++++++++++++++++++++++++-------------
 fs/ceph/subvolume_metrics.h |  26 ++-----
 4 files changed, 133 insertions(+), 73 deletions(-)
---
base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
change-id: 20261014-ceph-metrics-percpu-1cb5047f7150

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


