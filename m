From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: xio-rados-firefly branch update
Date: Tue, 29 Apr 2014 08:00:42 -0400 (EDT)
Message-ID: <2111717275.18.1398772842816.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1753662147.176.1398741267939.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2664 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933447AbaD2MBE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Apr 2014 08:01:04 -0400
In-Reply-To: <1753662147.176.1398741267939.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi Greg,

I forgot to finish a couple of thoughts, filling them in...

----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:

> > > 2. about the completion mechanisms--with the addition of
> claim_data,
> > this
> > > is provisionally complete
> >=20
> > Can you talk about this a bit in general before I comment? I want
> to
> > make sure I understand what's going on here, particularly with the
> > way
> > you're doing memory allocation in the mempools and handling the
> > refcounting.

I didn't actually talk about it :).  The mempools are used everywhere
to avoid allocation in XioMessenger fast paths (which is most of
them).  We arrived at a need for this via profiling and measurement,
of course.

The most complicated case is reclaiming memory for a Message and relate=
d
structures on the responder side.  We manage the memory together using=20
a per-request pool, which is a member of the completion hook object.
(The backing store is the Xio pool facility.)  The decoded Message itse=
lf
(assuming we successfully decode) as well as each tracking Ceph buffer
(logic for which we re-wrote from last version, as noted earlier) holds
a reference on the hook object.  When the last of those refs is release=
d
(the upper-layer code is done with Message and with any buffers which
it claimed) a cleamup process is started on the completion hook.  This
takes a new initial reference (yes, it's atomic) on the hook, which is
handed off to the XioPortal thread which originally delivered it, for
final cleanup.  That thread needs to be the one which returns xio_msg
buffers to Accelio.  Once that is done, the portal thread returns the
last reference to the completion hook, and it is recycled also.

>=20
> Yes, and also, we have just pushed a major update to this logic on
> our
> current stabilization branch
> (xio-rados-exp-noreg-buf-qs-upstream-ow-mdw).
> The logic in the last version was overly complex.  We streamlined
> things,
> and also have switched to using the Xio one-way message paradigm,
> which
> as you mentioned a while back, is closer to Ceph's, and also has
> higher
> performance.
>=20
> >=20
> > Is "new (bp) xio_msg_buffer(m_hook, buf, len);=E2=80=9D some syntax=
 I=E2=80=99m
> > unaware of, or a merge/rebase issue? (Seriously, no idea. :)
>=20
> This is C++ "placement new."

The placement new syntax is the way you substitute your own memory allo=
cation
strategy for built-in new and delete (which typically use the system
allocator, of course).  Essentially, this step calls the desired constr=
uctor
on the already-allocated memory.  This comes up because we're using Acc=
elio's
pool allocator.

>

--=20
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
