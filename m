From: Jeff Layton <jlayton@redhat.com>
Subject: Re: msgr2 protocol
Date: Tue, 13 Sep 2016 07:18:24 -0400
Message-ID: <1473765504.4740.14.camel@redhat.com>
References: <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
         <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
         <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
         <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
         <alpine.DEB.2.11.1606031333050.6221@cpach.fuggernut.com>
         <CAJ4mKGbyCiWbuwGxhGu_ohf7vxNqVqgf4XQQpQ7eg-tP-YO+gg@mail.gmail.com>
         <alpine.DEB.2.11.1606100649010.6221@cpach.fuggernut.com>
         <20160610190510.GA18999@degu.eng.arb.redhat.com>
         <alpine.DEB.2.11.1606101658530.6221@cpach.fuggernut.com>
         <20160611230503.GA18268@degu.eng.arb.redhat.com>
         <alpine.DEB.2.11.1606121950490.32559@cpach.fuggernut.com>
         <CACJqLyax_SXEZp3vA2_wR+CdwKOo2Re=SsK2xfXqmXjz9d8iNw@mail.gmail.com>
         <alpine.DEB.2.11.1609092112171.19761@piezo.us.to>
         <CACJqLyYwKZ5_1OHR_5=+mr=1ED2Nt34x4TB29j5dE1D+NjzFpg@mail.gmail.com>
         <CACJqLybA-cArcno2oS0AZx238hrV64PZyK9fFXdCBuVHKQQP3Q@mail.gmail.com>
         <alpine.DEB.2.11.1609111703430.19761@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34938 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIMLS2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 07:18:28 -0400
Received: by mail-qt0-f173.google.com with SMTP id 93so86944094qtg.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 04:18:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609111703430.19761@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>
Cc: Marcus Watts <mwatts@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 2016-09-11 at 17:05 +0000, Sage Weil wrote:
> On Sat, 10 Sep 2016, Haomai Wang wrote:
> > About thing is v1/v2 compatible. I rethink the details:
> > 
> > 0. we need to define the new banner which must longer than before("ceph v027")
> > 1. assume msgr v2 banner is "ceph v2 %64llx %64llx\n"
> > 2. both in simle/async codes, server side must issue banner firstly
> > 3. if server side supports v2 and client only supports v1, client will
> > receive 9 bytes and do memcmp, then reject this connection via closing
> > socket. So server side could retry the older version
> > 4. if server side only supports v1 and client supports v2, client
> > according banner to reply corresponding banner
> > 
> > This tricky design is based on the implementation fact "accept side
> > issue the banner firstly" and "new banner is longer than old banner",
> > and this way doesn't need to involve other dependences like mon port
> > changes.
> > 
> > Does this way has problem?
> 
> I was thinking we avoid this problem and any hacky initial handshakes by 
> speaking v2 on the new port and v1 on the old port.  Then the monmap has 
> an entity_addrvec_t with both a v1 and v2 address (encoding with just the 
> v1 address for old clients). Same for the OSDs.
> 
> The v1 handshake just isn't extensible (how do you tell a v2 client 
> connecting that you speak both v1 and v2?).
> 

Depending on port assignments for the protocol is pretty icky though.
There may be valid reasons to use different ports in some environments
and then that heuristic goes right out the window.

One thing that is really strange about both the old and new protocols
is that they have the client and server sending the initial exchange
concurrently, or have the server send it first.  While it may speed up
the initial negotiation slightly, it makes it really hard to handle
fallback to earlier protocol versions (as Haomai pointed out), as the
client is responsible for handing reconnects.

Consider the case where we have a client that supports only v1 but a
server that supports v1 and v2. Client connects and then server sends a
v2 message. Client doesn't understand it and closes the connection and
reconnects, only to end up in the same situation on the second attempt.

There's no way for the server to preserve the state from the initial
connection attempt and handle the new connection with v1. Would it not
make more sense to have the client connect and send its initial banner,
and then let the server decide what sort of banner to send based on
what the client sent?

