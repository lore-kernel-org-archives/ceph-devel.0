Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA433A9DB6
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033499; cv=none; b=FTQHbKBZOneLbYQln3ZQ0p6ujBQXyW1GtJZxHxofuNpQiVJ2R0cKvXX9UBjXYHSv20VKfrK9nIgQ3QFnm0k7Qnlc7gLe8/W3BoJK+GO6MwIWLj/ASnhVvru3xn4vaxM2vudbhIw9og27LY+ZLbIVIcEITnAtviZwiKDrQyCPeiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033499; c=relaxed/simple;
	bh=UuaFpLuS0uASOx1ItjUh7l+A7qqkN4HAwtRf1tdunrc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=HPmU8ZptW4nJas7LaRod6Efx9yoP3ttTu8Mz7r4n5iRbFQ+CiqRwVhFuNc9fxKO87fPQBI0DP2ntep8AbjeCPd/Dkx7SeGK3tT0PHmkW15cwc0wcWEmfYrnF5lxH1E7u3zc0EI3u5s+MpHlSXB3NZWypqteVJrtTIGsxzp0pbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObHqetSv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObHqetSv"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-920f33347f5so121472585a.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783033496; x=1783638296; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9OO2bBmW+wE0JOdX9vbnPFB4Ba8c4rH4yuNI3KKuGM=;
        b=ObHqetSv+meZfu7wL/mWw7+YezClLP/QcOPLpvQtnW7Fzq31y77sQHJR17jVn53wwi
         EF/a7e4A2ONO0awJGNuUEw2gPcLWKkmVlQppafs3SuEotHocWgFTT2XzVzS5X4M4rwi5
         Ojzc4mIaE/ALqy7m1BFr0JtEhJS3pixNebFlfi6rmcaqIQN5GVd04OpofbumTlw8utuX
         cO3BksqSbz9eM7cqv4eQ6OB8HfN+bMHBEX2UGq4KLlLtUtMosujV3NvCiRMP8cyg2lV3
         M4fxkTLbvIZqqdRkHgCPusYMeXqRepeyf8wTsHQhg5S5h1oVjY5xJvg4rvWTXoowhOHa
         45Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783033496; x=1783638296;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n9OO2bBmW+wE0JOdX9vbnPFB4Ba8c4rH4yuNI3KKuGM=;
        b=YKcm9UY+tSwj2wpUiL84oCA/uURntnBulH4+jwh8rt2fEhfkOxdi1zbx08mZyDMgKT
         VcrRhSmNPPwjKgmvgauDqE1IId0tX3JrTN28WYlm7LtyvJFhpDVBg8+r+NcuyKKJx/n9
         dRLbQP8qSqACgQTGfz7IZaaA+6kovnbh/zeA1MfV2gYRl1rDDK+GwJ2FigerYmM7T+35
         ntiFrUqleBgxzpRnvOfM38KVede+TzJJpJV3OCrDDZFmsaGiOgBe3OSWL3RzZAJ/77Z2
         Yr36YHsqd4z4JAcDoa4t+5vw09Js4p/zjELjpeh3MaZizuL+PrVzg39CyAVVM88ma0O/
         Utjw==
X-Gm-Message-State: AOJu0YxD9dvndTJpP6Cd37ysP6a9dzZtx5BVGIomK93NjRybEV49yTWX
	Jw9hmTOZxajtmFz6Inxf8hTcAnCajUBXkZU4ZDS1hlvQueN8kV/LkaE8
X-Gm-Gg: AfdE7clJ5G/l+RS8qysDU1ZIXJrnDXWl9wOMApyFc4h7MryWSMFtobnfKjze7R5ZiTC
	Qgr43k0oO0M0dfwXOEftuIZgucDNxWdIWstPyhk89EsXTA6OMBgQpFCYbezHLzO+QSywMqlAIZI
	2VD1MXvZC7kupXbQUd7lRr1uf3lC/QiKYkQ3sZTYJZ5ixIuVOVkJ9MfvnukIEV5qQLmscstpFLN
	1hDCK9i+6ydUeMDrDFcdGGOgK/SlSbBMN6hOxWCdV8OVVrmeLgrrzrX6bKnjP0+RZ+i1Qm57tvM
	n7tHIAHuZIFja1XdkjIT70JiOdSAhyAd9ShE4vRcsJb1zHfTq+GnDjv5ffdUCKi1s1S3379A4Vo
	oKkv/yKGmIyO7ZE4tAtQqgN3KjGkyu4zFGiD0HaTf/PkMqSuY4FYwc3H1fGg0peu/UIe/H8tvE+
	jeP291qazSz6KElkwnTioURWPG5U/DZB7zNzOTSYfRxXld7BXdTv8sjQ==
X-Received: by 2002:a05:620a:1a1a:b0:92e:5d76:743b with SMTP id af79cd13be357-92e784e7c80mr1118327985a.56.1783033496359;
        Thu, 02 Jul 2026 16:04:56 -0700 (PDT)
