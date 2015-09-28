From: Sage Weil <sage@newdream.net>
Subject: Re: [Hammer Backports] Should rest-bench be removed on hammer ?
Date: Mon, 28 Sep 2015 06:27:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509280626080.11876@cobra.newdream.net>
References: <CAP3mxSymbxxh8k3==03EsR51jmAO6jyY_RZrUsKOyo=aN5tibw@mail.gmail.com> <56091DEB.1070105@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44255 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933758AbbI1N1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 09:27:15 -0400
In-Reply-To: <56091DEB.1070105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek Varshney <abhishek.varshney@flipkart.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 28 Sep 2015, Loic Dachary wrote:
> Hi,
> 
> On 28/09/2015 12:19, Abhishek Varshney wrote:
> > Hi,
> > 
> > The rest-bench tool has been removed in master through PR #5428
> > (https://github.com/ceph/ceph/pull/5428). The backport PR #5812
> > (https://github.com/ceph/ceph/pull/5812) is currently causing failures
> > on the hammer-backports integration branch. These failures can be
> > resolved by either backporting PR #5428 or by adding a hammer-specific
> > commit to PR #5812.
> > 
> > How should we proceed here?
> 
> It looks like rest-bench support was removed because cosbench can replace it. The string cosbench or rest.bench does not show in ceph-qa-suite / ceph master or hammer, which probably means tests using rest-bench are outside of the scope of the ceph project. Deprecating rest-bench from hammer by backporting https://github.com/ceph/ceph/pull/5428 seems sensible.

I don't think we should be removing tools in a stable series unless we 
have a really good reason to do so.  In this case we're dropping 
rest-bench because we don't want to maintain it, not because it is fatally 
broken.  Hammer users who are using shouldn't find that is is removed in 
a later point release.

s

