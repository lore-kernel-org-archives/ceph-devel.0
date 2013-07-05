From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure coding library API
Date: Fri, 05 Jul 2013 18:34:53 +0200
Message-ID: <51D6F5AD.2050007@dachary.org>
References: <51D20A03.1030204@dachary.org> <68444BDD-2068-4850-998D-C65449C20353@ornl.gov> <14B8F72D-C792-4829-9F9B-1175CB27F3EA@ornl.gov> <CA+4uBUavSx4SKYB0BQbqz+NqPTy2_WYiFTUWSAXcSJQzJQ9TGQ@mail.gmail.com> <622F4407872BA447A16110F65453358C01A4D8067419@FMSAMAIL.fmsa.local> <487BCFAF-6093-4E0D-BE80-26D8D919EF4D@ornl.gov> <622F4407872BA447A16110F65453358C01A4D80674CF@FMSAMAIL.fmsa.local> <51D57784.8080005@dachary.org> <155A8CED-D1FA-4642-BEBB-FCD13F81A021@ornl.gov> <51D6D2F4.5050108@dachary.org> <EC00C3B1-E7D5-4A9D-B725-99FA54308ACC@ornl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D6E6AD87DE28F395559583A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47937 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab3GEQe5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 12:34:57 -0400
In-Reply-To: <EC00C3B1-E7D5-4A9D-B725-99FA54308ACC@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D6E6AD87DE28F395559583A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Scott,

That's unfortunate indeed and I now better understand why it is necessary=
 to add a signature to the chunks. I added the following to:

https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst

Bit flips happen. Not often, but it is possible. Here is an article from =
2011 also search for "bit rot" and "bit error rate". To detect corrupted =
chunks, a signature (SHA1 for instance) should be added as an attribute o=
f the file containing the chunk so that deep scrubbing can check that the=
 chunk is valid by rehashing the content of the chunk and compare it with=
 the signature.

While writing a more detailed version of the API taking your comments and=
 Sam's comment in account, I realized that I don't know if it is possible=
 to recover a parity chunk. If a data chunk is missing, it is enough to r=
ecover with a decode operation and write it back ( assuming a systematic =
code is used ). Would it be possible to do something similar with parity =
chunks ? Or would we need to re-encode all the parity chunks to write jus=
t one of them ? I assume the later but ... I'm not sure ;-)

Cheers

On 05/07/2013 17:02, Atchley, Scott wrote:
> On Jul 5, 2013, at 10:06 AM, Loic Dachary <loic@dachary.org> wrote:
>=20
>> On 05/07/2013 14:13, Atchley, Scott wrote:> Loic,
>>>
>>> Erasure codes take what ever you give them. You need to verify the ch=
unk before using it. Perhaps storing the checksum in the metadata/context=
 that describes the parity object?
>>
>> Hi Scott,
>>
>> Does that mean that if I give the chunks A + B + C to decode() and B i=
s corrupted but A and C are ok it will return an incorrectly decoded cont=
ent ?
>=20
> Unfortunately, yes.
>=20
>> I'm curious to know the answer but I don't think it is an actual probl=
em. A corrupted chunk would mean that the underlying file system corrupte=
d the content of one of its file. I can't remember the last time I saw th=
at happen ;-)
>=20
> Bit flips happen. Not often, but it is possible. Here is an article fro=
m 2011:
>=20
> http://www.linux-mag.com/id/8794/
>=20
> also search for "bit rot" and "bit error rate".
>=20
> Scott
>=20
>>
>> Cheers
>>
>>>
>>> Scott
>>>
>>> On Jul 4, 2013, at 9:24 AM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> I was thinking about scrubbing of erasure coded chunks and realized =
I don't know the answer to this very simple question : what happens when =
a chunk is corrupted ? I.e. if AB is coded with 2+1 into A + B ( data ) +=
 Z (parity ) and Z is replaced with Q. Would reed-solomon ignore/discard =
the corrupted chunk ? If that's the case I think it slightly changes what=
 the API should be.
