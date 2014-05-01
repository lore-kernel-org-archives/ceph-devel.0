From: Gregory Farnum <greg@inktank.com>
Subject: Re: xio-rados-firefly branch update
Date: Thu, 1 May 2014 15:26:24 -0700
Message-ID: <CAPYLRzg9qU6VTO1awXdkGmouPTieta_r2+o7B0hobOhpD_zmLw@mail.gmail.com>
References: <CAPYLRzhE8a=bXcONNYpAH_dXO-ffgCYXheGzNWZw+OLRA2WvbQ@mail.gmail.com>
	<1753662147.176.1398741267939.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:40459 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaEAW0Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 May 2014 18:26:25 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so3252855qgd.15
        for <ceph-devel@vger.kernel.org>; Thu, 01 May 2014 15:26:24 -0700 (PDT)
In-Reply-To: <1753662147.176.1398741267939.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

On Mon, Apr 28, 2014 at 8:14 PM, Matt W. Benjamin <matt@linuxbox.com> w=
rote:
> Hi Greg,
>
> ----- "Gregory Farnum" <greg@inktank.com> wrote:
>
>>
>> The re-org mostly looks fine.
>> I notice you're adding a few more "friend" declarations though, and =
I
>> don't think those should be necessary =E2=80=94 Connection can label=
 stuff as
>> protected instead of private to help with that.
>> PipeConnection should probably live with Pipe or SimpleMessenger
>> instead of Connection? Certainly don't want the backwards knowledge
>> that "friend class PipeConnection" implies.
>
> Ok.
>
>> It would be better if we didn't need to add members to the shared
>> classes in order to allow one implementation but not the other
>> (looking particularly at bi::list_member_hook<> dispatch_q).
>
> No, but this is a potential optimization for both/all Messengers.  It
> could also be worth revisiting whether Message could be specialized b=
y
> Messenger.
>
>>
>> SimplePolicyMessenger seems a bit weird =E2=80=94 it's just a
>> shared-implementation class, but it doesn't hide any of the meaning
>> of
>> the policies away from you or provide interfaces to do the work for
>> you. In particular, it doesn't look like the Xio stuff is actually
>> following any of the throttle rules about how much data is allowed i=
n
>> from clients, and SimplePolicyMessenger isn't helping it do so.
>
> I agree. What I meant by "shoving" all this stuff into SimplePolicyMe=
ssenger
> was that we hadn't examined the policy interfaces fully, and were jus=
t
> trying to clean up the interface, essentially, so XioMessenger could =
be
> clearer.  There's more work to do here, at least forward looking.

I guess I'd like to hear how you think that might work =E2=80=94 are yo=
u just
going to re-implement the DispatchQueue inside of a
SimplePolicyMessenger? Does the interface actually allow you to do
that? With TCP it's easy to stop accepting data from somebody =E2=80=94=
 just
stop reading off their socket, which we do by blocking on the
Throttler in the socket reader loop. That seems harder here and IIRC
you're passing the messages out asynchronously with anything that can
turn a throttle limit into backpressure.


