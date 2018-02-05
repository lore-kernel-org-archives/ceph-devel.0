From: Sage Weil <sage@newdream.net>
Subject: Re: Better anticipation for minor releases
Date: Mon, 5 Feb 2018 15:50:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802051529210.24931@piezo.novalocal>
References: <CAC-Np1yBwYUMBiS1tg=9CaJsgEkQJZazP43HzSKT=bR=eof=Uw@mail.gmail.com> <4173fd50ca3d6d4e4f691f116b425397@suse.com> <CAC-Np1xbgABOgjDoYpPrDUvX7hOn3U-AD-YF-LpRsbjAfEPi6g@mail.gmail.com> <bfc90180-334b-519b-cf2c-db13b33abff2@suse.cz>
 <CALqRxCzxBuihz6FTtFq4oROmgstnh79uB8F-iosameNo4+7SOQ@mail.gmail.com> <robbat2-20180202T195241-795645967Z@orbis-terrarum.net> <b0e75bc4-e7da-db16-ddb3-bb70df281699@suse.cz> <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:49632 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753223AbeBEPuJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 10:50:09 -0500
In-Reply-To: <CAEPMp+4mVJd6155ZykTUmrgupLAvoLFEPUTBLVY26Hk+anXogA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, "Robin H. Johnson" <robbat2@gentoo.org>, Ken Dreyer <kdreyer@redhat.com>, Alfredo Deza <adeza@redhat.com>, Abhishek <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 5 Feb 2018, Andrew Schoen wrote:
> >>
> >> Thought:
> >> - Tag or branch a candidate commit for going INTO the QE phase, say
> >>    v12.2.3-rcX.
> >> - Run QE on that tag.
> >> - If QE passes entirely, create final tag at same commit as rc tag.
> >
> >
> > That assumes it's possible the release tooling supports releasing something
> > other than the tip of a branch (i.e. a SHA1 or tag), though, right?
> 
> I'm pretty sure we have support to build from a tag. The build system
> might need a few tweaks, but I think it'd be doable and worth the
> effort.

Building from a tag seems like the wrong approach.  What if the build 
fails for some reason (e.g., minor error in cmake files that affects 
release build but not test build)?  Or, perhaps for important, what if we 
get to the point where we do some testing on the final build 
artifact before finalizing/blessing the release?

I don't understand why racing updates is a problem.  git branching/merge 
solves exactly this problem:

 .
 .
 o  foo
 o  bar ... luminous branch target at time we start build
 |\
 | o baz (a racing change to luminous branch)
 | |
 o | v12.2.3 commit bumping release, with signed tag
  \|
   o merge commit (luminous branch after release is published)
   .
   .

If there is something wrong with the branch commit to matching the commit 
to be built, then *that* seems like the thing to fix in the toolchain 
(e.g., check branch once at the start, get sha1, then build *that*.)

sage
