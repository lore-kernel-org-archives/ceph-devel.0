From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Erasure coding library API
Date: Fri, 5 Jul 2013 08:13:52 -0400
Message-ID: <155A8CED-D1FA-4642-BEBB-FCD13F81A021@ornl.gov>
References: <51D20A03.1030204@dachary.org>
 <68444BDD-2068-4850-998D-C65449C20353@ornl.gov>
 <14B8F72D-C792-4829-9F9B-1175CB27F3EA@ornl.gov>
 <CA+4uBUavSx4SKYB0BQbqz+NqPTy2_WYiFTUWSAXcSJQzJQ9TGQ@mail.gmail.com>
 <622F4407872BA447A16110F65453358C01A4D8067419@FMSAMAIL.fmsa.local>
 <487BCFAF-6093-4E0D-BE80-26D8D919EF4D@ornl.gov>
 <622F4407872BA447A16110F65453358C01A4D80674CF@FMSAMAIL.fmsa.local>
 <51D57784.8080005@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.177.12]:15895 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab3GEMN4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 08:13:56 -0400
In-Reply-To: <51D57784.8080005@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

Loic,

Erasure codes take what ever you give them. You need to verify the chun=
k before using it. Perhaps storing the checksum in the metadata/context=
 that describes the parity object?

Scott

On Jul 4, 2013, at 9:24 AM, Loic Dachary <loic@dachary.org> wrote:

> Hi,
>=20
> I was thinking about scrubbing of erasure coded chunks and realized I=
 don't know the answer to this very simple question : what happens when=
 a chunk is corrupted ? I.e. if AB is coded with 2+1 into A + B ( data =
) + Z (parity ) and Z is replaced with Q. Would reed-solomon ignore/dis=
card the corrupted chunk ? If that's the case I think it slightly chang=
es what the API should be.
>=20
> Cheers
>=20
> On 04/07/2013 05:06, Paul Von-Stamwitz wrote:
>> Scott, et al.
>>=20
>> Here is an interesting paper from Usenix HotStorage Conference which=
 provides local codes without additional capacity overhead.
>>=20
>> Check it out. (abstract with links to paper and slides)
>> https://www.usenix.org/conference/hotstorage13/solution-network-chal=
lenges-data-recovery-erasure-coded-distributed-storage
>>=20
>> Cheers,
>> pvs
>>=20
>>> On Jul 3, 2013, at 11:19 AM, Paul Von-Stamwitz wrote:
>>>=20
>>> Hi Scott,
>>>=20
>>> Point taken.
>>>=20
>>> I was thinking about Loic's decode description where k+m was reques=
ted and
>>> data was decoded when k blocks were received. But he was referring =
to full
>>> stripe reads where all the memory is allocated.
>>>=20
>>> Degraded reads and block repair are a different matter.
>>>=20
>>> pvs
>>>=20
>>>> On Jul 3, 2013, at 4:53 AM Scott Atchley wrote:
>>>>=20
>>>> On Jul 2, 2013, at 10:12 PM, Paul Von-Stamwitz
>>>> <PVonStamwitz@us.fujitsu.com> wrote:
>>>>=20
>>>>> Scott,
>>>>>=20
>>>>> You make a good point comparing (5/3) RS with Xorbas, but a small=
 nit:
>>>>>=20
>>>>> "The I/O to recover from a single failure for both schemes is 5 b=
locks
>>>> so it is as efficient as Xorbas."
>>>>>=20
>>>>> Maybe not. You would probably issue I/O to all the remaining 7 bl=
ocks
>>> to
>>>> cover for the possibility of double errors. The time to reconstruc=
t
>>> would
>>>> be about the same, but there could be more disk and network I/O. (=
LRC
>>> will
>>>> need to issue I/O to the rest of the global stripe if it detected
>>> multiple
>>>> local errors.)
>>>>=20
>>>> Why would you request more than five? If one cannot be read, reque=
st
>>>> another.
>>>>=20
>>>> Also, I am not sure that you want to request five at once since it=
 will
>>>> lead to spikes in network traffic and require memory for all five =
blocks.
>>>> You will need at least two buffers. Request the first two and star=
t the
>>>> decoding. You may want a third buffer to overlap the decoding of t=
he
>>>> current block with the communication for the next block. It may be=
 that
