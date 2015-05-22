From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS auth caps for cephfs
Date: Fri, 22 May 2015 15:02:31 -0700
Message-ID: <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<555EF6D0.5000903@redhat.com>
	<alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35564 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757269AbbEVWCc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 18:02:32 -0400
Received: by igbyr2 with SMTP id yr2so838814igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 15:02:32 -0700 (PDT)
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com. [209.85.223.182])
        by mx.google.com with ESMTPSA id n14sm2760981ion.5.2015.05.22.15.02.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 15:02:31 -0700 (PDT)
Received: by iesa3 with SMTP id a3so40692105ies.2
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2015 15:02:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Fri, May 22, 2015 at 2:35 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 22 May 2015, John Spray wrote:
>> On 21/05/2015 01:14, Sage Weil wrote:
>> > Looking at the MDSAuthCaps again, I think there are a few things w=
e might
>> > need to clean up first.  The way it is currently structured, the i=
dea is
>> > that you have an array of grants (MDSCapGrant).  For any operation=
, you'd
>> > look at each grant until one that says what you're trying to do is=
 okay.
>> > If non match, you fail.  (i.e., they're additive only.)
>> >
>> > Each MDSCapGrant has a 'spec' and a 'match'.  The 'match' is a che=
ck
>> > to see if the current grant applies to a given operation, and the =
'spec'
>> > says what you're allowed to do.
>> >
>> > Currently MDSCapMatch is just
>> >
>> >    int uid;  // Require UID to be equal to this, if !=3DMDS_AUTH_U=
ID_ANY
>> >    std::string path;  // Require path to be child of this (may be =
"/" for
>> > any)
>> >
>> > I think path is clearly right.  UID I'm not sure makes sense here.=
=2E. I'm
>> > inclined to ignore it (instead of removing it) until we decide
>> > how to restrict a mount to be a single user.
>> >
>> > The spec is
>> >
>> >    bool read;
>> >    bool write;
>> >    bool any;
>> >
>> > I'm not quite sure what 'any' means, but read/write are pretty cle=
ar.
>>
>> Ah, I added that when implementing 'tell' -- 'any' is checked when h=
andling
>> incoming MCommand in MDS, so it's effectively the admin permission.
>
> Ok!
>
>> > The root_squash option clearly belongs in spec, and Nistha's first=
 patch
>> > adds it there.  What about the other NFS options.. should be mirro=
r those
>> > too?
>> >
>> > root_squash
>> >   Map requests from uid/gid 0 to the anonymous uid/gid. Note that =
this does
>> >   not apply to any other uids or gids that might be equally sensit=
ive, such
>> >   as user bin or group staff.
>> > no_root_squash
>> >   Turn off root squashing. This option is mainly useful for diskle=
ss
>> >   clients.
>> > all_squash
>> >   Map all uids and gids to the anonymous user. Useful for NFS-expo=
rted
>> >   public FTP directories, news spool directories, etc. The opposit=
e option
>> >   is no_all_squash, which is the default setting.
>> > anonuid and anongid
>> >   These options explicitly set the uid and gid of the anonymous ac=
count.
>> >   This option is primarily useful for PC/NFS clients, where you mi=
ght want
>> >   all requests appear to be from one user. As an example, consider=
 the
>> >   export entry for /home/joe in the example section below, which m=
aps all
>> >   requests to uid 150 (which is supposedly that of user joe).
>>
>> Yes, I think we should.  Part of me wants to say that people who wan=
t NFS-like
>> behaviour should be using NFS gateways.  However, these are all prob=
ably
>> straightforward enough to implement that it's worth maintaining them=
 in cephfs
>> too.

Unfortunately not really =E2=80=94 the NFS semantics are very different=
 from
