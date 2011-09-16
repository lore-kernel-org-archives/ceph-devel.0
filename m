From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 5/5] qemu/rbd: improve rbd device specification
Date: Fri, 16 Sep 2011 10:01:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109161000260.11043@cobra.newdream.net>
References: <1316119944-25201-1-git-send-email-sage@newdream.net>
 <1316119944-25201-6-git-send-email-sage@newdream.net>
 <CAORUGqB9aAPTiRHKsuz5Rn-qcSy6JwT_5foMTu4q4GmA8FMW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-701576161-1316192490=:11043"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58563 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1IPQzd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 12:55:33 -0400
In-Reply-To: <CAORUGqB9aAPTiRHKsuz5Rn-qcSy6JwT_5foMTu4q4GmA8FMW4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-701576161-1316192490=:11043
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Sep 2011, Tommi Virtanen wrote:
> On Thu, Sep 15, 2011 at 13:52, Sage Weil <sage@newdream.net> wrote:
> > +static int buildRBDString(virConnectPtr conn,
> ...
> > + =A0 =A0 =A0 =A0/* look up secret */
> > + =A0 =A0 =A0 =A0snprintf(idDomain, sizeof(idDomain), "%s/%s", disk->au=
thId,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disk->authDomain);
> > + =A0 =A0 =A0 =A0sec =3D virSecretLookupByUsage(conn,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 VIR_SECRET_USAGE_TYPE_CEPH,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 idDomain);
> ...
> > + =A0 =A0 =A0 =A0 =A0 =A0secret =3D (char *)conn->secretDriver->getValu=
e(sec, &secret_size, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V=
IR_SECRET_GET_VALUE_INTERNAL_CALL);
> > + =A0 =A0 =A0 =A0 =A0 =A0/* qemu/librbd wants it base64 encoded */
> > + =A0 =A0 =A0 =A0 =A0 =A0base64_encode_alloc(secret, secret_size, &base=
64);
> > + =A0 =A0 =A0 =A0 =A0 =A0virBufferEscape(opt, ":", ":key=3D%s:auth_supp=
orted=3Dcephx\\;none",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0base64);
>=20
> If I'm reading this right, that puts the ceph secret on the kvm
> command line. That's not good, that makes it visible to anyone on the
> host.

Yeah, we definitely want something better, but I wanted to make sure the=20
overall approach is fine before doing something too annoying with=20
temporary unlinked files or environment variables or something.

sage
--557981400-701576161-1316192490=:11043--
