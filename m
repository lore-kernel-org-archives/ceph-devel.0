From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Approaches to wrapping aio_exec
Date: Sun, 3 Mar 2013 18:31:01 -0800
Message-ID: <CAC-hyiF+LGPmgeg7oVX_-7oJFAh5J54BfyZHX1h_0vwxtoShiA@mail.gmail.com>
References: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54580 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab3CDCbB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Mar 2013 21:31:01 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so5625280ied.16
        for <ceph-devel@vger.kernel.org>; Sun, 03 Mar 2013 18:31:01 -0800 (PST)
In-Reply-To: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Mar 3, 2013 at 5:08 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrot=
e:
>
> I've built a custom protocol on top of Rados::exec that uses serializ=
ed
> versions of InputObject and OutputObject to implement the protocol. H=
ere's
> simple pseudo-code that provides my_service::exec:
>
>  void my_service::exec(oid, input_params, bufferlist& out) {
>   bufferlist inbl, outbl;
>   InputObject in(input_params);
>   ::encode(in, inbl);
>
>   librados::exec(oid, inbl, outbl);
>
>   OutputObject reply;
>   ::decode(reply, outbl);
>   out =3D reply.payload;
>  }
>
> I'd like to provide a my_service::aio_exec that wraps librados::aio_e=
xec,
> but doing so doesn't seem to be straight-forward with the current asy=
nc
> interface.
>
> Notice in the above example that the callers output bufferlist must b=
e
> unpacked from the reply protocol. However, the librados::aio_exec int=
erface
> unpacks the output directly into the caller parameter:
>
> int librados::aio_exec(oid, =85, bufferlist *outbl)
> {
> ...
>    objecter->read(oid, oloc, rd, snap_seq, outbl, 0, onack, &c->objve=
r);
> }
>
> What's needed is a intermediate bufferlist that can be decoded when t=
he
> data is available.
>
> One way to do this would be wrap AioCompletion and intercept ack and =
safe
> callbacks to do the data unpacking. The problem with this is that we =
have to
> introduce a new AioCompletion type, or new AioCompletionImpl. I start=
ed to
> do this, but it feels quite clunky.
>
> Any suggestions for handling this?
>


I pushed the wip-librados-exec branch last week that solves a similar
issue. I added two more ObjectOperation::exec() api calls. The more
interesting one added a callback context that is called with the
output buffer of the completed sub-op. Currently in order to use it
you'll need to use operate()/aio_operate(), however, a similar
aio_exec interface can be added.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
