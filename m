From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: rbd and the next infernalis release v9.2.1
Date: Wed, 10 Feb 2016 22:46:27 -0800
Message-ID: <56BC2E43.5080206@redhat.com>
References: <CAP3mxSwUBZCk+UUjtRQeFe1kLi-djF_0wFe09cnwZkdpPCqGPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbcBKGq0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Feb 2016 01:46:26 -0500
In-Reply-To: <CAP3mxSwUBZCk+UUjtRQeFe1kLi-djF_0wFe09cnwZkdpPCqGPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On 02/10/2016 10:23 PM, Abhishek Varshney wrote:
> Hi Josh,
>
> The next infernalis release as found at
> https://github.com/ceph/ceph/tree/infernalis passed the rbd suite (
> http://tracker.ceph.com/issues/13750#note-18 ). Do you think the
> infernalis branch is ready for QE to start their own round of testing
> ?

I'd like to get the 4 in-flight changes in as well, since they've passed 
testing and just need commit message updates:

https://github.com/ceph/ceph/pull/6981
https://github.com/ceph/ceph/pull/7406
https://github.com/ceph/ceph/pull/7484

Jason, could you add the extra context to those commit messages?

This last one looks ready as-is:

https://github.com/ceph/ceph/pull/6629

Josh

