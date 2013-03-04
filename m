From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Approaches to wrapping aio_exec
Date: Sun, 3 Mar 2013 17:08:46 -0800
Message-ID: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:44117 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3CDBIs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Mar 2013 20:08:48 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so2735432pbc.24
        for <ceph-devel@vger.kernel.org>; Sun, 03 Mar 2013 17:08:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've built a custom protocol on top of Rados::exec that uses serialized=
 versions of InputObject and OutputObject to implement the protocol. He=
re's simple pseudo-code that provides my_service::exec:

 void my_service::exec(oid, input_params, bufferlist& out) {
  bufferlist inbl, outbl;
  InputObject in(input_params);
  ::encode(in, inbl);

  librados::exec(oid, inbl, outbl);

  OutputObject reply;
  ::decode(reply, outbl);
  out =3D reply.payload;
 }

I'd like to provide a my_service::aio_exec that wraps librados::aio_exe=
c, but doing so doesn't seem to be straight-forward with the current as=
ync interface.

Notice in the above example that the callers output bufferlist must be =
unpacked from the reply protocol. However, the librados::aio_exec inter=
face unpacks the output directly into the caller parameter:

int librados::aio_exec(oid, =85, bufferlist *outbl)
{
=2E..
   objecter->read(oid, oloc, rd, snap_seq, outbl, 0, onack, &c->objver)=
;
}

What's needed is a intermediate bufferlist that can be decoded when the=
 data is available.

One way to do this would be wrap AioCompletion and intercept ack and sa=
fe callbacks to do the data unpacking. The problem with this is that we=
 have to introduce a new AioCompletion type, or new AioCompletionImpl. =
I started to do this, but it feels quite clunky.

Any suggestions for handling this?

Thanks,
Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
