From: Martin Millnert <martin@millnert.se>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 14 Dec 2015 22:52:52 +0100
Message-ID: <1450129972.1035.15.camel@millnert.se>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncis.millnert.se ([185.19.66.196]:57867 "EHLO mail.millnert.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932273AbbLNVwy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Dec 2015 16:52:54 -0500
In-Reply-To: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Adam Kupczyk <akupczyk@mirantis.com>

On Mon, 2015-12-14 at 14:17 +0100, Radoslaw Zarzynski wrote:
> Hello Folks,
>=20
> I would like to publish a proposal regarding improvements to Ceph
> data-at-rest encryption mechanism. Adam Kupczyk and I worked
> on that in last weeks.
>=20
> Initially we considered several architectural approaches and made
> several iterations of discussions with Intel storage group. The propo=
sal
> is condensed description of the solution we see as the most promising
> one.
>=20
> We are open to any comments and questions.
>=20
> Regards,
> Adam Kupczyk
> Radoslaw Zarzynski
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Data at-rest encryption is mechanism for protecting data center
> operator from revealing content of physical carriers.
>=20
> Ceph already implements a form of at rest encryption. It is performed
> through dm-crypt as intermediary layer between OSD and its physical
> storage. The proposed at rest encryption mechanism will be orthogonal
> and, in some ways, superior to already existing solution.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Owners
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> * Radoslaw Zarzynski (Mirantis)
> * Adam Kupczyk (Mirantis)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Interested Parties
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> If you are interested in contributing to this blueprint, or want to b=
e
> a "speaker" during the Summit session, list your name here.
>=20
> Name (Affiliation)
> Name (Affiliation)
> Name
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Current Status
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Current data at rest encryption is achieved through dm-crypt placed
> under OSD=E2=80=99s filestore. This solution is a generic one and can=
not
> leverage Ceph-specific characteristics. The best example is that
> encryption is done multiple times - one time for each replica. Anothe=
r
> issue is lack of granularity - either OSD encrypts nothing, or OSD
> encrypts everything (with dm-crypt on).

All or nothing is some times a desired function of encryption.
"In-betweens" are tricky.

Additionally, dm-crypt is AFAICT fairly performant since at least
there's no need to context switch per crypto-op, since it sits in the d=
m
IO path within kernel.

These two points are not necessarily a critique of your proposal.

> Cryptographic keys are stored on filesystem of storage node that host=
s
> OSDs. Changing them require redeploying the OSDs.

Not very familiar with what deployment technique of dm-crypt you refer
to (don't use ceph-deploy personally). But the LUKS FDE suite does allo=
w
for separating encryption key from activation key (or whatever it is
called).

> The best way to address those issues seems to be introducing
> encryption into Ceph OSD.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Detailed Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> In addition to the currently available solution, Ceph OSD would
> accommodate encryption component placed in the replication mechanisms=
=2E
>=20
> Data incoming from Ceph clients would be encrypted by primary OSD. It
> would replicate ciphertext to non-primary members of an acting set.
> Data sent to Ceph client would be decrypted by OSD handling read
> operation. This allows to:
> * perform only one encryption per write,
> * achieve per-pool key granulation for both key and encryption itself=
=2E

I.e. the primary OSD's key for the PG in question, would be the one use=
d
for all replicas of the data, per acting set. I.e. granularity of
actually one key per acting set, controlled by primary OSD?

> Unfortunately, having always and everywhere the same key for a given
> pool is unacceptable - it would make cluster migration and key change
> extremely burdensome process. To address those issues crypto key
> versioning would be introduced. All RADOS objects inside single
> placement group stored on a given OSD would use the same crypto key
> version.

This seems to add key versioning on the primary OSD.

> The same PG on other replica may use different version of the
> same, per pool-granulated key.

Attempt to rewrite to see if I parsed correctly: Within a PG's acting
set, a non-primary OSD can use another version of the per-pool key.
That seems fair, to support asynchronous key roll forward/backward.

> In typical case ciphertext data transferred from OSD to OSD can be
> used without change. This is when both OSDs have the same crypto key
> version for given placement group. In rare cases when crypto keys are
> different (key change or transition period) receiving OSD will recryp=
t
> with local key versions.

Doesn't this presume the receiving OSD always has more up to date set o=
f
keys than the sending OSD?
What if sending OSD has a newer key than the receiving OSD?

> For compression to be effective it must be done before encryption. Du=
e
> to that encryption may be applied differently for replication pools
> and EC pools. Replicated pools do not implement compression; for thos=
e
> pools encryption is applied right after data enters OSD. For EC pools
> encryption is applied after compressing. When compression will be
> implemented for replicated pools, it must be placed before encryption=
=2E
>=20
> Ceph currently has thin abstraction layer over block ciphers
> (CryptoHandler, CryptoKeyHandler). We want to extend this API to
> introduce initialization vectors, chaining modes and asynchronous
> operations. Implementation of this API may be based on AF_ALG kernel
> interface. This assures the ability to use hardware accelerations
> already implemented in Linux kernel. Moreover, due to working on
> bigger chunks (dm-crypt operates on 512 byte long sectors) the raw
> encryption performance may be even higher.


> The encryption process must not impede random reads and random writes
> to RADOS objects.

That's a brave statement. :-)

>  Solution for this is to create encryption/decryption
> process that will be applicable for arbitrary data range. This can be
> done most easily by applying chaining mode that doesn=E2=80=99t impos=
e
> dependencies between subsequent data chunks. Good candidates are
> CTR[1] and XTS[2].
>=20
> Encryption-related metadata would be stored in extended attributes.
>=20
> In order to coordinate encryption across acting set, all replicas wil=
l
> share information about crypto key versions they use. Real
> cryptographic keys never be stored permanently by Ceph OSD. Instead,
> it would be gathered from monitors. Key management improvements will
> be addressed in separate task based on dedicated proposal [3].

Key management is indeed the Achilles heel of any cluster solution like
this, and depending on requirements sooner or later descends into some
sort of TPM or similar, I guess.  I.e. "to trust a computer someone els=
e
may have arbitrary physical access to."

/M

> [1] https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Coun=
ter_.28CTR.29
>=20
> [2] https://en.wikipedia.org/wiki/Disk_encryption_theory#XEX-based_tw=
eaked-codebook_mode_with_ciphertext_stealing_.28XTS.29
>=20
> [3] http://tracker.ceph.com/projects/ceph/wiki/Osd_-_simple_ceph-mon_=
dm-crypt_key_management
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Work items
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Coding tasks
> * Extended Crypto API (CryptoHandler, CryptoKeyHandler).
> * Encryption for replicated pools.
> * Encryption for EC pools.
> * Key management.
>=20
> Build / release tasks
> * Unit tests for extended Crypto API.
> * Functional tests for encrypted replicated pools.
> * Functional tests for encrypted EC pools.
>=20
> Documentation tasks
> * Document extended Crypto API.
> * Document migration procedures.
> * Document crypto key creation and versioning.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