>>>> the decode time is less than the communication and, in that case, =
you
>>> will
>>>> want to request all of the blocks at once.
>>>>=20
>>>>> What I like about Xorbas is that it is an extension of a (x,y) RS=
=2E You
>>>> can start with traditional RS. If degraded reads and repaired bloc=
ks are
>>>> causing a problem, you can add the LRC. If capacity is an issue, y=
ou can
>>>> take it out.
>>>>=20
>>>> I like it too and Microsoft has something similar with Pyramid cod=
es.
>>> That
>>>> said, my example using traditional RS can provide more fault-toler=
ance
>>> on
>>>> average given the same amount of storage overhead.
>>>>=20
>>>>>=20
>>>>> Best,
>>>>> Paul
>>>>>=20
>>>>> On Tue, Jul 2, 2013 at 2:33 PM, Samuel Just wrote:
>>>>>> I think we should be able to cover most cases by adding an inter=
face
>>>> like:
>>>>>>=20
>>>>>> set<int> minimum_to_read(const set<int> &want_to_read, const set=
<int>
>>>>>> &available_chunks);
>>>>>>=20
>>>>>> which returns the smallest set required to read/rebuild the chun=
ks in
>>>>>> want_to_read given the chunks in available_chunks.  Alternately,=
 we
>>>> might
>>>>>> include a "cost" for reading each chunk like
>>>>>>=20
>>>>>> set<int> minimum_to_read_with_cost(const set<int> &want_to_read,
>>> const
>>>>>> map<int, int> &available)
>>>>>>=20
>>>>>> which returns the minimum cost set required to read the specifie=
d
>>>> chunks
>>>>>> given a mapping of available chunks to costs.  The costs might a=
llow
>>> us
>>>> to
>>>>>> consider the difference between reading local chunks vs remote c=
hunks.
>>>>>> This should be sufficient to cover the read case (esp the degrad=
ed
>>> read
>>>>>> case) and the repair case.
>>>>>> -Sam
>>>>>>=20
>>>>>> On Tue, Jul 2, 2013 at 10:14 AM, Atchley, Scott <atchleyes@ornl.=
gov>
>>>>>> wrote:
>>>>>>> On Jul 2, 2013, at 10:07 AM, "Atchley, Scott" <atchleyes@ornl.g=
ov>
>>>>>> wrote:
>>>>>>>=20
>>>>>>>> On Jul 1, 2013, at 7:00 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>>>>>=20
>>>>>>>>> Hi,
>>>>>>>>>=20
>>>>>>>>> Today Sam pointed out that the API for LRC ( Xorbas Hadoop Pr=
oject
>>>>>> Page, Locally Repairable Codes (LRC) http://smahesh.com/HadoopUS=
C/
>>> for
>>>>>> instance ) would need to be different from the one initialy prop=
osed:
>>>>>>>>=20
>>>>>>>> An interesting video. Not as entertaining as Jim Plank's video=
=2E ;-)
>>>>>>>>=20
>>>>>>>> While Plank's focused on the processor requirements for
>>>>>> encoding/decoding, this video focuses on the network and disk I/=
O
>>>>>> requirements.
>>>>>>>>=20
>>>>>>>>> context(k, m, reed-solomon|...) =3D> context* c
>>>>>>>>> encode(context* c, void* data) =3D> void* chunks[k+m]
>>>>>>>>> decode(context* c, void* chunk[k+m], int*
>>>>>>>>> indices_of_erased_chunks) =3D> void* data // erased chunks ar=
e not
>>>> used
>>>>>>>>> repair(context* c, void* chunk[k+m], int*
>>>>>>>>> indices_of_erased_chunks) =3D> void* chunks[k+m] // erased ch=
unks
>>> are
>>>>>>>>> rebuilt
>>>>>>>>>=20
>>>>>>>>> The decode function must allow for partial read:
>>>>>>>>>=20
>>>>>>>>> decode(context* c, int offset, int length, void* chunk[k+m], =
int*
>>>>>>>>> indices_of_erased_chunks, int* missing_chunks) =3D> void* dat=
a
>>>>>>>>>=20
>>>>>>>>> If there are not enough chunks to recover the desired data ra=
nge
>>>>>> [offset, offset+length) the function returns NULL and sets
>>>> missing_chunks
>>>>>> to the list of chunks that must be retrieved in order to be able=
 to
>>>> read
>>>>>> the desired data.
>>>>>>>>>=20
>>>>>>>>> If decode is called to read just 1 chunk and it is missing, r=
eed-
>>>>>> solomon would return on error and ask for all other chunks to re=
pair.
>>>> If
>>>>>> the underlying library implements LRC, it would ask for a subset=
 of
