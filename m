From: Mark Nelson <mnelson@redhat.com>
Subject: rocksdb optimization regression (bluestore perf regression)
Date: Thu, 3 Nov 2016 09:59:01 -0500
Message-ID: <ea832d2a-96f4-7334-9d34-40d21740df6f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755798AbcKCO7E (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Nov 2016 10:59:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F3377F7B1
        for <ceph-devel@vger.kernel.org>; Thu,  3 Nov 2016 14:59:03 +0000 (UTC)
Received: from [10.3.112.103] (ovpn-112-103.phx2.redhat.com [10.3.112.103])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA3Ex1b0025604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Thu, 3 Nov 2016 10:59:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Mostly this is for Igor and Somnath:

It looks like the regression was indeed caused by lack of O2 
optimization for rocksdb in master after 418bfd7.  The following PR 
appears to resolve the performance regression in my tests:

https://github.com/ceph/ceph/pull/11767

Mark
