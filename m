From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: xio-rados-firefly branch update
Date: Mon, 28 Apr 2014 23:14:27 -0400 (EDT)
Message-ID: <1753662147.176.1398741267939.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3995 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134AbaD2DOm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 23:14:42 -0400
In-Reply-To: <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi Greg,

----- "Gregory Farnum" <greg@inktank.com> wrote:

>=20
> The re-org mostly looks fine.
> I notice you're adding a few more "friend" declarations though, and I
> don't think those should be necessary =E2=80=94 Connection can label =
stuff as
> protected instead of private to help with that.
> PipeConnection should probably live with Pipe or SimpleMessenger
> instead of Connection? Certainly don't want the backwards knowledge
> that "friend class PipeConnection" implies.

Ok.

> It would be better if we didn't need to add members to the shared
> classes in order to allow one implementation but not the other
> (looking particularly at bi::list_member_hook<> dispatch_q).

No, but this is a potential optimization for both/all Messengers.  It
could also be worth revisiting whether Message could be specialized by
Messenger.

>=20
> SimplePolicyMessenger seems a bit weird =E2=80=94 it's just a
> shared-implementation class, but it doesn't hide any of the meaning
> of
> the policies away from you or provide interfaces to do the work for
> you. In particular, it doesn't look like the Xio stuff is actually
> following any of the throttle rules about how much data is allowed in
> from clients, and SimplePolicyMessenger isn't helping it do so.

I agree. What I meant by "shoving" all this stuff into SimplePolicyMess=
enger
was that we hadn't examined the policy interfaces fully, and were just
trying to clean up the interface, essentially, so XioMessenger could be
clearer.  There's more work to do here, at least forward looking.

>=20
>=20
> > 2. about the completion mechanisms--with the addition of claim_data=
,
> this
> > is provisionally complete
>=20
> Can you talk about this a bit in general before I comment? I want to
> make sure I understand what's going on here, particularly with the
> way
> you're doing memory allocation in the mempools and handling the
> refcounting.

Yes, and also, we have just pushed a major update to this logic on our
current stabilization branch (xio-rados-exp-noreg-buf-qs-upstream-ow-md=
w).
The logic in the last version was overly complex.  We streamlined thing=
s,
and also have switched to using the Xio one-way message paradigm, which
as you mentioned a while back, is closer to Ceph's, and also has higher
performance.

>=20
> > 3. about DispatchStrategy and non-prio queueing, and how the way
> we're doing
> > things relates to your parallel work with SimpleMessenger
>=20
> This looks a bit problematic. In particular, the standard
> SimpleMessenger interface is responsible for delivery fairness
> between
> different peers, and none of your examples provide that. I suppose
> they do have the information needed to do so as part of the
> Message::connection member.
> My work on speeding up the SimpleMessenger introduces "fast dispatch"
> for specific types of messages, and shifts responsibility for
> fairness
> onto the Dispatcher. It's essentially your "FastStrategy" but via
> separate delivery interfaces (so the daemon can do less locking,
> etc).

I agree, there's a bit more cleanup needed here.  Initially, I only had
the equivalent of FastStrategy.  We realized that we wanted to make the
Dispatcher responsible for threading model, but didn't think we could
really tackle that without more feedback, so we made it possible to do
out-of-line delivery with the QueueStrategy, pending further discussion=
=2E

>=20
> Other notes of varying import:
> XioMessenger doesn't implement any of the mark_down stuff. I realize
> that those interfaces are a bit weird for a "persistent-in-hardware"
> connection, but we need some way of simulating them =E2=80=94 the Dis=
patcher
> uses those interfaces to toss everything out and start over, making
> sure messages don't survive from one daemon invocation to another. (A
> separate daemon invocation from the cluster's perspective might still
> be the same daemon on the local machine, if it went unresponsive for
> some reason.)

Agree.  Again, we tried to simplify the complexity away provisionally.

>=20
> Is MDataPing just for your messenger testing bits?

Yes.

>=20
> The buffer changes appear to have some unnecessary Xio class
> declarations in buffer.h, and it=E2=80=99d be nice if all of that was=
 guarded
> by HAVE_XIO blocks.
> Do you actually want the only exposed interface to be create_msg()?
> It
> might become convenient to be able to allocate xio memory space
> elsewhere and give it to the messenger (for instance, reading data
> off
> disk for transmission to a client).

Yes, we only need to expose create_msg(), and (Josh) we could do it in
another header, or whatever.

>=20
> Is "new (bp) xio_msg_buffer(m_hook, buf, len);=E2=80=9D some syntax I=
=E2=80=99m
> unaware of, or a merge/rebase issue? (Seriously, no idea. :)

This is C++ "placement new."

>=20
> What is CEPH_ENTITY_TYPE_GENERIC_SERVER for?

This was just cargo-cult coding.  It's a server that isn't one of
the known types (like a test harness).

>=20
> Looking at your example setups in OSD and Monitor, I'm not entirely
> thrilled with adding new parameters for an XioMessenger in addition
> to
> SimpleMessenger. I'd rather we came up with some interface so this
> was
> all transparent to the daemon code and endpoint selection was handled
> in the messenger layer.
> This is also introducing some difficulties with monitor
> identification
> =E2=80=94 they are pretty much identified by IP:port, and having two =
separate
> addresses for a single monitor is going to get weird.
> I notice that (for the OSD) you=E2=80=99re setting the =E2=80=9Cpoiso=
n pill=E2=80=9D on
> ms_public twice rather than adding it to ms_xio_public.

We have a bunch of work planned here.  Our current thinking is to creat=
e
a facade (named something like MessengerGroup) that encapsulates all
the messengers that an endpoint deals with.  It goes together with an
address-list extension to entity_name_t, as we talked about briefly.

Thank you, Greg (and Josh)!

>=20
> Thanks!
> -Greg

--=20
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
