From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: querying tiered EC pool info?
Date: Wed, 1 Jul 2015 14:26:48 -0400
Message-ID: <CAGbvivKfXmcN5eKnBD-QfZmjCJO1CjgdjB4_zLRKuZ6MTi-Jxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36133 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbGAS0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jul 2015 14:26:48 -0400
Received: by iecvh10 with SMTP id vh10so40704317iec.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Jul 2015 11:26:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Is there a ceph command to fetch the cache-tier information for an EC pool?

For example, you add a tier with "ceph osd tier add ...", but there
doesn't appear to be an equivalent "get" operation.

Likewise, getting the tier "cache-mode" or "overlay" doesn't appear
possible with the current tools in Hammer (94.2).

Am I missing something or is this a known issue?  It would be nice to
be able to get the EC Tier information for a given pool, and also to
know if a pool is being used as a tier for another pool.

thanks,
  Wyllys Ingersoll
