From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 00/39] fixes for MDS cluster recovery
Date: Mon, 1 Apr 2013 10:00:15 -0700
Message-ID: <CAPYLRzh1AffuLfLOJ0dUUnQn0KSrhY-Ti7g6JR=idTNzbD5=QA@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<5159496D.6040002@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:56501 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912Ab3DARAQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Apr 2013 13:00:16 -0400
Received: by mail-qa0-f45.google.com with SMTP id hg5so959102qab.4
        for <ceph-devel@vger.kernel.org>; Mon, 01 Apr 2013 10:00:15 -0700 (PDT)
In-Reply-To: <5159496D.6040002@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Mon, Apr 1, 2013 at 1:46 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> On 03/17/2013 10:51 PM, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> This serie fixes issues I encountered when running random MDS restart tests.
>> With these patches, my 3 MDS setup that runs fsstress + thrash_exports can
>> survive restarting one or two MDS dozens of times.
>>
>> But there still are lots of unsolved problems, Sometimes rstat corruption,
>> request hangs ...
>>
>> This patch series are also in:
>>   git://github.com/ukernel/ceph.git wip-mds
>>
>
> I rebased these patches. Replaced patch 5 and patch 6 with two new patches.
>
> [PATCH] mds: avoid sending duplicated table prepare/commit
> [PATCH] mds: don't roll back prepared table updates

All right, I've merged this whole series into master at last. Edited
one commit in order to give MMDSCacheRejoin the new versioned encoding
and added one commit to bump the MDS protocol like we talked about.
Thanks for all the fixes!
-Greg
