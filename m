From: Wuxiangwei <wuxiangwei@h3c.com>
Subject: how to see file object-mappings for cephfuse client
Date: Mon, 7 Dec 2015 02:51:56 +0000
Message-ID: <F075EA5A8A3F8045B2A81359C8B5B07C5E3E8A52@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.h3c.com ([60.191.123.56]:11167 "EHLO h3cmg01-ex.h3c.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755283AbbLGCwZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Dec 2015 21:52:25 -0500
Content-Language: zh-CN
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi, Everyone

Recently I'm trying to figure out how to use ceph-fuse. If we mount cephfs as the kernel client, there is a 'cephfs' command tool (though it seems to be 'deprecated') with 'map' and 'show_location' commands to show the RADOS objects belonging to a given file. However, it doesn't work well for ceph-fuse, neither can I find a similar tool to see the mappings. Any suggestions? 
Thank you!


-----------------------
Wu Xiangwei
Tel : 0571-86760875
2014 UIS 2, TEAM BORE

