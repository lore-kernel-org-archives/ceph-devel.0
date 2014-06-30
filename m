From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Re: erasure code and coefficients
Date: Mon, 30 Jun 2014 10:18:47 +0200
Message-ID: <CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>
References: <53AFDC99.9010009@dachary.org>
	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
	<53B05E85.9020405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:53151 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaF3ISs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 04:18:48 -0400
Received: by mail-ig0-f179.google.com with SMTP id uq10so4018629igb.6
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 01:18:47 -0700 (PDT)
In-Reply-To: <53B05E85.9020405@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

I am happy to contribute with some clarifications. In fact,
erasure/reliability concepts are not blocking my progress with the
reliability model at ceph. It is the ceph model itself that has some
parts not clear to me, and nobody had time yet to review the state
model diagram that I published on the wiki. :(
 Anyway, regarding coefficients here is a bit of background.
Coefficients are the numbers that multiply your variables inside an
equation. In a toy example, to solve the equation ax^2+bx+c=3D0 you nee=
d
to find the coefficients a,b,c that make the equation valid.
In the context of Reed Solomon, the definition of coefficients is a
bit more confusing. In the original design, the message x is
interpreted as coefficients of a polynomial p. But in subsequents
interpretations the message x is seen as the values of the polynomial
p evaluated at the first k points a1..ak. Such interpretation is
apparently a bit less efficient but desirable because you can
construct a systematic code.
In the context of xorbas, you are constructing a code on top of Reed
Solomon. The codewords are seen as values, and the idea is to get
coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this as a
missing introduction to my previous message)

Cheers,

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema


On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi koleofuscus,
>
> Thanks for the explanation : it is very conforting to know that you u=
nderstand this :-) At the risk of being thick, I must say that the very=
 notion of "coefficient" eludes me. What are they ?
>
> Cheers
>
> On 29/06/2014 20:38, Koleos Fuscus wrote:
>> Hello Loic,
>> Dimakis (one of the authors of xorbas) is talking about coefficients
>> because they want to find a way to reduce the storage overhead used
>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) ha=
s
>> 14/10 storage overhead but when using LRC, the overhead increases to
>> 17/10 because you also need to store s1, s2 and s3. Basically, the
>> idea is to find specific coefficients c1..c10 that permit to obtain =
s3
>> through s1 and s2. In other words, get some s1 and s2 that when xore=
d
>> together give s3. If you find such coefficients, you don't need to
>> store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.
>>
>> Dimakis said that for the Reed Solomon implementation used in HDFS
>> RAID they can simple set all coefficients with value '1' and use xor=
=2E
>>
>> This cannot be the case of the Reed Solomon implemented by you (I
>> understood is the jerasure library by Plank) but that I am not sure.=
 I
>> guess we need the help of a mathematician or at least check and
>> compare both implementations.
>>
>> Finally, apparently for xorbas they only implemented the configurati=
on
>> RS(10,4) and not other combinations. Unfortunately, the wiki page of
>> the project is empty http://wiki.apache.org/hadoop/ErasureCode and t=
he
>> main page says 'erasure coding under development'.
>>
>> I recommend you to watch the xorbas presentation video
>> http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) a=
nd
>> use the Dimakis wiki page to check the large collection of paper the=
y
>> have: http://storagewiki.ece.utexas.edu/
>>
>> Best,
>>
>> koleosfuscus
>>
>> ________________________________________________________________
>> "My reply is: the software has no known bugs, therefore it has not
>> been updated."
>> Wietse Venema
>>
>>
>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>> Hi Andreas,
>>>
>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of com=
puting local coding chunks the way it is implemented in https://github.=
com/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to other p=
lugins). However, there are theoretical aspects of the paper that I do =
not understand and I'm hoping you can shed some light on it. In particu=
lar, I don't know what "coefficients" are about. For instance in the co=
ntext of Figure 2 caption : "The main theoretical challenge is to choos=
e the coeffi cients c(i) to maximize the fault tolerance of the code."
>>>
>>> Would you recommend a paper to read to better understand this ? Als=
o I'd like to understand what "coefficients" mean in the context of jer=
asure or if they do not apply.
>>>
>>> Thanks for you help :-)
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
