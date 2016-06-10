From: Sage Weil <sage@newdream.net>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 16:38:24 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606101616210.6221@cpach.fuggernut.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com> <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com> <20160610195837.GB29233@ultraspiritum.eng.arb.redhat.com>
 <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1359184222-1465591106=:6221"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36484 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbcFJUh6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 16:37:58 -0400
In-Reply-To: <CAJ4mKGaSyKN+_52-+CSKhFXsL2WE+5T_Z6egpbBNaJvGs4a-Og@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1359184222-1465591106=:6221
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 10 Jun 2016, Gregory Farnum wrote:
> On Fri, Jun 10, 2016 at 12:58 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> > On 10/06/2016, Gregory Farnum wrote:
> >> Maybe I'm misunderstanding the scope of what you're proposing, but I
> >> don't think this is a good reason to go through this work right now.
> >> Lots of things that seem process-specific turn out to be essentially
> >> cluster properties, despite being configurable on both ends, and will
> >> need to be referenced from all over the stack. And in general if we're
> >> addressing multiple Ceph clusters within a utility we want a full
> >> RadosClient etc for each cluster, so the split doesn't do us much good
> >> on its own, does it? (If we don't want separate admin sockets for each
> >> one, we'd need to extend all of those interfaces to support two
> >> entries for the same type of thing, etc)
> >
> > Finding out exactly which things are process specific is one reason
> > I'm soliciting for feedback. AdminSocket doesn't have to be
> > included. Really, I think we'd get a lot of benefit if we made JUST
> > some debug options and dout support process specific and refactored it
> > that way. Other things could move later on if people wanted them to
> > but wouldn't have to.
> >
> >
> >> If this is your actual goal, I think the unappealing work of replacing
> >> g_ceph_context with a CephContext *cct is the way to go — we'd need to
> >> do this much to support multiple ClusterContexts within a process
> >> anyway. Once we have a motivating use case for splitting stuff up, we
> >> can address that. But if we try and do a generic solution it'll be
> >> much more difficult, and probably will miss some key points we don't
> >> run into until trying to make use of it.
> >>
> >> Am I missing something?
> >> -Greg
> >
> > I have been working on the unappealing work of replacing
> > g_ceph_context with CephContext* cct. It's not just unappealing work,
> > it ends up wiht a result ugly enough I don't think I'd want to merge
> > it if someone presented it to me. It's very invasive in that it
> > changes a whole lot of everything. The split would ALSO change a whole
> > lot of everything, but likely less. You would at least be able to
> > avoid changing the constructors of a while bunch of unrelated things
> > just to pass a variable in that only some member several classes in
> > cares about so it can log a message.
> 
> So you want everything to stay with/go back to having a global member
> for the ProcessContext?
> I'm surprised it needs to find its way into so many random things;
> most objects have references to their parent that let them go back to
> the MDSRank/OSD/whatever main class there is.

I think the crux of the issue is the debug/logging code.  Almost all the 
other uses of cct are related to config options that are per-cluster.

And with logging... it seems like even this is really a per-cluster (well, 
per entity) thing.  Sorting through a log file that combines output from 
two different objecters sounds horrific, and when we cram multiple
OSDs into one process, we're going to want them to still feed into 
different log files.  (And pid files. And admin sockets.)

There are a few things that really are process-bound (like the crypto 
libraries) and are obvious candidates, but I think even those we have to 
be careful with; using globals for anything that is dynamically linked 
(i.e., included in librados or libcommon) is generally a big no-no.  IIRC 
lockdep is the main place where we break that rule (for better or for 
worse).

How bad is the cct plumbing patch?  I fear this might still be the best 
path forward...

sage
--8323329-1359184222-1465591106=:6221--
