From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Untested PRs merged to jewel before 10.2.6 release?
Date: Wed, 8 Mar 2017 01:50:58 +0000
Message-ID: <robbat2-20170308T014947-232855039Z@orbis-terrarum.net>
References: <713de223-60a8-7def-5e59-c6c09b52dc06@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:43408 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756546AbdCHBvk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Mar 2017 20:51:40 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 586CB341689
        for <ceph-devel@vger.kernel.org>; Wed,  8 Mar 2017 01:51:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <713de223-60a8-7def-5e59-c6c09b52dc06@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 07, 2017 at 10:38:52PM +0100, Nathan Cutler wrote:
> Am I seeing that right? If so, that appears to potentially defeat the 
> purpose of the integration testing we do. Maybe I'm overstating the 
> danger here -- the commits look innocuous enough -- but it seems to set 
> a rather dangerous precedent.
There's a merge error in them too:
qa/suites/rgw/singleton/all/radosgw-admin.yaml
>>>>>>> 8af4c35f95... qa/suites/rgw: Add openstack volume configuration
-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
