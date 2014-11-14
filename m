From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Profiling with Perf
Date: Fri, 14 Nov 2014 16:38:44 -0500
Message-ID: <CANP1eJEpJydkrtnmSoGgxfFJd+BBJTOJEskrSgrQAmGOLBvX4Q@mail.gmail.com>
References: <5463CE1F.5060509@redhat.com>
	<259705d6-3505-41c3-b81d-9575bc001f33@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:45025 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbaKNViq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Nov 2014 16:38:46 -0500
Received: by mail-la0-f47.google.com with SMTP id gq15so62652lab.20
        for <ceph-devel@vger.kernel.org>; Fri, 14 Nov 2014 13:38:44 -0800 (PST)
In-Reply-To: <259705d6-3505-41c3-b81d-9575bc001f33@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 13, 2014 at 2:04 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
> Hi Mark,
>
>>> "perf record -g dwarf -F 100 -a"
>
> Give me
>
> # perf record -g dwarf -F 100 -a
> Workload failed: No such file or directory
>
> But
>
>
> perf record -g --call-graph dwarf -F 100 -a
>
> Seem to work.
>
> (This is with kernel 3.14 from debian)

Alexander,

That error is telling you have a bad command line. I remember running
into this error in the past and basically if perf fails to parse the
command line it will give this nondescript "Workload failed: No such
file or directory" error in some cases. It's since been fixed in new
versions of perf.

In your first example your passing in: `-g dwarf` which is wrong. If
you read the man page that comes up when you run perf help report
you'll see that the `-g` flag doesn't take any parameters. Instead,
you have to specify that after `--call-graph FOO`, like in your second
example, which takes the callgraph method as a parameter. Also,
`--call-graph FOO` already implies -g.

I hope that helps and hopefully most distros will ship a decent
version of perf sometime.
- Milosz

>
>
>
>>>Do you have problems with large trace files when you limit the sampl=
ing
>>>frequency? It hasn't been a problem for me when doing that.
>
>
> About perf.data size for 10s when my fio benchmark is running
>
> #  perf record -g --call-graph dwarf -a -F 100  -- sleep 10
> [ perf record: Woken up 214 times to write data ]
> [ perf record: Captured and wrote 54.611 MB perf.data (~2385986 sampl=
es) ]
>
>
>
>
> Another question, what is the best "perf report" options to provide a=
 clean report
> to sent to the mailing list ?
>
> I'm using
> "perf report --sort dso --stdio" currently, not sure it's the best
>
>
>
> BTW,
> I found this very cool script to generate dynamic svg graphics
> http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html
>
>
>
>
>
>
> ----- Mail original -----
>
> De: "Mark Nelson" <mark.nelson@inktank.com>
> =C3=80: "Milosz Tanski" <milosz@adfin.com>, "Mark Nelson" <mark.nelso=
n@inktank.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 12 Novembre 2014 22:16:15
> Objet: Re: Profiling with Perf
>
> On 11/12/2014 02:59 PM, Milosz Tanski wrote:
>> On Wed, Nov 12, 2014 at 3:42 PM, Mark Nelson <mark.nelson@inktank.co=
m> wrote:
>>> Hi, there was a question on the performance call today about how to=
 use
>>> dwarf symbols in perf. Roughly:
>>>
>>> 1) Make sure during the kernel/perf compile that libunwind is used.=
 This can
>>> be tricky depending on how you build the kernel, but theoretically =
should
>>> work.
>>>
>>> 2) invoke perf using something like:
>>>
>>> "perf record -g dwarf -F 100 -a"
>>>
>>> This tells perf to use dwarf symbols but limit the sampling rate. p=
erf can
>>> generate a *lot* of data with dwarf symbols and default sampling.
>>>
>>> 3) Look at results in perf report as normal.
>>>
>>> 4) Profit!
>>>
>>> Theoretically if you have frame pointers enabled when you compile c=
eph you
>>> should get good symbol resolution without dwarf but I've never gott=
en it to
>>> work well. Perf+Dwarf seems to give much better symbol resolution t=
han
>>> anything else I've tried with Ceph. There's some new LBR functional=
ity for
>>> profiling on Haswell in perf that might work too, but I haven't tri=
ed it:
>>>
>>> https://lkml.org/lkml/2014/10/19/166
>>
>> Mark,
>>
>> I personally would strong recommend using perf without the dwarf as =
it
>> seams writes very large trace files. It's not just file size, but it
>> also takes a very long time to load up profile in the other tools
>> (perf report). If you can help it rebuild the app with out the code
>> (eg the gcc -fno-omit-frame-pointer flag). When I say space savings
>> with call stack savings I mean like order of 2 magnitudes smaller
>> profile file (eg. you can log much longer / complicated runs).
>
> Do you have problems with large trace files when you limit the sampli=
ng
> frequency? It hasn't been a problem for me when doing that.
>
>>
>> Additionally, it seams to better handle splitting of inline function=
s
>> (where otherwise this would get folded into a large function). The
>> omit behavior is default on x86_64, which is what I assume most peop=
le
>> are building / testing on. There is a performance penalty for this a=
s
>> the compiler will be generating an extra instruction to update EBP..=
=2E
>> but for real world code this is less then 5% of a penalty.
>
> To be honest even when compiling with fno-omit-frame-pointer I've had=
 a
> ton of problems with symbol resolution. It's been a while since I
> messed with this so perhaps things have improved since then.
>
>>
>> I spend a lot of time using perf and looking at it's traces (runtime=
,
>> futex profiling, looking at bad branch points) every week. It took m=
e
>> a little while to figure this out... I hope it help you guys.
>
> Other than compiling with fno-omit-frame-pointer, is there anything e=
lse
> you do to get good symbol resolution? What platform are you using?
> This kind of information would be very valuable for the community if =
you
> can share. :)
>
>>
>> - Milosz
>>
>>>
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
