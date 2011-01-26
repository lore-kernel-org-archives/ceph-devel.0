From: "Longguang Yue" <longguang_yue@tcloudcomputing.com>
Subject: question about logger.cc
Date: Wed, 26 Jan 2011 22:54:27 +0800
Message-ID: <D0C67741759ABD4BBD8D3A5CB815606E07E64C@mail.cloud-valley.com.cn>
References: <Pine.LNX.4.64.1101250808480.3488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [203.114.244.22] ([203.114.244.22]:7599 "EHLO
	mail.cloud-valley.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751728Ab1AZOy3 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 26 Jan 2011 09:54:29 -0500
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

I do not find  where stopper is used!!!


common/Mutex.h: In function 'void Mutex::Lock(bool)':
common/Mutex.h:118: FAILED assert(r == 0)
 ceph version 0.24.2 (commit:f7572de5cb87eb7157217be4975ae66d90831bb7)
 1: (SafeTimer::shutdown()+0x6b1) [0x44a101]
 2: (FlusherStopper::~FlusherStopper()+0x58) [0x444788]
 3: (exit()+0xe1) [0x3716a379c1]
 4: (__libc_start_main()+0x104) [0x3716a1ee84]
 5: /usr/bin/cconf() [0x416769]
