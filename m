From: Willem Jan Withagen <wjw@digiware.nl>
Subject: there are still CLI tools that can not run stand alone...
Date: Fri, 27 May 2016 23:40:45 +0200
Message-ID: <86585350-4c2f-3680-79d3-f8a73af40864@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:55118 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbcE0VlH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2016 17:41:07 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 90B45153430
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2016 23:40:59 +0200 (CEST)
Received: from [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2] (unknown [IPv6:2001:4cb8:3:1:f85f:1e7c:9313:d8b2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 1830F153402
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2016 23:40:50 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Sorry to sound frustrated, but it keeps biting me....

# ./test/test_pool_create.sh
  ....
2016-05-27 23:36:02.279412 805017000 -1 load dlopen(/libec_jerasure.so):
Cannot open "/libec_jerasure.so"

Yes, I'm aware that it is possible to call it like:
	make recheck TESTS=./test/test_pool_create.sh

Problem is that make takes forever to determine that it can execute
the script. Making testing individual scripts rather hard.

--Wjw
