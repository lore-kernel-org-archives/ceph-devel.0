From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Wed, 27 May 2015 16:59:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net> <CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com> <alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
 <CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com> <alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net> <CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com> <alpine.DEB.2.00.1505261601400.26752@cobra.newdream.net>
 <CAC6JEv8tb3J-oNSe7SgNJGvLfXPWvXkd+W6aOK_+dsjktoYUrA@mail.gmail.com> <alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net> <CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com> <alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
 <CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com> <alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net> <CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40143 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbbE0X7u (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 May 2015 19:59:50 -0400
In-Reply-To: <CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Wed, 27 May 2015, Gregory Farnum wrote:
> On Wed, May 27, 2015 at 4:07 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Wed, 27 May 2015, Gregory Farnum wrote:
> >> On Wed, May 27, 2015 at 3:21 PM, Sage Weil <sweil@redhat.com> wrote:
> >> > On Wed, 27 May 2015, Gregory Farnum wrote:
> >> >> > I was just talking to Simo about the longer-term kerberos auth goals to
> >> >> > make sure we don't do something stupid here that we regret later.  His
> >> >> > feedback boils down to:
> >> >> >
> >> >> >  1) Don't bother with root squash since it doesn't buy you much, and
> >> >> >  2) Never let the client construct the credential--do it on the server.
> >> >> >
> >> >> > I'm okay with skipping squash_root (although it's simple enough it might
> >> >> > be worthwhile anyway)
> >> >>
> >> >> Oh, I like skipping it, given the syntax and usability problems we went over. ;)
> >> >>
> >> >> > but #2 is a bit different than what I was thinking.
> >> >> > Specifically, this is about tagging requests with the uid + gid list.  If
> >> >> > you let the client provide the group membership you lose most of the
> >> >> > security--this is what NFS did and it sucked.  (There were other problems
> >> >> > too, like a limit of 16 gids, and/or problems when a windows admin in 4000
> >> >> > groups comes along.)
> >> >>
> >> >> I'm not sure I understand this bit. I thought we were planning to have
> >> >> gids in the cephx caps, and then have the client construct the list it
> >> >> thinks is appropriate for each given request?
> >> >> Obviously that trusts the client *some*, but it sandboxes them in and
> >> >> I'm not sure the trust is a useful extension as long as we make sure
> >> >> the UID and GID sets go together from the cephx caps.
> >> >
> >> > We went around in circles about this for a while, but in the end I think
> >> > we agreed there is minimal value from having the client construct anything
> >> > (the gid list in this case), and it avoids taking any step down what is
> >> > ultimately a dead-end road.  For example, caps like
> >> >
> >> >   allow rw gid 2000
> >> >
> >> > are useless since the client can set gid=2000 but then make the request
> >> > uid anything it wants (namely, the file owner).  Cutting the client out of
> >> > the picture also avoids the many-gid issue.
> >>
> >> I don't think I understand the threat model we're worried about here.
> >> (Granted a cap that sets gid but not uid sounds like a bad idea to
> >> me.) But if the cephx caps include the GID then a client can only use
> >> weaker ones than they're permitted, which could frequently be correct.
> >> For instance if each tenant in a multitenant system has a single cephx
> >> key, but they have both admin and non-admin users within their local
> >> context?
> >
> > Not sure I understand the question.  The threat model is... a client that
> > can send arbitrary requests and wants to modify files?
> >
> > - Any cap that specifies gid only is useless, since you can choose a uid
> > to match the file.
> >
> > - Any cap that specifies uid only exposes any group-writeable files/dirs.
> >
> > - Any cap that specifies uid and gid(s) is fine.
> >
> > ...but if we have a server-side mapping of uid -> gid(s), then any of
> > those is fine (we can specify uid only, gid only, or both).
> 
> Okay, so it's just malformed cephx caps then. We could just make it
> refuse to accept gid specs if there's not a uid one as well.

Well... it's meaningless if the client gets to choose the gid set.  If we 
don't do that, then it depends on what the server-side does.  If kerberos 
is used (i.e., the user doesn't get to choose an arbitrary uid) then it's 
okay.  But yeah, I guess we should disallow it for now until that becomes 
available, since in the meantime even with server-side uid->gid mapping 
they can pick any uid.

> Not that I'm necessarily opposed to doing it server-side, but I'm not
> sure where we'd store it in the minimal configuration (without
> kerberos or some other server to do lookups in) and not including them
> in the cephx caps just feels odd.

