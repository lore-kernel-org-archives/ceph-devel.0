From: Haomai Wang <haomai@xsky.com>
Subject: About thread_local and TmapMigratePP.DataScan case
Date: Tue, 28 Jun 2016 02:04:51 +0800
Message-ID: <CACJqLybSUa6WtfcvXa5W4AAXJUgEBDPX2Mo+nd3SDeLkHVgDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0127.outbound.protection.outlook.com ([104.47.125.127]:40384
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751639AbcF0SFH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Jun 2016 14:05:07 -0400
Received: by mail-vk0-f45.google.com with SMTP id j2so242479098vkg.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2016 11:05:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

anyone who knows what's the special thing with TmapMigratePP.DataScan
case. When I introduce thread_local variable in
PR(https://github.com/ceph/ceph/pull/9783/files#diff-254a8401d238ec25c714a5596f85b5ebL64),
it always failed because the thread local variable is assigned to zero
when execute this test!

For example, when tid == 512596224 local_center should be 5fed4e48,
but after begin this test case, this thread_local variable is assigned
to zero!:
tid=-512596224 local_center=5fed4e48 this=5fed4e48
[New Thread 0x7fffdef21700 (LWP 11835)]
tid=-512596224 local_center=5fed4e48 this=5fed4e48
[New Thread 0x7fffde720700 (LWP 11836)]
[New Thread 0x7fffddf1f700 (LWP 11837)]
[New Thread 0x7fffdd71e700 (LWP 11838)]
[New Thread 0x7fffdcf1d700 (LWP 11839)]
[New Thread 0x7fffdc71c700 (LWP 11840)]
[New Thread 0x7fffdbf1b700 (LWP 11841)]
tid=-134366272 local_center=0 this=5fed4e48
tid=-134366272 local_center=0 this=5fed4e48
tid=-134366272 local_center=0 this=5fed4e48
tid=-512596224 local_center=0 this=5fed4e48


QA job:http://qa-proxy.ceph.com/teuthology/haomai-2016-06-27_03:55:04-rados-wip-haomai-testing---basic-smithi/279412/teuthology.log

This can be repeated locally and I want to know what's the difference
this case introduced
