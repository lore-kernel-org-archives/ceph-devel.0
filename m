From: David Zafman <dzafman@redhat.com>
Subject: Backport
Date: Wed, 23 Aug 2017 14:01:23 -0700
Message-ID: <e0de34c2-7eb8-e888-f6ff-fdc6e6c55f3b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932407AbdHWVB0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 23 Aug 2017 17:01:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A907C80B2A
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 21:01:26 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


Sage,


Should we backport http://tracker.ceph.com/issues/20730?  It was removal 
of the code to warn about OSDs space utilization differences.

It won't backport with a cherry-pick because in master the code moved 
then was removed.


David


