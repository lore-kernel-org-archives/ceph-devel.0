From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Tue, 15 Dec 2015 21:40:42 +0100
Message-ID: <CA+H5UW02Bjx9RBbqi9uUiCy0JbRnO=qD4fkp-GFcdbovc8DoeQ@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<1450129972.1035.15.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33269 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932365AbbLOUkn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 15:40:43 -0500
Received: by mail-wm0-f50.google.com with SMTP id n186so112873232wmn.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Dec 2015 12:40:43 -0800 (PST)
In-Reply-To: <1450129972.1035.15.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Adam Kupczyk <akupczyk@mirantis.com>

On Mon, Dec 14, 2015 at 10:52 PM, Martin Millnert <martin@millnert.se> =
wrote:
> On Mon, 2015-12-14 at 14:17 +0100, Radoslaw Zarzynski wrote:
>> Hello Folks,
>>
>> I would like to publish a proposal regarding improvements to Ceph
>> data-at-rest encryption mechanism. Adam Kupczyk and I worked
>> on that in last weeks.
>>
>> Initially we considered several architectural approaches and made
>> several iterations of discussions with Intel storage group. The prop=
osal
>> is condensed description of the solution we see as the most promisin=
g
>> one.
>>
>> We are open to any comments and questions.
>>
>> Regards,
>> Adam Kupczyk
>> Radoslaw Zarzynski
>>
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Summary
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Data at-rest encryption is mechanism for protecting data center
>> operator from revealing content of physical carriers.
>>
>> Ceph already implements a form of at rest encryption. It is performe=
d
>> through dm-crypt as intermediary layer between OSD and its physical
>> storage. The proposed at rest encryption mechanism will be orthogona=
l
>> and, in some ways, superior to already existing solution.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Owners
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> * Radoslaw Zarzynski (Mirantis)
>> * Adam Kupczyk (Mirantis)
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Interested Parties
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> If you are interested in contributing to this blueprint, or want to =
be
>> a "speaker" during the Summit session, list your name here.
>>
>> Name (Affiliation)
>> Name (Affiliation)
>> Name
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Current Status
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Current data at rest encryption is achieved through dm-crypt placed
>> under OSD=E2=80=99s filestore. This solution is a generic one and ca=
nnot
>> leverage Ceph-specific characteristics. The best example is that
>> encryption is done multiple times - one time for each replica. Anoth=
er
>> issue is lack of granularity - either OSD encrypts nothing, or OSD
>> encrypts everything (with dm-crypt on).
>
> All or nothing is some times a desired function of encryption.
> "In-betweens" are tricky.
>
> Additionally, dm-crypt is AFAICT fairly performant since at least
> there's no need to context switch per crypto-op, since it sits in the=
 dm
> IO path within kernel.

Hello Martin,

I cannot agree about dm-crypt performance in comparison to the OSD
solution. Each BIO handled by dm-crypt must go through at least one
kernel workqueue (kcryptd) [1]. Some of them have to pass additional
one (kcryptd_io) [2]. Those wqueues are served by dedicated set of
kthreads, so context switches are present here. Moreover, the whole
BIO is split into small, 512 bytes long chunks before passing to
ablkcipher [3]. IMO that's far less than ideal.

In the case of application-layer encryption you would operate much
closer to the data. You may encrypt in much larger chunks. Costs of
context switches and op setup phase (important for hw accelerators)
would be negligible providing much better performance. Leveraging
some Ceph-specific characteristics (encrypting only selected pools;
constant complexity according to replica count) multiplies gain even
further.

Regards,
Radoslaw

[1] http://lxr.free-electrons.com/source/drivers/md/dm-crypt.c?v=3D3.19=
#L1350
[2] http://lxr.free-electrons.com/source/drivers/md/dm-crypt.c?v=3D3.19=
#L1355
[3] http://lxr.free-electrons.com/source/drivers/md/dm-crypt.c?v=3D3.19=
#L864