>>> the
>>>>>> chunks.
>>>>>>>>>=20
>>>>>>>>> An implementation allowing only full reads and using jerasure
>>>> ( which
>>>>>> does not do LRC ) requires that offset is always zero, length is=
 the
>>>> size
>>>>>> of the object and returns a copy of indices_of_erased_chunks if =
there
>>>> are
>>>>>> not enough chunks to rebuild the missing ones.
>>>>>>>>>=20
>>>>>>>>> Comments are welcome :-)
>>>>>>>>=20
>>>>>>>> I have loosely followed this discussion and I have not looked
>>> closely
>>>>>> at the proposed API nor at the jerasure interface. My apologies =
if
>>> this
>>>>>> has already been addressed.
>>>>>>>>=20
>>>>>>>> It is not clear to me from the above proposed API (ignoring th=
e
>>>> partial
>>>>>> read) what it would do. Was the original intent to encode the en=
tire
>>>> file
>>>>>> using k+m blocks irregardless of the file size and of the rados
>>> object
>>>>>> size?
>>>>>>>>=20
>>>>>>>> If so, how will you map rados objects to the logical k+m objec=
ts
>>> and
>>>>>> vice versa?
>>>>>>>>=20
>>>>>>>> If not, then the initial API needed an offset and length (eith=
er
>>>>>> logical or rados object).
>>>>>>>>=20
>>>>>>>> I would assume that you would want to operate on rados sized
>>> objects.
>>>>>> Given a fixed k+m, then you may have more than one set of k+m ob=
jects
>>>> per
>>>>>> file. This is ignoring the LRC "local" parity blocks. For exampl=
e, if
>>>> the
>>>>>> rados object size if 1 MB and k =3D 10 and m =3D 4 (as in the Xo=
rbas
>>> video),
>>>>>> then for a 20 MB file one would need two sets of encoding blocks=
=2E The
>>>>>> first for objects 1-10 and the second for objects 11-20.
>>>>>>>>=20
>>>>>>>> Perhaps, this is what the context is above. If so, it should h=
ave
>>> the
>>>>>> logical offset and rados object size, no?
>>>>>>>>=20
>>>>>>>> I see value in the Xorbas concept and I wonder if the jerasure
>>>> library
>>>>>> can be modified to generate the local parity blocks such that th=
ey
>>> can
>>>> be
>>>>>> used to generate the global parity blocks. That would be a quest=
ion
>>> for
>>>>>> Jim Plank.
>>>>>>>=20
>>>>>>> The benefits of the Xorbas concept is reduced network and disk =
I/O
>>> for
>>>>>> failures while maintaining traditional RS's higher fault-toleran=
ce
>>> than
>>>> 3x
>>>>>> replication while using less space.
>>>>>>>=20
>>>>>>> You can do almost the same thing with jerasure without modifyin=
g it
>>> at
>>>>>> all. Using the values from the Xorbas video, they have k data bl=
ocks,
>>> m
>>>>>> global parity blocks, and 2 local parity blocks (generated from =
k/2
>>>> data
>>>>>> blocks) for a total of k+m+2 blocks on disk that can tolerate an=
y m
>>>>>> failures. In their example, k =3D 10 and m =3D 4. They store 16 =
blocks
>>> for
>>>>>> each 10 data blocks.
>>>>>>>=20
>>>>>>> If you use traditional RS encoding via jerasure and used the sa=
me
>>>> amount
>>>>>> of storage (16 blocks for each 10 data blocks), you could encode=
 3
>>>> parity
>>>>>> blocks for each 5 data blocks. This would consume 16 data blocks=
 for
>>>> each
>>>>>> 10 data blocks and the fault-tolerance would be variable from 3-=
6
>>>> failures
>>>>>> depending on how the failures fell between the two groups of 5 b=
locks
>>>>>> which is higher than the static 4 failures for the Xorbas code. =
The
>>> I/O
>>>> to
>>>>>> recover from a single failure for both schemes is 5 blocks so it=
 is
>>> as
>>>>>> efficient as Xorbas. On average, it provides more fault-toleranc=
e,
>>> but
>>>> it
>>>>>> can be less (four failures from one group of 5 data + 3 parity
>>> blocks),
>>>>>> but that worst case is the same as 3x replication.
>>>>>>>=20
>>>>>>> Scott--
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-
>>> devel"
>>>>>>> in the body of a message to majordomo@vger.kernel.org More majo=
rdomo
>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>> in
>>>>>> the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info
>>>> at
>>>>>> http://vger.kernel.org/majordomo-info.html
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
