From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: what I did to fix the damaged
Date: Fri, 15 Sep 2017 10:14:15 +0800
Message-ID: <B9914DF0-F3E9-493B-ADD9-AA8D6C94FA23@redhat.com>
References: <CAKRxpuvEV9rNST=4fFeKPeGZzDaa684dvR40a3n0b1n+RMtfuA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbdIOCOU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Sep 2017 22:14:20 -0400
In-Reply-To: <CAKRxpuvEV9rNST=4fFeKPeGZzDaa684dvR40a3n0b1n+RMtfuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> On 15 Sep 2017, at 02:39, Two Spirit <twospirit6905@gmail.com> wrote:
> 
>> the unfound object is the tail object of mds log. what I did was finding the position of latest valid log entry and set log write_pos to it
> 
> Thanks for the help. The file system came back up after the scrub, I
> mounted it, started copying files back on to it and within 1-2 hours
> the file system went back degraded. Is this possibly due to the same
> bug you found with mds not replay? Do I need to wait for a patch to
> continue testing this?

What do you mean fs degraded, mds damaged or mds crashed? Your fs hasn’t been completely fixed. It’s possible that mds encountered
some inconsistent metatda. I didn’t find any bug in mds replay code. you had an unfound mds log object. mds were supposed to go to damaged
state in that case. 

ping me at the same irc channel

Regards
Yan, Zheng