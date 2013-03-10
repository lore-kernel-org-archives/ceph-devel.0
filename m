From: Yann ROBIN <yann.robin@youscribe.com>
Subject: Rados gateway 0.58 crash in RGWProcess::_clear
Date: Sun, 10 Mar 2013 22:48:14 +0000
Message-ID: <367CC0B0FC02EE47BF7482398BD623C55D3C74FE@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:6504
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751642Ab3CJWs3 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Mar 2013 18:48:29 -0400
Received: from mail30-db3 (localhost [127.0.0.1])	by mail30-db3-R.bigfish.com
 (Postfix) with ESMTP id 543F72E0285	for <ceph-devel@vger.kernel.org>; Sun, 10
 Mar 2013 22:48:27 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.243])	by
 mail30-db3.bigfish.com (Postfix) with ESMTP id 0F0074004C	for
 <ceph-devel@vger.kernel.org>; Sun, 10 Mar 2013 22:48:15 +0000 (UTC)
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We recently setup a cluster using version 0.58. We did massive parallel upload to the gateway and saw the radosgw restarted every 5 to 10 minutes.
Here are the debug log :
https://gist.github.com/kYann/5130775

Small version :
-2> 2013-03-10 23:20:02.916521 7fc1376ee700  1 ====== req done req=0x237fc10 http_status=200 ======
    -1> 2013-03-10 23:20:02.916546 7fc1376ee700  1 RGWProcess::m_tp worker finish
     0> 2013-03-10 23:20:02.931847 7fc1efa5b780 -1 rgw/rgw_main.cc: In function 'virtual void RGWProcess::RGWWQ::_clear()' thread 7fc1efa5b780 time 2013-03-10 23:20:02.922020
rgw/rgw_main.cc: 175: FAILED assert(process->m_req_queue.empty())
 
ceph version 0.58 (ba3f91e7504867a52a83399d60917e3414e8c3e2)
1: (RGWRESTMgr_Admin::~RGWRESTMgr_Admin()+0) [0x474910]
2: (ThreadPool::stop(bool)+0x1ed) [0x4909bd]
3: (RGWProcess::run()+0x3c7) [0x473367]
4: (main()+0x8b6) [0x447276]
5: (__libc_start_main()+0xed) [0x7fc1ec92276d]
6: /usr/bin/radosgw() [0x448871]


-- 
Yann ROBIN
YouScribe


