From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: PG statechart
Date: Fri, 26 Apr 2013 21:49:59 -0700
Message-ID: <D58A1729-FB75-4F68-9E14-E1E3F4532336@inktank.com>
References: <517A9B3A.3080806@dachary.org> <281AE624-F6F6-4376-8130-77608D174646@inktank.com> <517B523D.8000503@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:60356 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab3D0EuD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 00:50:03 -0400
Received: by mail-pd0-f175.google.com with SMTP id g12so932693pdj.6
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 21:50:01 -0700 (PDT)
In-Reply-To: <517B523D.8000503@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Very cool!

On Apr 26, 2013, at 9:21 PM, Loic Dachary <loic@dachary.org> wrote:

> Hi Noah,
>=20
> Nice tool :-) Here is the statechart generated from PG.h.
>=20
> Cheers
>=20
> On 04/26/2013 06:07 PM, Noah Watkins wrote:
>> Boost Statechart Viewer generates GraphViz:
>>=20
>>  http://rtime.felk.cvut.cz/statechart-viewer/
>>=20
>> Having trouble with my LLVM environment on 12.04, so I haven't teste=
d it.
>>=20
>> -Noah
>>=20
>> On Apr 26, 2013, at 8:20 AM, Loic Dachary <loic@dachary.org> wrote:
>>=20
>>> Hi,
>>>=20
>>> I was considering drawing a statechart ( http://www.math-cs.gordon.=
edu/courses/cs211/ATMExample/SessionStatechart.gif ) to better understa=
nd the transitions of PG
>>>=20
>>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h#L1341
>>>=20
>>> and realized that it probably already exists somewhere. Does it ?=20
>>>=20
>>> /me hopefull ;-)
>>>=20
>>> --=20
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>=20
>>=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> <PG.pdf>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
