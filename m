From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Checking on wip-blkin branch
Date: Tue, 09 Jun 2015 07:44:58 -0700
Message-ID: <5576FBEA.8030805@redhat.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B304B99DEA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37095 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932950AbbFIOpA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jun 2015 10:45:00 -0400
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B304B99DEA@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Shewmaker <agshew@gmail.com>

Hi Chendi,

On 06/09/2015 04:59 AM, Xue, Chendi wrote:
> Hi, Josh and Andrew
>
> Today, I applied wip-blkin branch to my 4 nodes ceph setup, and created zipkin-based lttng results successfully.
>
> Since we wanna using this latency analyzing methodology on further release or on keyvalue store and newstore.
> I am wondering what is the gap to merge blkin into master? Can I help to rebase to master, so we can merge this branch?

That'd be great! Andrew and I simply haven't had time to finish fixing
up the remaining issues. Running it through a rados suite showed some
more changes were necessary to handle more complicated osd usage -
you'll see several osd crashes in this rados suite run [1].

The code was looking fine to me, it just needs rebasing and debugging
so it can pass the rados test suite.

Thanks!
Josh

[1] 
http://pulpito.ceph.com/joshd-2015-03-25_17:29:16-rados-wip-blkin---blkin-multi/
