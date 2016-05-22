From: Willem Jan Withagen <wjw@digiware.nl>
Subject: not able to run src/ceph any longer
Date: Mon, 23 May 2016 01:10:00 +0200
Message-ID: <c6296508-10eb-f78a-f0e1-6bac2d1be6ea@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:56351 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbcEVXKL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 22 May 2016 19:10:11 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 303D81534DD
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 01:10:05 +0200 (CEST)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 7ACCB15340D
	for <ceph-devel@vger.kernel.org>; Mon, 23 May 2016 01:09:59 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

When the testscripts try to run src/ceph I get:

*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
Traceback (most recent call last):
  File "src/ceph", line 118, in <module>
    import rados
ImportError: /usr/srcs/Ceph/work/ceph/src/.libs/librados.so.2: Undefined
symbol "g_ceph_context"

which is in libglobal, but if I try to link that to librados I'm just
getting nothing but dubble definitions and errors.

Where have things gone wrong for me?
How should "import rados" get the g_ceph_context?

Thanx
--WjW