>> > 2. about the completion mechanisms--with the addition of claim_dat=
a,
>> this
>> > is provisionally complete
>>
>> Can you talk about this a bit in general before I comment? I want to
>> make sure I understand what's going on here, particularly with the
>> way
>> you're doing memory allocation in the mempools and handling the
>> refcounting.
>
> Yes, and also, we have just pushed a major update to this logic on ou=
r
> current stabilization branch (xio-rados-exp-noreg-buf-qs-upstream-ow-=
mdw).
> The logic in the last version was overly complex.  We streamlined thi=
ngs,
> and also have switched to using the Xio one-way message paradigm, whi=
ch
> as you mentioned a while back, is closer to Ceph's, and also has high=
er
> performance.
=2E..
> I didn't actually talk about it :).  The mempools are used everywhere
> to avoid allocation in XioMessenger fast paths (which is most of
> them).  We arrived at a need for this via profiling and measurement,
> of course.
>
> The most complicated case is reclaiming memory for a Message and rela=
ted
> structures on the responder side.  We manage the memory together usin=
g
> a per-request pool, which is a member of the completion hook object.
> (The backing store is the Xio pool facility.)  The decoded Message it=
self
> (assuming we successfully decode) as well as each tracking Ceph buffe=
r
> (logic for which we re-wrote from last version, as noted earlier) hol=
ds
> a reference on the hook object.  When the last of those refs is relea=
sed
> (the upper-layer code is done with Message and with any buffers which
> it claimed) a cleamup process is started on the completion hook.  Thi=
s
> takes a new initial reference (yes, it's atomic) on the hook, which i=
s
> handed off to the XioPortal thread which originally delivered it, for
> final cleanup.  That thread needs to be the one which returns xio_msg
> buffers to Accelio.  Once that is done, the portal thread returns the
> last reference to the completion hook, and it is recycled also.

Okay, I think this makes sense. I was hoping we could just make use of
static functions or something instead of carrying around a hook on
every message, but I can't think of a good way to do that while
supporting multiple messengers in a system.


>
>>
>> > 3. about DispatchStrategy and non-prio queueing, and how the way
>> we're doing
>> > things relates to your parallel work with SimpleMessenger
>>
>> This looks a bit problematic. In particular, the standard
>> SimpleMessenger interface is responsible for delivery fairness
>> between
>> different peers, and none of your examples provide that. I suppose
>> they do have the information needed to do so as part of the
>> Message::connection member.
>> My work on speeding up the SimpleMessenger introduces "fast dispatch=
"
>> for specific types of messages, and shifts responsibility for
>> fairness
>> onto the Dispatcher. It's essentially your "FastStrategy" but via
>> separate delivery interfaces (so the daemon can do less locking,
>> etc).
>
> I agree, there's a bit more cleanup needed here.  Initially, I only h=
ad
> the equivalent of FastStrategy.  We realized that we wanted to make t=
he
> Dispatcher responsible for threading model, but didn't think we could
> really tackle that without more feedback, so we made it possible to d=
o
> out-of-line delivery with the QueueStrategy, pending further discussi=
on.

Hrm. "mak[ing] the Dispatcher responsible for threading model" does
not really fill me with warm fuzzy thoughts. I don't want to change
those interface without very good reason =E2=80=94 it took a long time =
just to
do the fast dispatch work in the OSD and will be much more code churn
in the other daemons; I'm not really sure how we could do make it the
Dispatcher's responsibility except by moving the code over but I think
it lives better in the Messenger, because it has so much more
information available about what connections are busy, etc; but maybe
there's something I'm missing. I didn't read through much of the
XioMessenger implementation, but from the parts I looked at and the
interfaces I'm seeing I think we need to address this soon.

>
>>
>> Other notes of varying import:
>> XioMessenger doesn't implement any of the mark_down stuff. I realize
>> that those interfaces are a bit weird for a "persistent-in-hardware"
>> connection, but we need some way of simulating them =E2=80=94 the Di=
spatcher
>> uses those interfaces to toss everything out and start over, making
>> sure messages don't survive from one daemon invocation to another. (=
A
>> separate daemon invocation from the cluster's perspective might stil=
l
>> be the same daemon on the local machine, if it went unresponsive for
>> some reason.)
>
> Agree.  Again, we tried to simplify the complexity away provisionally=
=2E

Again, from what I'm seeing this is something that needs to get
addressed soon. These interfaces aren't minor bolt-ons even for a
TCP-based messenger, and I suspect it will be more work for an
RDMA-style one.
Along some similar lines, I didn't look closely enough to see how
you're handling stuff like the lossy/non-lossy and server/client
distinctions. Have you taken those on yet?

>> The buffer changes appear to have some unnecessary Xio class
>> declarations in buffer.h, and it=E2=80=99d be nice if all of that wa=
s guarded
>> by HAVE_XIO blocks.
>> Do you actually want the only exposed interface to be create_msg()?
>> It
>> might become convenient to be able to allocate xio memory space
>> elsewhere and give it to the messenger (for instance, reading data
>> off
>> disk for transmission to a client).
>
> Yes, we only need to expose create_msg(), and (Josh) we could do it i=
n
> another header, or whatever.
>
>>
>> Is "new (bp) xio_msg_buffer(m_hook, buf, len);=E2=80=9D some syntax =
I=E2=80=99m
>> unaware of, or a merge/rebase issue? (Seriously, no idea. :)
>
> This is C++ "placement new."

Ah, nifty. Not sure why I haven't run across that before.


>> Looking at your example setups in OSD and Monitor, I'm not entirely
>> thrilled with adding new parameters for an XioMessenger in addition
>> to
>> SimpleMessenger. I'd rather we came up with some interface so this
>> was
>> all transparent to the daemon code and endpoint selection was handle=
d
>> in the messenger layer.
>> This is also introducing some difficulties with monitor
>> identification
>> =E2=80=94 they are pretty much identified by IP:port, and having two=
 separate
>> addresses for a single monitor is going to get weird.
>> I notice that (for the OSD) you=E2=80=99re setting the =E2=80=9Cpois=
on pill=E2=80=9D on
>> ms_public twice rather than adding it to ms_xio_public.
>
> We have a bunch of work planned here.  Our current thinking is to cre=
ate
> a facade (named something like MessengerGroup) that encapsulates all
> the messengers that an endpoint deals with.  It goes together with an
> address-list extension to entity_name_t, as we talked about briefly.

Yeah, that sounds good. Just wanted to check.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
