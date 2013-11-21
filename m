From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: [RFC] Ceph encryption support
Date: Thu, 21 Nov 2013 00:44:04 -0800
Message-ID: <l6kh4c$vj0$1@ger.gmane.org>
References: <528236D7.6020106@ubuntukylin.com> <l5ujbn$8jq$1@ger.gmane.org> <528DAFB7.6020208@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42657 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3KUIoV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Nov 2013 03:44:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1VjPs3-0007kr-On
	for ceph-devel@vger.kernel.org; Thu, 21 Nov 2013 09:44:19 +0100
Received: from c-50-132-41-203.hsd1.wa.comcast.net ([50.132.41.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 21 Nov 2013 09:44:19 +0100
Received: from eternaleye by c-50-132-41-203.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 21 Nov 2013 09:44:19 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Li Wang wrote:

> Hi Alex,
>    Thanks for your comments.
> 
> 
> On 11/13/2013 09:07 AM, Alex Elsayed wrote:
>> Li Wang wrote:
>>
>>> Hi,
>>>     We want to implement encryption support for Ceph.
>>>     Currently, we have the draft design,
>>>
>>> 1 When user mount a ceph directory for the first time, he can specify a
>>> passphrase and the encryption algorithm and length of key etc. These
>>> will be stored as extend attribute of the current root directory, of
>>> course, with the passphrase being hashed several times, call it TOKEN.
>>> 2 When user try to mount an encrypted directory, a passphrase is
>>> required to given, then hash and compare with the stored TOKEN, if
>>> equal, accept to mount, otherwise reject to mount.
>>> 3 When a file is created, a random key (FEK, file encryption key) is
>>> generated, and this key is encrypted by TOKEN, we get EFEK (encrypted
>>> FEK), the EFEK and other encryption related information inherited from
>>> the root directory are stored in the extend attribute of file.
>>> 4 When a file is opened, retrieve the extend attribute, we get EFEK,
>>> use TOKEN to decrypt EFEK, get FEK, buffered in the inode
>>> 5 When a file is read in readpage()/readpages(), the encrypted pages are
>>> decrypted transparently by using FEK, and the plain data are sent to
>>> application
>>> 6 When a file is written in writepage()/writepages(), the pages are
>>> encrypted transparently by using FEK, and then written to OSDs.
>>
>> Okay, this is sounding quite similar to eCryptfs so far. What that makes
>> me wonder is whether eCryptfs can be used, as it's a _stacked_
>> filesystem.
>>
> 
> eCryptfs has many limitations, mainly due to the stacked filesystem
> design. Linux VFS has no special support for stacked filesystem. The
> lower file system is never aware of the existence of upper file system,
> namely, eCryptfs. That will cause many problems from synchronization and
> consistency, especially for network and distributed file system. That is
> why eCryptfs can not work well on nfs, cifs, gfs etc. Basically, the
> problem is that even lower file system has done the synchronization, it
> will not notify eCryptfs. This also happens when you manipulate directly
> on the lower filesystem. For Ceph, it has already automatically
> synchronized the metadata while multiple clients operate the same file,
> using eCryptfs, the application could not see the synchronization, since
> eCryptfs has its own metadata cache, which is not synchronized. The
> second is that eCryptfs maintains its own page cache, which typically
> results in double-caching, consume much more memory.

Okay, all of that makes sense. I do think that looking _very_ closely at how 
ecryptfs works would be beneficial. For instance, it pads files prior to 
encryption to obscure the actual size and boundaries of the file (which 
mitigates known-plaintext attacks), it encrypts the names of files (which 
forces an attacker who wishes to perform an offline attack to expend more 
effort), etc.

>>> Some points,
>>> 1 We do client side encryption, the advantages are,
>>>     (1) The data over network are encrypted;
>>>     (2) OSDs are intended to do io intensive job, we donot wanna bother
>>> them to do cpu intensive job, thus we can use cheap and low power
>>> machines
>>>     (3) The implementation is OSD transparent, and mostly MDS
>>> transparent, enjoys the simplification.
>>
>> This, however, is potentially problematic. At-rest encryption of files
>> and encryption of moving data on the wire are different problems, and
>> using one to try and address the other can lead to significant issues -
>> in particular, this is why it is STRONGLY recommended not to rely on
>> dm-crypt for security on network block devices like iSCSI without
>> encrypting the transport using ipsec or similar.
>>
> 
> Ok. To guarantee the data confidence during networking transportation,
> it could set up the ipsec etc, that is not contradict with our plan,
> just need two times of encryption.

The issue here is that while iSCSI (which was my example above) is point-to-
point, and considerably easier to set up an encrypted tunnel for. With Ceph, 
the set of OSDs is expected to be large and variable. Opportunistic IPSEC 
has never really worked reliably (or been broadly deployed), and the other 
options aren't any better. It may be okay to say 'this is out of scope right 
now', but I want to ensure it's at least a running consideration.

>>> 2 What about if no page cache?
>>>     Block cipher algorithm is more secure than stream cipher algorithm,
>>> so we prefer the former. If no page cache, we have two choices, with
>>> encryption enabled, the same file is not allowed by opened by the second
>>> writer, alternatively, we enforce O_LAZYIO on the file, but application
>>> is supposed to be aware of this.
>>
>> "Block cipher algorithm is more secure than stream cipher algorithm"
>> cannot be taken as axiomatic. It being stated as such is something I find
>> worrisome.
>>
>> In particular, using AES in CTR mode (in which case it is essentially a
>> random-access stream cipher) is in a number circumstances considerably
>> more secure than AES in CBC mode. The stream ciphers Salsa20 and ChaCha
>> are believed to be strong as well. Weaknesses in RC4 aren't due to being
>> a stream cipher, but rather due to improper use (as in WEP, where the IVs
>> were handled improperly) or flaws in the specific cipher.
>>
> 
> No problem, we do not quite care which cipher to use, as long as kernel
> crypto API support, we can leave it the user's choice as eCryptfs does.

My objection wasn't to choosing block ciphers - it was to the reasoning 
given. Block ciphers aren't automatically more secure than stream ciphers, 
and assuming so can lead in problematic directions.

That said, eCryptfs *does* use block ciphers exclusively (while allowing the 
user to choose _which_ block cipher is used), due to having decided that the 
mode of operation would _always_ be GCM. Because GCM is an AEAD 
(Authenticated Encryption with Associated Data) mode, it ensures both 
confidentiality and integrity while avoiding the pitfalls around what 
ordering to use between padding, MAC, and encryption.

>> How are you intending to handle integrity? Do you intend to use a MAC
>> (and if so, PLEASE review the literature on mac-and-encrypt vs.
>> mac-then-encrypt vs. encrypt-then-mac), or do you plan on using an AEAD
>> cipher mode such as GCM (like eCryptfs does)? If your cipher mode uses
>> IVs, how do you intend to generate them?
>>
>> All of these have SIGNIFICANT security impact, and could lead to problems
>> if left unaddressed or addressed improperly.
>>
> 
> Do we really need integrity, I think that is mainly used to detect the
> unauthorized modification to the encrypted text. If need, we can
> consider to use HMAC or GCM.

I'd suggest using AEAD modes exclusively, because with a separate MAC there 
are a number of pitfalls to be carefully avoided. In particular, if you 
authenticate, then pad, then encrypt there are a number of timing attacks 
that become available; if you authenticate, encrypt, and concatenate the two 
then there are other vulnerabilities, etc.

Currently, the only AEAD mode in the kernel is GCM. Unfortunately, GCM has 
some efficiency issues on systems that don't have accelerated multiplication 
in GF(2^x), but the other AEAD modes available either also have efficiency 
issues or are potentially subject to patent issues[1].

I *would* suggest permitting any AEAD mode (even though only GCM is 
currently available), to allow the mode to be changed if a more efficient 
mode is added or a weakness is found in GCM. That's one place where I 
disagree with eCryptfs' choices - GCM is specifically hardcoded as I 
understand it.

>>> We plan to submit it as a blueprint for the incoming CDS, comments are
>>> welcome.

Looking forward to seeing it!

[1] OCB is patented, but that's not the issue - Rogaway has issued a 
royalty-free license for open-source software. The issue is that Gligor, 
Donescu, and Jutla (who have created other efficient AEAD modes) have 
patents that may-or-may-not ALSO apply, and have offered no such license. 
See http://www.cs.ucdavis.edu/~rogaway/ocb/ocb-faq.htm#patent:phil