>
> These two points are not necessarily a critique of your proposal.
>
>> Cryptographic keys are stored on filesystem of storage node that hos=
ts
>> OSDs. Changing them require redeploying the OSDs.
>
> Not very familiar with what deployment technique of dm-crypt you refe=
r
> to (don't use ceph-deploy personally). But the LUKS FDE suite does al=
low
> for separating encryption key from activation key (or whatever it is
> called).
>
>> The best way to address those issues seems to be introducing
>> encryption into Ceph OSD.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Detailed Description
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> In addition to the currently available solution, Ceph OSD would
>> accommodate encryption component placed in the replication mechanism=
s.
>>
>> Data incoming from Ceph clients would be encrypted by primary OSD. I=
t
>> would replicate ciphertext to non-primary members of an acting set.
>> Data sent to Ceph client would be decrypted by OSD handling read
>> operation. This allows to:
>> * perform only one encryption per write,
>> * achieve per-pool key granulation for both key and encryption itsel=
f.
>
> I.e. the primary OSD's key for the PG in question, would be the one u=
sed
> for all replicas of the data, per acting set. I.e. granularity of
> actually one key per acting set, controlled by primary OSD?
>
>> Unfortunately, having always and everywhere the same key for a given
>> pool is unacceptable - it would make cluster migration and key chang=
e
>> extremely burdensome process. To address those issues crypto key
>> versioning would be introduced. All RADOS objects inside single
>> placement group stored on a given OSD would use the same crypto key
>> version.
>
> This seems to add key versioning on the primary OSD.
>
>> The same PG on other replica may use different version of the
>> same, per pool-granulated key.
>
> Attempt to rewrite to see if I parsed correctly: Within a PG's acting
> set, a non-primary OSD can use another version of the per-pool key.
> That seems fair, to support asynchronous key roll forward/backward.
>
>> In typical case ciphertext data transferred from OSD to OSD can be
>> used without change. This is when both OSDs have the same crypto key
>> version for given placement group. In rare cases when crypto keys ar=
e
>> different (key change or transition period) receiving OSD will recry=
pt
>> with local key versions.
>
> Doesn't this presume the receiving OSD always has more up to date set=
 of
> keys than the sending OSD?
> What if sending OSD has a newer key than the receiving OSD?
>
>> For compression to be effective it must be done before encryption. D=
ue
>> to that encryption may be applied differently for replication pools
>> and EC pools. Replicated pools do not implement compression; for tho=
se
>> pools encryption is applied right after data enters OSD. For EC pool=
s
>> encryption is applied after compressing. When compression will be
>> implemented for replicated pools, it must be placed before encryptio=
n.
>>
>> Ceph currently has thin abstraction layer over block ciphers
>> (CryptoHandler, CryptoKeyHandler). We want to extend this API to
>> introduce initialization vectors, chaining modes and asynchronous
>> operations. Implementation of this API may be based on AF_ALG kernel
>> interface. This assures the ability to use hardware accelerations
>> already implemented in Linux kernel. Moreover, due to working on
>> bigger chunks (dm-crypt operates on 512 byte long sectors) the raw
>> encryption performance may be even higher.
>
>
>> The encryption process must not impede random reads and random write=
s
>> to RADOS objects.
>
> That's a brave statement. :-)
>
>>  Solution for this is to create encryption/decryption
>> process that will be applicable for arbitrary data range. This can b=
e
>> done most easily by applying chaining mode that doesn=E2=80=99t impo=
se
>> dependencies between subsequent data chunks. Good candidates are
>> CTR[1] and XTS[2].
>>
>> Encryption-related metadata would be stored in extended attributes.
>>
>> In order to coordinate encryption across acting set, all replicas wi=
ll
>> share information about crypto key versions they use. Real
>> cryptographic keys never be stored permanently by Ceph OSD. Instead,
>> it would be gathered from monitors. Key management improvements will
>> be addressed in separate task based on dedicated proposal [3].
>
> Key management is indeed the Achilles heel of any cluster solution li=
ke
> this, and depending on requirements sooner or later descends into som=
e
> sort of TPM or similar, I guess.  I.e. "to trust a computer someone e=
lse
> may have arbitrary physical access to."
>
> /M
>
>> [1] https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Cou=
nter_.28CTR.29
>>
>> [2] https://en.wikipedia.org/wiki/Disk_encryption_theory#XEX-based_t=
weaked-codebook_mode_with_ciphertext_stealing_.28XTS.29
>>
>> [3] http://tracker.ceph.com/projects/ceph/wiki/Osd_-_simple_ceph-mon=
_dm-crypt_key_management
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Work items
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Coding tasks
>> * Extended Crypto API (CryptoHandler, CryptoKeyHandler).
>> * Encryption for replicated pools.
>> * Encryption for EC pools.
>> * Key management.
>>
>> Build / release tasks
>> * Unit tests for extended Crypto API.
>> * Functional tests for encrypted replicated pools.
>> * Functional tests for encrypted EC pools.
>>
>> Documentation tasks
>> * Document extended Crypto API.
>> * Document migration procedures.
>> * Document crypto key creation and versioning.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
