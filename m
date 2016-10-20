From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: mempools everywhere
Date: Thu, 20 Oct 2016 14:59:06 +0000
Message-ID: <BLUPR0201MB15242A3C96E75E7A8FF9A619E8D50@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1610181634150.6167@piezo.us.to>
 <BLUPR0201MB15240B7882D0381D5152363AE8D30@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <BLUPR0201MB152443595C256F34701829CFE8D20@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <589246c6-4094-c782-28b7-5d5dd7f493dd@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:47116
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759588AbcJTPON (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Oct 2016 11:14:13 -0400
In-Reply-To: <589246c6-4094-c782-28b7-5d5dd7f493dd@corp.ovh.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?iso-8859-2?Q?Bart=B3omiej_=A6wi=EAcki?= <bartlomiej.swiecki@corp.ovh.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes, that's much better. I'm chagrined to have not thought of it :(

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Bart=B3omiej =A6wi=EAcki [mailto:bartlomiej.swiecki@corp.ovh.com]
> Sent: Thursday, October 20, 2016 2:34 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sweil@redhat.com>; ceph-devel@vger.kernel.org
> Subject: Re: mempools everywhere
>=20
> Why not just use something like:
>=20
> mempool::pool_t& mempool::get_pool(mempool::pool_index_t ix) {
>      static Mempool table[num_mempools] =3D { #define P(x)
> mempool::pool_t(#x),
>        DEFINE_MEMORY_POOLS_HELPER(P)
> #undef P
>      };
>      return table[ix];
> }
>=20
> Constructors of 'table' entries are guaranteed to be executed on the firs=
t call
> (and to be thread safe in c++0x11) and looks like the extra cost for a ch=
eck if
> 'table' is initialized or not is basically load+cmp+jmp, compilers could =
use
> some clever tricks to make this fast. IIRC this should also ensure that
> destructors are called when unloading the module, not 100% sure about tha=
t
> though.
>=20
> Bartek
>=20
>=20
> On 10/19/2016 05:09 PM, Allen Samuels wrote:
> > Here's a two-line patch to eliminate the memory leak of the mempool
> > object itself :)
> >
> > Mempool& GetPool(index) {
> >     If (table[index] =3D=3D nullptr) {
> >        Static char storage[num_mempools][sizeof(mempool_t)];
> >        Table[index] =3D new ((void *)stroage[index]) mempool_t;
> >     }
> >     Return Table[index];
> > }
> >
> >
> > Volia, no leaks :) Makes the .so unload problem easier too :)
> >
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> owner@vger.kernel.org] On Behalf Of Allen Samuels
> >> Sent: Tuesday, October 18, 2016 10:00 AM
> >> To: Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
> >> Subject: RE: mempools everywhere
> >>
> >>> -----Original Message-----
> >>> From: Sage Weil [mailto:sweil@redhat.com]
> >>> Sent: Tuesday, October 18, 2016 9:52 AM
> >>> To: ceph-devel@vger.kernel.org
> >>> Cc: Allen Samuels <Allen.Samuels@sandisk.com>
> >>> Subject: mempools everywhere
> >>>
> >>> The mempool PR is more or less ready for final test/merge.  Once
> >>> it's in place we'd love to use this all over the place so that we
> >>> can tell where memory is going.  There's one major remaining roadbloc=
k,
> though:
> >>> right now mempool is part of libglobal since it has global state
> >>> (the mempools themselves).  This prevents us from putting anything
> >>> in, say, osd_types.h (which is included in client code) in a
> >>> mempool.  Which includes things like pg_log_t, a major consumer of
> memory.
> >>>
> >>> We have a few options...
> >>>
> >>> - Segregate types into different compilation units so that things
> >>> that are server-side only can be built separately (and put in mempool=
s).
> >>>
> >>> - Just avoid these types :(
> >>>
> >>> - Use mempools for client code as well.
> >> +1
> >>
> >>> The last one is the most appealing to me, but it's violating a big
> >>> no-no of shared libraries (static state!).  However, I think that
> >>> mempools may be one of those special things that all of the usual
> >>> reasons that global variables are bad don't really apply to.  The
> >>> main one being: if we have multiple users of, say, librados in the
> >>> same process, it is totally fine (and possibly desired?) that they
> >>> would share the
> >> same mempools.
> >>> What do you think?
> >>>
> >>> FWIW, there is one bit of potentially shady initialization going on
> >>> with the mempools.  Instead of statically defining the pools, we
> >>> instead declare an array of pool pointers, and rely on the compiler
> >>> and runtime environment to zero that for the process *before* any
> >>> constructors are run for any compilation unit.  This allows pools to
> >>> be allocated on-demand when needed by constructors in any
> >>> compilation unit, regardless of the link order relative to
> >>> mempool.cc.  This appears to be a safe thing to do (and avoids the
> >>> very tedious process of ensuring that mempool.cc is always linked fir=
st
> so that it's ctors run first).
> >> I don't think is a cause for concern. There are hundreds of thousands
> >> of lines of existing code that are making the same assumption (global
> >> statics are set to zero unless overridden explicitly).
> >>
> >>> If we want to take the plunge and make this usable by librados and
> >>> other client code, I think it may just work, modulo leaking the
> >>> pool_t structures if the .so is ever unloaded (not sure any librados
> >>> user does this?).  In that case, we could probably move the
> >>> setup/teardown into the init/fini .so methods, although we'd need to
> >>> confirm that these would run
> >>> *before* any constructors for statically linked modules.
> >>>
> >>> Anyway.. thoughts?
> >>>
> >>> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >> in the body of a message to majordomo@vger.kernel.org More
> majordomo
> >> info at http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

