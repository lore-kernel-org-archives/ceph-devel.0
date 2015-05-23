From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: ceph-ci.git?
Date: Sat, 23 May 2015 10:34:49 +0100
Message-ID: <556049B9.9080906@suse.de>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47287 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757850AbbEWJez (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 23 May 2015 05:34:55 -0400
In-Reply-To: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 18/05/15 05:40, Sage Weil wrote:
> As the number of people contributing code grows, we've added more and more
> people to the github ceph org who have write access to ceph.git.  Those
> people can merge pull requests and can also push branches directly to the
> repo.
>
> We also use ceph.git as a source for the test build infrastrucure
> (gitbuilders) to generate packages for QA or hot fixes and make check
> tests.  This leads to an every-growing body of wip-* branches in the repo
> (which is annoying), and also means that in order to build something to
> test in QA you also get the ability to (say) push directly to master.
>
> How about we instead
>
>   - create a second repo named something like ceph-ci.git (that's the best
> I can come up with at the moment)
>   - add this as a second source for all gitbuilders (they can poll a list)
>   - move all wip-* branches here
>   - create a new github team with contributing developers who can push to
> this repo and are trusted not to wreak havoc on the builders
>   - remove all the cruft from ceph.git, so that it's just master, next, the
> stable branches, release tags, and anything else similarly important.
>   - restrict ceph.git write access to core developers
>
> This will improve security somewhat and reduce the risk of an accidental
> push to an important branch.
>
> It may also reduce the risk associated with accidental force pushes
> (something we've hemmed and hawed about recently) by limiting the circle
> of people who can write to ceph.git and also changing workflows so that it
> is almost never used directly...

I think this is a great idea!

'ceph-ci' also looks like a simple enough name conveying its purpose, 
even though the 'continuous' part is not necessarily true (but it's 
trivial to type, so it gets my vote).

   -Joao

