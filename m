From: Adam Kupczyk <akupczyk@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Tue, 15 Dec 2015 11:04:17 +0100
Message-ID: <CAHMeWhGUBExWAg1OOVf4Ec0O5Jhd33qkA0OOMYAGm6h=CmfVYw@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37470 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbbLOKEX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 05:04:23 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so17597601wmn.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Dec 2015 02:04:23 -0800 (PST)
In-Reply-To: <CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 14, 2015 at 9:28 PM, Gregory Farnum <gfarnum@redhat.com> wr=
ote:
>
> On Mon, Dec 14, 2015 at 5:17 AM, Radoslaw Zarzynski
> <rzarzynski@mirantis.com> wrote:
> > Hello Folks,
> >
> > I would like to publish a proposal regarding improvements to Ceph
> > data-at-rest encryption mechanism. Adam Kupczyk and I worked
> > on that in last weeks.
> >
> > Initially we considered several architectural approaches and made
> > several iterations of discussions with Intel storage group. The pro=
posal
> > is condensed description of the solution we see as the most promisi=
ng
> > one.
> >
> > We are open to any comments and questions.
> >
> > Regards,
> > Adam Kupczyk
> > Radoslaw Zarzynski
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Data at-rest encryption is mechanism for protecting data center
> > operator from revealing content of physical carriers.
> >
> > Ceph already implements a form of at rest encryption. It is perform=
ed
> > through dm-crypt as intermediary layer between OSD and its physical
> > storage. The proposed at rest encryption mechanism will be orthogon=
al
> > and, in some ways, superior to already existing solution.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Owners
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > * Radoslaw Zarzynski (Mirantis)
> > * Adam Kupczyk (Mirantis)
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Interested Parties
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > If you are interested in contributing to this blueprint, or want to=
 be
> > a "speaker" during the Summit session, list your name here.
> >
> > Name (Affiliation)
> > Name (Affiliation)
> > Name
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Current Status
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Current data at rest encryption is achieved through dm-crypt placed
> > under OSD=E2=80=99s filestore. This solution is a generic one and c=
annot
> > leverage Ceph-specific characteristics. The best example is that
> > encryption is done multiple times - one time for each replica. Anot=
her
> > issue is lack of granularity - either OSD encrypts nothing, or OSD
> > encrypts everything (with dm-crypt on).
> >
> > Cryptographic keys are stored on filesystem of storage node that ho=
sts
> > OSDs. Changing them require redeploying the OSDs.
> >
> > The best way to address those issues seems to be introducing
> > encryption into Ceph OSD.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Detailed Description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In addition to the currently available solution, Ceph OSD would
> > accommodate encryption component placed in the replication mechanis=
ms.
> >
> > Data incoming from Ceph clients would be encrypted by primary OSD. =
It
> > would replicate ciphertext to non-primary members of an acting set.
> > Data sent to Ceph client would be decrypted by OSD handling read
> > operation. This allows to:
> > * perform only one encryption per write,
> > * achieve per-pool key granulation for both key and encryption itse=
lf.
> >
> > Unfortunately, having always and everywhere the same key for a give=
n
> > pool is unacceptable - it would make cluster migration and key chan=
ge
> > extremely burdensome process. To address those issues crypto key
> > versioning would be introduced. All RADOS objects inside single
> > placement group stored on a given OSD would use the same crypto key
> > version. The same PG on other replica may use different version of =
the
> > same, per pool-granulated key.
> >
> > In typical case ciphertext data transferred from OSD to OSD can be
> > used without change. This is when both OSDs have the same crypto ke=
y
> > version for given placement group. In rare cases when crypto keys a=
re
> > different (key change or transition period) receiving OSD will recr=
ypt
> > with local key versions.
>
> I don't understand this part at all. Do you plan to read and rewrite
> the entire PG whenever you change the "key version"? How often do you
> plan to change these keys? What is even the point of changing them,
> since anybody who can control an OSD can grab the entire current key
> set?
We envision that key change will happen very infrequently. Usually in
reaction to some possible security breach.
After key version is incremented, nothing happens automatically. Old
key is used for as long as  PG is not empty. When first RADOS object
is created, the current key version is locked to PG.
There is no solution when someone gets control over OSD - either by
running custom OSD binary or extracting data by impersonating client.
It is outside of scope of at-rest-encryption. We only addressed cases
when media storage somehow leaves datacenter premises. Ability to
change key is necessary, since we need procedure to recover data
security after keys are compromised.
>
> > For compression to be effective it must be done before encryption. =
Due
> > to that encryption may be applied differently for replication pools
> > and EC pools. Replicated pools do not implement compression; for th=
ose
> > pools encryption is applied right after data enters OSD. For EC poo=
ls
> > encryption is applied after compressing. When compression will be
> > implemented for replicated pools, it must be placed before encrypti=
on.
>
> So this means you'll be encrypting the object data, but not the omap
> nor xattrs, and not the file names on disk. Is that acceptable to
> people? It's probably fine for a lot of rbd use cases, but not for
> RGW, CephFS, nor raw RADOS where meaningful metadata (and even *data*=
)
> is stored in those regions. I'd rather a solution worked on the full
> data set. :/

We intend to encrypt:
- object data
- omap values
- xattr values
We consider to encrypt:
- object names
- xattr names
We are unable to encrypt:
- omap names
> -Greg
>
> >
> > Ceph currently has thin abstraction layer over block ciphers
> > (CryptoHandler, CryptoKeyHandler). We want to extend this API to
> > introduce initialization vectors, chaining modes and asynchronous
> > operations. Implementation of this API may be based on AF_ALG kerne=
l
> > interface. This assures the ability to use hardware accelerations
> > already implemented in Linux kernel. Moreover, due to working on
> > bigger chunks (dm-crypt operates on 512 byte long sectors) the raw
> > encryption performance may be even higher.
> >
> > The encryption process must not impede random reads and random writ=
es
> > to RADOS objects. Solution for this is to create encryption/decrypt=
ion
> > process that will be applicable for arbitrary data range. This can =
be
> > done most easily by applying chaining mode that doesn=E2=80=99t imp=
ose
> > dependencies between subsequent data chunks. Good candidates are
> > CTR[1] and XTS[2].
> >
> > Encryption-related metadata would be stored in extended attributes.
> >
> > In order to coordinate encryption across acting set, all replicas w=
ill
> > share information about crypto key versions they use. Real
> > cryptographic keys never be stored permanently by Ceph OSD. Instead=
,
> > it would be gathered from monitors. Key management improvements wil=
l
> > be addressed in separate task based on dedicated proposal [3].
> >
> >
> > [1] https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Co=
unter_.28CTR.29
> >
> > [2] https://en.wikipedia.org/wiki/Disk_encryption_theory#XEX-based_=
tweaked-codebook_mode_with_ciphertext_stealing_.28XTS.29
> >
> > [3] http://tracker.ceph.com/projects/ceph/wiki/Osd_-_simple_ceph-mo=
n_dm-crypt_key_management
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Work items
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Coding tasks
> > * Extended Crypto API (CryptoHandler, CryptoKeyHandler).
> > * Encryption for replicated pools.
> > * Encryption for EC pools.
> > * Key management.
> >
> > Build / release tasks
> > * Unit tests for extended Crypto API.
> > * Functional tests for encrypted replicated pools.
> > * Functional tests for encrypted EC pools.
> >
> > Documentation tasks
> > * Document extended Crypto API.
> > * Document migration procedures.
> > * Document crypto key creation and versioning.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
