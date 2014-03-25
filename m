From: Milosz Tanski <milosz@adfin.com>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 10:44:29 -0400
Message-ID: <CANP1eJEYea5=tdxPVAe7G8aY30HZGb-MqdHAhCaoigtYEX3s-w@mail.gmail.com>
References: <532F3B0E.2050204@dachary.org>
	<1395614070.15058.140.camel@pc2>
	<5330A328.9060203@dachary.org>
	<1395740605.15058.205.camel@pc2>
	<533152E9.50709@dachary.org>
	<1395746572.15058.219.camel@pc2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33100 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaCYOob convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 10:44:31 -0400
Received: by mail-wi0-f177.google.com with SMTP id cc10so682080wib.16
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 07:44:29 -0700 (PDT)
In-Reply-To: <1395746572.15058.219.camel@pc2>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent GUERBY <laurent@guerby.net>
Cc: Loic Dachary <loic@dachary.org>, Kevin Greenan <kmgreen2@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Loic,

If you're already doing a runtime checking of these bits before
calling the functions you want to optimize then you can use the gcc
Function Specific Opt feature of GCC.
http://gcc.gnu.org/onlinedocs/gcc-4.4.0/gcc/Function-Attributes.html#index-g_t_0040code_007btarget_007d-function-attribute-2259

Basically you add a target attribute to a function (specifying use SSE version).

void my_optimized_function(void* sse_vec, size_t n)
    __attribute__ ((__target__ ("sse4.2")));

It's available from GCC 4.4 and on. That happens to be the GCC version
on RHEL6, Debian Squeeze, Ubuntu 10.04 LTS. Hopefully that's good
enough and you can omit the optimization on people on platforms older
than that.

Best,
- Milosz


On Tue, Mar 25, 2014 at 7:22 AM, Laurent GUERBY <laurent@guerby.net> wrote:
> On Tue, 2014-03-25 at 10:56 +0100, Loic Dachary wrote:
>> Hi Laurent,
>
> Hi Loic,
>
>> It occurs to me that all we're after is to enable SSE functions such as _mm_set_epi32. We're not trying to have the binary optimized in any implicit way, it is all explicit. The problem seems to be that -msse4.2 will do both
>>
>> * activate _mm_set_epi32 etc functions
>> * optimize the binary to use sse4.2 instructions
>>
>> Do you know of a compiler flag that would only
>>
>> * activate _mm_set_epi32 etc functions
>
> This is a function part of an Intel defined standard to access processor
> feature, this standard will have one or more implementation depending on
> your compiler/libc/OS. IIRC these functions are closely aligned with
> specific processor feature, if the feature isn't there in general it
> makes no sense to use them.
>
> In the particular case of  _mm_set_epi32 it seems
> to be a data formating inline function:
>
> /usr/lib/gcc/x86_64-linux-gnu/4.7.2/include/emmintrin.h
> ...
> typedef long long __m128i __attribute__ ((__vector_size__ (16),
> __may_alias__));
> ...
> extern __inline __m128i __attribute__((__gnu_inline__,
> __always_inline__, __artificial__))
> _mm_set_epi32 (int __q3, int __q2, int __q1, int __q0)
> {
>   return __extension__ (__m128i)(__v4si){ __q0, __q1, __q2, __q3 };
> }
>
> Functions in this include files are using GCC builtins:
>
> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/X86-Built-in-Functions.html#X86-Built-in-Functions
>
> To avoid any issue I wouldn't use these functions at all
> on a non SSE machine.
>
> Sincerely,
>
> Laurent
>
>> and not
>>
>> * optimize the binary to use sse4.2 instructions
>>
>> ? It may be a RTFM question and I apologize for that. Reading http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options it looks like this is more or less what --mtune=corei7-avx would do (because gf-complete uses PCLMUL when available). But it feels weird to specify a specific processor model where what we need is a set of features.
>>
>> Thanks for your help :-)
>>
>> On 25/03/2014 10:43, Laurent GUERBY wrote:
>> > On Mon, 2014-03-24 at 22:27 +0100, Loic Dachary wrote:
>> >>
>> >> On 23/03/2014 23:34, Laurent GUERBY wrote:
>> >>> http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/i386-and-x86-64-Options.html#i386-and-x86-64-Options
>> >>>
>> >>> So unless you want to run your code a very very old x86 32 bit processor
>> >>> "-msse" shouldn't be an issue. "-msse2" is similar.
>> >>
>> >> This is good to know :) Should I be worried about unintended side effects of -msse4.2 -mssse3 -msse4.1 or -mpclmul ? These are the flags that gf-complete are using, specifically.
>> >
>> > Hi,
>> >
>> > SSE4.2 will be available only in more recent
>> > processors as documented on the page above.
>> >
>> > If your library already is dynamically checking for processor
>> > feature I would advise to be conservative in your
>> > -m flags, ie using what debian would use for maximum
>> > x86 portability.
>> >
>> > Sincerely,
>> >
>> > Laurent
>> >
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
