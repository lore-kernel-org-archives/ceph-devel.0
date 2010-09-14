From: Sage Weil <sage@newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Tue, 14 Sep 2010 14:10:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009141407520.29179@cobra.newdream.net>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
 <Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
 <AANLkTi=cp6QipKogCfqNOaEoanP3K+XEeczoZe2k7JzN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2052412093-1284498615=:29179"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34979 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0INVIo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Sep 2010 17:08:44 -0400
In-Reply-To: <AANLkTi=cp6QipKogCfqNOaEoanP3K+XEeczoZe2k7JzN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2052412093-1284498615=:29179
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Sep 2010, Takuya ASADA wrote:
> Hi,
>=20
> > There currently isn't a way to use a preallocated buffer for reads. =A0=
The
> > incoming data is read into a buffer allocated low in the stack by the
> > messaging layer. =A0The bufferlist& ref is really a handle for the call=
er to
> > get at the buffers; any prior contents are discarded.
>=20
> I understood.
> So that allocated inside SimpleMessenger::Pipe::read_message(), right?
>=20
> > This is something that could be changed, but it will require an additio=
nal
> > messenger callback so that the upper layers can provide the buffer to r=
ead
> > the data into. =A0(That is what the kernel implementation does.)
>=20
> Well, could you tell me where can I find that callback code?
> In fs/ceph/messenger.c?
> I'd like to look into it.

Yeah, it's the alloc_msg callback in struct ceph_connection_operations. =20
You'll find implementations in {osd,mon,mds}_client.c.  The message header=
=20
is passed as an argument, which includes message payload sizes as well as=
=20
a tid (request/transaction id) to (say) look up the request the response=20
is for.

sage
--557981400-2052412093-1284498615=:29179--