>>>>
>>>> Cheers
>>>>
>>>> On 04/07/2013 05:06, Paul Von-Stamwitz wrote:
>>>>> Scott, et al.
>>>>>
>>>>> Here is an interesting paper from Usenix HotStorage Conference whic=
h provides local codes without additional capacity overhead.
>>>>>
>>>>> Check it out. (abstract with links to paper and slides)
>>>>> https://www.usenix.org/conference/hotstorage13/solution-network-cha=
llenges-data-recovery-erasure-coded-distributed-storage
>>>>>
>>>>> Cheers,
>>>>> pvs
>>>>>
>>>>>> On Jul 3, 2013, at 11:19 AM, Paul Von-Stamwitz wrote:
>>>>>>
>>>>>> Hi Scott,
>>>>>>
>>>>>> Point taken.
>>>>>>
>>>>>> I was thinking about Loic's decode description where k+m was reque=
sted and
>>>>>> data was decoded when k blocks were received. But he was referring=
 to full
>>>>>> stripe reads where all the memory is allocated.
>>>>>>
>>>>>> Degraded reads and block repair are a different matter.
>>>>>>
>>>>>> pvs
>>>>>>
>>>>>>> On Jul 3, 2013, at 4:53 AM Scott Atchley wrote:
>>>>>>>
>>>>>>> On Jul 2, 2013, at 10:12 PM, Paul Von-Stamwitz
>>>>>>> <PVonStamwitz@us.fujitsu.com> wrote:
>>>>>>>
>>>>>>>> Scott,
>>>>>>>>
>>>>>>>> You make a good point comparing (5/3) RS with Xorbas, but a smal=
l nit:
>>>>>>>>
>>>>>>>> "The I/O to recover from a single failure for both schemes is 5 =
blocks
>>>>>>> so it is as efficient as Xorbas."
>>>>>>>>
>>>>>>>> Maybe not. You would probably issue I/O to all the remaining 7 b=
locks
>>>>>> to
>>>>>>> cover for the possibility of double errors. The time to reconstru=
ct
>>>>>> would
>>>>>>> be about the same, but there could be more disk and network I/O. =
(LRC
>>>>>> will
>>>>>>> need to issue I/O to the rest of the global stripe if it detected=

>>>>>> multiple
>>>>>>> local errors.)
>>>>>>>
>>>>>>> Why would you request more than five? If one cannot be read, requ=
est
>>>>>>> another.
>>>>>>>
>>>>>>> Also, I am not sure that you want to request five at once since i=
t will
>>>>>>> lead to spikes in network traffic and require memory for all five=
 blocks.
>>>>>>> You will need at least two buffers. Request the first two and sta=
rt the
>>>>>>> decoding. You may want a third buffer to overlap the decoding of =
the
>>>>>>> current block with the communication for the next block. It may b=
e that
>>>>>>> the decode time is less than the communication and, in that case,=
 you
