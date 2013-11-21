From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: [RFC] Ceph encryption support
Date: Thu, 21 Nov 2013 11:50:10 +0800
Message-ID: <528D82F2.1090007@ubuntukylin.com>
References: <528236D7.6020106@ubuntukylin.com> <CAPYLRzi3qK2+Hp9b--iJyjVtrjiNT08MPm1XnxO2eXfGOs2L6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:54100 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3KUDuO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Nov 2013 22:50:14 -0500
In-Reply-To: <CAPYLRzi3qK2+Hp9b--iJyjVtrjiNT08MPm1XnxO2eXfGOs2L6A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, eternaleye@gmail.com

Hi Gregory,
   Thanks for your comments.

On 11/13/2013 01:58 AM, Gregory Farnum wrote:
> On Tue, Nov 12, 2013 at 6:10 AM, Li Wang <liwang@ubuntukylin.com> wro=
te:
>> Hi,
>>    We want to implement encryption support for Ceph.
>>    Currently, we have the draft design,
>>
>> 1 When user mount a ceph directory for the first time, he can specif=
y a
>> passphrase and the encryption algorithm and length of key etc. These=
 will be
>> stored as extend attribute of the current root directory, of course,=
 with
>> the passphrase being hashed several times, call it TOKEN.
>> 2 When user try to mount an encrypted directory, a passphrase is req=
uired to
>> given, then hash and compare with the stored TOKEN, if equal, accept=
 to
>> mount, otherwise reject to mount.
>
> How would this work? If I mount the root directory and then try to
> navigate down into an encrypted directory, when do I get asked for th=
e
> passphrase?
>

I think the duty of encryption is to protect the confidence of the=20
content of files, that is, user cannot view the plain text if without=20
valid password. But not to prevent user from navigating into the=20
directory, even damage and delete the file, those are something should=20
be done by access control (acl, selinux etc). So, our design for the=20
initial version of encryption is that we donot care this, user could=20
navigate into the encyrpted directory, so what, he will see all=20
encrypted text, and the encrypted file name. This is also what eCryptfs=
=20
is doing, user could read/write/delete the encrypted file directly from=
=20
the lower file system, provided the access control allows him to do so.

>> 3 When a file is created, a random key (FEK, file encryption key) is
>> generated, and this key is encrypted by TOKEN, we get EFEK (encrypte=
d FEK),
>> the EFEK and other encryption related information inherited from the=
 root
>> directory are stored in the extend attribute of file.
>
> So the hash is visible to clients who don't support encryption? Or do
> you want to hide it somehow?
>

So we plan to not to store Token at all. If you enter wrong pass phrase=
,=20
you could still mount the directory, but you will see encrypted text.=20
This is basically what eCryptfs is doing. Maybe we could improve user=20
experience a little bit by using HMAC on Token to get a hash value=20
HToken to be stored. But HToken is only used to warn the valid user if=20
he accidentally input wrong pass phrase.

So in a word, we think that encryption is for protecting the current=20
content of files, rather than preventing damaging/deleting the files,=20
that is what access control is supposed to do. And, in any case, we=20
could hardly prevent the user using old client (without encryption=20
support) or manipulating rados directly to damage/delete the encrypted=20
file. But one thing we do could consider is to use HMAC to warn the=20
valid user that the file has been modified by other unauthorized person=
=2E

>> 4 When a file is opened, retrieve the extend attribute, we get EFEK,
>> use TOKEN to decrypt EFEK, get FEK, buffered in the inode
>> 5 When a file is read in readpage()/readpages(), the encrypted pages=
 are
>> decrypted transparently by using FEK, and the plain data are sent to
>> application
>> 6 When a file is written in writepage()/writepages(), the pages are
>> encrypted transparently by using FEK, and then written to OSDs.
>>
>> Some points,
>> 1 We do client side encryption, the advantages are,
>>    (1) The data over network are encrypted;
>>    (2) OSDs are intended to do io intensive job, we donot wanna both=
er them
>> to do cpu intensive job, thus we can use cheap and low power machine=
s
>>    (3) The implementation is OSD transparent, and mostly MDS transpa=
rent,
>> enjoys the simplification.
>> 2 What about if no page cache?
>>    Block cipher algorithm is more secure than stream cipher algorith=
m, so we
>> prefer the former. If no page cache, we have two choices, with encry=
ption
>> enabled, the same file is not allowed by opened by the second writer=
,
>> alternatively, we enforce O_LAZYIO on the file, but application is s=
upposed
>> to be aware of this.
>>
>> We plan to submit it as a blueprint for the incoming CDS, comments a=
re
>> welcome.
>
> This doesn't sound infeasible, but I'll welcome the details in a
> blueprint. :) The main thing I'm worried about is that if anybody
> breaks the TOKEN they have access to everything, and the hash is goin=
g
> to be available to anybody who wants to see it.
> When I've thought about this in the past I've tended more towards a
> system that uses time-based passcodes derived from a secret which the
> MDS and OSD share, which lets you do sharing without giving the clien=
t
> unlimited permissions on a file. But that requires a lot more
> modifications, and your system has some nice properties as well. You
> might also find
> https://www.usenix.org/system/files/conference/fast13/fast13-final142=
=2Epdf
> interesting =97 it's a very different approach, but people have done
> some thinking about distributed filesystem security before and it's
> always good to consider what's out there before starting. :)
> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
