From: David Galloway <dgallowa@redhat.com>
Subject: Re: dropping trusty
Date: Thu, 30 Nov 2017 12:55:26 -0500
Message-ID: <f3f4d84b-2df0-0b7d-65f1-074e4d308348@redhat.com>
References: <alpine.DEB.2.11.1711301711470.12766@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbdK3Rz1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 12:55:27 -0500
In-Reply-To: <alpine.DEB.2.11.1711301711470.12766@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

On 11/30/2017 12:21 PM, Sage Weil wrote:
> We're talking about dropping trusty support for mimic due to the old 
> compiler (incomplete C++11), hassle of using an updated toolchain, general 
> desire to stop supporting old stuff, and lack of user objections to 
> dropping it in the next release.
> 
> We would continue to build trusty packages for luminous and older 
> releases, just not mimic going forward.
> 
> My question is whether we should drop all of the trusty installs on smithi 
> and focus testing on xenial and centos.  I haven't seen any trusty related 
> failures in half a year.  There were some kernel-related issues 6+ months 
> ago that are resolved, and there is a valgrind issue with xenial that is 
> making us do valgrind only on centos, but otherwise I don't recall any 
> other problems.  I think the likelihood of a trusty-specific regression on 
> luminous/jewel is low.  Note that we can still do install and smoke 
> testing on VMs to ensure the packages work; we just wouldn't stress test.
> 
> Does this seem reasonable?  If so, we could reimage the trusty hosts 
> immediately, right?
> 
> Am I missing anything?
> 

Someone would need to prune through the qa dir and make sure nothing
relies on trusty for tests.  We've gotten into a bind recently with the
testing of FOG [1] where jobs are stuck in Waiting for a long time
(tying up workers) because jobs are requesting Trusty.  We got close to
having zero Trusty testnodes since the wip-fog branch has been reimaging
baremetal testnodes on every job.

But other than that, yes, I can reimage the Trusty testnodes.  Once FOG
is merged into teuthology master, we won't have to worry about this
anymore since jobs will automatically reimage machines based on what
distro they require.

[1] https://github.com/ceph/teuthology/compare/wip-fog
