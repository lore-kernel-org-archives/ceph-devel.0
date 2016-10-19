From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: mempools everywhere
Date: Wed, 19 Oct 2016 15:09:48 +0000
Message-ID: <BLUPR0201MB152443595C256F34701829CFE8D20@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to>
 <BLUPR0201MB15240B7882D0381D5152363AE8D30@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:20832
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754337AbcJSPJv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Oct 2016 11:09:51 -0400
In-Reply-To: <BLUPR0201MB15240B7882D0381D5152363AE8D30@BLUPR0201MB1524.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Here's a two-line patch to eliminate the memory leak of the mempool object =
itself :)

Mempool& GetPool(index) {
   If (table[index] =3D=3D nullptr) {
      Static char storage[num_mempools][sizeof(mempool_t)];
      Table[index] =3D new ((void *)stroage[index]) mempool_t;
   }
   Return Table[index];
}


Volia, no leaks :) Makes the .so unload problem easier too :)

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Allen Samuels
> Sent: Tuesday, October 18, 2016 10:00 AM
> To: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: RE: mempools everywhere
>=20
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Tuesday, October 18, 2016 9:52 AM
> > To: ceph-devel@vger.kernel.org
> > Cc: Allen Samuels <Allen.Samuels@sandisk.com>
> > Subject: mempools everywhere
> >
> > The mempool PR is more or less ready for final test/merge.  Once it's
> > in place we'd love to use this all over the place so that we can tell
> > where memory is going.  There's one major remaining roadblock, though:
> > right now mempool is part of libglobal since it has global state (the
> > mempools themselves).  This prevents us from putting anything in, say,
> > osd_types.h (which is included in client code) in a mempool.  Which
> > includes things like pg_log_t, a major consumer of memory.
> >
> > We have a few options...
> >
> > - Segregate types into different compilation units so that things that
> > are server-side only can be built separately (and put in mempools).
> >
> > - Just avoid these types :(
> >
> > - Use mempools for client code as well.
>=20
> +1
>=20
> >
> > The last one is the most appealing to me, but it's violating a big
> > no-no of shared libraries (static state!).  However, I think that
> > mempools may be one of those special things that all of the usual
> > reasons that global variables are bad don't really apply to.  The main
> > one being: if we have multiple users of, say, librados in the same
> > process, it is totally fine (and possibly desired?) that they would sha=
re the
> same mempools.
> >
> > What do you think?
> >
> > FWIW, there is one bit of potentially shady initialization going on
> > with the mempools.  Instead of statically defining the pools, we
> > instead declare an array of pool pointers, and rely on the compiler
> > and runtime environment to zero that for the process *before* any
> > constructors are run for any compilation unit.  This allows pools to
> > be allocated on-demand when needed by constructors in any compilation
> > unit, regardless of the link order relative to mempool.cc.  This
> > appears to be a safe thing to do (and avoids the very tedious process
> > of ensuring that mempool.cc is always linked first so that it's ctors r=
un first).
>=20
> I don't think is a cause for concern. There are hundreds of thousands of =
lines
> of existing code that are making the same assumption (global statics are =
set
> to zero unless overridden explicitly).
>=20
> >
> > If we want to take the plunge and make this usable by librados and
> > other client code, I think it may just work, modulo leaking the pool_t
> > structures if the .so is ever unloaded (not sure any librados user
> > does this?).  In that case, we could probably move the setup/teardown
> > into the init/fini .so methods, although we'd need to confirm that
> > these would run
> > *before* any constructors for statically linked modules.
> >
> > Anyway.. thoughts?
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in =
the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