Received: from smtpclient.apple ([2601:985:4601:5df0:b43e:3302:2fab:914e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b81342sm2716285a.7.2026.07.02.16.04.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2026 16:04:56 -0700 (PDT)
From: Shuangpeng <shuangpeng.kernel@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] ceph: KASAN slab-use-after-free in ceph_put_wrbuffer_cap_refs
Message-Id: <A8282F50-9D26-4DF3-8B86-D09252A5767A@gmail.com>
Date: Thu, 2 Jul 2026 19:04:25 -0400
Cc: ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: idryomov@gmail.com,
 amarkuze@redhat.com,
 slava@dubeyko.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Kernel Maintainers,

I hit the following KASAN report while testing current upstream kernel:

KASAN: slab-use-after-free in ceph_put_wrbuffer_cap_refs

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/c82cc2452f2fd3f31815efb83ad80b1d

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  197.863252][  T795] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  197.864328][  T795] BUG: KASAN: slab-use-after-free in =
ceph_put_wrbuffer_cap_refs (fs/ceph/caps.c:3404)
[  197.866347][  T795] Read of size 8 at addr ffff888117a93c38 by task =
kworker/1:2/795
[  197.867135][  T795]
[  197.867396][  T795] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + =
PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  197.867399][  T795] Workqueue: ceph-msgr ceph_con_workfn
[  197.868513][  T795] Call Trace:
[  197.868518][  T795]  <TASK>
[  197.868521][  T795]  dump_stack_lvl (lib/dump_stack.c:94 =
lib/dump_stack.c:120)
[  197.868529][  T795]  print_report (mm/kasan/report.c:378 =
mm/kasan/report.c:482)
[  197.868548][  T795]  kasan_report (mm/kasan/report.c:595)
[  197.868555][  T795]  ceph_put_wrbuffer_cap_refs (fs/ceph/caps.c:3404)
[  197.868560][  T795]  writepages_finish (fs/ceph/addr.c:980)
[  197.868568][  T795]  osd_dispatch (net/ceph/osd_client.c:2524 =
net/ceph/osd_client.c:3870 net/ceph/osd_client.c:5370)
[  197.869699][  T795]  ceph_con_process_message =
(net/ceph/messenger.c:1425)
[  197.869718][  T795]  ceph_con_v1_try_read =
(net/ceph/messenger_v1.c:1430)
[  197.869727][  T795]  ceph_con_workfn (net/ceph/messenger.c:1577)
[  197.869731][  T795]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  197.869739][  T795]  worker_thread (kernel/workqueue.c:3478)
[  197.869754][  T795]  kthread (kernel/kthread.c:436)
[  197.869765][  T795]  ret_from_fork (kernel/process.c:158)
[  197.869773][  T795]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  197.869780][  T795]  </TASK>
[  197.869782][  T795]
[  197.887591][  T795] Freed by task 795 on cpu 1 at 197.863249s:
[  197.888221][  T795]  kasan_save_track (mm/kasan/common.c:57 =
mm/kasan/common.c:78)
[  197.888728][  T795]  kasan_save_free_info (mm/kasan/generic.c:584)
[  197.889253][  T795]  __kasan_slab_free (mm/kasan/common.c:253 =
mm/kasan/common.c:285)
[  197.889758][  T795]  kmem_cache_free (include/linux/kasan.h:235 =
mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6378)
[  197.890256][  T795]  ceph_try_drop_cap_snap (fs/ceph/super.h:283 =
fs/ceph/caps.c:3213)
[  197.890820][  T795]  ceph_put_wrbuffer_cap_refs (fs/ceph/caps.c:3396)
[  197.891411][  T795]  writepages_finish (fs/ceph/addr.c:980)
[  197.891930][  T795]  osd_dispatch (net/ceph/osd_client.c:2524 =
net/ceph/osd_client.c:3870 net/ceph/osd_client.c:5370)
[  197.892422][  T795]  ceph_con_process_message =
(net/ceph/messenger.c:1425)
[  197.892999][  T795]  ceph_con_v1_try_read =
(net/ceph/messenger_v1.c:1430)
[  197.893552][  T795]  ceph_con_workfn (net/ceph/messenger.c:1577)
[  197.894053][  T795]  process_scheduled_works (kernel/workqueue.c:3314 =
kernel/workqueue.c:3397)
[  197.894614][  T795]  worker_thread (kernel/workqueue.c:3478)
[  197.895096][  T795]  kthread (kernel/kthread.c:436)
[  197.895519][  T795]  ret_from_fork (kernel/process.c:158)
[  197.896005][  T795]  ret_from_fork_asm =
(arch/x86/entry/entry_64.S:245)
[  197.896498][  T795]
[  197.896754][  T795] The buggy address belongs to the object at =
ffff888117a93be0
[  197.896754][  T795]  which belongs to the cache ceph_cap_snap of size =
240
[  197.898196][  T795] The buggy address is located 88 bytes inside of
[  197.898196][  T795]  freed 240-byte region [ffff888117a93be0, =
ffff888117a93cd0)

Best,
Shuangpeng

