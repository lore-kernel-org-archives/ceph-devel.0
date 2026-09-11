Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071501A3160
	for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2026 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135326; cv=none; b=ITAL4zUJcbuX/M/SOMVe3M5H/3iWZ72khDKZsUAjbAdr1hf61qq2M7CyQCdiUMpPGHKWGhZQTZO7oKyYQnBCYRn3rW/Kv3hL0H4KTAmqq6eStyRZNyv2b1v7h3axBvW77j5gLBTUfHayIFJfor8Zbv5ZodoG6DaFCTlb6P7Ip2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135326; c=relaxed/simple;
	bh=WQemfS3+YoWxOOn1vLjyJiveqV4wGefGNjV15zTnag8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi/HRAXUASe7yteWanZ0S/dX35v0SLQ7pKIEscGgAUH/FTxA3QX8dcM8RIum28vCaZioMWE+RhKklzQk04rSUMMqkegG8yx/XncH8eoLhxH0MA2ERWdvH/QEJa0+vt7bgvsnsNM1fjxgsSeowVryqWVGFCYO77aNyNbPIz8pGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=H0ETdBxd; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="H0ETdBxd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1789135322;
	bh=A1Al0oEmi9FS/HMks3AVF9haopiQhso4aa3qva+SAhQ=;
	h=From:Subject:Date:Message-ID;
	b=H0ETdBxdKFl7FNvdn74t0feD9grChLXIYds52cCVSscpvB/xw+NTEEf3R5oFEbEOu
	 lXlpRutH9gG/ytrIt7dsAeVevROT1Hh6o0LJKzdeP2/kgGxNTOWWPo4JpzD61lC+Vj
	 2LiFsCt6BN07Ic6I4bTbtkkKU3unp4XaBx+KUGlY=
X-SMAIL-HELO: lxu-ped-host..
Received: from unknown (HELO lxu-ped-host..)([111.198.231.89])
	by sina.com (10.54.253.32) with ESMTP
	id 6AA409AA00002A27; Fri, 11 Sep 2026 22:01:21 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 1090394456897
X-SMAIL-UIID: 2B13AABE8E51442BB04E11A10E795460-20260911-220121-1
From: Edward Adam Davis <eadavis@sina.com>
To: eadavis@sina.com
Cc: amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	linux-kernel@vger.kernel.org,
	sage@newdream.net,
	slava@dubeyko.com,
	syzbot+1dbed5969931c19d3eb5@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] ceph: reject create client if no monitor
Date: Fri, 11 Sep 2026 22:01:14 +0800
Message-ID: <20260911140114.864756-1-eadavis@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911135718.864217-1-eadavis@sina.com>
References: <20260911135718.864217-1-eadavis@sina.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
v1 -> v2: unified email address

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

