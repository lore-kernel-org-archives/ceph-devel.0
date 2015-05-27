From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS auth caps for cephfs
Date: Wed, 27 May 2015 15:40:59 -0700
Message-ID: <CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<555EF6D0.5000903@redhat.com>
	<alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net>
	<CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
	<alpine.DEB.2.00.1505221505441.6462@cobra.newdream.net>
	<CAC6JEv9Zd11mXiO=VWNQ6s_LKtOkkk4HmCdoa0mTLi7-H-q+tA@mail.gmail.com>
	<alpine.DEB.2.00.1505221544570.6462@cobra.newdream.net>
	<CAC6JEv8EzQ9Pp=ca_LSuVqiyAYSfhyF2ie1Os4YM2v46Ru8Z4w@mail.gmail.com>
	<alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
	<CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com>
	<alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net>
	<CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com>
	<alpine.DEB.2.00.1505261601400.26752@cobra.newdream.net>
	<CAC6JEv8tb3J-oNSe7SgNJGvLfXPWvXkd+W6aOK_+dsjktoYUrA@mail.gmail.com>
	<alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net>
	<CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com>
	<alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:33636 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbE0WlC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 May 2015 18:41:02 -0400
Received: by qcmi9 with SMTP id i9so10505602qcm.0
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 15:41:00 -0700 (PDT)
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com. [209.85.216.181])
        by mx.google.com with ESMTPSA id 143sm204983qhg.16.2015.05.27.15.41.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 15:41:00 -0700 (PDT)
Received: by qchk10 with SMTP id k10so10470944qch.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2015 15:40:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Wed, May 27, 2015 at 3:21 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 27 May 2015, Gregory Farnum wrote:
>> > I was just talking to Simo about the longer-term kerberos auth goals to
>> > make sure we don't do something stupid here that we regret later.  His
>> > feedback boils down to:
>> >
>> >  1) Don't bother with root squash since it doesn't buy you much, and
>> >  2) Never let the client construct the credential--do it on the server.
>> >
>> > I'm okay with skipping squash_root (although it's simple enough it might
>> > be worthwhile anyway)
>>
>> Oh, I like skipping it, given the syntax and usability problems we went over. ;)
>>
>> > but #2 is a bit different than what I was thinking.
>> > Specifically, this is about tagging requests with the uid + gid list.  If
>> > you let the client provide the group membership you lose most of the
>> > security--this is what NFS did and it sucked.  (There were other problems
>> > too, like a limit of 16 gids, and/or problems when a windows admin in 4000
>> > groups comes along.)
>>
>> I'm not sure I understand this bit. I thought we were planning to have
>> gids in the cephx caps, and then have the client construct the list it
>> thinks is appropriate for each given request?
>> Obviously that trusts the client *some*, but it sandboxes them in and
>> I'm not sure the trust is a useful extension as long as we make sure
>> the UID and GID sets go together from the cephx caps.
>
> We went around in circles about this for a while, but in the end I think
> we agreed there is minimal value from having the client construct anything
> (the gid list in this case), and it avoids taking any step down what is
> ultimately a dead-end road.  For example, caps like
>
>   allow rw gid 2000
>
> are useless since the client can set gid=2000 but then make the request
> uid anything it wants (namely, the file owner).  Cutting the client out of
> the picture also avoids the many-gid issue.

I don't think I understand the threat model we're worried about here.
(Granted a cap that sets gid but not uid sounds like a bad idea to
me.) But if the cephx caps include the GID then a client can only use
weaker ones than they're permitted, which could frequently be correct.
For instance if each tenant in a multitenant system has a single cephx
key, but they have both admin and non-admin users within their local
context?

>  The trade-off is that if you
> want stronger auth you need to teach the MDS how to do those mappings.
>
> We need to make sure we can make this sane in a multi-namespace
> environment, e.g., where we have different cloud tenants in different
> paths.  Would we want to specify different uid->gid mappings for those?
> Maybe we actually want a cap like
>
>  allow rw path=/foo uidgidns=foo
>
> or something so that another tenant could have
>
>  allow rw path=/foo uidgidns=bar
>
> Or, we can just say that you get either
>
>  - a global uid->gid mapping, server-side enforcement, and allow based on
> uid;
>  - same as above, but also with a path restriction; or
>  - path restriction, and no server-side uid/gid permission/acl checks

