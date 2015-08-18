From: Sage Weil <sage@newdream.net>
Subject: Re: Signed-off-by and aliases
Date: Tue, 18 Aug 2015 06:39:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508180629470.22099@cobra.newdream.net>
References: <55BBD384.7030703@dachary.org> <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com> <55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org> <55CDABB2.4080401@suse.de>
 <55CDC978.20304@dachary.org> <mqtfkc$ic7$1@ger.gmane.org> <55D24790.4010703@dachary.org> <mqthtj$jp4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32836 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbHRNjH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Aug 2015 09:39:07 -0400
In-Reply-To: <mqthtj$jp4$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 17 Aug 2015, Alex Elsayed wrote:
> Loic Dachary wrote:
> 
> > Hi Alex,
> > 
> > On 17/08/2015 22:19, Alex Elsayed wrote:
> <snip>
> >> This is where I see a subtle, but meaningful distinction: Accepting from
> >> aliases *which have submitted a DCO* means that the person behind the
> >> alias, even if we don't know their name, has bound themselves to a
> >> standard ov behavior.
> >> 
> >> Accepting from arbitrary aliases does _not_ carry that meaning.
> > 
> > Yes. Although we don't do formal background checks, we make sure that each
> > commit is Signed-off-by: the author as required by
> > https://github.com/ceph/ceph/blob/master/SubmittingPatches#L22 which is
> > linked from the https://github.com/ceph/ceph/blob/master/CONTRIBUTING.rst
> > document that shows whenever someone submits a pull request.
> > 
> > I also believe this is an important distinction and I would feel
> > uncomfortable if Ceph accepted contributions (aliases or not) that are not
> > Signed-off one way or the other.
> 
> The kernel does something slightly different, in a very careful manner: 
> Signed-off-by says that you have _submitted_ the DCO - as in, you must have, 
> from the same address as you signed off by, emailed the DCO itself to the 
> list.
> 
> The S-o-B tag, then, simply says "If you look, you'll find my affirmation of 
> intent to follow the DCO" - it is not, in itself, anything other than a 
> pointer. This prevents people from copypasta'ing the S-o-B line as a magic 
> incantation, without understanding the meaning. (Which the kernel has found 
> _does_ happen _anyway_, but with the "actually submitted a DCO" requirement 
> they can _detect_ that.)

I can't find any reference to emailing a copy of the DCO to any address in 
SubmittingPatches or elsewhere.  Are you sure this is the case?  See

	https://www.kernel.org/doc/Documentation/SubmittingPatches

FWIW, LWN's coverage of James's talk on the DCO last year matches my 
understanding:

	https://lwn.net/Articles/592503/

...

As far as aliases go in sign-offs, I don't see that it's an issue.  In my 
opinion the sign-off is more about due diligence than anything else--that 
we have made a good faith effort to ensure that the code is made in 
compliance with the license.

James contends that it's also more cleaning out offending code when a 
problematic contributor is identified and less about liability for that 
individual, so as long as an alias is used consistently I'm not sure it 
makes a difference.  Lots of people go by names that are not technically 
their legal names, but shortened or anglicized versions of them, but as 
long as they are sufficient to associate the contribution with the 
contributor it serves its purpose.

sage
