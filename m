From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Follow-Up on Alexandre's Transparent Huge Pages Testing
Date: Tue, 29 Sep 2015 08:22:18 -0500
Message-ID: <560A908A.9040208@redhat.com>
References: <5609CE4C.5060403@gmail.com> <90559C83A9C7FA45B5846C975DFA612DDB54D32F42@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964828AbbI2NWV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Sep 2015 09:22:21 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB54D32F42@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?IkRhxYJlaywgUGlvdHIi?= <Piotr.Dalek@ts.fujitsu.com>, Mark Nelson <mark.a.nelson@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 09/29/2015 12:59 AM, Da=C5=82ek, Piotr wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Tuesday, September 29, 2015 1:34 AM
>>
>> Hi Everyone,
>>
>> A while back Alexandre Derumier posted some test results looking at =
how
>> transparent huge pages can reduce memory usage with jemalloc.  I wen=
t
>> back and ran a number of new tests on the community performance clus=
ter
>> to verify his findings and also look at how performance and cpu usag=
e were
>> affected, both during various fio benchmark tests and also during a =
4k
>> random write recovery scenario.  I tested tcmalloc 2.4 with 32MB thr=
ead
>> cache, 128MB thread cache, and jemalloc 4.0.
>> [..]
>> Here's are the results:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZY3U3TUU3RkJVeVk/view
>
>  From my point of view, this looks excellent. I generally didn't like=
 the idea of moving to Jemalloc because of memory usage increase (which=
 is absurdly high as you can see from the graphs), but with THP disable=
d things look way better.
> How about trying Jemalloc 4 without THP and with Ceph patched with ht=
tps://github.com/ceph/ceph/pull/5855? I wonder how much difference it'l=
l give on Incerta.

I actually did try 5855, but there was a nasty monitor memory leak in=20
master that prevented the tests from running.  It didn't get fixed unti=
l=20
early last week and 5855 no longer merges cleanly with latest master.  =
I=20
haven't had time to go back and see what's conflicting, but if you want=
=20
to take a look and update it I would be happy to give it a whirl. :)

Mark

>
>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>
>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
