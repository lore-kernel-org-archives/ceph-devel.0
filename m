From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure coding library API
Date: Fri, 05 Jul 2013 18:50:52 +0200
Message-ID: <51D6F96C.7040608@dachary.org>
References: <51D20A03.1030204@dachary.org> <68444BDD-2068-4850-998D-C65449C20353@ornl.gov> <14B8F72D-C792-4829-9F9B-1175CB27F3EA@ornl.gov> <CA+4uBUavSx4SKYB0BQbqz+NqPTy2_WYiFTUWSAXcSJQzJQ9TGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3291CE22BF33A227EE7BE6E3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:59030 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab3GEQuz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 12:50:55 -0400
In-Reply-To: <CA+4uBUavSx4SKYB0BQbqz+NqPTy2_WYiFTUWSAXcSJQzJQ9TGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3291CE22BF33A227EE7BE6E3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I updated the API description at

https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst#erasure-code-library-abstract-api

Please let me know if I missed something.

Cheers

On 02/07/2013 23:33, Samuel Just wrote:
> I think we should be able to cover most cases by adding an interface li=
ke:
>=20
> set<int> minimum_to_read(const set<int> &want_to_read, const set<int>
> &available_chunks);
>=20
> which returns the smallest set required to read/rebuild the chunks in
> want_to_read given the chunks in available_chunks.  Alternately, we
> might include a "cost" for reading each chunk like
>=20
> set<int> minimum_to_read_with_cost(const set<int> &want_to_read, const
> map<int, int> &available)
>=20
> which returns the minimum cost set required to read the specified
> chunks given a mapping of available chunks to costs.  The costs might
> allow us to consider the difference between reading local chunks vs
> remote chunks.  This should be sufficient to cover the read case (esp
> the degraded read case) and the repair case.
> -Sam
>=20
> On Tue, Jul 2, 2013 at 10:14 AM, Atchley, Scott <atchleyes@ornl.gov> wr=
ote:
>> On Jul 2, 2013, at 10:07 AM, "Atchley, Scott" <atchleyes@ornl.gov> wro=
te:
>>
>>> On Jul 1, 2013, at 7:00 PM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> Today Sam pointed out that the API for LRC ( Xorbas Hadoop Project P=
age, Locally Repairable Codes (LRC) http://smahesh.com/HadoopUSC/ for ins=
tance ) would need to be different from the one initialy proposed:
>>>
>>> An interesting video. Not as entertaining as Jim Plank's video. ;-)
>>>
>>> While Plank's focused on the processor requirements for encoding/deco=
ding, this video focuses on the network and disk I/O requirements.
>>>
>>>>   context(k, m, reed-solomon|...) =3D> context* c
>>>>   encode(context* c, void* data) =3D> void* chunks[k+m]
>>>>   decode(context* c, void* chunk[k+m], int* indices_of_erased_chunks=
) =3D> void* data // erased chunks are
>>>> not used
>>>>   repair(context* c, void* chunk[k+m], int* indices_of_erased_chunks=
) =3D> void* chunks[k+m] // erased
>>>> chunks are rebuilt
>>>>
>>>> The decode function must allow for partial read:
>>>>
>>>>   decode(context* c, int offset, int length, void* chunk[k+m], int* =
indices_of_erased_chunks, int* missing_chunks) =3D> void* data
>>>>
>>>> If there are not enough chunks to recover the desired data range [of=
fset, offset+length) the function returns NULL and sets missing_chunks to=
 the list of chunks that must be retrieved in order to be able to read th=
e desired data.
>>>>
>>>> If decode is called to read just 1 chunk and it is missing, reed-sol=
omon would return on error and ask for all other chunks to repair. If the=
 underlying library implements LRC, it would ask for a subset of the chun=
ks.
>>>>
>>>> An implementation allowing only full reads and using jerasure ( whic=
h does not do LRC ) requires that offset is always zero, length is the si=
ze of the object and returns a copy of indices_of_erased_chunks if there =
are not enough chunks to rebuild the missing ones.
>>>>
>>>> Comments are welcome :-)
>>>
>>> I have loosely followed this discussion and I have not looked closely=
 at the proposed API nor at the jerasure interface. My apologies if this =
has already been addressed.
>>>
>>> It is not clear to me from the above proposed API (ignoring the parti=
al read) what it would do. Was the original intent to encode the entire f=
ile using k+m blocks irregardless of the file size and of the rados objec=
t size?
>>>
>>> If so, how will you map rados objects to the logical k+m objects and =
vice versa?
>>>
>>> If not, then the initial API needed an offset and length (either logi=
cal or rados object).
>>>
>>> I would assume that you would want to operate on rados sized objects.=
 Given a fixed k+m, then you may have more than one set of k+m objects pe=
r file. This is ignoring the LRC "local" parity blocks. For example, if t=
he rados object size if 1 MB and k =3D 10 and m =3D 4 (as in the Xorbas v=
ideo), then for a 20 MB file one would need two sets of encoding blocks. =
The first for objects 1-10 and the second for objects 11-20.
>>>
>>> Perhaps, this is what the context is above. If so, it should have the=
 logical offset and rados object size, no?
>>>
>>> I see value in the Xorbas concept and I wonder if the jerasure librar=
y can be modified to generate the local parity blocks such that they can =
be used to generate the global parity blocks. That would be a question fo=
r Jim Plank.
>>
>> The benefits of the Xorbas concept is reduced network and disk I/O for=
 failures while maintaining traditional RS's higher fault-tolerance than =
3x replication while using less space.
>>
>> You can do almost the same thing with jerasure without modifying it at=
 all. Using the values from the Xorbas video, they have k data blocks, m =
global parity blocks, and 2 local parity blocks (generated from k/2 data =
blocks) for a total of k+m+2 blocks on disk that can tolerate any m failu=
res. In their example, k =3D 10 and m =3D 4. They store 16 blocks for eac=
h 10 data blocks.
>>
>> If you use traditional RS encoding via jerasure and used the same amou=
nt of storage (16 blocks for each 10 data blocks), you could encode 3 par=
ity blocks for each 5 data blocks. This would consume 16 data blocks for =
each 10 data blocks and the fault-tolerance would be variable from 3-6 fa=
ilures depending on how the failures fell between the two groups of 5 blo=
cks which is higher than the static 4 failures for the Xorbas code. The I=
/O to recover from a single failure for both schemes is 5 blocks so it is=
 as efficient as Xorbas. On average, it provides more fault-tolerance, bu=
t it can be less (four failures from one group of 5 data + 3 parity block=
s), but that worst case is the same as 3x replication.
>>
>> Scott--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig3291CE22BF33A227EE7BE6E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHW+WwACgkQ8dLMyEl6F21viwCggvhI+cxwONMyUjQtA4O0iSbT
CloAn0roA6Rc17ChuqpdFqL71lTLE+6P
=kdvm
-----END PGP SIGNATURE-----

--------------enig3291CE22BF33A227EE7BE6E3--
