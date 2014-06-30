From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: erasure code and coefficients
Date: Mon, 30 Jun 2014 09:26:11 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE746F2A@CERNXCHG44.cern.ch>
References: <53AFDC99.9010009@dachary.org>
	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
	<53B05E85.9020405@dachary.org>
 <CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>,<53B1289D.8030901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:42350 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbaF3J0O convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 05:26:14 -0400
In-Reply-To: <53B1289D.8030901@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Koleos Fuscus <koleosfuscus@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,=20

i think the best is to read along the sources. It is very readable!

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/=
src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java

If there is a high interest in this, you  could port the code from Java=
 to C++ and use the GF-complete or Intel GF-multiplication implementati=
on for the used GF multiplications.

Cheers Andreas.


________________________________________
=46rom: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.=
org] on behalf of Loic Dachary [loic@dachary.org]
Sent: 30 June 2014 11:06
To: Koleos Fuscus
Cc: Ceph Development
Subject: Re: erasure code and coefficients

Hi koleosfuscus,

It clarifies it enough to raise a question : where can I read code (or =
an algorithm if not code) that chose the coefficients desirable to impl=
ement what is suggested in the Xorbas paper ?

Cheers

On 30/06/2014 10:18, Koleos Fuscus wrote:
> Hi Loic,
>
> I am happy to contribute with some clarifications. In fact,
> erasure/reliability concepts are not blocking my progress with the
> reliability model at ceph. It is the ceph model itself that has some
> parts not clear to me, and nobody had time yet to review the state
> model diagram that I published on the wiki. :(
>  Anyway, regarding coefficients here is a bit of background.
> Coefficients are the numbers that multiply your variables inside an
> equation. In a toy example, to solve the equation ax^2+bx+c=3D0 you n=
eed
> to find the coefficients a,b,c that make the equation valid.
> In the context of Reed Solomon, the definition of coefficients is a
> bit more confusing. In the original design, the message x is
> interpreted as coefficients of a polynomial p. But in subsequents
> interpretations the message x is seen as the values of the polynomial
> p evaluated at the first k points a1..ak. Such interpretation is
> apparently a bit less efficient but desirable because you can
> construct a systematic code.
> In the context of xorbas, you are constructing a code on top of Reed
> Solomon. The codewords are seen as values, and the idea is to get
> coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this as a
> missing introduction to my previous message)
>
> Cheers,
>
> koleosfuscus
>
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>
>
> On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi koleofuscus,
>>
>> Thanks for the explanation : it is very conforting to know that you =
understand this :-) At the risk of being thick, I must say that the ver=
y notion of "coefficient" eludes me. What are they ?
>>
>> Cheers
>>
>> On 29/06/2014 20:38, Koleos Fuscus wrote:
>>> Hello Loic,
>>> Dimakis (one of the authors of xorbas) is talking about coefficient=
s
>>> because they want to find a way to reduce the storage overhead used
>>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) h=
as
>>> 14/10 storage overhead but when using LRC, the overhead increases t=
o
>>> 17/10 because you also need to store s1, s2 and s3. Basically, the
>>> idea is to find specific coefficients c1..c10 that permit to obtain=
 s3
>>> through s1 and s2. In other words, get some s1 and s2 that when xor=
ed
>>> together give s3. If you find such coefficients, you don't need to
>>> store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.
>>>
>>> Dimakis said that for the Reed Solomon implementation used in HDFS
>>> RAID they can simple set all coefficients with value '1' and use xo=
r.
>>>
>>> This cannot be the case of the Reed Solomon implemented by you (I
>>> understood is the jerasure library by Plank) but that I am not sure=
=2E I
>>> guess we need the help of a mathematician or at least check and
>>> compare both implementations.
>>>
>>> Finally, apparently for xorbas they only implemented the configurat=
ion
>>> RS(10,4) and not other combinations. Unfortunately, the wiki page o=
f
>>> the project is empty http://wiki.apache.org/hadoop/ErasureCode and =
the
>>> main page says 'erasure coding under development'.
>>>
>>> I recommend you to watch the xorbas presentation video
>>> http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) =
and
>>> use the Dimakis wiki page to check the large collection of paper th=
ey
>>> have: http://storagewiki.ece.utexas.edu/
>>>
>>> Best,
>>>
>>> koleosfuscus
>>>
>>> ________________________________________________________________
>>> "My reply is: the software has no known bugs, therefore it has not
>>> been updated."
>>> Wietse Venema
>>>
>>>
>>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> w=
rote:
>>>> Hi Andreas,
>>>>
>>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of co=
mputing local coding chunks the way it is implemented in https://github=
=2Ecom/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to othe=
r plugins). However, there are theoretical aspects of the paper that I =
do not understand and I'm hoping you can shed some light on it. In part=
icular, I don't know what "coefficients" are about. For instance in the=
 context of Figure 2 caption : "The main theoretical challenge is to ch=
oose the coeffi cients c(i) to maximize the fault tolerance of the code=
=2E"
>>>>
>>>> Would you recommend a paper to read to better understand this ? Al=
so I'd like to understand what "coefficients" mean in the context of je=
rasure or if they do not apply.
>>>>
>>>> Thanks for you help :-)
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
