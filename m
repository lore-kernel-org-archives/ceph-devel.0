From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: FW: erasure code and coefficients
Date: Mon, 30 Jun 2014 12:59:52 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE746FD9@CERNXCHG44.cern.ch>
References: <53AFDC99.9010009@dachary.org>
	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
	<53B05E85.9020405@dachary.org>
	<CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>
	<53B1289D.8030901@dachary.org>
	<3472A07E6605974CBC9BC573F1BC02E4AE746F2A@CERNXCHG44.cern.ch>
	<53B13D2A.8030901@dachary.org>
 <CAGhffvxTXLfziX9YLifvufYtuBnFPoooKNL5nGaHU0QyZWt6yg@mail.gmail.com>,<53B158FC.8050303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:22056 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaF3M7y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:59:54 -0400
In-Reply-To: <53B158FC.8050303@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Hi Loic,=20

I was reading through the code and I have got the impression that they =
have formulated something simple with a lot of mathematical formulas in=
 this paper. Indeed all ci =3D 1 ... which makes it simple ...

The code seems to work  like this  e..g 10 + 2 + 4 :

Data =3D (1,2,3,4,5,6,7,8,9,10)

(RS1,RS2,RS3,RS4) =3D RS(1,2,3,4,5,5,6,7,8,9,10)

P1 =3D 1 ^ 2 ^ 3 ^ 4 ^ 5
P2 =3D 6 ^ 7 ^ 8 ^ 9 ^ 10
P3 =3D P1 ^ P2 =3D RS1 ^ RS2 ^ RS3 ^ RS4 ( no need to store that, since=
 we store P1 and P2)

You can reconstruct a missing RS chunk with local parity like: RS1 =3D =
P1 ^ P2 ^ RS2 ^ RS3 ^ RS4

At least this is what I got out of the code ...  look at getSRCGroupNei=
ghbors

What I don't know is, if P1 ^ P2 ^ P3 =3D 0 work with every encoding ma=
trix or only for that particular one used.

Cheers Andreas.



>
> On Mon, Jun 30, 2014 at 12:34 PM, Loic Dachary <loic@dachary.org <mai=
lto:loic@dachary.org>> wrote:
>
>     Hi Andreas,
>
>     TL;DR: which part of the code chooses the coefficients to maximiz=
e the fault tolerance of the code as suggested in the Xorbas paper ?
>
>     If I understand correctly, the locality is computed (i.e. how man=
y local parity chunks are created) with:
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L84
>
>     This is different from specifying it explicitly (https://github.c=
om/dachary/ceph/commit/91b9cc2be5851f7668d593bb69b2f4f089ea585a#diff-55=
18964bc98a094a784ce2d17a5b0cc1R11)
>
>     Then a RS encoding matrix is calculated
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L100
>
>     and will be used when encoding an object
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L143
>
>     then each local parity chunk is calculated using a simpler functi=
on (XOR)
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L154
>
>     When decoding, the equivalent of the Ceph minimum_to_decode metho=
d is used to figure out which chunks are needed to recover the lost chu=
nks
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L319
>
>     During recovery, if only one chunk is missing, it is recovered wi=
th the simpler function (XOR)
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L207
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L224
>     (both of which are combined recursively)
>
>     and if there is is a "conflict" (i.e. if local parity is not enou=
gh to recover), then the RS decoding function is used
>
>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib=
/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L266
>
>     I don't understand at all how local parity is related to RS parit=
y, in the sense of "choosing the coefficients c(i) to maximize the faul=
t tolerance of the code" as mentioned in the Xorbas paper : I must be m=
issing something :-) I do understand how the code works though, which i=
s troubling. It also is reassuring because the logic is very similar to=
 what is proposed in https://github.com/ceph/ceph/pull/1921
>
>     Cheers
>
>     On 30/06/2014 11:26, Andreas Joachim Peters wrote:
>     > Hi Loic,
>     >
>     > i think the best is to read along the sources. It is very reada=
ble!
>     >
>     > https://github.com/madiator/HadoopUSC/blob/developUSC/src/contr=
ib/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java
>     >
>     > If there is a high interest in this, you  could port the code f=
rom Java to C++ and use the GF-complete or Intel GF-multiplication impl=
ementation for the used GF multiplications.
>     >
>     > Cheers Andreas.
>     >
>     >
>     > ________________________________________
>     > From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner=
@vger.kernel.org> [ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-=
owner@vger.kernel.org>] on behalf of Loic Dachary [loic@dachary.org <ma=
ilto:loic@dachary.org>]
>     > Sent: 30 June 2014 11:06
>     > To: Koleos Fuscus
>     > Cc: Ceph Development
>     > Subject: Re: erasure code and coefficients
>     >
>     > Hi koleosfuscus,
>     >
>     > It clarifies it enough to raise a question : where can I read c=
ode (or an algorithm if not code) that chose the coefficients desirable=
 to implement what is suggested in the Xorbas paper ?
>     >
>     > Cheers
>     >
>     > On 30/06/2014 10:18, Koleos Fuscus wrote:
>     >> Hi Loic,
>     >>
>     >> I am happy to contribute with some clarifications. In fact,
>     >> erasure/reliability concepts are not blocking my progress with=
 the
