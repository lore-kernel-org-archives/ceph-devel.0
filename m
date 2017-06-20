From: Nathan Cutler <ncutler@suse.cz>
Subject: jewel 10.2.8 status - blocked
Date: Tue, 20 Jun 2017 13:36:23 +0200
Message-ID: <5b7336d6-e7ee-d36d-5272-e807cb17a4b1@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53931 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750993AbdFTLgZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Jun 2017 07:36:25 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D3AAAAF2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 11:36:23 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here's the latest jewel 10.2.8 status update.

I prepared an integration branch containing the following PRs that the 
leads indicated they would like to see merged before the release:

https://github.com/ceph/ceph/pull/14392
https://github.com/ceph/ceph/pull/14930
https://github.com/ceph/ceph/pull/15000
https://github.com/ceph/ceph/pull/15383
https://github.com/ceph/ceph/pull/15438
https://github.com/ceph/ceph/pull/15468
https://github.com/ceph/ceph/pull/15472
https://github.com/ceph/ceph/pull/15529

However, as the last jewel rados nightly [1] shows, integration testing 
will not be possible until we implement a fix for 
http://tracker.ceph.com/issues/20171

Kefu and I looked at that one today - it appears to be a Debian 
packaging issue which doesn't apply to kraken or master because 
ceph-create-keys was ripped out in infernalis.

As soon as we have a PR open with a fix, I'll add it to the integration 
branch and start the last round of testing.

Nathan

[1] 
http://pulpito.ceph.com/teuthology-2017-06-19_02:00:02-rados-jewel-distro-basic-smithi/
