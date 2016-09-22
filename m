From: Dan Mick <dmick@redhat.com>
Subject: Re: Docs falling out of sync with code
Date: Wed, 21 Sep 2016 18:33:47 -0700
Message-ID: <478c5b5e-2bfe-33ff-67e9-401f7d9f38c4@redhat.com>
References: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com>
 <alpine.DEB.2.11.1609212228270.1040@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933183AbcIVBds (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 21:33:48 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A84E6CB4D
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 01:33:47 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8M1Xlci014022
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 21:33:47 -0400
In-Reply-To: <alpine.DEB.2.11.1609212228270.1040@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 09/21/2016 03:29 PM, Sage Weil wrote:
> On Wed, 21 Sep 2016, Dan Mick wrote:
>> The upstream docs at http://ceph.com/docs can tend to become out of
>> date.  We don't have much process to track things that need doc work.
>>
>> As a start, I propose we add a "docs needed" flag to tracker.ceph.com so
>> that we can at least search things that add or change features through a
>> tracker issue, and a "docs needed" label to github, so we can track it
>> on PRs as well.
>>
>> Thoughts?  We can make this happen pretty quickly, and of course it's no
>> perfect lock, but at least it may start contributors and reviewers
>> thinking about the issue.
> 
> We can make a 'needs-docs' tag for PRs in github.  If they don't block the 
> merge, then we can still search for them in open or closed prs, and make a 
> point of removing the tag once the docs are eventually updated.
> 
> For the tracker, maybe a category for each project instead of a 
> separate tracker?  Not sure..
> 
> sage

Seemed like general consensus, so I've added both a "Needs Doc" checkbox
to tracker and a "needs-doc" tag for PRs and GH issues.  See how they feel.

