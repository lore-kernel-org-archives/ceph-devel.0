Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAF19D8BC
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135097; cv=none; b=IeUS7zLp2wWUlz0s5oyrhM3BkgtPnkfIs71N89lOZ0UyEe2A1AFHWPaOSUjNVQK3bNuV0VdFHsv8Xcb8782aTfUSDI3zz2cJY/B2y4uvd8y9s9fQaxqYOoMUeMk5BChg+0Tjde6in6NKG4QoeYZzR+1M0+NbiLkhPtLUlnl7KZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135097; c=relaxed/simple;
	bh=5e7rbjCz+3YxIVToEiw98Io3Cj0lgTHKqDX6fKaN6/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Emxc2kESpJkP5V1gbAwG0+/yzR+sNsOCsE5MQ2n76F2y90QGi0JV/0Nfa/QZNj42bh3mhau3fyl0tfwR1uHL5jgB3XjYFI5t8/5vcRiOI/71KmaF0C/281IKEPWkJwpF3ZV09vRdXI8D55pNb0VkOhNSBsTTaawaQERCT1xRQ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FVgh+RFu; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FVgh+RFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1789135091;
	bh=KtLTgJmYgCgMjBJobKAo6lCs1IASf63I2XyeCDoH1sA=;
	h=From:Subject:Date:Message-ID;
	b=FVgh+RFuTrfODMc34N90AxLvxu/bueUZYTXfpbDGx+mcxdD0Un1X0BhWWp01S8h/Z
	 sLGUhXhd41xhoVJzX/O6gQxMdbti64cSIQzFy1RvxVHV9a4zl8VXaSqIcjTb8kuf1y
	 gahJ0DiB7Y5b6udQUjH8qgLH4GQK4IzDqUqt9iE8=
X-SMAIL-HELO: lxu-ped-host..
Received: from unknown (HELO lxu-ped-host..)([111.198.231.89])
	by sina.com (10.54.253.33) with ESMTP
	id 6AA408BE000017B2; Fri, 11 Sep 2026 21:57:23 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 9867866685322
X-SMAIL-UIID: 4528D04178E4406AB92BBF8A37E9D359-20260911-215723-1
From: Edward Adam Davis <eadavis@sina.com>
To: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Cc: amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com,
	sage@newdream.net
Subject: [PATCH] ceph: reject create client if no monitor
Date: Fri, 11 Sep 2026 21:57:18 +0800
Message-ID: <20260911135718.864217-1-eadavis@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6aa30f2a.f81106d8.2ab401.0013.GAE@google.com>
References: <6aa30f2a.f81106d8.2ab401.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

During the resolution of monitor addresses, the failure to resolve the
server name [1] resulted in no available monitors (i.e., the num_mon
value in ceph_options was 0).

This triggered the issue [2] when joining the Ceph cluster.

Before creating the client, if the number of monitors specified in the
options is invalid, the client creation process is aborted.

[1]
libceph: resolve '127.0.0.' (ret=-3): failed

[2]
kernel BUG at net/ceph/mon_client.c:211!
Call Trace:
 ceph_monc_open_session+0x46/0x60 net/ceph/mon_client.c:534
 __ceph_open_session+0x135/0x590 net/ceph/ceph_common.c:798
 ceph_real_mount fs/ceph/super.c:1173 [inline]
 ceph_get_tree+0xd98/0x1fd0 fs/ceph/super.c:1362

Fixes: 16725b9d2a2e ("ceph: super.c")
Reported-by: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1dbed5969931c19d3eb5
Tested-by: syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ceph/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 72935f665f11..0f20d6c5e4bd 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -818,7 +818,11 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 					struct ceph_options *opt)
 {
 	struct ceph_fs_client *fsc;
-	int err;
+	int err, num_mon;
+
+	num_mon = opt->num_mon;
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
+		return ERR_PTR(-EINVAL);
 
 	fsc = kzalloc_obj(*fsc);
 	if (!fsc) {
-- 
2.43.0

