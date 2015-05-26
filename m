From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 26 May 2015 09:28:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <555EF6D0.5000903@redhat.com> <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com> <alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
 <CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com> <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net> <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754409AbbEZQ2T (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 12:28:19 -0400
In-Reply-To: <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Tue, 26 May 2015, Gregory Farnum wrote:
> On Fri, May 22, 2015 at 3:52 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 22 May 2015, Gregory Farnum wrote:
> >> On Fri, May 22, 2015 at 3:18 PM, Sage Weil <sweil@redhat.com> wrote:
> >> >> What would it mean for a user who doesn't have no_root_squash to have
> >> >> access to uid 0? Why should we allow random users to access any UID
> >> >> *except* for root? Does a client who has no_root_squash and anon uid
> >> >> 123 get to access stuff as root, or else as 123? Can they access as
> >> >> 124?
> >> >
> >> > I can't tell what you mean... :(
> >> >
> >> > I'm guessing you're getting at root_squash being a weak tool, since it
> >> > mostly only prevents you from doing something that only root could do (a
> >> > compromised client can just claim to be any uid).  A weak tool is still a
> >> > tool, though, and one that people can make use of.
> >>
> >> I guess maybe I am. But it's not just that: it's that I don't
> >> understand how it interacts with specifying UIDs. I would *expect*
> >> that we grant specific cephx keys access to specific UIDs,
> >
> >  allow uid 1 rw
> >  allow uid 2 rw
> >
> >> or to "any except root",
> >
> >  allow rw options root_squash
> >
> >> or to "any".
> >
> >  allow rw     # implied no_root_squash
> >
> >> But the usage of root_squash implies that any client can try to act as
> >> any UID and we'll let them.
> >
> > Yes... any uid *except* uid 0.
> >
> >> So if a key says "no_root_squash, allow uid=123, allow gid=123", does
> >> that key allow the client to act as root? I think it *does*, but it
> >> *shouldn't*.
> >
> > Do you mean
> >
> >  allow rw options  # implied no_root_squash
> >  allow uid 123 rw
> >  allow gid 123 rw
> >
> > ?  Because the 2nd and third are no-ops since the first will already let
> > 123 and any-other non-0 uid (or gid) do a write.
> >
> > Or, do you mean
> >
> >  allow uid 123 gid 123 options no_root_squash
> >
> > In that case, I think no_root_squash is a meaningless option because we
> > have already said 'uid 123' only please.
> 
> So here you've said that no_root_squash is meaningless because of a
> different set of granted permissions; that doesn't sound strictly
> additive to me.
> Or do you mean (as John implies below) that no_root_squash will not
> squash the user and then it will fail because it doesn't have adequate
> access permissions?

It is 'additive' means that we have a set of 'allow ...' stanzas, and if 
there exists one that is says "yes" then we are happy; there is no such 
thing as 'deny ...'.

I think what we make the 'allow ...' look like internally is a separate 
issue... John called it a syntax issue, which I think makes sense.  I'm 
not sure about the proposal to put squash stuff outside of the additive 
grant list, though, or else we lose the additive property.

I think the confusing part here is that "squash" is a verb.  I think we 
have 2 options:

1) Treat the caps as a conditional test only that is e.g. const.  This 
is (mostly) what I've been thinking.  Or,

2) Mix in actions, like "squash uids to X, and then see if it is allowed. 
If so, perform the (squashed) operation."

The latter muddies the water, I think, but I think it's what is needed to 
make this truly NFS-ilke.

> On Tue, May 26, 2015 at 5:56 AM, John Spray <john.spray@redhat.com> wrote:
> > This feels more like a syntax issue: as you say, these NFS-esque options
> > don't make sense as part of a list of additive capabilities, they're more
> > like a single structure with some fields.  The naming is potentially
> > confusing too; we're really talking about a condition under which we squash
> > a UID (never, when requester was root, or always), and then how we do the
> > squashing (to which UID/GID).
> >
> > A syntax that doesn't allow the nonsensical combinations of options might be
> > something like:
> > squash: <none|all|root>
> > squash_to: <uid> <gid>
> > capabilities: [existing additive list style] [] []...
> >
> > (or even a list of those structures, so that admin could define e.g.
> > multiple path-limited capabilities, each with different squashing rules).
> >
> > But maybe it is a good idea to avoid introducing this to users as "it's like
> > NFS" to avoid confusion.
> 
> Yes, something like this makes a lot more sense to me. Although I'd
> almost expect/want it to be done client-side rather than on the
> server: the server is responsible for making sure clients have
> permission to do what they're asking; the clients are responsible for
> forming their requests in a way that they have permission. Is that
> nonsensical?

That makes sense to me.  I suggest

- the MDS decides it is allowed.  If so, do the presented operation.  
Preserve the const-ness of teh current permission checks.

- the client may do some squashing before-hand.

- forget what I said before and make this un-NFS-like.  :)

Perhaps the illustrative example is this: an op to create a file, as uid 
0, in a 777 directory comes in, and the capability says root_squash.  In 
this case, our const check says "if i were to squash to 65534, it would 
still be allowed" and so the mds goes ahead and creates a file *owned by 
root*.

Does that make sense?

sage

