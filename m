From: David Galloway <dgallowa@redhat.com>
Subject: Emergency Infra Maintenance due to Meltdown
Date: Wed, 10 Jan 2018 10:49:12 -0500
Message-ID: <6f60d2fd-004d-d7b7-1898-eb091c9c0853@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965376AbeAJPtN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 Jan 2018 10:49:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D78F780F1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 15:49:13 +0000 (UTC)
Received: from [10.10.126.19] (ovpn-126-19.rdu2.redhat.com [10.10.126.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CF9D80E64
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 15:49:12 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

With the release of patched kernels for CentOS and Ubuntu, I'm going to
be updating kernels and rebooting hosts.

This includes hosts like download.ceph.com, tracker, docs as well as
resources in the Sepia lab.

I'll try to keep this as non-disruptive as possible but will likely need
to pause the Sepia queue for an hour or two to get everything up to date.

-- 
David Galloway
Systems Administrator, RDU
Ceph Engineering
IRC: dgalloway