>     >> reliability model at ceph. It is the ceph model itself that ha=
s some
>     >> parts not clear to me, and nobody had time yet to review the s=
tate
>     >> model diagram that I published on the wiki. :(
>     >>  Anyway, regarding coefficients here is a bit of background.
>     >> Coefficients are the numbers that multiply your variables insi=
de an
>     >> equation. In a toy example, to solve the equation ax^2+bx+c=3D=
0 you need
>     >> to find the coefficients a,b,c that make the equation valid.
>     >> In the context of Reed Solomon, the definition of coefficients=
 is a
>     >> bit more confusing. In the original design, the message x is
>     >> interpreted as coefficients of a polynomial p. But in subseque=
nts
>     >> interpretations the message x is seen as the values of the pol=
ynomial
>     >> p evaluated at the first k points a1..ak. Such interpretation =
is
>     >> apparently a bit less efficient but desirable because you can
>     >> construct a systematic code.
>     >> In the context of xorbas, you are constructing a code on top o=
f Reed
>     >> Solomon. The codewords are seen as values, and the idea is to =
get
>     >> coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this=
 as a
>     >> missing introduction to my previous message)
>     >>
>     >> Cheers,
>     >>
>     >> koleosfuscus
>     >>
>     >> ______________________________________________________________=
__
>     >> "My reply is: the software has no known bugs, therefore it has=
 not
>     >> been updated."
>     >> Wietse Venema
>     >>
>     >>
>     >> On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.or=
g <mailto:loic@dachary.org>> wrote:
>     >>> Hi koleofuscus,
>     >>>
>     >>> Thanks for the explanation : it is very conforting to know th=
at you understand this :-) At the risk of being thick, I must say that =
the very notion of "coefficient" eludes me. What are they ?
>     >>>
>     >>> Cheers
>     >>>
>     >>> On 29/06/2014 20:38, Koleos Fuscus wrote:
>     >>>> Hello Loic,
>     >>>> Dimakis (one of the authors of xorbas) is talking about coef=
ficients
>     >>>> because they want to find a way to reduce the storage overhe=
ad used
>     >>>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=
=3D4) has
>     >>>> 14/10 storage overhead but when using LRC, the overhead incr=
eases to
>     >>>> 17/10 because you also need to store s1, s2 and s3. Basicall=
y, the
>     >>>> idea is to find specific coefficients c1..c10 that permit to=
 obtain s3
>     >>>> through s1 and s2. In other words, get some s1 and s2 that w=
hen xored
>     >>>> together give s3. If you find such coefficients, you don't n=
eed to
>     >>>> store s3 and the storage overhead of LRC is 1.6x instead of =
1.7x.
>     >>>>
>     >>>> Dimakis said that for the Reed Solomon implementation used i=
n HDFS
>     >>>> RAID they can simple set all coefficients with value '1' and=
 use xor.
>     >>>>
>     >>>> This cannot be the case of the Reed Solomon implemented by y=
ou (I
>     >>>> understood is the jerasure library by Plank) but that I am n=
ot sure. I
>     >>>> guess we need the help of a mathematician or at least check =
and
>     >>>> compare both implementations.
>     >>>>
>     >>>> Finally, apparently for xorbas they only implemented the con=
figuration
>     >>>> RS(10,4) and not other combinations. Unfortunately, the wiki=
 page of
>     >>>> the project is empty http://wiki.apache.org/hadoop/ErasureCo=
de and the
>     >>>> main page says 'erasure coding under development'.
>     >>>>
>     >>>> I recommend you to watch the xorbas presentation video
>     >>>> http://smahesh.com/HadoopUSC/ (a very clear explanation of x=
orbas) and
>     >>>> use the Dimakis wiki page to check the large collection of p=
aper they
>     >>>> have: http://storagewiki.ece.utexas.edu/
>     >>>>
>     >>>> Best,
>     >>>>
>     >>>> koleosfuscus
>     >>>>
>     >>>> ____________________________________________________________=
____
>     >>>> "My reply is: the software has no known bugs, therefore it h=
as not
>     >>>> been updated."
>     >>>> Wietse Venema
>     >>>>
>     >>>>
>     >>>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary=
=2Eorg <mailto:loic@dachary.org>> wrote:
>     >>>>> Hi Andreas,
>     >>>>>
>     >>>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the ide=
a of computing local coding chunks the way it is implemented in https:/=
/github.com/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to=
 other plugins). However, there are theoretical aspects of the paper th=
at I do not understand and I'm hoping you can shed some light on it. In=
 particular, I don't know what "coefficients" are about. For instance i=
n the context of Figure 2 caption : "The main theoretical challenge is =
to choose the coeffi cients c(i) to maximize the fault tolerance of the=
 code."
>     >>>>>
>     >>>>> Would you recommend a paper to read to better understand th=
is ? Also I'd like to understand what "coefficients" mean in the contex=
t of jerasure or if they do not apply.
>     >>>>>
>     >>>>> Thanks for you help :-)
>     >>>>>
>     >>>>> --
>     >>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>     >>>>>
>     >>>
>     >>> --
>     >>> Lo=EFc Dachary, Artisan Logiciel Libre
>     >>>
>     >
>     > --
>     > Lo=EFc Dachary, Artisan Logiciel Libre
>     >
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>     > the body of a message to majordomo@vger.kernel.org <mailto:majo=
rdomo@vger.kernel.org>
>     > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>     >
>
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>
>

--
Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
