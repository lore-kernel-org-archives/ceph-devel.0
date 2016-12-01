From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Re: [ceph-users] stalls caused by scrub on jewel
Date: Thu, 1 Dec 2016 16:47:08 +0100
Message-ID: <0309fdb3-1924-dec4-9658-b8f3055b3518@epfl.ch>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
 <67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:57168 "EHLO smtp4.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbcLAPrO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 10:47:14 -0500
In-Reply-To: <67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass@univ-lorraine.fr>, Sage Weil <sweil@redhat.com>, ceph-users@ceph.com, ceph-devel@vger.kernel.org

Hello,

> We're impacted by this bug (case 01725311). Our cluster is running RHCS 2.0 and is no more capable to scrub neither deep-scrub.
> 
> [1] http://tracker.ceph.com/issues/17859
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1394007
> [3] https://github.com/ceph/ceph/pull/11898
> 
> I'm worried we'll have to live with a cluster that can't scrub/deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).
> 
> Can we have this fix any sooner ?

As far as I know about that bug, it appears if you have big PGs, a workaround could be increasing the pg_num of the pool that has the biggest PGs.

-- 
Yoann Moulin
EPFL IC-IT
