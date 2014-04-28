From: Gregory Farnum <greg@inktank.com>
Subject: Re: xio-rados-firefly branch update
Date: Mon, 28 Apr 2014 16:40:39 -0700
Message-ID: <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
References: <226225586.131.1398202885165.JavaMail.root@thunderbeast.private.linuxbox.com>
	<2001054477.133.1398203420696.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:58355 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbaD1Xkk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 19:40:40 -0400
Received: by mail-qg0-f45.google.com with SMTP id a108so7574485qge.4
        for <ceph-devel@vger.kernel.org>; Mon, 28 Apr 2014 16:40:39 -0700 (PDT)
In-Reply-To: <2001054477.133.1398203420696.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

A few days later than I wanted, but I got through various pieces of
this today. It wasn't a thorough review but more a "shape of things"
check, but I have a bunch of notes.

On Tue, Apr 22, 2014 at 2:50 PM, Matt W. Benjamin <matt@linuxbox.com> w=
rote:
> Hi Greg,
>
> Sure.  I'm interested in all feedback you come up with, but for start=
ers,
> it would be helpful to have feedback on
>
> 1. the Messenger reorg in general, and perhaps specifically how to th=
ink
> about the throttle ideas that I shoved into SimplePolicyMessenger

The re-org mostly looks fine.
I notice you're adding a few more "friend" declarations though, and I
don't think those should be necessary =E2=80=94 Connection can label st=
uff as
protected instead of private to help with that.
PipeConnection should probably live with Pipe or SimpleMessenger
instead of Connection? Certainly don't want the backwards knowledge
that "friend class PipeConnection" implies.
It would be better if we didn't need to add members to the shared
classes in order to allow one implementation but not the other
(looking particularly at bi::list_member_hook<> dispatch_q).

SimplePolicyMessenger seems a bit weird =E2=80=94 it's just a
shared-implementation class, but it doesn't hide any of the meaning of
the policies away from you or provide interfaces to do the work for
you. In particular, it doesn't look like the Xio stuff is actually
following any of the throttle rules about how much data is allowed in
from clients, and SimplePolicyMessenger isn't helping it do so.


> 2. about the completion mechanisms--with the addition of claim_data, =
this
> is provisionally complete

Can you talk about this a bit in general before I comment? I want to
make sure I understand what's going on here, particularly with the way
you're doing memory allocation in the mempools and handling the
refcounting.

> 3. about DispatchStrategy and non-prio queueing, and how the way we'r=
e doing
> things relates to your parallel work with SimpleMessenger

This looks a bit problematic. In particular, the standard
SimpleMessenger interface is responsible for delivery fairness between
different peers, and none of your examples provide that. I suppose
they do have the information needed to do so as part of the
Message::connection member.
My work on speeding up the SimpleMessenger introduces "fast dispatch"
for specific types of messages, and shifts responsibility for fairness
onto the Dispatcher. It's essentially your "FastStrategy" but via
separate delivery interfaces (so the daemon can do less locking, etc).

Other notes of varying import:
XioMessenger doesn't implement any of the mark_down stuff. I realize
that those interfaces are a bit weird for a "persistent-in-hardware"
connection, but we need some way of simulating them =E2=80=94 the Dispa=
tcher
uses those interfaces to toss everything out and start over, making
sure messages don't survive from one daemon invocation to another. (A
separate daemon invocation from the cluster's perspective might still
be the same daemon on the local machine, if it went unresponsive for
some reason.)

Is MDataPing just for your messenger testing bits?

The buffer changes appear to have some unnecessary Xio class
declarations in buffer.h, and it=E2=80=99d be nice if all of that was g=
uarded
by HAVE_XIO blocks.
Do you actually want the only exposed interface to be create_msg()? It
might become convenient to be able to allocate xio memory space
elsewhere and give it to the messenger (for instance, reading data off
disk for transmission to a client).

Is "new (bp) xio_msg_buffer(m_hook, buf, len);=E2=80=9D some syntax I=E2=
=80=99m
unaware of, or a merge/rebase issue? (Seriously, no idea. :)

What is CEPH_ENTITY_TYPE_GENERIC_SERVER for?

Looking at your example setups in OSD and Monitor, I'm not entirely
thrilled with adding new parameters for an XioMessenger in addition to
SimpleMessenger. I'd rather we came up with some interface so this was
all transparent to the daemon code and endpoint selection was handled
in the messenger layer.
This is also introducing some difficulties with monitor identification
=E2=80=94 they are pretty much identified by IP:port, and having two se=
parate
addresses for a single monitor is going to get weird.
I notice that (for the OSD) you=E2=80=99re setting the =E2=80=9Cpoison =
pill=E2=80=9D on
ms_public twice rather than adding it to ms_xio_public.

Thanks!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
