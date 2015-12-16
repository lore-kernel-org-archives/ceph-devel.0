From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Wed, 16 Dec 2015 16:36:08 +0100
Message-ID: <CA+H5UW1ZbHO-HZOeMAwkd1uW+_PuC855BYP4+06-XUo=2yuoRw@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
	<CAHMeWhGgHWq=jPZfj8s_KCB=wLhsBNCyJjZSBQQFZXc8r63M7A@mail.gmail.com>
	<CAJ4mKGYfCdF5p7cD+G4HSYmrSWKABRxWz2h0kOM1XbhOz7SBfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35386 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965648AbbLPPgJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 10:36:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id l126so43968957wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 07:36:09 -0800 (PST)
In-Reply-To: <CAJ4mKGYfCdF5p7cD+G4HSYmrSWKABRxWz2h0kOM1XbhOz7SBfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Adam Kupczyk <akupczyk@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 15, 2015 at 10:04 PM, Gregory Farnum <gfarnum@redhat.com> w=
rote:
> On Tue, Dec 15, 2015 at 1:58 AM, Adam Kupczyk <akupczyk@mirantis.com>=
 wrote:
>>
>>
>> On Mon, Dec 14, 2015 at 9:28 PM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
>>>
>>> On Mon, Dec 14, 2015 at 5:17 AM, Radoslaw Zarzynski
>>> <rzarzynski@mirantis.com> wrote:
>>> > Hello Folks,
>>> >
>>> > I would like to publish a proposal regarding improvements to Ceph
>>> > data-at-rest encryption mechanism. Adam Kupczyk and I worked
>>> > on that in last weeks.
>>> >
>>> > Initially we considered several architectural approaches and made
>>> > several iterations of discussions with Intel storage group. The p=
roposal
>>> > is condensed description of the solution we see as the most promi=
sing
>>> > one.
>>> >
>>> > We are open to any comments and questions.
>>> >
>>> > Regards,
>>> > Adam Kupczyk
>>> > Radoslaw Zarzynski
>>> >
>>> >
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> > Summary
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> >
>>> > Data at-rest encryption is mechanism for protecting data center
>>> > operator from revealing content of physical carriers.
>>> >
>>> > Ceph already implements a form of at rest encryption. It is perfo=
rmed
>>> > through dm-crypt as intermediary layer between OSD and its physic=
al
>>> > storage. The proposed at rest encryption mechanism will be orthog=
onal
>>> > and, in some ways, superior to already existing solution.
>>> >
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> > Owners
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> >
>>> > * Radoslaw Zarzynski (Mirantis)
>>> > * Adam Kupczyk (Mirantis)
>>> >
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> > Interested Parties
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> >
>>> > If you are interested in contributing to this blueprint, or want =
to be
>>> > a "speaker" during the Summit session, list your name here.
>>> >
>>> > Name (Affiliation)
>>> > Name (Affiliation)
>>> > Name
>>> >
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> > Current Status
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> >
>>> > Current data at rest encryption is achieved through dm-crypt plac=
ed
>>> > under OSD=E2=80=99s filestore. This solution is a generic one and=
 cannot
>>> > leverage Ceph-specific characteristics. The best example is that
>>> > encryption is done multiple times - one time for each replica. An=
other
>>> > issue is lack of granularity - either OSD encrypts nothing, or OS=
D
>>> > encrypts everything (with dm-crypt on).
>>> >
>>> > Cryptographic keys are stored on filesystem of storage node that =
hosts
>>> > OSDs. Changing them require redeploying the OSDs.
>>> >
>>> > The best way to address those issues seems to be introducing
>>> > encryption into Ceph OSD.
>>> >
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> > Detailed Description
>>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>>> >
>>> > In addition to the currently available solution, Ceph OSD would
>>> > accommodate encryption component placed in the replication mechan=
isms.
>>> >
>>> > Data incoming from Ceph clients would be encrypted by primary OSD=
=2E It
>>> > would replicate ciphertext to non-primary members of an acting se=
t.
>>> > Data sent to Ceph client would be decrypted by OSD handling read
>>> > operation. This allows to:
>>> > * perform only one encryption per write,
>>> > * achieve per-pool key granulation for both key and encryption it=
self.
>>> >
>>> > Unfortunately, having always and everywhere the same key for a gi=
ven
>>> > pool is unacceptable - it would make cluster migration and key ch=
ange
>>> > extremely burdensome process. To address those issues crypto key
>>> > versioning would be introduced. All RADOS objects inside single
>>> > placement group stored on a given OSD would use the same crypto k=
ey
>>> > version. The same PG on other replica may use different version o=
f the
>>> > same, per pool-granulated key.
>>> >
>>> > In typical case ciphertext data transferred from OSD to OSD can b=
e
>>> > used without change. This is when both OSDs have the same crypto =
key
>>> > version for given placement group. In rare cases when crypto keys=
 are
>>> > different (key change or transition period) receiving OSD will re=
crypt
>>> > with local key versions.
>>>
>>> I don't understand this part at all. Do you plan to read and rewrit=
e
>>> the entire PG whenever you change the "key version"? How often do y=
ou
>>> plan to change these keys? What is even the point of changing them,
>>> since anybody who can control an OSD can grab the entire current ke=
y
>>> set?
>>
>> We envision that key change will happen very infrequently. Usually i=
n
>> reaction to some possible security breach.
>> After key version is incremented, nothing happens automatically. Old=
 key is
>> used for as long as  PG is not empty. When first RADOS object is cre=
ated,
>> the current key version is locked to PG.
>> There is no solution when someone gets control over OSD - either by =
running
>> custom OSD binary or extracting data by impersonating client. It is =
outside
>> of scope of at-rest-encryption. We only addressed cases when media s=
torage
>> somehow leaves datacenter premises. Ability to change key is necessa=
ry,
>> since we need procedure to recover data security after keys are comp=
romised.
>>>
>>>
>>> > For compression to be effective it must be done before encryption=
=2E Due
>>> > to that encryption may be applied differently for replication poo=
ls
>>> > and EC pools. Replicated pools do not implement compression; for =
those
>>> > pools encryption is applied right after data enters OSD. For EC p=
ools
>>> > encryption is applied after compressing. When compression will be
>>> > implemented for replicated pools, it must be placed before encryp=
tion.
>>>
>>> So this means you'll be encrypting the object data, but not the oma=
p
>>> nor xattrs, and not the file names on disk. Is that acceptable to
>>> people? It's probably fine for a lot of rbd use cases, but not for
>>> RGW, CephFS, nor raw RADOS where meaningful metadata (and even *dat=
a*)
>>> is stored in those regions. I'd rather a solution worked on the ful=
l
>>> data set. :/
>>
>> We intend to encrypt:
>> - object data
>> - omap values
>> - xattr values
>> We consider to encrypt:
>> - object names
>> - xattr names
>> We are unable to encrypt:
>> - omap names
>
> Are there any encryption mechanisms that can efficiently and
> effectively encrypt pieces of data that small? I don't have any
> expertise in crypto but I thought you needed a certain minimum size o=
f
> the output blob to get any security at all. If we're turning every
> 8-byte thing into a 64-byte thing that's going to go much worse for u=
s
> than just having every OSD encrypt their local disk...
> -Greg

Hello Greg,

In addition to what Adam said:
 * stream ciphers don't have requirements on data length,
 * block cipher like AES may be turned into stream cipher
   using specific mode of operation (eg. CTR).

Regards,
Radoslaw
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
