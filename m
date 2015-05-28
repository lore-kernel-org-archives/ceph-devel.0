From: Sage Weil <sweil@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Wed, 27 May 2015 17:37:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net> <CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com> <alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net>
 <CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com> <alpine.DEB.2.00.1505261601400.26752@cobra.newdream.net> <CAC6JEv8tb3J-oNSe7SgNJGvLfXPWvXkd+W6aOK_+dsjktoYUrA@mail.gmail.com> <alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net>
 <CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com> <alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net> <CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com> <alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net>
 <CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com> <alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net> <CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbbE1Ah7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 May 2015 20:37:59 -0400
In-Reply-To: <CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Wed, 27 May 2015, Gregory Farnum wrote:
> On Wed, May 27, 2015 at 4:59 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Wed, 27 May 2015, Gregory Farnum wrote:
> >> On Wed, May 27, 2015 at 4:07 PM, Sage Weil <sweil@redhat.com> wrote:
> >> > On Wed, 27 May 2015, Gregory Farnum wrote:
> >> >> On Wed, May 27, 2015 at 3:21 PM, Sage Weil <sweil@redhat.com> wrote:
> >> >> > On Wed, 27 May 2015, Gregory Farnum wrote:
> >> >> >> > I was just talking to Simo about the longer-term kerberos auth goals to
> >> >> >> > make sure we don't do something stupid here that we regret later.  His
> >> >> >> > feedback boils down to:
> >> >> >> >
> >> >> >> >  1) Don't bother with root squash since it doesn't buy you much, and
> >> >> >> >  2) Never let the client construct the credential--do it on the server.
> >> >> >> >
> >> >> >> > I'm okay with skipping squash_root (although it's simple enough it might
> >> >> >> > be worthwhile anyway)
> >> >> >>
> >> >> >> Oh, I like skipping it, given the syntax and usability problems we went over. ;)
> >> >> >>
> >> >> >> > but #2 is a bit different than what I was thinking.
> >> >> >> > Specifically, this is about tagging requests with the uid + gid list.  If
> >> >> >> > you let the client provide the group membership you lose most of the
> >> >> >> > security--this is what NFS did and it sucked.  (There were other problems
> >> >> >> > too, like a limit of 16 gids, and/or problems when a windows admin in 4000
> >> >> >> > groups comes along.)
> >> >> >>
> >> >> >> I'm not sure I understand this bit. I thought we were planning to have
> >> >> >> gids in the cephx caps, and then have the client construct the list it
> >> >> >> thinks is appropriate for each given request?
> >> >> >> Obviously that trusts the client *some*, but it sandboxes them in and
> >> >> >> I'm not sure the trust is a useful extension as long as we make sure
> >> >> >> the UID and GID sets go together from the cephx caps.
> >> >> >
> >> >> > We went around in circles about this for a while, but in the end I think
> >> >> > we agreed there is minimal value from having the client construct anything
> >> >> > (the gid list in this case), and it avoids taking any step down what is
> >> >> > ultimately a dead-end road.  For example, caps like
> >> >> >
> >> >> >   allow rw gid 2000
> >> >> >
> >> >> > are useless since the client can set gid=2000 but then make the request
> >> >> > uid anything it wants (namely, the file owner).  Cutting the client out of
> >> >> > the picture also avoids the many-gid issue.
> >> >>
> >> >> I don't think I understand the threat model we're worried about here.
> >> >> (Granted a cap that sets gid but not uid sounds like a bad idea to
> >> >> me.) But if the cephx caps include the GID then a client can only use
> >> >> weaker ones than they're permitted, which could frequently be correct.
> >> >> For instance if each tenant in a multitenant system has a single cephx
> >> >> key, but they have both admin and non-admin users within their local
> >> >> context?
> >> >
> >> > Not sure I understand the question.  The threat model is... a client that
> >> > can send arbitrary requests and wants to modify files?
> >> >
> >> > - Any cap that specifies gid only is useless, since you can choose a uid
> >> > to match the file.
> >> >
> >> > - Any cap that specifies uid only exposes any group-writeable files/dirs.
> >> >
> >> > - Any cap that specifies uid and gid(s) is fine.
> >> >
> >> > ...but if we have a server-side mapping of uid -> gid(s), then any of
> >> > those is fine (we can specify uid only, gid only, or both).
> >>
> >> Okay, so it's just malformed cephx caps then. We could just make it
> >> refuse to accept gid specs if there's not a uid one as well.
> >
> > Well... it's meaningless if the client gets to choose the gid set.  If we
> > don't do that, then it depends on what the server-side does.  If kerberos
> > is used (i.e., the user doesn't get to choose an arbitrary uid) then it's
> > okay.  But yeah, I guess we should disallow it for now until that becomes
> > available, since in the meantime even with server-side uid->gid mapping
> > they can pick any uid.
> >
> >> Not that I'm necessarily opposed to doing it server-side, but I'm not
> >> sure where we'd store it in the minimal configuration (without
> >> kerberos or some other server to do lookups in) and not including them
> >> in the cephx caps just feels odd.
> >
> > Yeah.  In fact, if we do have a server-side uid->gid map, and a cap like
> >
> >  allow rw uid 100 gid 100
> >
> > does the gid part actually accomplish anything?  I'm thinking it doesn't,
> > and we can just forget gid in the caps entirely for the time being?  I
> > mean, maybe the user is in groups 100, 200, and 300, but we only want to
> > them act as though they're in 100 for this mount.. but who would even want
> > to do that, and do we care at this point?
> 
> I don't understand. In the base case where there is no other user
> authentication/authorization system in place, we need to either
> support group allows in the cephx caps, or we disallow the use of
> groups, or each individual user/mount can claim to be a member of
> whatever group they want.

Oh, right.  I was assuming the MDS is configured with some uid->gid 
backend.  But many won't have or want that, and

> So that makes me think we need to support group allows in the cephx
> caps, of form something like
> 
>  allow rw uid 100 gid 100,200,300
> 
> That would let the client act as user 100 and as a member of groups
> 100, 200, and 300 (*only* with uid 100!) if they so desire. That
> enables lots of important use cases with sharing, right? And it's not
> the client choosing the allowed set, it's the Ceph administrator. Is
> there something about this that we don't want to enable that I'm just
> missing, or are you ignoring the non-Kerberos case, or is there some
> conflict between this and the Kerberos case, or....?

I think this makes perfect sense.  :)

So, the use-cases are now:

1) No authentication: 'allow any'.  What we have now.

2) Subtree restriction: 'allow rw path /foo'.

3) Uid and group restriction: 'allow rw uid 123 gids 123,1000,1001'.

4) Uid restriction + some backend: 'allow rw uid 123'.  MDS will do some 
call-out to map each uid to a gid list.

5) Kerberos: 'allow rw kerberos blah blah'.  Client presents user tickets 
to MDS, and MDS will do the call-out to map that to a uid + gid list.

6) 2 + 3

7) 2 + 4

8) 2 + 5

And then later, maybe,

9) 2 + a different backend for each subtree.
...

> I feel like our meanings are sliding past each other again here. :(

Hopefully not?  :)
sage
