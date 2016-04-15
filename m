From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: jemalloc 4.1 released, some  improvements
Date: Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Message-ID: <1400996895.321670018.1460703006084.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:50440 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbcDOGuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 02:50:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 73FD848745FB7
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8-13ApVtgrfc for <ceph-devel@vger.kernel.org>;
	Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 4BBC248745FCB
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ntrcGARcJLxP for <ceph-devel@vger.kernel.org>;
	Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 29E9648745FB7
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 08:50:06 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

jemalloc 4.1 has been released
https://github.com/jemalloc/jemalloc/releases/tag/4.1.0

a new feature is "Implement decay-based unused dirty page purging"

https://github.com/jemalloc/jemalloc/issues/325


I'll try to give it a try next month on a new test cluster with jewel to see if memory usage vs tcmalloc has lowered.

Regards,

Alexandre
