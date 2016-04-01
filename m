From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [BUG] backport commit ebeec2ef4c in ubuntu-vivid.git break cephfs
Date: Fri, 1 Apr 2016 10:01:23 +0800
Message-ID: <87CCCB41-994B-4259-8883-001D88B7B893@redhat.com>
References: <90A03E70-2B8B-4C29-9655-A73D7D4523D5@redhat.com> <20160331143921.GB18035@whence.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44492 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbcDACB3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Mar 2016 22:01:29 -0400
In-Reply-To: <20160331143921.GB18035@whence.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kamal Mostafa <kamal@canonical.com>
Cc: kernel-team@lists.ubuntu.com, Ceph Development <ceph-devel@vger.kernel.org>, Luis Henriques <luis.henriques@canonical.com>


> On Mar 31, 2016, at 22:39, Kamal Mostafa <kamal@canonical.com> wrote:
> 
> On Thu, Mar 31, 2016 at 12:06:42PM +0800, Yan, Zheng wrote:
>> ubuntu-vivid git tree includes commit ebeec2ef4c (ceph: fix message
>> length computation), but does not contain backport for upstream commit
>> 1f041a89b4 (ceph: fix request time stamp encoding). This breaks cephfs
>> kernel driver completely. Please add the later commit to your git
>> tree.
>> 
>> Regards
>> Yan, Zheng
> 
> Hi Yan-
> 
> Thanks for letting us know about this.  If that patch is required for
> all trees that carry a backport of 777d738 (ceph: fix message length
> computation), then we'll need to apply 1f041a89b4 to:

yes, that patch is required for all trees include the back port 

> 
>  3.19.y-ckt (stable)
>  3.16.y-ckt (stable)
>  ubuntu-vivid
>  ubuntu-utopic
> 
> For our reference, can you point me to a bug report or email thread
> which discusses the breakage?
> 
http://tracker.ceph.com/issues/15302 <http://tracker.ceph.com/issues/15302>

Regards
Yan, Zheng


> -Kamal

