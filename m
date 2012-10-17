From: Gregory Farnum <greg@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Wed, 17 Oct 2012 15:04:23 -0700
Message-ID: <CAPYLRzg5tkaTSvxnKsDMPFSdfSHKqiFOyETKxnSNFmrYOuf6fA@mail.gmail.com>
References: <937776470.145.1350510476081.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1471957339.149.1350510684603.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36108 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab2JQWEY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 18:04:24 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so5831401iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 15:04:23 -0700 (PDT)
In-Reply-To: <1471957339.149.1350510684603.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <casey@linuxbox.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, aemerson <aemerson@linuxbox.com>, peter honeyman <peter.honeyman@gmail.com>, Sage Weil <sage@inktank.com>

I still don't get it. Putting every inode's primary link in a lookup
directory and then patching the lookup code to go there makes sense to
me. But if you have to go the other way (from the inode directory's
secondary link to some other location as the primary link), you need
an up-to-date path for that primary link, right? How do you handle it
when the path changes =97 do you have a two-phase commit on the lookup
directory attributes?

On Wed, Oct 17, 2012 at 2:51 PM, Casey Bodley <casey@linuxbox.com> wrot=
e:
> Hi Greg,
>
> In this case where an inode is created on mds.a and exported to mds.b=
, there is a potential race on mds.b between a subsequent lookup-by-ino=
 and the primary link actually making it into the inode container.
>
> Our tentative solution was to rely on the way InoTable breaks up the =
range of inode numbers based on mds nodeid. So when a lookup on the ino=
de container fails, we can determine which mds would have allocated tha=
t inode number and attempt to find the inode there. The originating mds=
=2Ea should always find the inode in its cache while it's pinned for ex=
port. Depending on whether the inode is found on mds.a, the lookup-by-i=
no on mds.b either returns failure or waits for the import to finish.
>
> Casey
>
> ----- Original Message -----
> From: "Gregory Farnum" <greg@inktank.com>
> To: "Casey Bodley" <casey@linuxbox.com>
> Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.or=
g, "aemerson" <aemerson@linuxbox.com>, "peter honeyman" <peter.honeyman=
@gmail.com>, "Sage Weil" <sage@inktank.com>
> Sent: Wednesday, October 17, 2012 4:18:04 PM
> Subject: Re: parent xattrs on file objects
>
> On Wed, Oct 17, 2012 at 12:40 PM, Casey Bodley <casey@linuxbox.com> w=
rote:
>> To expand on what Matt said, we're also trying to address this issue=
 of lookups by inode number for use with NFS.
>>
>> The design we've been exploring is to create a single system inode, =
designated the 'inode container' directory, which stores the primary li=
nks to all inodes in the filesystem. These links are named by their ino=
de number to satisfy lookups and obviate the need for an anchor table. =
This design allows the inode container to make use of existing director=
y fragmentation and load balancing to distribute the inodes over the MD=
S cluster.
>>
>> When a new file is created, it then adds two links: a primary link i=
nto the inode container, and a remote link into the filesystem namespac=
e. In the case where the parent directory fragment's authority is diffe=
rent than the corresponding inode container fragment's, it is created i=
n the parent directory then exported to the inode container via an asyn=
chronous slave request.
>>
>> We welcome additional discussion, both on this design specifically a=
nd on the general topic of scalable ino lookups.
>
> So if the primary link isn't always in the "inode container", you mus=
t
> be preserving the anchor table for this setup. Am I understanding tha=
t
> correctly? Or is there some other mechanism for linking them that's
> less expensive?
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
