From: Loic Dachary <ldachary@redhat.com>
Subject: rados and the next hammer release v0.94.3
Date: Mon, 03 Aug 2015 17:42:15 +0200
Message-ID: <55BF8BD7.7020003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55044 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbbHCPmR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Aug 2015 11:42:17 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 775BEABD
	for <ceph-devel@vger.kernel.org>; Mon,  3 Aug 2015 15:42:17 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sam,

We need http://tracker.ceph.com/issues/12465 in hammer v0.94.3. Is there anything else we want before publishing this release ? Should we wait for http://tracker.ceph.com/issues/12410 maybe ? And http://tracker.ceph.com/issues/12536 ?

The next hammer release as found at https://github.com/ceph/ceph/tree/hammer passed the rados suite. Provided it also contains the fixes for the above three issues, do you think it is ready for QE to start their own round of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/11990#Release-information has direct links to the pull requests merged into hammer since v0.94.2 in case you need more context about one of them.

