From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RFC] Ceph encryption support
Date: Tue, 12 Nov 2013 09:58:08 -0800
Message-ID: <CAPYLRzi3qK2+Hp9b--iJyjVtrjiNT08MPm1XnxO2eXfGOs2L6A@mail.gmail.com>
References: <528236D7.6020106@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:61283 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3KLR6K convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 12:58:10 -0500
Received: by mail-wg0-f47.google.com with SMTP id y10so2755843wgg.26
        for <ceph-devel@vger.kernel.org>; Tue, 12 Nov 2013 09:58:09 -0800 (PST)
In-Reply-To: <528236D7.6020106@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Tue, Nov 12, 2013 at 6:10 AM, Li Wang <liwang@ubuntukylin.com> wrote=
:
> Hi,
>   We want to implement encryption support for Ceph.
>   Currently, we have the draft design,
>
> 1 When user mount a ceph directory for the first time, he can specify=
 a
> passphrase and the encryption algorithm and length of key etc. These =
will be
> stored as extend attribute of the current root directory, of course, =
with
> the passphrase being hashed several times, call it TOKEN.
> 2 When user try to mount an encrypted directory, a passphrase is requ=
ired to
> given, then hash and compare with the stored TOKEN, if equal, accept =
to
> mount, otherwise reject to mount.

How would this work? If I mount the root directory and then try to
navigate down into an encrypted directory, when do I get asked for the
passphrase?

> 3 When a file is created, a random key (FEK, file encryption key) is
> generated, and this key is encrypted by TOKEN, we get EFEK (encrypted=
 FEK),
> the EFEK and other encryption related information inherited from the =
root
> directory are stored in the extend attribute of file.

So the hash is visible to clients who don't support encryption? Or do
you want to hide it somehow?

> 4 When a file is opened, retrieve the extend attribute, we get EFEK,
> use TOKEN to decrypt EFEK, get FEK, buffered in the inode
> 5 When a file is read in readpage()/readpages(), the encrypted pages =
are
> decrypted transparently by using FEK, and the plain data are sent to
> application
> 6 When a file is written in writepage()/writepages(), the pages are
> encrypted transparently by using FEK, and then written to OSDs.
>
> Some points,
> 1 We do client side encryption, the advantages are,
>   (1) The data over network are encrypted;
>   (2) OSDs are intended to do io intensive job, we donot wanna bother=
 them
> to do cpu intensive job, thus we can use cheap and low power machines
>   (3) The implementation is OSD transparent, and mostly MDS transpare=
nt,
> enjoys the simplification.
> 2 What about if no page cache?
>   Block cipher algorithm is more secure than stream cipher algorithm,=
 so we
> prefer the former. If no page cache, we have two choices, with encryp=
tion
> enabled, the same file is not allowed by opened by the second writer,
> alternatively, we enforce O_LAZYIO on the file, but application is su=
pposed
> to be aware of this.
>
> We plan to submit it as a blueprint for the incoming CDS, comments ar=
e
> welcome.

This doesn't sound infeasible, but I'll welcome the details in a
blueprint. :) The main thing I'm worried about is that if anybody
breaks the TOKEN they have access to everything, and the hash is going
to be available to anybody who wants to see it.
When I've thought about this in the past I've tended more towards a
system that uses time-based passcodes derived from a secret which the
MDS and OSD share, which lets you do sharing without giving the client
unlimited permissions on a file. But that requires a lot more
modifications, and your system has some nice properties as well. You
might also find
https://www.usenix.org/system/files/conference/fast13/fast13-final142.p=
df
interesting =97 it's a very different approach, but people have done
some thinking about distributed filesystem security before and it's
always good to consider what's out there before starting. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
