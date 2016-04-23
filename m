From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: open the floodgates...
Date: Sat, 23 Apr 2016 10:21:23 +0200
Message-ID: <571B3083.5070606@suse.cz>
References: <alpine.DEB.2.11.1604211432300.16393@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46115 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbcDWIV1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 23 Apr 2016 04:21:27 -0400
In-Reply-To: <alpine.DEB.2.11.1604211432300.16393@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 04/21/2016 09:03 PM, Sage Weil wrote:
> and release the (pull requests with code destined for) kraken!
>
> One question: we moved from a 'next' branch to 'jewel' branch for the
> development period to represent the 'frozen' bugfix branch before each
> development checkpoint release.  Should we
>
> 1) Use a 'kraken' branch, just like we did with jewel.  After each dev
> release, merge in the next lump of new stuff from master.\

I've become accustomed to this, so it seems natural to me. Subjectively, +1

> 2) Go back to a 'next' branch, like we did pre-jewel.

No, thanks.

> 3) Give up on the delayed dev checkpoint release thing we've been doing
> (where we send bug fixes to next or kraken for 2 weeks before release) and
> just release regular checkpoints of master (as 11.0.z).

Though this delay introduces some complexity, we have it documented and 
it serves a good purpose: i.e. making the dev checkpoint releases more 
stable.

> 4) Stop doing development checkpoint releases entirely and let testers
> pull automated builds from gitbuilder or jenkins.

Psychologically, the "imprimatur" of a checkpoint release is reassuring. 
Perhaps more importantly, the granularity of point releases has 
information value. You ask someone what version they are running - with 
dev checkpoint releases they say "10.1.2". Without them, they would say 
"4a2a6f72640d6b74a3bbd92798bb913ed380dcd4".

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
