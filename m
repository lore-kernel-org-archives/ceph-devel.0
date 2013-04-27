From: Samuel Just <sam.just@inktank.com>
Subject: Re: PG statechart
Date: Sat, 27 Apr 2013 01:08:44 -0700
Message-ID: <CA+4uBUbAuXPRyG_EuH12yXkLSu6_my1HzqcUmXvKCRkA50vWFA@mail.gmail.com>
References: <517A9B3A.3080806@dachary.org>
	<281AE624-F6F6-4376-8130-77608D174646@inktank.com>
	<517B523D.8000503@dachary.org>
	<D58A1729-FB75-4F68-9E14-E1E3F4532336@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:47156 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab3D0IIp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 04:08:45 -0400
Received: by mail-vc0-f169.google.com with SMTP id gd11so4454261vcb.28
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 01:08:44 -0700 (PDT)
In-Reply-To: <D58A1729-FB75-4F68-9E14-E1E3F4532336@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

There is actually a peering state diagram generated with the docs:
http://ceph.com/docs/master/dev/peering/

Unfortunately, the image comes out rather small, you can generate it
for yourself with the script at doc/scripts/gen_state_diagram.py.
=46rom admin/build_doc:

cat src/osd/PG.h src/osd/PG.cc | doc/scripts/gen_state_diagram.py >
doc/dev/peering_graph.generated.dot

It's similar to the boost generated one, but also includes most of the
state transitions from within the custom_reaction state chart
reactions.
-Sam

On Fri, Apr 26, 2013 at 9:49 PM, Noah Watkins <noah.watkins@inktank.com=
> wrote:
> Very cool!
>
> On Apr 26, 2013, at 9:21 PM, Loic Dachary <loic@dachary.org> wrote:
>
>> Hi Noah,
>>
>> Nice tool :-) Here is the statechart generated from PG.h.
>>
>> Cheers
>>
>> On 04/26/2013 06:07 PM, Noah Watkins wrote:
>>> Boost Statechart Viewer generates GraphViz:
>>>
>>>  http://rtime.felk.cvut.cz/statechart-viewer/
>>>
>>> Having trouble with my LLVM environment on 12.04, so I haven't test=
ed it.
>>>
>>> -Noah
>>>
>>> On Apr 26, 2013, at 8:20 AM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> I was considering drawing a statechart ( http://www.math-cs.gordon=
=2Eedu/courses/cs211/ATMExample/SessionStatechart.gif ) to better under=
stand the transitions of PG
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h#L1341
>>>>
>>>> and realized that it probably already exists somewhere. Does it ?
>>>>
>>>> /me hopefull ;-)
>>>>
>>>> --
>>>> Lo=C4=8Fc Dachary, Artisan Logiciel Libre
>>>>
>>>
>>
>> --
>> Lo=C4=8Fc Dachary, Artisan Logiciel Libre
>> <PG.pdf>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
