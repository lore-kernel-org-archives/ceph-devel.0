From: Sage Weil <sage@newdream.net>
Subject: Re: rados semantic changes
Date: Wed, 9 Mar 2016 16:47:45 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603091634250.14377@cpach.fuggernut.com>
References: <alpine.DEB.2.00.1505061044140.28239@cobra.newdream.net> <1500936117.16594659.1431127115994.JavaMail.zimbra@redhat.com> <CAC6JEv-BO88qnp4-Pkd6Qy5C+-OsgFBJPRTNFtprBQONUqZf+w@mail.gmail.com> <alpine.DEB.2.00.1505101927130.28239@cobra.newdream.net>
 <alpine.DEB.2.11.1603091539530.22603@cpach.fuggernut.com> <CAJ4mKGa7W2sDTAK-ZGshigjfsuea6j3cAsVidQO4r2_auuXiaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43975 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcCIVsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 16:48:07 -0500
In-Reply-To: <CAJ4mKGa7W2sDTAK-ZGshigjfsuea6j3cAsVidQO4r2_auuXiaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 9 Mar 2016, Gregory Farnum wrote:
> On Wed, Mar 9, 2016 at 12:42 PM, Sage Weil <sage@newdream.net> wrote:
> > Resurrecting an old thread.
> >
> > I think we really want to make these semantic changes to current rados
> > ops (like delete) to make life better going forward.  Ideally shortly
> > after jewel so that they have plenty of time to bake before K and L.
> >
> > I'm wondering if the way to make this change visible to users is to
> > (finally) rev librados to librados3.  We can take the opportunity to make
> > any other pending cleanups to the public API as well...
> 
> Yep. I presume you're thinking of this because of
> http://tracker.ceph.com/issues/14468? It looks like we didn't really
> have any good solutions for that pipelining problem though; any new
> suggestions?

Yeah, I'm still not very happy with either alternative:

1) We persistently record the reqid and return value in the pg log.  This 
turns failed rw ops into a replicated (metadata) write, which sort of 
sucks.  It also means that we probably *wouldn't* store any reply payload, 
which means we lose the ability to have a failure return useful data 
(e.g., info about why it failed).

2) The objecter prevents rw ops from being pipelined.  This means a hash 
table in the objecter so that it transparently blocks subsequent requests 
to the same object.  Or,

3) librados users are expected to avoid pipelining.  We'd document it.  
They'd inevitably get it wrong and have very rare and hard to track down 
failures.

I guess I lean toward #2.  That's a bit different than what we were 
thinking a year ago on this thread...

sage


