From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Hammer backport and bypassing procedure
Date: Fri, 28 Aug 2015 13:43:47 -0700
Message-ID: <55E0C803.8020402@redhat.com>
References: <55E0B396.2090602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40992 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbbH1Unp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Aug 2015 16:43:45 -0400
In-Reply-To: <55E0B396.2090602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 08/28/2015 12:16 PM, Loic Dachary wrote:
> Hi Abhishek,
>
> We've just had an example of a backport merged into hammer although it did not follow the procedure : https://github.com/ceph/ceph/pull/5691
>
> It's a key aspect of backports : we're bound to follow procedure, but developers are allowed to bypass it entirely. It may seem like something leading to chaos and frustration but it turns out to be exactly the opposite. In a nutshell, it would be constant source of frustration for developers to learn and obey the rules documented at http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO because it would not benefit them significantly. It would also be a problem for us, backporters, because developers would not be as interested in backporting and our workload would significantly increase.
>
> When a developer prepares a backport on his / her own, we update the pull request and the issues to obey the procedure so the (s)he does not have to. Sure, it's a little tedious but it's a small price to pay for the benefit of having a backport being dealt with. That's what I did for https://github.com/ceph/ceph/pull/5691 : updaging the corresponding issues, adding cross references to the pull request.
>
> Samuel Just felt confident enough about the backport that it did not need a rados run to verify it does the right thing. Since it's ultimately Sam's responsibility, that's also ok. The only thing we need to keep in mind when analyzing the next rados run is that this backport did not pass yet. We don't have a way to mark commits that bypassed tests just yet, if you have ideas let us know :-)

That was me merging it based on my local testing. I'll keep an eye out
for any fallout in the hammer runs.

Thanks for keeping everything updated Loic!
Josh
