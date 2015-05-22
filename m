From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Fri, 22 May 2015 15:18:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <555EF6D0.5000903@redhat.com> <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757022AbbEVWSG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 18:18:06 -0400
In-Reply-To: <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Fri, 22 May 2015, Gregory Farnum wrote:
> >> > The root_squash option clearly belongs in spec, and Nistha's first patch
> >> > adds it there.  What about the other NFS options.. should be mirror those
> >> > too?
> >> >
> >> > root_squash
> >> >   Map requests from uid/gid 0 to the anonymous uid/gid. Note that this does
> >> >   not apply to any other uids or gids that might be equally sensitive, such
> >> >   as user bin or group staff.
> >> > no_root_squash
> >> >   Turn off root squashing. This option is mainly useful for diskless
> >> >   clients.
> >> > all_squash
> >> >   Map all uids and gids to the anonymous user. Useful for NFS-exported
> >> >   public FTP directories, news spool directories, etc. The opposite option
> >> >   is no_all_squash, which is the default setting.
> >> > anonuid and anongid
> >> >   These options explicitly set the uid and gid of the anonymous account.
> >> >   This option is primarily useful for PC/NFS clients, where you might want
> >> >   all requests appear to be from one user. As an example, consider the
> >> >   export entry for /home/joe in the example section below, which maps all
> >> >   requests to uid 150 (which is supposedly that of user joe).
> >>
> >> Yes, I think we should.  Part of me wants to say that people who want NFS-like
> >> behaviour should be using NFS gateways.  However, these are all probably
> >> straightforward enough to implement that it's worth maintaining them in cephfs
> >> too.
> 
> Unfortunately not really ? the NFS semantics are very different from
> the way our CephX security caps work. We grant accesses with each
> permission, rather than restricting them. We can accomplish similar
> things, but they'll need to be in opposite directions:
> allow anon_access
> allow uid 123, allow gid 123[,456,789,...]
> allow root
> where each additional grant gives the session more access. (And I'm
> not sure if these are best set up as specific things on their own or
> just squashed in so that UID -1 is "anon", etc) These let you set up
> access permissions like those of NFS, but it's a quite different model
> than the various mounting and config file options NFS gives you. I
> want to make sure we're clear about not trying to match those
> precisely because otherwise our security capabilities are not going to
> make any kind of sense. :(

I don't think this additive vs not additive thing is an issue.  Each 
"grant" exists in isolation.  It either grants access, or it doesn't.  If 
it doesn't, we check other grants (that may or may not grant something).  
How each grant decides whether it grants access can be based on 
anything--including a rule that says e.g. "anything that couldn't only be 
done by root".

The above example would be silly, since the final 'allow root' would 
presumably allow anything--the other grants needn't exist and won't 
have any effect on the result.

(Similarly, whether it defaults to root_squash or you have to explicitly 
mention it is just a UX issue... and maybe compatibility if we care about 
existing clusters with 'mds = allow rwx' caps out there.)

> What would it mean for a user who doesn't have no_root_squash to have
> access to uid 0? Why should we allow random users to access any UID
> *except* for root? Does a client who has no_root_squash and anon uid
> 123 get to access stuff as root, or else as 123? Can they access as
> 124?

I can't tell what you mean... :(

I'm guessing you're getting at root_squash being a weak tool, since it 
mostly only prevents you from doing something that only root could do (a 
compromised client can just claim to be any uid).  A weak tool is still a 
tool, though, and one that people can make use of.

> I mean, I think it would have to mean they get access to everything as
> anybody, and I'm not sure which requests would be considered
> "anonymous" for the uid 123 bit to kick in. But I don't think that's
> what the administrator would *mean* for them to have.
> 
> As I think about this more I guess the point is that for multi tenancy
> we want each client to be able to do anything inside of their own
> particular directory namespace, since UIDs and GIDs may not be
> synchronized across tenants? I'm not sure how to address that, but
> either way I think it will require a wider/different set of primitives
> than we've described here. :/

I agree that locking mounts inside directories is a much more useful 
paradigm, and likely the one that lots of people will use most of the 
time.  But we still need to deal with different users accessing shared 
storage.

> >> We probably need to mirror these in our mount options too, so that e.g.
> >> someone with an admin key can still enable root_squash at will, rather than
> >> having to craft an authentication token with the desired behaviour.
> 
> Mmmm, given that clients normally can't see their capabilities at all
> that's a bit tricky. We could maybe accomplish it by tying in with the
> extra session exchange (that Sage referred to below); that will be
> necessary for adding clients to an existing host session dynamically
> and we could also let a user voluntarily drop certain permissions with
> it...although dropping permissions requires a client to know that they
> have them. Hrm.

Hrm.  I'm inclined to leave it to the cap for now for simplicity?

> On Fri, May 22, 2015 at 2:35 PM, Sage Weil <sweil@redhat.com> wrote:
> > Yeah. So Greg and Josh and I sat down with Dan van der Ster yesterday and
> > went over some of this.  I think we also concluded:
> >
> >  - We should somehow tag requests with a uid and list<gid>.  This will
> > make the request path permission checks sane WRT these sorts of checks.
> 
> Well, hopefully we don't need to tag individual requests with a list
> of GIDs because the group information will be in the session state?
> 
> >
> >  - We need something trickier for cap writeback.  We can simply tag the
> > dirty cap on the client with the uid etc of whoever dirtied it, but if
> > multiple users do that it can get messy.  I suggest forcing the client to
> > flush before allowing a second dirty, although this will be slighly
> > painful as we need to handle the case where the MDS fails or a subtree
> > migrates, so it might mean actually blocking in that case.  (This will be
> > semi gross to code but I don't think will affect any realworld workload.)
> 
> Flushing *might* be the easiest solution to implement, but I actually
> worry we'll run into it a non-trivial amount of the time. Consider a
> client with multiple containerized applications running on the same
> host, that need to share data...
> I'd need to look through the writeback paths in the client pretty
> carefully before I felt comfortable picking a path forward here. I'm
> tempted to set up some kind of ordered flush thing similar to our
> projected journal updates (but simpler!) ? if the client allows
> something the MDS doesn't then we've got a problem, but that basically
> requires a user subverting the client so I'm not sure it's worth
> worrying about?

Yeah.  I agree, ordered flushes would be nicer.

> >  - For per-user kerberos, we'll need an extra exchange between client and
> > MDS to establish user credentials (e.g., when a user does kinit, or a new
> > user logs into the box, etc.).  Note that the kerberos credential has a
> > group concept, but I'm not sure how that maps onto the Unix groups
> > (perhaps that is a parallel PAM thing with the LDAP/AD server?).  In any
> > case, if such an exchange will be needed there, and that session
> > state is what we'll be checking against, should we create that structure
> > now and use it to establish the gid list (instead of, say, including a
> > potentially largish list<gid_t> in every MClientRequest)?
> 
> Like I've said, the GID list that the MDS can care about needs to be
> in the session list anyway, right? So we shouldn't need to add it to
> MClientRequests.

Okay, that means adding these new user auth messages we've been talking 
about now rather than later.  I'm okay with that, but it's more work, and 
comes with some risk that we'll get it wrong (since we're not knee-deep in 
per-user kerberos yet)...

sage
