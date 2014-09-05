From: "Ethan L. Miller" <elm@soe.ucsc.edu>
Subject: Re: ARM NEON optimisations for gf-complete/jerasure/ceph-erasure
Date: Thu, 4 Sep 2014 17:27:16 -0700
Message-ID: <CAMMD=N2GhtqrJvayV2WB7nmWPhV=ygcxrk555xFSx0gAMJQg-g@mail.gmail.com>
References: <20140904144237.GK2591@jannau.net>
	<54088C03.10900@dachary.org>
Reply-To: elm@cs.ucsc.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34412 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaIEA1R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Sep 2014 20:27:17 -0400
Received: by mail-qc0-f181.google.com with SMTP id i17so11202247qcy.40
        for <ceph-devel@vger.kernel.org>; Thu, 04 Sep 2014 17:27:17 -0700 (PDT)
In-Reply-To: <54088C03.10900@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>, Kevin Greenan <kmgreen2@gmail.com>, Ethan Miller <elm@soe.ucsc.edu>

Yes, it's possible to use CPU flags to allow the use of advanced
instruction sets automatically.  The difficulty is that, if those
instructions aren't available, it's not clear which of the "basic"
approaches to use, since performance can vary based on a lot of
factors.  Even with advanced instructions, there are often multiple
reasonable approaches to take, as Janne's email makes clear, so it's
impossible to say "this algorithm is always best".

We can certainly set up a default approach if we want, though, that
can be overridden by compile-time flags.

Incidentally, I'm starting to work on coding a version of gf-complete
(and associated erasure coding functions) in C++ using templates,
which will hopefully allow us to better separate out different
implementations.  We could still have run-time dispatch for the
desired routines, but templates should allow for more compact code and
better isolation of architecture-specific code.  The big drawback is
that C++ code isn't typically used in the kernel....

ethan

On Thu, Sep 4, 2014 at 8:57 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Janne,
>
> On 04/09/2014 16:42, Janne Grunau wrote:
>> Hi,
>>
>> I've started writing ARM/AArch64 NEON optimizations for gf-complete.
>> http://git.jannau.net/gf-complete.git/log/?h=3Dneon has proof of con=
cept
>> AArch64 NEON optimisations for w8.
>>
>> Implemented methods are so far the carry-less/polynomial multiplicat=
ion
>> and the split table. The polynomial multiplication is reasonable fas=
t
>> for region multiplications (~2000MB/s on an Apple A7 at 1.3GHz) sinc=
e
>> NEON has a 8-bit to 16-bit SIMD polynomial multiplication.
>>
>> The split table method is still faster though, 5700MB/s on the same =
CPU.
>> I'm actually surprised by that since it is faster (per cycle) than t=
he
>> Core i7-3770 from gf-complete's manual (page 14). That suggests that
>> SSE3 code might not be optimal.
>>
>> I'm currently working on integrating NEON into the build system and =
then
>> will extend the existing code to work on ARMv7-a too. Those two are
>> straight forward. There are a couple of other issues I would like to
>> discuss before I start to work on them.
>>
>> The #if/#ifdefs in the source are starting to make the source hard t=
o
>> read then more than one optimization is added. Separating arch speci=
fic
>> implementations from each other and from the generic implementation
>> works reasonable well for the multimedia related projects I have
>> experience with (libav/FFmpeg, x264). There would be arch specific i=
nit
>> functions which set the appropriate function pointers. The neon
>> optimisations would then live in w8_arm.c which would be only compil=
ed
>> for arm. If someone has another idea how to avoid the #ifdefs I'm op=
en
>> for that too.
>
> Would it be possible to make use of ifunc ( https://gcc.gnu.org/onlin=
edocs/gcc-4.7.2/gcc/Function-Attributes.html#index-g_t_0040code_007bifu=
nc_007d-attribute-2529 ) to chose the function depending on CPU feature=
s ?
>
> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.h=
tml#i386-and-x86-64-Options
>
> http://www.spinics.net/lists/ceph-devel/msg18452.html
>
> Cheers
>
>> I'm currently using the SSE/NOSSE region option which is bogus. I'm
>> wondering whether I should just rename that SIMD/NOSIMD (not really =
true
>> since the carry less operations for w64 and w128 only use the SIMD
>> instruction set but are single data). That would need to have backwa=
rd
>> compatibility for SSE/NOSSE. The other option would be to add
>> NEON/NONEON flags.
>>
>> I'm sure I find other issues to discuss when I start integrating the
>> NEON optimisations into jerasure and ceph.
>>
>> thanks
>>
>> Janne
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>



--=20
( Ethan L. Miller               Email: elm@cs.ucsc.edu            )
( Professor, Computer Science   Web: http://www.cs.ucsc.edu/~elm/ )
( University of California      Phone: +1 831 459-1222            )
( Santa Cruz, CA 95064 USA      Fax:   +1 831 459-1041            )
( PGP keyprint: 76C7 D699 1FF6 A1A4 B7A1 9629 2EBF 1273 A6ED 6A09 )
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
