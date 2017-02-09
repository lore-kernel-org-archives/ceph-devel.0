From: Bastian Rosner <bastian.rosner@profitbricks.com>
Subject: Can't link/unlink buckets with tenant context
Date: Thu, 9 Feb 2017 19:00:39 +0100
Message-ID: <c1ada22e-29d2-b9fa-1787-aca7c0af1c1e@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35692 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753170AbdBISBa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 13:01:30 -0500
Received: by mail-lf0-f53.google.com with SMTP id n124so7098934lfd.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2017 10:00:42 -0800 (PST)
Received: from [192.168.88.123] ([62.217.45.26])
        by smtp.googlemail.com with ESMTPSA id r18sm3783935lff.4.2017.02.09.10.00.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Feb 2017 10:00:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we are currently evaluating radosgw-admin API and seem to have run into 
http://tracker.ceph.com/issues/16736

Although this issue is already 7 months old and has been reported for 
jewel, we can reproduce it under kraken as well.
Without multi-tenancy, so just creating S3-users without specifying a 
tenant, linking and unlinking buckets works as expected.

I understand that the whole concept of tenants in RGW is nothing more 
than a simple namespace extension, at least that's how it is right now.
But not being able to link buckets to other S3-users just because they 
are used inside the context of a tenant makes it pretty hard to run a 
true multi-tenant object-store.

Is there any chance this multi-tenancy behavior might change in the next 
release?

Best, Bastian