the way our CephX security caps work. We grant accesses with each
permission, rather than restricting them. We can accomplish similar
things, but they'll need to be in opposite directions:
allow anon_access
allow uid 123, allow gid 123[,456,789,...]
allow root
where each additional grant gives the session more access. (And I'm
not sure if these are best set up as specific things on their own or
just squashed in so that UID -1 is "anon", etc) These let you set up
access permissions like those of NFS, but it's a quite different model
than the various mounting and config file options NFS gives you. I
want to make sure we're clear about not trying to match those
precisely because otherwise our security capabilities are not going to
make any kind of sense. :(
What would it mean for a user who doesn't have no_root_squash to have
access to uid 0? Why should we allow random users to access any UID
*except* for root? Does a client who has no_root_squash and anon uid
123 get to access stuff as root, or else as 123? Can they access as
124?
I mean, I think it would have to mean they get access to everything as
anybody, and I'm not sure which requests would be considered
"anonymous" for the uid 123 bit to kick in. But I don't think that's
what the administrator would *mean* for them to have.

As I think about this more I guess the point is that for multi tenancy
we want each client to be able to do anything inside of their own
particular directory namespace, since UIDs and GIDs may not be
synchronized across tenants? I'm not sure how to address that, but
either way I think it will require a wider/different set of primitives
than we've described here. :/

>>
>> We probably need to mirror these in our mount options too, so that e=
=2Eg.
>> someone with an admin key can still enable root_squash at will, rath=
er than
>> having to craft an authentication token with the desired behaviour.

Mmmm, given that clients normally can't see their capabilities at all
that's a bit tricky. We could maybe accomplish it by tying in with the
extra session exchange (that Sage referred to below); that will be
necessary for adding clients to an existing host session dynamically
and we could also let a user voluntarily drop certain permissions with
it...although dropping permissions requires a client to know that they
have them. Hrm.

On Fri, May 22, 2015 at 2:35 PM, Sage Weil <sweil@redhat.com> wrote:
> Yeah. So Greg and Josh and I sat down with Dan van der Ster yesterday=
 and
> went over some of this.  I think we also concluded:
>
>  - We should somehow tag requests with a uid and list<gid>.  This wil=
l
> make the request path permission checks sane WRT these sorts of check=
s.

Well, hopefully we don't need to tag individual requests with a list
of GIDs because the group information will be in the session state?

>
>  - We need something trickier for cap writeback.  We can simply tag t=
he
> dirty cap on the client with the uid etc of whoever dirtied it, but i=
f
> multiple users do that it can get messy.  I suggest forcing the clien=
t to
> flush before allowing a second dirty, although this will be slighly
> painful as we need to handle the case where the MDS fails or a subtre=
e
> migrates, so it might mean actually blocking in that case.  (This wil=
l be
> semi gross to code but I don't think will affect any realworld worklo=
ad.)

=46lushing *might* be the easiest solution to implement, but I actually
worry we'll run into it a non-trivial amount of the time. Consider a
client with multiple containerized applications running on the same
host, that need to share data...
I'd need to look through the writeback paths in the client pretty
carefully before I felt comfortable picking a path forward here. I'm
tempted to set up some kind of ordered flush thing similar to our
projected journal updates (but simpler!) =E2=80=94 if the client allows
something the MDS doesn't then we've got a problem, but that basically
requires a user subverting the client so I'm not sure it's worth
worrying about?

>
>  - For per-user kerberos, we'll need an extra exchange between client=
 and
> MDS to establish user credentials (e.g., when a user does kinit, or a=
 new
> user logs into the box, etc.).  Note that the kerberos credential has=
 a
> group concept, but I'm not sure how that maps onto the Unix groups
> (perhaps that is a parallel PAM thing with the LDAP/AD server?).  In =
any
> case, if such an exchange will be needed there, and that session
> state is what we'll be checking against, should we create that struct=
ure
> now and use it to establish the gid list (instead of, say, including =
a
> potentially largish list<gid_t> in every MClientRequest)?

Like I've said, the GID list that the MDS can care about needs to be
in the session list anyway, right? So we shouldn't need to add it to
MClientRequests.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
