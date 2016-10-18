From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: mempools everywhere
Date: Tue, 18 Oct 2016 16:59:45 +0000
Message-ID: <BLUPR0201MB15240B7882D0381D5152363AE8D30@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:14176
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933951AbcJRRdI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Oct 2016 13:33:08 -0400
In-Reply-To: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Tuesday, October 18, 2016 9:52 AM
> To: ceph-devel@vger.kernel.org
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>
> Subject: mempools everywhere
>=20
> The mempool PR is more or less ready for final test/merge.  Once it's in =
place
> we'd love to use this all over the place so that we can tell where memory=
 is
> going.  There's one major remaining roadblock, though:
> right now mempool is part of libglobal since it has global state (the mem=
pools
> themselves).  This prevents us from putting anything in, say, osd_types.h
> (which is included in client code) in a mempool.  Which includes things l=
ike
> pg_log_t, a major consumer of memory.
>=20
> We have a few options...
>=20
> - Segregate types into different compilation units so that things that ar=
e
> server-side only can be built separately (and put in mempools).
>=20
> - Just avoid these types :(
>=20
> - Use mempools for client code as well.

+1

>=20
> The last one is the most appealing to me, but it's violating a big no-no =
of
> shared libraries (static state!).  However, I think that mempools may be =
one
> of those special things that all of the usual reasons that global variabl=
es are
> bad don't really apply to.  The main one being: if we have multiple users=
 of,
> say, librados in the same process, it is totally fine (and possibly desir=
ed?) that
> they would share the same mempools.
>=20
> What do you think?
>=20
> FWIW, there is one bit of potentially shady initialization going on with =
the
> mempools.  Instead of statically defining the pools, we instead declare a=
n
> array of pool pointers, and rely on the compiler and runtime environment =
to
> zero that for the process *before* any constructors are run for any
> compilation unit.  This allows pools to be allocated on-demand when neede=
d
> by constructors in any compilation unit, regardless of the link order rel=
ative to
> mempool.cc.  This appears to be a safe thing to do (and avoids the very
> tedious process of ensuring that mempool.cc is always linked first so tha=
t it's
> ctors run first).

I don't think is a cause for concern. There are hundreds of thousands of li=
nes of existing code that are making the same assumption (global statics ar=
e set to zero unless overridden explicitly).
=20
>=20
> If we want to take the plunge and make this usable by librados and other
> client code, I think it may just work, modulo leaking the pool_t structur=
es if
> the .so is ever unloaded (not sure any librados user does this?).  In tha=
t case,
> we could probably move the setup/teardown into the init/fini .so methods,
> although we'd need to confirm that these would run
> *before* any constructors for statically linked modules.
>=20
> Anyway.. thoughts?
>=20
> sage
