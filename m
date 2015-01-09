From: Sage Weil <sweil@redhat.com>
Subject: Re: wip-sage-testing firefly conclusions
Date: Thu, 8 Jan 2015 16:18:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501081618030.5967@cobra.newdream.net>
References: <54AF1D2C.6040603@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbbAIATY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Jan 2015 19:19:24 -0500
In-Reply-To: <54AF1D2C.6040603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 9 Jan 2015, Loic Dachary wrote:
> Hi Sage,
> 
> On the matter of http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/
> 
> There are five errors that are not apt-get / yum trivial errors:
> 
> http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/688065/ is http://tracker.ceph.com/issues/6003#note-41
> http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/688210 is http://tracker.ceph.com/issues/10488
> http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/688210/ is http://tracker.ceph.com/issues/10484
> http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/688402/ is http://tracker.ceph.com/issues/8011
> http://pulpito.ceph.com/sage-2015-01-06_09:44:19-rados-wip-sage-testing-firefly---basic-multi/688290/ is http://tracker.ceph.com/issues/10485

None of those appear related to the new backports:

https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+label%3Awip-sage-testing+milestone%3Afirefly

I think merge them!
sage