Yes, this multi-namespace environment was what I was touching on in
some of my more confusing asides earlier. I think we need to survey
more operators about what they'd want here before making any
decisions, because I just don't understand the tradeoffs from their
perspective. (Is that list of 3 choices going to be a problem for
anybody? It's certainly the *easiest* to implement, and UID namespaces
within a single hierarchy sound like a bit of a nightmare both to
implement and administer...at that point maybe we're better off with
just multiple separate hierarchies.)

>
>> > The idea we ended up on was to have a plugin interface on the MDS do to
>> > the credential -> uid + gid list mapping.  For simplicity, our initial
>> > "credential id" can just be a uid.  And the plugin interface would be
>> > something like
>> >
>> >  int resolve_credential(bufferlist cred, uid_t *uid, vector<gid_t> *gidls);
>> >
>> > with plugins that do various trivial things, like
>> >
>> >  - cred = uid, assume we are in one group with gid == uid
>> >  - cred = uid, resolve groups from local machine (where ceph-mds
>> > is running)
>> >  - cred = uid, resolve groups from explicitly named passwd/group files
>> >
>> > and later we'd add plugins to query LDAP, parse a kerberos
>> > credential, or parse the MS-PAC thing from kerberos.
>> >
>> > The target environments would be:
>> >
>> > 1) trusted, no auth, keep doing what we do now (trust the client and check
>> > nothing at the mds)
>> >
>> >   allow any
>> >
>> > 2) semi-trusted client.  Use cap like
>> >
>> >   allow rw
>> >
>> > but check client requests at MDS by resolving credentials and verifying
>> > unix permissions/ACLs.  (This will use the above call-out to do the uid ->
>> > gid translation.)
>> >
>> > 3) per-client trust.  Use caps like
>> >
>> >   allow rw uid 123 gids 123,1000
>> >
>> > so that a given host is locked as a single user (or maybe a small list of
>> > users).  Or,
>> >
>> >   allow rw path /foo uid 123 gids 123
>> >
>> > etc.
>> >
>> > 4) untrusted client.  Use kerberos.  Use caps like
>> >
>> >   allow rw kerberos_domain=FOO.COM
>> >
>> > and do all the fancypants stuff to get per-user tickets from clients,
>> > resolve them to groups, and enforce things on the server.  This one is
>> > still hand-wavey since we haven't defined the protocol etc.
>> >
>> > I think we can get 1-3 without too much trouble!  The main question for me
>> > right now is how we define teh credential we tag requests and cap
>> > writeback with.  Maybe something simple like
>> >
>> > struct ceph_cred_handle {
>> >         enum { NONE, UID, OTHER } type;
>> >         uint64_t id;
>> > };
>> >
>> > For now we just stuff the uid into id.  For kerberos, we'll put some
>> > cookie in there that came from a previous exchange where we passed the
>> > kerberos ticket to the MDS and got an id.  (The ticket may be big--we
>> > don't want to attach it to each request.)
>>
>> Okay, so we want to do a lot more than in-cephx uid and gid
>> permissions granting? These look depressingly
>> integration-intensive-difficult but not terribly complicated
>> internally. I'd kind of like the interface to not imply we're doing
>> external callouts on every MDS op, though!
>
> We'd probably need to allow it to be async (return EAGAIN) or something.
> Some cases will hit a cache or be trivial and non-blocking, but others
> will need to do an upcall to some slow network service.  Maybe
>
>   int resolve_credential(bufferlist cred, uid_t *uid, vector<gid_t>
>      *gidls, Context *onfinish);
>
> where r == 0 means we did it, and r == -EAGAIN means we will call onfinish
> when the result is ready.  Or some similar construct that let's avoid a
> spurious Context alloc+free in the fast path.

Mmm. "slow network service" scares me. I presume you're thinking here
that this is a per-session request, not a per-operation one? If we're
going to include external security systems we probably need to let
them get a say on every request but it very much needs to be local
data only for those.
-Greg
