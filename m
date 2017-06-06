From: Dan Mick <dmick@redhat.com>
Subject: make check failures on arm64
Date: Mon, 5 Jun 2017 21:33:28 -0700
Message-ID: <f30c77d2-76f6-5028-dca7-848b624acb70@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750857AbdFFEd2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 6 Jun 2017 00:33:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 512C480C07
        for <ceph-devel@vger.kernel.org>; Tue,  6 Jun 2017 04:33:28 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E78B17B65
        for <ceph-devel@vger.kernel.org>; Tue,  6 Jun 2017 04:33:28 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Haven't looked into these yet; just in process of redoing the build to
make sure it wasn't spurious.  Looks like some things crept in.

The following tests FAILED:
	 13 - unittest_bufferlist.sh (Failed)
	 31 - unittest_bufferlist (Failed)
	 62 - unittest_sloppy_crc_map (Failed)
	 68 - unittest_crc32c (Failed)
	 76 - unittest_bit_vector (Failed)
	114 - unittest_journal (Failed)
	140 - unittest_bluestore_types (Failed)

https://jenkins.ceph.com/view/pull-requests/job/ceph-pull-requests-arm64/55/console

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
