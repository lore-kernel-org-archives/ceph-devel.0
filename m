From: John Spray <john.spray@redhat.com>
Subject: Re: MDS auth caps for cephfs
Date: Tue, 26 May 2015 13:56:53 +0100
Message-ID: <55646D95.6070105@redhat.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>	<555EF6D0.5000903@redhat.com>	<alpine.DEB.2.00.1505221426120.6462@cobra.newdream.net> <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48763 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbbEZN7D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 May 2015 09:59:03 -0400
In-Reply-To: <CAC6JEv9GRO5S4gT-Zy3R7X_9LHy7UK1KAx7r-riXzX6k3yNGQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>



On 22/05/2015 23:02, Gregory Farnum wrote:
> On Fri, May 22, 2015 at 2:35 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Fri, 22 May 2015, John Spray wrote:
>> Yes, I think we should.  Part of me wants to say that people who wan=
t NFS-like
>> behaviour should be using NFS gateways.  However, these are all prob=
ably
>> straightforward enough to implement that it's worth maintaining them=
 in cephfs
>> too.
> Unfortunately not really =E2=80=94 the NFS semantics are very differe=
nt from
> the way our CephX security caps work. We grant accesses with each
> permission, rather than restricting them. We can accomplish similar
> things, but they'll need to be in opposite directions:
> allow anon_access
> allow uid 123, allow gid 123[,456,789,...]
> allow root
> where each additional grant gives the session more access. (And I'm
> not sure if these are best set up as specific things on their own or
> just squashed in so that UID -1 is "anon", etc) These let you set up
> access permissions like those of NFS, but it's a quite different mode=
l
> than the various mounting and config file options NFS gives you. I
> want to make sure we're clear about not trying to match those
> precisely because otherwise our security capabilities are not going t=
o
> make any kind of sense. :(
> What would it mean for a user who doesn't have no_root_squash to have
> access to uid 0? Why should we allow random users to access any UID
> *except* for root? Does a client who has no_root_squash and anon uid
> 123 get to access stuff as root, or else as 123? Can they access as
> 124?
> I mean, I think it would have to mean they get access to everything a=
s
> anybody, and I'm not sure which requests would be considered
> "anonymous" for the uid 123 bit to kick in. But I don't think that's
> what the administrator would *mean* for them to have.
This feels more like a syntax issue: as you say, these NFS-esque option=
s=20
don't make sense as part of a list of additive capabilities, they're=20
more like a single structure with some fields.  The naming is=20
potentially confusing too; we're really talking about a condition under=
=20
which we squash a UID (never, when requester was root, or always), and=20
then how we do the squashing (to which UID/GID).

A syntax that doesn't allow the nonsensical combinations of options=20
might be something like:
squash: <none|all|root>
squash_to: <uid> <gid>
capabilities: [existing additive list style] [] []...

(or even a list of those structures, so that admin could define e.g.=20
multiple path-limited capabilities, each with different squashing rules=
).

But maybe it is a good idea to avoid introducing this to users as "it's=
=20
like NFS" to avoid confusion.

>
> As I think about this more I guess the point is that for multi tenanc=
y
> we want each client to be able to do anything inside of their own
> particular directory namespace, since UIDs and GIDs may not be
> synchronized across tenants? I'm not sure how to address that, but
> either way I think it will require a wider/different set of primitive=
s
> than we've described here. :/


The path limiting is the most important thing (protect clients accessin=
g=20
one subtree from clients accessing another subtree) but UID mangling is=
=20
important too (protect multiple clients mounting same path from one=20
another's local user DBs).  It's two different motivations.

I'm imagining that "access to path /foo/bar, all_squash to user 123"=20
would be a very typical use case for multitenancy, for environments=20
where each tenant is a single-UID application, but we don't really care=
=20
what the local UIDs are.

>
>>> We probably need to mirror these in our mount options too, so that =
e.g.
>>> someone with an admin key can still enable root_squash at will, rat=
her than
>>> having to craft an authentication token with the desired behaviour.
> Mmmm, given that clients normally can't see their capabilities at all
> that's a bit tricky. We could maybe accomplish it by tying in with th=
e
> extra session exchange (that Sage referred to below); that will be
> necessary for adding clients to an existing host session dynamically
> and we could also let a user voluntarily drop certain permissions wit=
h
> it...although dropping permissions requires a client to know that the=
y
> have them. Hrm.

The mount options could just be overrides that the client sends in the=20
session open: it would be up to the MDS to perform the requested=20
dropping of capabilities.  But now that I think about this more, the=20
idea of defining a second syntax for clients to use to request=20
subtractions from their capabilities becomes unappealing.  Maybe we=20
should just say that what's in your MDSAuthCaps is what you get, and=20
make sure that the associated tooling is simple enough for users to=20
readily create these on a per-mount basis if they want different option=
s.

John
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
