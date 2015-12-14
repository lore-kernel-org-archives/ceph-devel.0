From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Improving Data-At-Rest encryption in Ceph
Date: Mon, 14 Dec 2015 14:17:08 +0100
Message-ID: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34132 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbbLNNRJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 08:17:09 -0500
Received: by mail-wm0-f53.google.com with SMTP id p66so61510954wmp.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 05:17:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Adam Kupczyk <akupczyk@mirantis.com>

Hello Folks,

I would like to publish a proposal regarding improvements to Ceph
data-at-rest encryption mechanism. Adam Kupczyk and I worked
on that in last weeks.

Initially we considered several architectural approaches and made
several iterations of discussions with Intel storage group. The proposa=
l
is condensed description of the solution we see as the most promising
one.

We are open to any comments and questions.

Regards,
Adam Kupczyk
Radoslaw Zarzynski


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Data at-rest encryption is mechanism for protecting data center
operator from revealing content of physical carriers.

Ceph already implements a form of at rest encryption. It is performed
through dm-crypt as intermediary layer between OSD and its physical
storage. The proposed at rest encryption mechanism will be orthogonal
and, in some ways, superior to already existing solution.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Owners
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Radoslaw Zarzynski (Mirantis)
* Adam Kupczyk (Mirantis)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Interested Parties
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you are interested in contributing to this blueprint, or want to be
a "speaker" during the Summit session, list your name here.

Name (Affiliation)
Name (Affiliation)
Name

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Current Status
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Current data at rest encryption is achieved through dm-crypt placed
under OSD=E2=80=99s filestore. This solution is a generic one and canno=
t
leverage Ceph-specific characteristics. The best example is that
encryption is done multiple times - one time for each replica. Another
issue is lack of granularity - either OSD encrypts nothing, or OSD
encrypts everything (with dm-crypt on).

Cryptographic keys are stored on filesystem of storage node that hosts
OSDs. Changing them require redeploying the OSDs.

The best way to address those issues seems to be introducing
encryption into Ceph OSD.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Detailed Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In addition to the currently available solution, Ceph OSD would
accommodate encryption component placed in the replication mechanisms.

Data incoming from Ceph clients would be encrypted by primary OSD. It
would replicate ciphertext to non-primary members of an acting set.
Data sent to Ceph client would be decrypted by OSD handling read
operation. This allows to:
* perform only one encryption per write,
* achieve per-pool key granulation for both key and encryption itself.

Unfortunately, having always and everywhere the same key for a given
pool is unacceptable - it would make cluster migration and key change
extremely burdensome process. To address those issues crypto key
versioning would be introduced. All RADOS objects inside single
placement group stored on a given OSD would use the same crypto key
version. The same PG on other replica may use different version of the
same, per pool-granulated key.

In typical case ciphertext data transferred from OSD to OSD can be
used without change. This is when both OSDs have the same crypto key
version for given placement group. In rare cases when crypto keys are
different (key change or transition period) receiving OSD will recrypt
with local key versions.

=46or compression to be effective it must be done before encryption. Du=
e
to that encryption may be applied differently for replication pools
and EC pools. Replicated pools do not implement compression; for those
pools encryption is applied right after data enters OSD. For EC pools
encryption is applied after compressing. When compression will be
implemented for replicated pools, it must be placed before encryption.

Ceph currently has thin abstraction layer over block ciphers
(CryptoHandler, CryptoKeyHandler). We want to extend this API to
introduce initialization vectors, chaining modes and asynchronous
operations. Implementation of this API may be based on AF_ALG kernel
interface. This assures the ability to use hardware accelerations
already implemented in Linux kernel. Moreover, due to working on
bigger chunks (dm-crypt operates on 512 byte long sectors) the raw
encryption performance may be even higher.

The encryption process must not impede random reads and random writes
to RADOS objects. Solution for this is to create encryption/decryption
process that will be applicable for arbitrary data range. This can be
done most easily by applying chaining mode that doesn=E2=80=99t impose
dependencies between subsequent data chunks. Good candidates are
CTR[1] and XTS[2].

Encryption-related metadata would be stored in extended attributes.

In order to coordinate encryption across acting set, all replicas will
share information about crypto key versions they use. Real
cryptographic keys never be stored permanently by Ceph OSD. Instead,
it would be gathered from monitors. Key management improvements will
be addressed in separate task based on dedicated proposal [3].


[1] https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Counte=
r_.28CTR.29

[2] https://en.wikipedia.org/wiki/Disk_encryption_theory#XEX-based_twea=
ked-codebook_mode_with_ciphertext_stealing_.28XTS.29

[3] http://tracker.ceph.com/projects/ceph/wiki/Osd_-_simple_ceph-mon_dm=
-crypt_key_management

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Work items
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Coding tasks
* Extended Crypto API (CryptoHandler, CryptoKeyHandler).
* Encryption for replicated pools.
* Encryption for EC pools.
* Key management.

Build / release tasks
* Unit tests for extended Crypto API.
* Functional tests for encrypted replicated pools.
* Functional tests for encrypted EC pools.

Documentation tasks
* Document extended Crypto API.
* Document migration procedures.
* Document crypto key creation and versioning.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
