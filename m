From: Josh Durgin <jdurgin@redhat.com>
Subject: updated gmock/gtest - now a googletest submodule
Date: Wed, 13 Jul 2016 08:30:42 -0700
Message-ID: <57865EA2.8080501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbcGMPbB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Jul 2016 11:31:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8DD712049C
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 15:30:36 +0000 (UTC)
Received: from [10.3.225.116] (vpn-225-116.phx2.redhat.com [10.3.225.116])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6DFUaQG001419
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2016 11:30:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hey folks, an updated version of gmock and gtest, which are now in a
single shared repo, called googletest, has been merged [0].

You'll need to make sure your submodules are up to date if you build
the latest master.

This fixes a bug with gcc 6 and unit tests as noted in that PR,
but as with any update, may introduce bugs. If you see any new
oddities related to gmock or gtest, this may be the cause.

Josh

[0] https://github.com/ceph/ceph/pull/9134
