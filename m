From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: v0.80.8 and librbd performance
Date: Wed, 04 Mar 2015 11:53:39 -0800
Message-ID: <54F762C3.2030608@redhat.com>
References: <alpine.DEB.2.00.1503031512270.25972@cobra.newdream.net> <54F64382.7060308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246AbbCDTxl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Mar 2015 14:53:41 -0500
In-Reply-To: <54F64382.7060308@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

On 03/03/2015 03:28 PM, Ken Dreyer wrote:
> On 03/03/2015 04:19 PM, Sage Weil wrote:
>> Hi,
>>
>> This is just a heads up that we've identified a performance regression in
>> v0.80.8 from previous firefly releases.  A v0.80.9 is working it's way
>> through QA and should be out in a few days.  If you haven't upgraded yet
>> you may want to wait.
>>
>> Thanks!
>> sage
>
> Hi Sage,
>
> I've seen a couple Redmine tickets on this (eg
> http://tracker.ceph.com/issues/9854 ,
> http://tracker.ceph.com/issues/10956). It's not totally clear to me
> which of the 70+ unreleased commits on the firefly branch fix this
> librbd issue.  Is it only the three commits in
> https://github.com/ceph/ceph/pull/3410 , or are there more?

Those are the only ones needed to fix the librbd performance
regression, yes.

Josh
