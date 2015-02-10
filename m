From: Sage Weil <sweil@redhat.com>
Subject: Re: K/V interface buffer transaction
Date: Tue, 10 Feb 2015 10:44:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502101043260.1652@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282A62CE@SACMBXIP02.sdcorp.global.sandisk.com> <CA+4uBUa+XBKHkx32hmZAvn4JOLp=o2WJywnA7OWXzSphvEcgjw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F282A63A6@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502101025100.1652@cobra.newdream.net> <CAC6JEv_zcReo1y4JktniD-gcrKRUPLuviHJAtpoEWJ9=aai6Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbbBJSoZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Feb 2015 13:44:25 -0500
In-Reply-To: <CAC6JEv_zcReo1y4JktniD-gcrKRUPLuviHJAtpoEWJ9=aai6Tg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "sjust@redhat.com" <sjust@redhat.com>, "Haomai Wang (haomaiwang@gmail.com)" <haomaiwang@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 10 Feb 2015, Gregory Farnum wrote:
> On Tue, Feb 10, 2015 at 10:26 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 10 Feb 2015, Somnath Roy wrote:
> >> Thanks Sam !
> >> So, is it safe to do ordering if in a transaction *no* remove/truncate/create/add call ?
> >> For example, do we need to preserve ordering in case of the below transaction ?
> >> It will be helpful if you can give some insight in what scenario preserving order is *must*.
> >
> > If I'm not mistaken teh only time ordering would matter at all in an
> > transaction is when the same key is updated twice, right?  The whole thing
> > is committed atomically.  If there *are* dups, then the order there
> > obviously should be preserved.
> >
> > Maybe a first pass would be add an assert or something that there are no
> > dup keys and see if anything every falls out of that... hopefully there
> > are none!
> 
> I'm pretty sure some of the transaction analysis discussions people
> have had say that we do double-updates at times. IIRC it might have
> been the pglog head getting set twice in most transactions?

Oh yeah, could be.  There was the snapset xattr update, but that was 
resetting it to an existing value (not the same value inside the same 
txn).  I forget if there were others.

sage
