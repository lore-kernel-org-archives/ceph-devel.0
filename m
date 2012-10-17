From: Casey Bodley <casey@linuxbox.com>
Subject: Re: parent xattrs on file objects
Date: Wed, 17 Oct 2012 17:51:24 -0400 (EDT)
Message-ID: <1471957339.149.1350510684603.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <937776470.145.1350510476081.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1764 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430Ab2JQVv3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Oct 2012 17:51:29 -0400
In-Reply-To: <937776470.145.1350510476081.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, aemerson <aemerson@linuxbox.com>, peter honeyman <peter.honeyman@gmail.com>, Sage Weil <sage@inktank.com>

Hi Greg,

In this case where an inode is created on mds.a and exported to mds.b, there is a potential race on mds.b between a subsequent lookup-by-ino and the primary link actually making it into the inode container.

Our tentative solution was to rely on the way InoTable breaks up the range of inode numbers based on mds nodeid. So when a lookup on the inode container fails, we can determine which mds would have allocated that inode number and attempt to find the inode there. The originating mds.a should always find the inode in its cache while it's pinned for export. Depending on whether the inode is found on mds.a, the lookup-by-ino on mds.b either returns failure or waits for the import to finish.

Casey

----- Original Message -----
From: "Gregory Farnum" <greg@inktank.com>
To: "Casey Bodley" <casey@linuxbox.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, "aemerson" <aemerson@linuxbox.com>, "peter honeyman" <peter.honeyman@gmail.com>, "Sage Weil" <sage@inktank.com>
Sent: Wednesday, October 17, 2012 4:18:04 PM
Subject: Re: parent xattrs on file objects

On Wed, Oct 17, 2012 at 12:40 PM, Casey Bodley <casey@linuxbox.com> wrote:
> To expand on what Matt said, we're also trying to address this issue of lookups by inode number for use with NFS.
>
> The design we've been exploring is to create a single system inode, designated the 'inode container' directory, which stores the primary links to all inodes in the filesystem. These links are named by their inode number to satisfy lookups and obviate the need for an anchor table. This design allows the inode container to make use of existing directory fragmentation and load balancing to distribute the inodes over the MDS cluster.
>
> When a new file is created, it then adds two links: a primary link into the inode container, and a remote link into the filesystem namespace. In the case where the parent directory fragment's authority is different than the corresponding inode container fragment's, it is created in the parent directory then exported to the inode container via an asynchronous slave request.
>
> We welcome additional discussion, both on this design specifically and on the general topic of scalable ino lookups.

So if the primary link isn't always in the "inode container", you must
be preserving the anchor table for this setup. Am I understanding that
correctly? Or is there some other mechanism for linking them that's
less expensive?
-Greg