> > 
> > 
> > > On Sat, Sep 10, 2016 at 11:37 AM, Haomai Wang <haomai@xsky.com> wrote:
> > >
> > >
> > > > On Sat, Sep 10, 2016 at 5:14 AM, Sage Weil <sweil@redhat.com> wrote:
> > >>
> > >> On Sat, 10 Sep 2016, Haomai Wang wrote:
> > >> > @sage in current impl, when logic fault like state mismatch, data format
> > >> > mismatch or anything else, connection will abort session via closing
> > >> > socket.
> > >> > And the peer side would do something according to policy too.
> > >> > In msgr v2 when introducing multi streams in the same connection, we
> > >> > can't
> > >> > simply abort socket to indicate something wrong now. I think we need to
> > >> > introduce TAG_ABORT with error message.
> > >> >
> > >> > But the peer side may stuck into a state like reading enough data as
> > >> > "length" indicate. It may miss the TAG_ABORT notify or other reconnect
> > >> > tag.
> > >> > A tricky thing is we use tcp OOB bit to send which exactly trigger
> > >> > "urgent"
> > >> > signal when receiving, but it only occur 1 byte in tcp proto which can
> > >> > be
> > >> > used here to indicate the stream id(32bit designed now).
> > >> >
> > >> > What's more, multi stream mixed within one socket may make trouble to
> > >> > message receiving when potential tcp packet silent error. So it looks we
> > >> > can't use the same socket the multi stream to meet our demands.
> > >> >
> > >> > Any idea?
> > >>
> > >> I think we intorduce a TAG_ABORT to interrupt the stream.  And then we
> > >> have to assume that the low-level msgr2 implementation that reads and
> > >> writes frames (which have their own frame_len) is not buggy.  In practice,
> > >> the aborts tend to happen because we get a message we don't understand
> > >> (version mismatch, encoding compatibility bug, etc.), and that'll happen
> > >> at a higher level after frames have been read... so a TAG_ABORT will be
> > >> sufficient.
> > >
> > >
> > > yes, if frame is ok. It should be ok.... Let's go through this firstly...
> > > The worse case is the frame length is not expected as data transferred.
> > >
> > >>
> > >>
> > >> Also, we can have an option to make aborts close the socket.  That'll be
> > >> fine for now anyway, although later it's probably to disruptive when
> > >> multiple streams are sharing a socket...
> > >>
> > >> sage
> > >>
> > >>
> > >>  >
> > >> >
> > >> >
> > > >> > On Mon, Jun 13, 2016 at 7:59 AM, Sage Weil <sweil@redhat.com> wrote:
> > >> >       On Sat, 11 Jun 2016, Marcus Watts wrote:
> > >> >       > If the client doesn't look at "features" before it sends
> > >> >       stuff, it
> > >> >       > will not be able to be very smart about taking advantage of
> > >> >       some
> > >> >       > future better method.  In fact, there isn't much advantage
> > >> >       > to the server sending anything early - it could just as easily
> > >> >       > wait until after it's seen the clients request.
> > >> >       >
> > >> >       > Failing hard & retrying on a failed reconnect is going to be
> > >> >       slower.
> > >> >       > On the bright side, at least it shouldn't happen often.
> > >> >
> > >> >       Yep.  Well, I think it is the client's (limited choice).  If it
> > >> >       needs to
> > >> >       know the server features, it needs to either wait for them, or
> > >> >       make some
> > >> >       optimistic choice and be prepared to pay the cost of a mistake.
> > >> >       We should
> > >> >       give the client choice, though, if we can.
> > >> >
> > >> >       > If you're sending encryption (w/ different auth or keys) from
> > >> >       several
> > >> >       > different streams, how are you planning to indicate which bits
> > >> >       > go with which scheme?, and which bits are you planning to
> > >> >       encrypt
> > >> >       > and which not?
> > >> >
> > >> >       This is what he stream ids are for, and why the outer portion of
> > >> >       the frame
> > >> >       is unencrypted.  See
> > >> >
> > >> >
> > >> > https://github.com/ceph/ceph/pull/9461/files#diff-83789b4be697d82eedbcbe330
> > >> >       c44b436R68
> > >> >
> > >> >        +  stream_id (le32)
> > >> >        +  frame_len (le32)
> > >> >        +  tag (TAG_* byte)
> > >> >        +  payload
> > >> >        +  [payload padding -- only present after stream auth phase]
> > >> >        +  [signature -- only present after stream auth phase]
> > >> >
> > >> >       The tag and payload (and padding) would be encrypted or signed,
> > >> >       but not
> > >> >       the stream id and frame_len.
> > >> >
> > >> >       > Byte count limits.  Basically, you don't want collisions
> > >> >       because
> > >> >       > of duplicated keys or data.  This depends on your crypto
> > >> >       system,
> > >> >       > so, for instance, you should not encrypt with one key more
> > >> >       than
> > >> >       >       aes, cbc        about 2^68 bytes
> > >> >       >       aes, ctr        exactly 2^128 bytes
> > >> >       > more generally, this depends on mode, blocksize, ...
> > >> >       > This applies across *all* uses of the key - and so you would
> > >> >       > generally want to use the session key directly as little as
> > >> >       possible.
> > >> >       > (in particular, using the session key for ctr directly would
> > >> >       be very very bad.)
> > >> >       >
> > >> >       > If you've got multiple streams going already, you should be
> > >> >       able
> > >> >       > to include a fairly simple rekey method with little effort.
> > >> >       > For instance, as part of the method, you could,
> > >> >       >       up front as part of the method
> > >> >       >               send a per-stream key encrypted under the shared
> > >> >       secret.
> > >> >       >       prepend to the first data sent in a payload
> > >> >       >               byte limit, stream key #0 (encrypted under the
> > >> >       per-stream key)
> > >> >       >               then encrypt the next N bytes with stream key #0
> > >> >       >       when the byte limit is reached, prepend to the
> > >> >       >               next data sent in a payload
> > >> >       >               byte limit, stream key #1 (encrypted under the
> > >> >       per-stream key)
> > >> >       >               then encrypt the next N bytes with stream key #1
> > >> >       >       &etc.
> > >> >
> > >> >       Good idea.  If I understand correctly, it means that the
> > >> >       session_key is
> > >> >       only used to send the new/next random encryption key, and if we
> > >> >       make the
> > >> >       byte limit part of the initial protocol we get the rotation we
> > >> >       need.  It
> > >> >       might be simpler to do it as a frame limit instead of byte
> > >> >       limit, and
> > >> >       assume max-length frames (2^32 bytes).  We could still be super
> > >> >       conservative and rotate the encryption key every 2^16 messages
> > >> >       or
> > >> >       something...?  And rotating the key on frame boundaries should
> > >> >       be much
> > >> >       simpler to implement.
> > >> >
> > >> >       Anyway, that part can be defined a bit later, I think.
> > >> >
> > >> >       Thanks!
> > >> >       sage
> > >> >
> > >> >
> > >> >
> > >> >
> > >
> > >
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Jeff Layton <jlayton@poochiereds.net>
-- 
Jeff Layton <jlayton@redhat.com>
