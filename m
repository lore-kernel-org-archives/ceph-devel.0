From: Gregory Farnum <greg@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Wed, 17 Oct 2012 13:18:04 -0700
Message-ID: <CAPYLRzgw2owQyhGJH8dhHLVHZeUijAiuzVh8yfvBDkMiXrCNQg@mail.gmail.com>
References: <2054435269.116.1350502651797.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1161967657.118.1350502807306.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50494 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757795Ab2JQUSG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 16:18:06 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so12531112iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 13:18:04 -0700 (PDT)
In-Reply-To: <1161967657.118.1350502807306.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <casey@linuxbox.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, ceph-devel@vger.kernel.org, aemerson <aemerson@linuxbox.com>, peter honeyman <peter.honeyman@gmail.com>, Sage Weil <sage@inktank.com>

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
