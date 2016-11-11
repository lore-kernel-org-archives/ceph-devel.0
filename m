From: Wido den Hollander <wido@42on.com>
Subject: How do I add a note to the Ceph release notes?
Date: Fri, 11 Nov 2016 09:47:03 +0100 (CET)
Message-ID: <539332276.1908.1478854023888@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48839 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755792AbcKKIrU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 03:47:20 -0500
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 25262762C0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 09:47:03 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

With the merge of PR #11665 [0] the Monitors will no longer allow pools to be removed by default

Users explicitly need to set mon_allow_pool_delete to true in their ceph.conf before they can remove pools.

I would like to add this to the release notes of Kraken, but where do I add this? I found a script which generates the release notes from Git.

I thought there would be a tracker issue, but couldn't find that one either.

Hints?

Wido

[0]: https://github.com/ceph/ceph/pull/11665
