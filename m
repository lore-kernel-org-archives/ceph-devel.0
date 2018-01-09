From: Igor Fedotov <ifedotov@suse.de>
Subject: Excessive fragmentation in BlueStore allocators
Date: Tue, 9 Jan 2018 18:22:44 +0300
Message-ID: <627697e6-13cd-48b3-f256-0a2b9cec1379@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35819 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932736AbeAIPWr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 Jan 2018 10:22:47 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 17A8FACAE
        for <ceph-devel@vger.kernel.org>; Tue,  9 Jan 2018 15:22:46 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Cephers,

Some of us have been observing this issue for a while, see:

https://github.com/ceph/ceph/pull/18494

http://tracker.ceph.com/issues/22510

And still no perfect solution has been suggested.

Here is another trivial one that's probably is far from being ideal. But 
we has to deal with the issue somehow as it might cause real failures 
with customers.

The idea is to restrict 'hint' advance within some store space region 
('unprotected area'), e.g. 80% of the store.
Once hint value jumps out of that space on hint advance - it's reset to 
the zero. Allocations from the 'protected' area (rest 20%) are still 
allowed but limited to the case when 'unprotected' area is unable to 
serve the request. This is achieved automatically by starting the looku
This way sequential allocations we now benefit from are still available 
most of the time. And space for large continuous allocations is much 
less utilized and hence is better preserved too.

What do you think?

Thanks,
Igor
