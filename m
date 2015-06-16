From: "Xue, Chendi" <chendi.xue@intel.com>
Subject: RE: Checking on wip-blkin branch
Date: Tue, 16 Jun 2015 07:02:59 +0000
Message-ID: <C8CF870384EBCF4CAB89D2041A5C80B304BAAAE6@SHSMSX101.ccr.corp.intel.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B304B99DEA@SHSMSX101.ccr.corp.intel.com>
 <5576FBEA.8030805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33560 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbbFPHDk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 03:03:40 -0400
In-Reply-To: <5576FBEA.8030805@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Shewmaker <agshew@gmail.com>

HI, Josh and Andrew

I just rebase the wip-blkin branch to 9.0.1, and did a rados bench test on that

https://github.com/ceph/ceph/pull/4963


Lttng result is collected successfully

Considering on rados testsuits failing issues, I don't have a test environment, any suggests?

Best Regards,
-Chendi

-----Original Message-----
From: Josh Durgin [mailto:jdurgin@redhat.com] 
Sent: Tuesday, June 9, 2015 10:45 PM
To: Xue, Chendi; ceph-devel@vger.kernel.org; Andrew Shewmaker
Subject: Re: Checking on wip-blkin branch

Hi Chendi,

On 06/09/2015 04:59 AM, Xue, Chendi wrote:
> Hi, Josh and Andrew
>
> Today, I applied wip-blkin branch to my 4 nodes ceph setup, and created zipkin-based lttng results successfully.
>
> Since we wanna using this latency analyzing methodology on further release or on keyvalue store and newstore.
> I am wondering what is the gap to merge blkin into master? Can I help to rebase to master, so we can merge this branch?

That'd be great! Andrew and I simply haven't had time to finish fixing up the remaining issues. Running it through a rados suite showed some more changes were necessary to handle more complicated osd usage - you'll see several osd crashes in this rados suite run [1].

The code was looking fine to me, it just needs rebasing and debugging so it can pass the rados test suite.

Thanks!
Josh

[1]
http://pulpito.ceph.com/joshd-2015-03-25_17:29:16-rados-wip-blkin---blkin-multi/
