From: Adam Kupczyk <akupczyk@mirantis.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Wed, 16 Dec 2015 23:29:21 +0100
Message-ID: <CAHMeWhFeSTd8w9zjoN1E=3ks7EysziFa_MRxNV4_oua18omRNw@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<20151215142304.GI31644@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34485 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbbLPW3W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 17:29:22 -0500
Received: by mail-wm0-f54.google.com with SMTP id l126so60692252wml.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 14:29:21 -0800 (PST)
In-Reply-To: <20151215142304.GI31644@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Dec 15, 2015 at 3:23 PM, Lars Marowsky-Bree <lmb@suse.com> wrot=
e:
> On 2015-12-14T14:17:08, Radoslaw Zarzynski <rzarzynski@mirantis.com> =
wrote:
>
> Hi all,
>
> great to see this revived.
>
> However, I have come to see some concerns with handling the encryptio=
n
> within Ceph itself.
>
> The key part to any such approach is formulating the threat scenario.
> For the use cases we have seen, the data-at-rest encryption matters s=
o
> they can confidently throw away disks without leaking data. It's not
> meant as a defense against an online attacker. There usually is no
> problem with "a few" disks being privileged, or one or two nodes that
> need an admin intervention for booting (to enter some master encrypti=
on
> key somehow, somewhere).
>
> However, that requires *all* data on the OSDs to be encrypted.
>
> Crucially, that includes not just the file system meta data (so not j=
ust
> the data), but also the root and especially the swap partition. Those
> potentially include swapped out data, coredumps, logs, etc.
>
> (As an optional feature, it'd be cool if an OSD could be moved to a
> different chassis and continue operating there, to speed up recovery.
> Another optional feature would be to eventually be able, for those
> customers that trust them ;-), supply the key to the on-disk encrypti=
on
> (OPAL et al).)
>
> The proposal that Joshua posted a while ago essentially remained base=
d
> on dm-crypt, but put in simple hooks to retrieve the keys from some
> "secured" server via sftp/ftps instead of loading them from the root =
fs.
> Similar to deo, that ties the key to being on the network and knowing
> the OSD UUID.
>
> This would then also be somewhat easily extensible to utilize the sam=
e
> key management server via initrd/dracut.
>
> Yes, this means that each OSD disk is separately encrypted, but given
> modern CPUs, this is less of a problem. It does have the benefit of
> being completely transparent to Ceph, and actually covering the whole
> node.
Agreed, if encryption is infinitely fast dm-crypt is best solution.
Below is short analysis of encryption burden for dm-crypt and
OSD-encryption when using replicated pools.

Summary:
OSD encryption requires 2.6 times less crypto operations then dm-crypt.
Crypto ops are bottleneck.
Possible solutions:
- make fewer crypto-ops (OSD based encryption can help)
- take crypto ops off CPU (H/W accelerators; not all are integrated
with kcrypto)

Calculations and explanations:
A) DM-CRYPT
When we use dm-crypt whole data and metadata is encrypted. In typical
deployment journal is located on different disc, but is also
encrypted.
On write data path is:
1) enc when writing to journal
2) dec when reading journal
3) enc when writing to storage
So for each byte 2-3 crypto operations are performed (2 can be skipped
if kernel's page allocated in 1 has not been evicted). Lets assume
2.5.
On read data path we have:
4) dec when reading from storage

Balance between reads and writes depends on deployment. Assuming 75%
are reads and 25% are writes and replication factor 3.
This gives us 1*0.75+2.5*0.25*3=3D2.625 bytes of crypto operation per
byte of disc i/o operation.

B) CRYPTO INSIDE OSD
When we do encryption in OSD less bytes are encrypted (dm-crypt has to
encrypt entire disc sectors); anyway we round it to 1.
Read requires 1 byte crypto op per byte. (when data comes from client)
Write requires 1 byte crypto op per byte. (when data goes to client)
This gives us 1*0.75+1*0.25=3D1 byte of crypto op per disc i/o.

C) OSD I/O performance calculation
Lets assume encryption speed 600MB/s per CPU core. (using AES-NI Haswel=
l [1])
This gives us 600/2.625 =3D 229MB for dm-crypt and 600MB/s for OSD loca=
ted crypt.
Usually there are few discs per CPU core in storage nodes. Lets say 6.
6xHDD=3D~600MB/s
6xSSD=3D~6000MB/s

It is clear that crypto is limit for speed.

https://software.intel.com/en-us/articles/intel-aes-ni-performance-enha=
ncements-hytrust-datacontrol-case-study
>
> Of course, one of the key issues is always the key server.
> Putting/retrieving/deleting keys is reasonably simple, but the questi=
on
> of how to ensure HA for it is a bit tricky. But doable; people have b=
een
> building HA ftp/http servers for a while ;-) Also, a single key serve=
r
> setup could theoretically serve multiple Ceph clusters.
>
> It's not yet perfect, but I think the approach is superior to being
> implemented in Ceph natively. If there's any encryption that should b=
e
> implemented in Ceph, I believe it'd be the on-the-wire encryption to
> protect against evasedroppers.
>
> Other scenarios would require client-side encryption.
>
>> Current data at rest encryption is achieved through dm-crypt placed
>> under OSD=E2=80=99s filestore. This solution is a generic one and ca=
nnot
>> leverage Ceph-specific characteristics. The best example is that
>> encryption is done multiple times - one time for each replica. Anoth=
er
>> issue is lack of granularity - either OSD encrypts nothing, or OSD
>> encrypts everything (with dm-crypt on).
>
> True. But for the threat scenario, a holistic approach to encryption
> seems actually required.
>
>> Cryptographic keys are stored on filesystem of storage node that hos=
ts
>> OSDs. Changing them require redeploying the OSDs.
>
> This is solvable by storing the key on an external key server.
>
> Changing the key is only necessary if the key has been exposed. And w=
ith
> dm-crypt, that's still possible - it's not the actual encryption key
> that's stored, but the secret that is needed to unlock it, and that c=
an
> be re-encrypted quite fast. (In theory; it's not implemented yet for
> the Ceph OSDs.)
>
>
>> Data incoming from Ceph clients would be encrypted by primary OSD. I=
t
>> would replicate ciphertext to non-primary members of an acting set.
>
> This still exposes data in coredumps or on swap on the primary OSD, a=
nd
> metadata on the secondaries.
>
>
> Regards,
>     Lars
>
> --
> Architect Storage/HA
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham No=
rton, HRB 21284 (AG N=C3=BCrnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar W=
ilde
>
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