>>>>>> will
>>>>>>> want to request all of the blocks at once.
>>>>>>>
>>>>>>>> What I like about Xorbas is that it is an extension of a (x,y) R=
S. You
>>>>>>> can start with traditional RS. If degraded reads and repaired blo=
cks are
>>>>>>> causing a problem, you can add the LRC. If capacity is an issue, =
you can
>>>>>>> take it out.
>>>>>>>
>>>>>>> I like it too and Microsoft has something similar with Pyramid co=
des.
>>>>>> That
>>>>>>> said, my example using traditional RS can provide more fault-tole=
rance
>>>>>> on
>>>>>>> average given the same amount of storage overhead.
>>>>>>>
>>>>>>>>
>>>>>>>> Best,
>>>>>>>> Paul
>>>>>>>>
>>>>>>>> On Tue, Jul 2, 2013 at 2:33 PM, Samuel Just wrote:
>>>>>>>>> I think we should be able to cover most cases by adding an inte=
rface
>>>>>>> like:
>>>>>>>>>
>>>>>>>>> set<int> minimum_to_read(const set<int> &want_to_read, const se=
t<int>
>>>>>>>>> &available_chunks);
>>>>>>>>>
>>>>>>>>> which returns the smallest set required to read/rebuild the chu=
nks in
>>>>>>>>> want_to_read given the chunks in available_chunks.  Alternately=
, we
>>>>>>> might
>>>>>>>>> include a "cost" for reading each chunk like
>>>>>>>>>
>>>>>>>>> set<int> minimum_to_read_with_cost(const set<int> &want_to_read=
,
>>>>>> const
>>>>>>>>> map<int, int> &available)
>>>>>>>>>
>>>>>>>>> which returns the minimum cost set required to read the specifi=
ed
>>>>>>> chunks
>>>>>>>>> given a mapping of available chunks to costs.  The costs might =
allow
>>>>>> us
>>>>>>> to
>>>>>>>>> consider the difference between reading local chunks vs remote =
chunks.
>>>>>>>>> This should be sufficient to cover the read case (esp the degra=
ded
>>>>>> read
>>>>>>>>> case) and the repair case.
>>>>>>>>> -Sam
>>>>>>>>>
>>>>>>>>> On Tue, Jul 2, 2013 at 10:14 AM, Atchley, Scott <atchleyes@ornl=
=2Egov>
>>>>>>>>> wrote:
>>>>>>>>>> On Jul 2, 2013, at 10:07 AM, "Atchley, Scott" <atchleyes@ornl.=
gov>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>> On Jul 1, 2013, at 7:00 PM, Loic Dachary <loic@dachary.org> w=
rote:
>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> Today Sam pointed out that the API for LRC ( Xorbas Hadoop P=
roject
>>>>>>>>> Page, Locally Repairable Codes (LRC) http://smahesh.com/HadoopU=
SC/
>>>>>> for
>>>>>>>>> instance ) would need to be different from the one initialy pro=
posed:
>>>>>>>>>>>
>>>>>>>>>>> An interesting video. Not as entertaining as Jim Plank's vide=
o. ;-)
>>>>>>>>>>>
>>>>>>>>>>> While Plank's focused on the processor requirements for
>>>>>>>>> encoding/decoding, this video focuses on the network and disk I=
/O
>>>>>>>>> requirements.
>>>>>>>>>>>
>>>>>>>>>>>> context(k, m, reed-solomon|...) =3D> context* c
>>>>>>>>>>>> encode(context* c, void* data) =3D> void* chunks[k+m]
>>>>>>>>>>>> decode(context* c, void* chunk[k+m], int*
>>>>>>>>>>>> indices_of_erased_chunks) =3D> void* data // erased chunks a=
re not
>>>>>>> used
>>>>>>>>>>>> repair(context* c, void* chunk[k+m], int*
>>>>>>>>>>>> indices_of_erased_chunks) =3D> void* chunks[k+m] // erased c=
hunks
>>>>>> are
>>>>>>>>>>>> rebuilt
>>>>>>>>>>>>
>>>>>>>>>>>> The decode function must allow for partial read:
>>>>>>>>>>>>
>>>>>>>>>>>> decode(context* c, int offset, int length, void* chunk[k+m],=
 int*
>>>>>>>>>>>> indices_of_erased_chunks, int* missing_chunks) =3D> void* da=
ta
>>>>>>>>>>>>
>>>>>>>>>>>> If there are not enough chunks to recover the desired data r=
ange
>>>>>>>>> [offset, offset+length) the function returns NULL and sets
>>>>>>> missing_chunks
>>>>>>>>> to the list of chunks that must be retrieved in order to be abl=
e to
>>>>>>> read
>>>>>>>>> the desired data.
>>>>>>>>>>>>
>>>>>>>>>>>> If decode is called to read just 1 chunk and it is missing, =
reed-
>>>>>>>>> solomon would return on error and ask for all other chunks to r=
epair.
>>>>>>> If
>>>>>>>>> the underlying library implements LRC, it would ask for a subse=
t of
>>>>>> the
>>>>>>>>> chunks.
>>>>>>>>>>>>
>>>>>>>>>>>> An implementation allowing only full reads and using jerasur=
e
>>>>>>> ( which
>>>>>>>>> does not do LRC ) requires that offset is always zero, length i=
s the
>>>>>>> size
>>>>>>>>> of the object and returns a copy of indices_of_erased_chunks if=
 there
>>>>>>> are
>>>>>>>>> not enough chunks to rebuild the missing ones.
>>>>>>>>>>>>
>>>>>>>>>>>> Comments are welcome :-)
>>>>>>>>>>>
>>>>>>>>>>> I have loosely followed this discussion and I have not looked=

>>>>>> closely
>>>>>>>>> at the proposed API nor at the jerasure interface. My apologies=
 if
>>>>>> this
>>>>>>>>> has already been addressed.
>>>>>>>>>>>
>>>>>>>>>>> It is not clear to me from the above proposed API (ignoring t=
he
>>>>>>> partial
>>>>>>>>> read) what it would do. Was the original intent to encode the e=
ntire
>>>>>>> file
>>>>>>>>> using k+m blocks irregardless of the file size and of the rados=

