From: Sage Weil <sweil@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Thu, 17 Nov 2016 00:15:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611170015250.12110@piezo.us.to>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com> <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com> <20161116222935.GB8507@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGZdmR++4PDKGOnyS7kHf9PUzKms_gVaChtjEbhoj+EO0Q@mail.gmail.com> <715cd198-a7e4-9ae7-cf04-f973669c22a9@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754098AbcKQAPx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 19:15:53 -0500
In-Reply-To: <715cd198-a7e4-9ae7-cf04-f973669c22a9@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Thu, 17 Nov 2016, Willem Jan Withagen wrote:
> On 16-11-2016 23:33, Gregory Farnum wrote:
> > On Wed, Nov 16, 2016 at 2:29 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> >> On 16/11/2016, Gregory Farnum wrote:
> >>> Is that branch going to merge imminently? If not maybe we could pull
> >>> out this and the BlueStore fixes for fast merging. :)
> >>
> >> It is in wip-sage-testing at the moment.
> >>
> >>> Is this different from the boost changes you mentioned you already
> >>> have? :)
> >>
> >> Yes and no. The boost changes fix everything in external dependencies
> >> I know about. I was just pointing out that we shouldn't have trouble
> >> addressing future problems if they crop up.
> > 
> > Okay, so once your stuff is in we ought to be able to add -Werr to the
> > build flags. Hurray!
> 
> 'mmmm,
> 
> Perhaps you can fix the CMakeList.txt such that ATM it is only set for
> Linux/GCC....
> 
> I'm all for it, and there is already quite some work done to get the
> code to pass with CLANG.
> But you are going to rain a bit on my parade in getting up to running
> all tests successful and getting to a milestone for the port to FreeBSD.
> Due to execluding some code for FreeBSD, I end up with quite a few more
> unused errors. So I'll have to start fixing them as well.
> 
> Perhaps it would be possible to have jenkins test compilation with Clang
> on Linux, since otherwise my port is the only thing that is going to
> catch Clang warnings. And it is not always easy to get those fixed if
> you are not into the changed code.

Once the clang build is working I'd love to have a clang build test!

sage
