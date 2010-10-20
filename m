From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: read/write on RADOS using external buffer
Date: Wed, 20 Oct 2010 10:04:58 -0700
Message-ID: <AANLkTingwXNcvkTV3OG-siRywzEj6r_Vmb==BnodEUka@mail.gmail.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
	<Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
	<20101019222727.GA1737@enoki.dokukino.com>
	<AANLkTinjo-cyALumDEHiw4NwwJS5E0v5_59X1w11iTog@mail.gmail.com>
	<Pine.LNX.4.64.1010192059070.21300@cobra.newdream.net>
	<AANLkTin0+n+e6Cb_WJcz5JA7xR_XG_K=2k0_bhSDuDRh@mail.gmail.com>
	<Pine.LNX.4.64.1010200821210.3927@cobra.newdream.net>
	<AANLkTi=GyJdFkRV5zo-v-74tn=YBKCBuZC9fdeg1fJCr@mail.gmail.com>
	<Pine.LNX.4.64.1010200948040.3927@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37938 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab0JTRFA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 13:05:00 -0400
Received: by ywi6 with SMTP id 6so2117704ywi.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 10:04:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010200948040.3927@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Takuya ASADA <syuu@dokukino.com>, ceph-devel@vger.kernel.org

On Wed, Oct 20, 2010 at 9:53 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 20 Oct 2010, Colin McCabe wrote:
>> > SimpleMessenger will change no matter what, because the core probl=
em that
>> > we're trying to solve is that it allocates a new buffer when a mes=
sage is
>> > being read off the wire. =A0See SimpleMessenger::read_message(). =A0=
Somehow
>> > that needs to discover and use the user provided buffer instead. =A0=
That
>> > will invariably involve a callback of some sort to find the user b=
uffer.
>> > And some means of yanking the buffer away to deal with the corner =
issue
>> > above.
>>
>> I can see now that we're always allocating a new bufferlist in
>> SimpleMessenger. I can see why we want this feature.
>>
>> I wish we didn't have to have a callback just to get the buffer we'r=
e
>> trying to write into. It feels like that should somehow be grouped
>> with the rest of the transaction data. Why can't we add it to
>> Objector::Op's constructor, for example. There must be some obvious
>> reason but I don't see it yet.
>
> Well, we could push it into the Objecter. =A0We could also try to pus=
h it
> all the way down into the messenger, my maintaining a map of <type,ti=
d> to
> buffer or something. =A0Mainly I want to avoid changing too much of t=
he
> intervening interfaces if we can avoid it. =A0That may be possible, t=
hough.
> If the Objecter::read() is given a non-empty bufferlist* to read into=
, it
> could advertise that buffer to the messenger and the messenger could
> handle it all.

I kind of like the idea of always having the Objecter to pass in a
bufferlist. If the user wants to allocate a new buffer each time, he
knows how to call bufferlist::new().

> But the same problem comes up: we need to also have an interface to t=
ake
> the buffer back, which will mean some interesting interaction with th=
e
> reader threads.

Yeah, we would need to know when it's safe for the client to read /
reuse the buffer they passed in.

Colin

> The kernel messenger avoids this, btw, because it is event driven: we=
 wake
> up when there is socket activity and do non-blocking reads/writes, so=
 we
> can lock the buffers while doing that IO. =A0The SimpleMessenger
> implementation uses threads, and IIRC the pthread locking
> and select/poll interfaces don't play well together.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
