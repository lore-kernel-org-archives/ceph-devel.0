From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users]  Mds lock
Date: Sat, 17 Aug 2013 08:05:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308170803570.1479@cobra.newdream.net>
References: <97A897FA540C414C8CBBC5922950EEB3DEB8C3@CNMAILMBX05.lenovo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1646557540-1376751954=:1479"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55264 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab3HQPFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Aug 2013 11:05:54 -0400
In-Reply-To: <97A897FA540C414C8CBBC5922950EEB3DEB8C3@CNMAILMBX05.lenovo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jun Jun8 Liu <liujun8@lenovo.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1646557540-1376751954=:1479
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[moving to ceph-devel]

On Fri, 16 Aug 2013, Jun Jun8 Liu wrote:
>=20
> Hi all, =A0=A0=A0=A0=A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 I am doing some research about mds.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 there are so many types lock and states .But I=
 don't found some
> document to describe.
>=20
> =A0
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 Is there anybody tell me what is "loner" and "=
lock_mix"

'loner' tracks when a single client has some exclusive capabilities on=20
the file.  For example, when it is the only client with the file open, it=
=20
can buffer reads and perform setattr operations locally.

lock_mix (lock->mix) is a transition state from lock (primary mds copy=20
exclusive lock, sort of) and mix (shared write lock between multiple=20
mds's).  The MDS locking is quite complex, but unfortunately there is not=
=20
much in the way of documentation for the code. :(

sage
--557981400-1646557540-1376751954=:1479--
