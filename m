From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Profiling with Perf
Date: Thu, 13 Nov 2014 08:04:59 +0100 (CET)
Message-ID: <259705d6-3505-41c3-b81d-9575bc001f33@mailpro>
References: <5463CE1F.5060509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:60464 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbaKMHFH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 02:05:07 -0500
In-Reply-To: <5463CE1F.5060509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org, Milosz Tanski <milosz@adfin.com>

Hi Mark,

>> "perf record -g dwarf -F 100 -a"=20

Give me

# perf record -g dwarf -F 100 -a=20
Workload failed: No such file or directory

But


perf record -g --call-graph dwarf -F 100 -a  =20

Seem to work.

(This is with kernel 3.14 from debian)



>>Do you have problems with large trace files when you limit the sampli=
ng=20
>>frequency? It hasn't been a problem for me when doing that.=20


About perf.data size for 10s when my fio benchmark is running

#  perf record -g --call-graph dwarf -a -F 100  -- sleep 10
[ perf record: Woken up 214 times to write data ]
[ perf record: Captured and wrote 54.611 MB perf.data (~2385986 samples=
) ]




Another question, what is the best "perf report" options to provide a c=
lean report
to sent to the mailing list ?

I'm using=20
"perf report --sort dso --stdio" currently, not sure it's the best



BTW,
I found this very cool script to generate dynamic svg graphics
http://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html






----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Milosz Tanski" <milosz@adfin.com>, "Mark Nelson" <mark.nelson@=
inktank.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 12 Novembre 2014 22:16:15=20
Objet: Re: Profiling with Perf=20

On 11/12/2014 02:59 PM, Milosz Tanski wrote:=20
> On Wed, Nov 12, 2014 at 3:42 PM, Mark Nelson <mark.nelson@inktank.com=
> wrote:=20
>> Hi, there was a question on the performance call today about how to =
use=20
>> dwarf symbols in perf. Roughly:=20
>>=20
>> 1) Make sure during the kernel/perf compile that libunwind is used. =
This can=20
>> be tricky depending on how you build the kernel, but theoretically s=
hould=20
>> work.=20
>>=20
>> 2) invoke perf using something like:=20
>>=20
>> "perf record -g dwarf -F 100 -a"=20
>>=20
>> This tells perf to use dwarf symbols but limit the sampling rate. pe=
rf can=20
>> generate a *lot* of data with dwarf symbols and default sampling.=20
>>=20
>> 3) Look at results in perf report as normal.=20
>>=20
>> 4) Profit!=20
>>=20
>> Theoretically if you have frame pointers enabled when you compile ce=
ph you=20
>> should get good symbol resolution without dwarf but I've never gotte=
n it to=20
>> work well. Perf+Dwarf seems to give much better symbol resolution th=
an=20
>> anything else I've tried with Ceph. There's some new LBR functionali=
ty for=20
>> profiling on Haswell in perf that might work too, but I haven't trie=
d it:=20
>>=20
>> https://lkml.org/lkml/2014/10/19/166=20
>=20
> Mark,=20
>=20
> I personally would strong recommend using perf without the dwarf as i=
t=20
> seams writes very large trace files. It's not just file size, but it=20
> also takes a very long time to load up profile in the other tools=20
> (perf report). If you can help it rebuild the app with out the code=20
> (eg the gcc -fno-omit-frame-pointer flag). When I say space savings=20
> with call stack savings I mean like order of 2 magnitudes smaller=20
> profile file (eg. you can log much longer / complicated runs).=20

Do you have problems with large trace files when you limit the sampling=
=20
frequency? It hasn't been a problem for me when doing that.=20

>=20
> Additionally, it seams to better handle splitting of inline functions=
=20
> (where otherwise this would get folded into a large function). The=20
> omit behavior is default on x86_64, which is what I assume most peopl=
e=20
> are building / testing on. There is a performance penalty for this as=
=20
> the compiler will be generating an extra instruction to update EBP...=
=20
> but for real world code this is less then 5% of a penalty.=20

To be honest even when compiling with fno-omit-frame-pointer I've had a=
=20
ton of problems with symbol resolution. It's been a while since I=20
messed with this so perhaps things have improved since then.=20

>=20
> I spend a lot of time using perf and looking at it's traces (runtime,=
=20
> futex profiling, looking at bad branch points) every week. It took me=
=20
> a little while to figure this out... I hope it help you guys.=20

Other than compiling with fno-omit-frame-pointer, is there anything els=
e=20
you do to get good symbol resolution? What platform are you using?=20
This kind of information would be very valuable for the community if yo=
u=20
can share. :)=20

>=20
> - Milosz=20
>=20
>>=20
>> Mark=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
>=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