>>>>>> object
>>>>>>>>> size?
>>>>>>>>>>>
>>>>>>>>>>> If so, how will you map rados objects to the logical k+m obje=
cts
>>>>>> and
>>>>>>>>> vice versa?
>>>>>>>>>>>
>>>>>>>>>>> If not, then the initial API needed an offset and length (eit=
her
>>>>>>>>> logical or rados object).
>>>>>>>>>>>
>>>>>>>>>>> I would assume that you would want to operate on rados sized
>>>>>> objects.
>>>>>>>>> Given a fixed k+m, then you may have more than one set of k+m o=
bjects
>>>>>>> per
>>>>>>>>> file. This is ignoring the LRC "local" parity blocks. For examp=
le, if
>>>>>>> the
>>>>>>>>> rados object size if 1 MB and k =3D 10 and m =3D 4 (as in the X=
orbas
>>>>>> video),
>>>>>>>>> then for a 20 MB file one would need two sets of encoding block=
s. The
>>>>>>>>> first for objects 1-10 and the second for objects 11-20.
>>>>>>>>>>>
>>>>>>>>>>> Perhaps, this is what the context is above. If so, it should =
have
>>>>>> the
>>>>>>>>> logical offset and rados object size, no?
>>>>>>>>>>>
>>>>>>>>>>> I see value in the Xorbas concept and I wonder if the jerasur=
e
>>>>>>> library
>>>>>>>>> can be modified to generate the local parity blocks such that t=
hey
>>>>>> can
>>>>>>> be
>>>>>>>>> used to generate the global parity blocks. That would be a ques=
tion
>>>>>> for
>>>>>>>>> Jim Plank.
>>>>>>>>>>
>>>>>>>>>> The benefits of the Xorbas concept is reduced network and disk=
 I/O
>>>>>> for
>>>>>>>>> failures while maintaining traditional RS's higher fault-tolera=
nce
>>>>>> than
>>>>>>> 3x
>>>>>>>>> replication while using less space.
>>>>>>>>>>
>>>>>>>>>> You can do almost the same thing with jerasure without modifyi=
ng it
>>>>>> at
>>>>>>>>> all. Using the values from the Xorbas video, they have k data b=
locks,
>>>>>> m
>>>>>>>>> global parity blocks, and 2 local parity blocks (generated from=
 k/2
>>>>>>> data
>>>>>>>>> blocks) for a total of k+m+2 blocks on disk that can tolerate a=
ny m
>>>>>>>>> failures. In their example, k =3D 10 and m =3D 4. They store 16=
 blocks
>>>>>> for
>>>>>>>>> each 10 data blocks.
>>>>>>>>>>
>>>>>>>>>> If you use traditional RS encoding via jerasure and used the s=
ame
>>>>>>> amount
>>>>>>>>> of storage (16 blocks for each 10 data blocks), you could encod=
e 3
>>>>>>> parity
>>>>>>>>> blocks for each 5 data blocks. This would consume 16 data block=
s for
>>>>>>> each
>>>>>>>>> 10 data blocks and the fault-tolerance would be variable from 3=
-6
>>>>>>> failures
>>>>>>>>> depending on how the failures fell between the two groups of 5 =
blocks
>>>>>>>>> which is higher than the static 4 failures for the Xorbas code.=
 The
>>>>>> I/O
>>>>>>> to
>>>>>>>>> recover from a single failure for both schemes is 5 blocks so i=
t is
>>>>>> as
>>>>>>>>> efficient as Xorbas. On average, it provides more fault-toleran=
ce,
>>>>>> but
>>>>>>> it
>>>>>>>>> can be less (four failures from one group of 5 data + 3 parity
>>>>>> blocks),
>>>>>>>>> but that worst case is the same as 3x replication.
>>>>>>>>>>
>>>>>>>>>> Scott--
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-
>>>>>> devel"
>>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More maj=
ordomo
>>>>>>>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>> --
>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
>>>>>>> in
>>>>>>>>> the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>>>> info
>>>>>>> at
>>>>>>>>> http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --=20
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>>>
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig4D6E6AD87DE28F395559583A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHW9a0ACgkQ8dLMyEl6F22lFQCdFvE96x+p/9XJQY3Hpt8jYv7m
2foAnRbC5a8qEAuO02CjRuXbWL11f4ic
=4lmJ
-----END PGP SIGNATURE-----

--------------enig4D6E6AD87DE28F395559583A--