> -Greg
> 
> >
> > sage
> >
> >
> >
> > On Sun, 10 May 2015, Sage Weil wrote:
> >
> >> On Fri, 8 May 2015, Gregory Farnum wrote:
> >> > Do we have any tickets or something motivating these? I'm not quite
> >> > sure which of these problems are things you noticed, versus things
> >> > we've seen in the field, versus stuff that might make our lives easier
> >> > in the future.
> >> >
> >> > That said, my votes so far are
> >> > On Fri, May 8, 2015 at 4:18 PM, Samuel Just <sjust@redhat.com> wrote:
> >> > > So, the problem is sequences of piplined operations like:
> >> > >
> >> > > (object does not exist)
> >> > > 1. [exists_guard, write]
> >> > > 2. [write]
> >> > >
> >> > > Currently, if a client sends 1. and then 2. without waiting for 1. to complete, the guarantee is that even in the event of peering or a client crash the only visible orderings are [], [1], and [1, 2].  However, if both operations complete (with 1. returning ENOENT) and are then replayed, we will see a result of [2, 1].  1. will be executed first, but since 2. already completed, exists_guard will not error out, and the write will succeed.  2. will then return immediately with success since pg log will contain an entry indicating that it already happened.  Delete seems to be a special case of this.
> >> > >
> >> > > For the more general problem, it seems like the objecter cannot pipeline rw ops with any kind of write (including other rw ops).  This means the objecter in the case above would hold 2. back until 1. completes and is not in danger of being re-sent.  We'll need some machinery in the objecter to handle this part.
> >> >
> >> > Although I think you mean it can't pipeline rw ops on the same object,
> >> > that still seems unpleasant ? especially for our more annoying
> >> > operations that might touch multiple objects.
> >> >
> >> > >
> >> > > For this to work, we need the pg log to record that an op marked as w has been processed regardless of the result.  We can do this for a particular op type marked as w by ensuring that it always succeeds, by writing a noop log entry recording the result, or by giving up and marking that op rw.
> >> > >
> >> > > It seems to me that:
> >> > > 1) delete should always succeed.  We'll have to record a noop log entry to ensure that it is not replayed out of turn.
> >> >
> >> > yes
> >> >
> >> > >   - Or we can leave delete as it is and mark it rw.
> >> > > 2) omap and xattr set operations implicitly create the object and therefore always succeed.
> >> >
> >> > that's not current behavior? yes
> >> >
> >> > > 3) omap remove operations are marked as rw so they can return ENOENT.
> >> > >   - Otherwise, an omap remove operation on a non-existing object would have to add a noop entry to the log or implicitly create the object -- the latter would be particularly odd.
> >> > >   - Or, we could record a noop log entry with the return code.
> >> >
> >> > This one ? I don't think log entries are very expensive, and I don't
> >> > think we want to serialize omap ops. In particular I think serializing
> >> > omap rm would be bad for rgw.
> >>
> >> Yeah, agree on these.  It'll be pretty easy to log noop items.
> >>
> >> We could also put a return value in those noop log entries (or, perhaps,
> >> any log entry).  If I'm following correctly, that will allow the client to
> >> pipeline RW ops.  I'm not sure that's the best idea in the general case
> >> (e.g., if we expect the test to fail frequently), but an op flag
> >> could indicate whether we want to record/log test failures (allowing
> >> the client to pipeline) or whether the objecter will plug the request
> >> stream for the object to keep things correct.
> >>
> >> Actually, I'm not really sure we'll want to cram all that into the
> >> Objecter--it'll mean a hash_map by object that checks that there
> >> aren't already in-flight rw ops on the given object, etc., which may have
> >> a significant performance impact, all to guard against a sequence
> >> very few clients will ever generate.
> >>
> >> sage
> >>
> >>
> >> >
> >> > > 4) I don't think there are any current object classes which should be marked w, but they should be carefully audited.
> >> > >
> >> > > On the implementation side, we probably need new versions of the affected librados calls (omap_set2?, blind_delete?) since we are changing the return values and there may be older code which relies on this behavior.
> >> >
> >> > But then they'd also be preserving broken behavior, right? Perhaps
> >> > it's time to do something interesting with our versioning.
> >> >
> >> > >
> >> > > Write ordered reads also appear to be fundamentally broken in the current implementation for the same reason.  It seems like we'd have to handle that at the objecter level by marking the reads rw.
> >> > >
> >> > > We could also find a way to relax the ordering guarantees even further, but I fear that that would make it excessively difficult to reason about librados operation ordering.
> >> > >
> >> > > Thoughts?
> >> > > -Sam
> >> > >
> >> > > ----- Original Message -----
> >> > > From: "Sage Weil" <sweil@redhat.com>
> >> > > To: sjust@redhat.com, ceph-devel@vger.kernel.org
> >> > > Sent: Wednesday, May 6, 2015 10:47:11 AM
> >> > > Subject: rados semantic changes
> >> > >
> >> > > It sounds like we're kicking around two proposed changes:
> >> > >
> >> > > 1) A delete will never -ENOENT; a delete on a non-existent object is a
> >> > > success.  This is important for cache tiering, and allowing us to skip
> >> > > checking the base tier for certain client requests.
> >> > >
> >> > > 2) Any write will implicitly create the object.  If we want such a
> >> > > dependency (so we see ENOENT), the user can put an assert_exists in the op
> >> > > vector.
> >> > >
> >> > > I think what both of these amount to is that the writes have no read-side
> >> > > checks and will effectively never fail (except for true failure
> >> > > cases).  If the user wants some sort of failure, it will be explicit
> >> > > in the form of another read check in the op vector.
> >> > >
> >> > > Sam, is this what you're thinking?
> >> > >
> >> > > It's a subtle but real change in the semantics of rados ops, but I
> >> > > think now would be the time to make it...
> >> > >
> >> > > sage
> >> > > --
> >> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > > the body of a message to majordomo@vger.kernel.org
> >> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> > >
> >> > > --
> >> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > > the body of a message to majordomo@vger.kernel.org
> >> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