Yeah.  In fact, if we do have a server-side uid->gid map, and a cap like

 allow rw uid 100 gid 100

does the gid part actually accomplish anything?  I'm thinking it doesn't, 
and we can just forget gid in the caps entirely for the time being?  I 
mean, maybe the user is in groups 100, 200, and 300, but we only want to 
them act as though they're in 100 for this mount.. but who would even want 
to do that, and do we care at this point?

FWIW, my inclination would be to make the default mapping be a trivial 
mapping where the gid list == the uid.  Or, maybe, no gids at all.

> >> >> > I think we can get 1-3 without too much trouble!  The main question for me
> >> >> > right now is how we define teh credential we tag requests and cap
> >> >> > writeback with.  Maybe something simple like
> >> >> >
> >> >> > struct ceph_cred_handle {
> >> >> >         enum { NONE, UID, OTHER } type;
> >> >> >         uint64_t id;
> >> >> > };
> >> >> >
> >> >> > For now we just stuff the uid into id.  For kerberos, we'll put some
> >> >> > cookie in there that came from a previous exchange where we passed the
> >> >> > kerberos ticket to the MDS and got an id.  (The ticket may be big--we
> >> >> > don't want to attach it to each request.)
> >> >>
> >> >> Okay, so we want to do a lot more than in-cephx uid and gid
> >> >> permissions granting? These look depressingly
> >> >> integration-intensive-difficult but not terribly complicated
> >> >> internally. I'd kind of like the interface to not imply we're doing
> >> >> external callouts on every MDS op, though!
> >> >
> >> > We'd probably need to allow it to be async (return EAGAIN) or something.
> >> > Some cases will hit a cache or be trivial and non-blocking, but others
> >> > will need to do an upcall to some slow network service.  Maybe
> >> >
> >> >   int resolve_credential(bufferlist cred, uid_t *uid, vector<gid_t>
> >> >      *gidls, Context *onfinish);
> >> >
> >> > where r == 0 means we did it, and r == -EAGAIN means we will call onfinish
> >> > when the result is ready.  Or some similar construct that let's avoid a
> >> > spurious Context alloc+free in the fast path.
> >>
> >> Mmm. "slow network service" scares me. I presume you're thinking here
> >> that this is a per-session request, not a per-operation one? If we're
> >> going to include external security systems we probably need to let
> >> them get a say on every request but it very much needs to be local
> >> data only for those.
> >
> > The ceph_cred_handle would be per-request, but you would normally do
> > upcalls infrequently.  Like in the kerberos case, we'd do that when they
> > credential was registered (before it was used).  The the resolve step
> > would have no network hop.  Or we might call out to LDAP, in which case
> > the plugin would go async, and then cache the result so it is fast the
> > next time around.
> 
> ceph_cred_handle as you defined it above is just an internal Ceph
> structure though, right? I'm imagining more complicated systems (which
> maybe don't exist) that couldn't be well-represented by a simple ID to
> permissions mapping that we'll always understand. Or systems that
> include timeouts and want us to renew the credential every N seconds.
> So it'd be useful to let them define their own per-request security
> check operating on static data, as well as the (async)
> credential-identifying upcall.

I'm thinking it can either be a simple int (like uid) for trivial schemes, 
or an id referencing a previous exchange that set up the complicated 
thingk (like a kerberos ticket). e.g.,

 client -> mds : register_credential(<blob>)
 mds -> client : register_credential_reply(cred_handle.id=123, expires=...)
 client -> mds : request(mkdir foo, cred_handle.id=123)
 client -> mds : request(mkdir bar, cred_handle.id=123)
 client -> mds : request(mkdir baz, cred_handle.id=123)
 ...

I was just trying to keep it small and fixed-size.  But we could also just 
make it a bufferlist/blob in case there is a larger, non-fixed size thing 
that we want to include with every request (that's actually what Simo 
originally suggested).  I think that's only helpful though if we expect to 
have big blobs that aren't reused...

sage
