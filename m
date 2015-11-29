From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 11:51:27 +0000
Message-ID: <565AE6BF.4040701@suse.de>
References: <5659CE92.4000203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52984 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbK2Lv3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 29 Nov 2015 06:51:29 -0500
In-Reply-To: <5659CE92.4000203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 11/28/2015 03:56 PM, Loic Dachary wrote:
> Hi Ceph,
> 
> An optional teuthology field could be added to a commit message like so:
> 
> teuthology: --suite rbd
> 
> to state that this commit should be tested with the rbd suite. It could be parsed by bots and humans.
> 
> It would make it easy and cost effective to run partial teuthology suites automatically on pull requests.
> 
> What do you think ?

Can't we use git-notes for that instead?

I think this pollutes the history a bit. Especially considering this
sort of metadata isn't necessarily specific to a given diff.

Also should be considered that this is a field that may make sense today
but may not make much sense in 10, 15 years. And while we have quite a
few special-purpose fields (e.g., Fixes, Backport), those are currently
pretty explanatory and I believe will be still easily understandable in
a decade's time.

In any case, if there's absolutely no other way to do this and the other
folk thinks it's important to have this, I will certainly not be the
party pooper ;)

  -Joao
