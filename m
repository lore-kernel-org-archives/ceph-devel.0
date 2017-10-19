From: Sage Weil <sage@newdream.net>
Subject: Re: librados3
Date: Thu, 19 Oct 2017 12:00:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710191200091.26711@piezo.us.to>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com> <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:48822 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdJSMAb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 08:00:31 -0400
In-Reply-To: <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

On Thu, 19 Oct 2017, John Spray wrote:
> On Thu, Oct 19, 2017 at 10:25 AM, kefu chai <tchaikov@gmail.com> wrote:
> > in luminous, we introduced a change not backward compatible with
> > pre-luminous librados. see see http://tracker.ceph.com/issues/21573.
> > and i cannot see an obvious solution without bumping up the so version
> > of librados to 3.
> >
> > if we have the luxury to do it,  we will be able to give librados an
> > overhaul. for a todo list, see http://pad.ceph.com/p/librados3.
> >
> > what do you think?
> 
> I've added a couple of items to the pad for deprecated bits to remove
> when we go up a version.
> 
> I guess we would do the version bump for Mimic and for Luminous we
> will just have to apologetically tell people they need to recompile?
> 
> Or we could have a so.3 version (ABI change only) in Luminous that
> just bumps the version to force a recompile, and a so.4 version in
> Mimic that actually makes the API changes?

Yeah, it sounds like this is what we actually want in this case?

sage
