From: Milosz Tanski <milosz@adfin.com>
Subject: Re: GCC -msse2 portability question
Date: Tue, 25 Mar 2014 15:46:31 -0400
Message-ID: <CANP1eJFMRN5=-N0jJm=5XgJ+veKFWBR1P=TpKncfw2_XeHGE=A@mail.gmail.com>
References: <532F3B0E.2050204@dachary.org>
	<5331D41B.5040001@dachary.org>
	<CA+AFVBhpOZEPehsd4qHCBr4aRzv60ZW8LzRwKsduUrZmLV1wxQ@mail.gmail.com>
	<5331D738.9030409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:50432 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaCYTqc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 15:46:32 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr14so2361972wib.10
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 12:46:31 -0700 (PDT)
In-Reply-To: <5331D738.9030409@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>, Laurent Guerby <laurent@guerby.net>, Ceph Development <ceph-devel@vger.kernel.org>

It gets a bit more tricky with x86_64 since the arch dictates that the
base line has SSE2 (but not necessarily later).

I would do is both support SSE2 (maybe in core without dlopen) and
then support all the others in a SSE4 version (including SSE4_PCMUL).
I'm glossing over x86-32 here, but you could something similar.

Best
- Milosz

On Tue, Mar 25, 2014 at 3:21 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 25/03/2014 20:13, Kevin Greenan wrote:
>> +1
>>
>> Yeah, that sounds better...  Let's keep this as simple as possible.
>
> I'll rework the https://bitbucket.org/jimplank/gf-complete/pull-reque=
st/4/defer-the-decision-to-use-a-given-sse accordingly.
>
> Would it be sensible to compile with SSE optimizations only if all ar=
e available ( SSE2, SSSE3, SSE4, SSE4_PCMUL ) and not attempt to distin=
guish betweel SSSE3 being available but not SSE4_PCMUL etc. From what I=
 understand at this point that kind of distinction is going to be diffi=
cult to manage anyway.
>
> Is it too simplistic ?
>
>>
>> -kevin
>>
>>
>> On Tue, Mar 25, 2014 at 12:08 PM, Loic Dachary <loic@dachary.org <ma=
ilto:loic@dachary.org>> wrote:
>>
>>     Andreas Peters suggested another approach, which makes sense to =
me : have one plugin with SSE optimizations enabled, another without th=
em and chose at runtime between the two.
>>
>>     What do you think ?
>>
>>     On 23/03/2014 20:50, Loic Dachary wrote:
>>     > Hi Laurent,
>>     >
>>     > In the context of optimizing erasure code functions implemente=
d by Kevin Greenan (cc'ed) and James Plank at https://bitbucket.org/jim=
plank/gf-complete/ we ran accross a question you may have the answer to=
: can gcc -msse2 (or -msse* for that matter ) have a negative impact on=
 the portability of the compiled binary code ?
>>     >
>>     > In other words, if a code is compiled without -msse* and runs =
fine on all intel processors it targets, could it be that adding -msse*=
 to the compilation of the same source code generate a binary that woul=
d fail on some processors ? This is assuming no sse specific functions =
were used in the source code.
>>     >
>>     > In gf-complete, all sse specific instructions are carefully pr=
otected to not be run on a CPU that does not support them. The runtime =
detection is done by checking CPU id bits ( see https://bitbucket.org/j=
implank/gf-complete/pull-request/7/probe-intel-sse-features-at-runtime/=
diff#Lsrc/gf_intel.cT28 )
>>     >
>>     > The corresponding thread is at:
>>     >
>>     > https://bitbucket.org/jimplank/gf-complete/pull-request/4/defe=
r-the-decision-to-use-a-given-sse/diff#comment-1479296
>>     >
>>     > Cheers
>>     >
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>



--=20
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
