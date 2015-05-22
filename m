From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Fri, 22 May 2015 15:52:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <555EF6D0.5000903@redhat.com> <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com> <alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
 <CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56593 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946036AbbEVWwO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 18:52:14 -0400
In-Reply-To: <CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Fri, 22 May 2015, Gregory Farnum wrote:
> On Fri, May 22, 2015 at 3:18 PM, Sage Weil <sweil@redhat.com> wrote:
> >> What would it mean for a user who doesn't have no_root_squash to have
> >> access to uid 0? Why should we allow random users to access any UID
> >> *except* for root? Does a client who has no_root_squash and anon uid
> >> 123 get to access stuff as root, or else as 123? Can they access as
> >> 124?
> >
> > I can't tell what you mean... :(
> >
> > I'm guessing you're getting at root_squash being a weak tool, since it
> > mostly only prevents you from doing something that only root could do (a
> > compromised client can just claim to be any uid).  A weak tool is still a
> > tool, though, and one that people can make use of.
> 
> I guess maybe I am. But it's not just that: it's that I don't
> understand how it interacts with specifying UIDs. I would *expect*
> that we grant specific cephx keys access to specific UIDs, 

 allow uid 1 rw
 allow uid 2 rw

> or to "any except root",

 allow rw options root_squash

> or to "any". 

 allow rw     # implied no_root_squash

> But the usage of root_squash implies that any client can try to act as 
> any UID and we'll let them.

Yes... any uid *except* uid 0.

> So if a key says "no_root_squash, allow uid=123, allow gid=123", does 
> that key allow the client to act as root? I think it *does*, but it 
> *shouldn't*.

Do you mean

 allow rw options  # implied no_root_squash
 allow uid 123 rw
 allow gid 123 rw

?  Because the 2nd and third are no-ops since the first will already let 
123 and any-other non-0 uid (or gid) do a write.

Or, do you mean

 allow uid 123 gid 123 options no_root_squash

In that case, I think no_root_squash is a meaningless option because we 
have already said 'uid 123' only please.


> >> >  - For per-user kerberos, we'll need an extra exchange between client and
> >> > MDS to establish user credentials (e.g., when a user does kinit, or a new
> >> > user logs into the box, etc.).  Note that the kerberos credential has a
> >> > group concept, but I'm not sure how that maps onto the Unix groups
> >> > (perhaps that is a parallel PAM thing with the LDAP/AD server?).  In any
> >> > case, if such an exchange will be needed there, and that session
> >> > state is what we'll be checking against, should we create that structure
> >> > now and use it to establish the gid list (instead of, say, including a
> >> > potentially largish list<gid_t> in every MClientRequest)?
> >>
> >> Like I've said, the GID list that the MDS can care about needs to be
> >> in the session list anyway, right? So we shouldn't need to add it to
> >> MClientRequests.
> >
> > Okay, that means adding these new user auth messages we've been talking
> > about now rather than later.  I'm okay with that, but it's more work, and
> > comes with some risk that we'll get it wrong (since we're not knee-deep in
> > per-user kerberos yet)...
> 
> Does adding new ones right now get us anything? If we're just using
> them to report what groups the user has on the local machine, we might
> as well be verifying them on the client.

Once we start talking about 'allow uid XXX' etc, we'll need to know the 
user's gid so we can apply the group rwx bits.

s
