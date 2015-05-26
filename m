From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 26 May 2015 16:12:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505261601400.26752@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <555EF6D0.5000903@redhat.com> <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com> <alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
 <CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com> <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net> <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com> <alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
 <CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com> <alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net> <CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35875 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbbEZXMn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 19:12:43 -0400
In-Reply-To: <CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Tue, 26 May 2015, Gregory Farnum wrote:
> On Tue, May 26, 2015 at 3:17 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Tue, 26 May 2015, Gregory Farnum wrote:
> >> > That makes sense to me.  I suggest
> >> >
> >> > - the MDS decides it is allowed.  If so, do the presented operation.
> >> > Preserve the const-ness of teh current permission checks.
> >> >
> >> > - the client may do some squashing before-hand.
> >> >
> >> > - forget what I said before and make this un-NFS-like.  :)
> >>
> >> :)
> >>
> >> >
> >> > Perhaps the illustrative example is this: an op to create a file, as uid
> >> > 0, in a 777 directory comes in, and the capability says root_squash.  In
> >> > this case, our const check says "if i were to squash to 65534, it would
> >> > still be allowed" and so the mds goes ahead and creates a file *owned by
> >> > root*.
> >> >
> >> > Does that make sense?
> >>
> >> Mmm, I'm having trouble making this one work out. If you can write a
> >> file with UID 0 you have to be able to subsequently read it, and I
> >> just don't see that happening if you aren't doing an operation as UID
> >> 0?
> >
> > The operation would be done as uid 0.
> >
> > (Also, I'm completely ignoring read operations for the moment... :/ )
> 
> Okay, let's not ignore that. If a read comes in as anonymous for a

"as anonymous"?

> file owned by UID 0 and without world-readable caps (which that write
> operation you described can do), it fails. Correct?
> I see that as a bit of a problem. :/

It's perfectly okay to create a file you can't read:

 echo asdf > foo
 chmod 0 foo
 cat foo

..and things are get fishy when root squash kicks in, so I'm not sure it's 
a problem.

> >> But this is getting thornier as we consider future multi-tenant (not
> >> just multi-user) and subtree work. I've been imaging the subtree
> >> restriction as *not additive*, in that it would be a restriction to
> >> users.
> >
> > I think we're still talking past each other about 'additive'.  I'm
> > suggesting caps are *always* additive.  That is, any operation permitted
> > by
> >
> >  allow A
> >
> > will also permit the same operation if you have
> >
> >  allow A ; allow B
> >
> > for *any* B.  B cannot effect A, and only one of the allow's needs to say
> > "yes".
> >
> > ...but what does that have to do with path restrictions?  If you have an
> > allow A like
> >
> >  allow rw path /foo
> >
> > that will allow something in /foo regardless of what other allow B's are
> > added to the list.
> >
> > Right?
> 
> Okay, so that's one path we could go down. I'm not sure if it's the
> right one or not.

What other path is there?  In my mind this is what "additive" means... if 
that's not what you mean please clarify because I'm so confused right now!

> In particular, I'd like us to be able to guarantee that users never
> escape out of their given subtree.

That's a matter of implementing the checks properly...

> It seems like they could if it's
> just a positive grant. Or maybe if the cephx caps don't include
> anything else then no operations elsewhere will be disallowed? I guess
> that should work. But in any case, not what you wrote in the pad:
> 
> > If a path is specified in the cap, only ops within that subtree are allowed.
> 
> :/

Sorry, this means *for that allow clause*.  I'll clarify in the pad.  That 
is, if you change the above cap to be

 allow rw path /foo ; allow rw

they would not be restricted to /foo.  The set of things you can do is a 
union, not an intersection.

> >> It looks like you've got similar ideas from the pad, so I don't
> >> understand how the anonymous user would generally be allowed to do
> >> things against the tree except read it?
> >>
> >> When looking at your pad and you say "if a UID is specified..." do you
> >> mean specified within an op, or in the cephx caps? The first one makes
> >> sense to me; the second won't work (not additive, etc).
> >
> > In the caps, where it is optional.  The uid on the op will be required
> > (modulo whatever we have to do for compatibility).
> 
> Okay, quoting from the pad:
> > If the uid is specified in the cap, we only allow the operation if it is tagged with the same uid
> > (and all other constraints are satisfied).
> 
> Maybe this is the right way for us to go, but that's definitely not
> additive: it *disallows* the operation if its UID doesn't match the
> one in this cephx cap, regardless of what anything else says.

No, there is no such thing as disallow.  It *grants* access *if* some set 
of conditions are true.

> UIDs like this I think can and should be strictly additive. We
> probably want to include ranges or some other sort of aggregation, but
> I don't see much point to making them optional restrictions the way I
> see for the path-based stuff?
> 
> Or (looking below) perhaps you mean the uid for a specific grant, not
> for all grants within the set of cephx caps. That does make a bit more
> sense, and makes upgrades easier. Hrmm.

Yes

> >> Basically I'm still stuck on how any of this lets us lock a user into
> >> a subtree while letting them do what they want within it. I'm not sure
> >> how/if NFS solves that problem...
> >
> > That's easy:
> >
> >  # lock client into a dir
> >  allow rw path /home/user
> >
> > Or, for a shared model:
> >
> >  # allow access to a project dir, as project or user gid
> >  allow rw path /share/project uid 123 gids 123,1000
> 
> I think I'm forgetting how the parsing works. Is that all one specific
> allow stanza that is evaluated as a unit? Ie, to match it an operation
> must fall within /share/project and be sent by a user with either UID
> 123 or GID{123,1000}? You're right, that works.

Right.  Each 'allow' stanza is a set of conditions.  If they are true, 
then we allow.

sage


> 
> >
> > Ooh... are you thinking forward to when we might have to dynamically write
> > a cap that implements changing kerberos auth information?  For that, I'd
> > suggest something like
> >
> >  allow rw path /foo kerberos
> >
> > ...where that then does an additional check against any kerberos tickets
> > info we've gotten from the client session?
> >
> > sage
> 
> 
