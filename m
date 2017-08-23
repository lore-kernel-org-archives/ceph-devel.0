From: Sage Weil <sage@newdream.net>
Subject: Re: High memory usage kills OSD while peering
Date: Wed, 23 Aug 2017 13:46:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com> <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com> <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com> <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal> <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60995 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbdHWNrA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 09:47:00 -0400
In-Reply-To: <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Chips <linux.chips@gmail.com>
Cc: Mustafa Muhammad <mustafa1024m@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 23 Aug 2017, Linux Chips wrote:
> On 08/23/2017 01:33 AM, Sage Weil wrote:
> > One other trick that has been used here: if you look inside the PG
> > directories on the OSDs and find that they are mostly empty then it's
> > possible some of the memory and peering overhead is related to
> > empty and useless PG instances on the wrong OSDs.  You can write a script
> > to find empty directories (or ones that only contain the single pgmeta
> > object with a mostly-empty name) and remove them (using
> > ceph-objectstore-tool).  (For safety I'd recommend doing
> > ceph-objectstore-tool export first, just in case there is some useful
> > metadata there.)
> > 
> > That will only help if most of the pg dirs look empty, though.  If so,
> > it's worth a shot!
> > 
> > The other thing we once did was use a kludge patch to trim the
> > past_intervals metadata, which was respnosible for most of the memory
> > usage.  I can't tell from the profile in this thread if that is the case
> > or not.  There is a patch floating around in git somewhere that can be
> > reused if it looks like that is the thing consuming the memory.
> > 
> > sage
> > 
> > 
> 
> we ll try the empty pg search. not sure how much is there, but i randomly
> checked and found a few.
> 
> as for the "kludge" patch, where can I find it. I searched the git repo, but
> could not identify it. did not know what to look for specifically.
> also, what would we need to better know if the patch would be useful?
> e.g. if we need another/more mem profiling.

I found and rebased the branch, but until we have some confidence this is 
the problem I wouldn't use it.
 
> we installed a test cluster of 4 nodes and replicated the issue there, and we
> are testing various scenarios there. if any one cares to replicate it i can
> elaborate on the steps.

How were you able to reproduce the situation?

> if all failed, do you think moving pgs out of the current dir is safe? we are
> trying to test it, but we ll never be sure 100%

It is safe if you use ceph-objectstore-tool export and then remove.  Do 
not just move the directory around as that will leave behind all kinds of 
random state in leveldb!

sage
