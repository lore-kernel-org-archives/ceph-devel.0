From: Willem Jan Withagen <wjw@digiware.nl>
Subject: getting more updates in rocksdb
Date: Wed, 20 Jul 2016 12:38:34 +0200
Message-ID: <a8d5d498-cbc7-f252-64a3-791995bfc5bc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:40404 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbcGTKiu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 06:38:50 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 6042415340A
	for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 12:38:37 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi,

I submitted a small patch to rocksdb for FreeBSD
https://github.com/facebook/rocksdb/commit/b726bf59619d43651838e03cce9f876b3560cbda

And was hopping that it would be tracked by my Ceph stuff as well.
But refetching things, it does not seem to be in the tree ceph cmake
fetches.

And I'm not fluent enough in git to actually check if my current
checkout with hash: 5647fa427c4eab87c0caf8bcbb91f5846a4623f9
should contain the above commit.

And if it is not in, would it be possible to get it in the module we
fetch for Ceph?

--WjW
