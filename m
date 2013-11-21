From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [RFC] Ceph encryption support
Date: Thu, 21 Nov 2013 15:01:11 +0800
Message-ID: <528DAFB7.6020208@ubuntukylin.com>
References: <528236D7.6020106@ubuntukylin.com> <l5ujbn$8jq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:37740 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3KUHB0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 02:01:26 -0500
In-Reply-To: <l5ujbn$8jq$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Alex,
   Thanks for your comments.


On 11/13/2013 09:07 AM, Alex Elsayed wrote:
> Li Wang wrote:
>
>> Hi,
>>     We want to implement encryption support for Ceph.
>>     Currently, we have the draft design,
>>
>> 1 When user mount a ceph directory for the first time, he can specify a
>> passphrase and the encryption algorithm and length of key etc. These
>> will be stored as extend attribute of the current root directory, of
>> course, with the passphrase being hashed several times, call it TOKEN.
>> 2 When user try to mount an encrypted directory, a passphrase is
>> required to given, then hash and compare with the stored TOKEN, if
>> equal, accept to mount, otherwise reject to mount.
>> 3 When a file is created, a random key (FEK, file encryption key) is
>> generated, and this key is encrypted by TOKEN, we get EFEK (encrypted
>> FEK), the EFEK and other encryption related information inherited from
>> the root directory are stored in the extend attribute of file.
>> 4 When a file is opened, retrieve the extend attribute, we get EFEK,
>> use TOKEN to decrypt EFEK, get FEK, buffered in the inode
>> 5 When a file is read in readpage()/readpages(), the encrypted pages are
>> decrypted transparently by using FEK, and the plain data are sent to
>> application
>> 6 When a file is written in writepage()/writepages(), the pages are
>> encrypted transparently by using FEK, and then written to OSDs.
>
> Okay, this is sounding quite similar to eCryptfs so far. What that makes me
> wonder is whether eCryptfs can be used, as it's a _stacked_ filesystem.
>

eCryptfs has many limitations, mainly due to the stacked filesystem 
design. Linux VFS has no special support for stacked filesystem. The 
lower file system is never aware of the existence of upper file system, 
namely, eCryptfs. That will cause many problems from synchronization and 
consistency, especially for network and distributed file system. That is 
why eCryptfs can not work well on nfs, cifs, gfs etc. Basically, the 
problem is that even lower file system has done the synchronization, it 
will not notify eCryptfs. This also happens when you manipulate directly 
on the lower filesystem. For Ceph, it has already automatically 
synchronized the metadata while multiple clients operate the same file, 
using eCryptfs, the application could not see the synchronization, since 
eCryptfs has its own metadata cache, which is not synchronized. The 
second is that eCryptfs maintains its own page cache, which typically 
results in double-caching, consume much more memory.

>> Some points,
>> 1 We do client side encryption, the advantages are,
>>     (1) The data over network are encrypted;
>>     (2) OSDs are intended to do io intensive job, we donot wanna bother
>> them to do cpu intensive job, thus we can use cheap and low power machines
>>     (3) The implementation is OSD transparent, and mostly MDS
>> transparent, enjoys the simplification.
>
> This, however, is potentially problematic. At-rest encryption of files and
> encryption of moving data on the wire are different problems, and using one
> to try and address the other can lead to significant issues - in particular,
> this is why it is STRONGLY recommended not to rely on dm-crypt for security
> on network block devices like iSCSI without encrypting the transport using
> ipsec or similar.
>

Ok. To guarantee the data confidence during networking transportation, 
it could set up the ipsec etc, that is not contradict with our plan, 
just need two times of encryption.

>> 2 What about if no page cache?
>>     Block cipher algorithm is more secure than stream cipher algorithm,
>> so we prefer the former. If no page cache, we have two choices, with
>> encryption enabled, the same file is not allowed by opened by the second
>> writer, alternatively, we enforce O_LAZYIO on the file, but application
>> is supposed to be aware of this.
>
> "Block cipher algorithm is more secure than stream cipher algorithm" cannot
> be taken as axiomatic. It being stated as such is something I find
> worrisome.
>
> In particular, using AES in CTR mode (in which case it is essentially a
> random-access stream cipher) is in a number circumstances considerably more
> secure than AES in CBC mode. The stream ciphers Salsa20 and ChaCha are
> believed to be strong as well. Weaknesses in RC4 aren't due to being a
> stream cipher, but rather due to improper use (as in WEP, where the IVs were
> handled improperly) or flaws in the specific cipher.
>

No problem, we do not quite care which cipher to use, as long as kernel 
crypto API support, we can leave it the user's choice as eCryptfs does.

> How are you intending to handle integrity? Do you intend to use a MAC (and
> if so, PLEASE review the literature on mac-and-encrypt vs. mac-then-encrypt
> vs. encrypt-then-mac), or do you plan on using an AEAD cipher mode such as
> GCM (like eCryptfs does)? If your cipher mode uses IVs, how do you intend to
> generate them?
>
> All of these have SIGNIFICANT security impact, and could lead to problems if
> left unaddressed or addressed improperly.
>

Do we really need integrity, I think that is mainly used to detect the 
unauthorized modification to the encrypted text. If need, we can 
consider to use HMAC or GCM.

>> We plan to submit it as a blueprint for the incoming CDS, comments are
>> welcome.
>>
>> Cheers,
>> Li Wang
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
