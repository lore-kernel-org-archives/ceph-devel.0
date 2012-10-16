From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Tue, 16 Oct 2012 16:32:59 -0500
Message-ID: <507DD28B.4030605@inktank.com>
References: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:56583 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab2JPVdE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:33:04 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so4932304iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:33:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/16/2012 04:17 PM, Sage Weil wrote:
> Hey-
>
> One of the design goals of the ceph fs was to keep metadata separate from
> data.  This means, among other things, that when a client is creating a
> bunch of files, it creates the inode via the mds and writes the file data
> to the OSD, but no mds->osd interaction is necessary.
>
> One of the challenges we currently have is that it is difficult to lookup
> an inode by ino.  Normally clients traverse the hierarchy to get there, so
> things are fine for native ceph clients, but when reexporting via NFS we
> can get ESTALE because we an ancient nfs file handle can be presented and
> the ceph MDS won't know where to find it.  We have a similar problem with
> the fsck design in that it is not always possible to discover orphaned
> children of directory that was somehow lost.
>
> One option is to put an ancestor xattr on the first object for each file,
> similar to what we do for directories.  This basically means that each
> file creation will be followed (eventually) by a setxattr osd operation.
> This used to scare me, but now it's seeming like a pretty small price to
> pay for robust NFS reexport and additional information for fsck to
> utilize.
>

Seems like a small price to pay especially for large writes.  How much 
later does the setxattr happen?  For small writes, any idea if this is 
going to cause an additional seek if it's delayed?

> It's also nice because it means we could get rid of the anchor table (used
> for locating files with multiple hard links) entirely and use the
> ancestore xattrs instead.  That means one less thing to fsck, and avoids
> having to invest any time in making the anchor table effectively scale (it
> currently doesn't).
>
> Anyone feel like we shouldn't go ahead and do this?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

