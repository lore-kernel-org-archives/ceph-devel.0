From: =?utf-8?B?RnLDqWTDqXJpYyBOYXNz?= <frederic.nass@univ-lorraine.fr>
Subject: Re: [ceph-users] stalls caused by scrub on jewel
Date: Thu, 1 Dec 2016 21:38:00 +0100
Message-ID: <9F915199-F93D-4F5E-82F8-ACA428ADFA30@univ-lorraine.fr>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
 <67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
 <0309fdb3-1924-dec4-9658-b8f3055b3518@epfl.ch>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta-outslow1.mel.univ-lorraine.fr ([193.54.32.11]:56924 "EHLO
        mta-outslow1.mel.univ-lorraine.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751234AbcLAUiF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2016 15:38:05 -0500
In-Reply-To: <0309fdb3-1924-dec4-9658-b8f3055b3518@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: Sage Weil <sweil@redhat.com>, ceph-users@ceph.com, ceph-devel@vger.kernel.org

Hi Yoann,

Thank you for your input. I was just told by RH support that it’s gonna make it to RHCS 2.0 (10.2.3). Thank you guys for the fix !

We thought about increasing the number of PGs just after changing the merge/split threshold values but this would have led to a _lot_ of data movements (1.2 billion of XFS files) over weeks, without any possibility to scrub / deep-scrub to ensure data consistency. Still as soon as we get the fix, we will increase the number of PGs.

Regards,

Frederic.



> Le 1 déc. 2016 à 16:47, Yoann Moulin <yoann.moulin@epfl.ch> a écrit :
> 
> Hello,
> 
>> We're impacted by this bug (case 01725311). Our cluster is running RHCS 2.0 and is no more capable to scrub neither deep-scrub.
>> 
>> [1] http://tracker.ceph.com/issues/17859
>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1394007
>> [3] https://github.com/ceph/ceph/pull/11898
>> 
>> I'm worried we'll have to live with a cluster that can't scrub/deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).
>> 
>> Can we have this fix any sooner ?
> 
> As far as I know about that bug, it appears if you have big PGs, a workaround could be increasing the pg_num of the pool that has the biggest PGs.
> 
> -- 
> Yoann Moulin
> EPFL IC-IT

