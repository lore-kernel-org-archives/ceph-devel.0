From: Gregory Farnum <greg@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Tue, 16 Oct 2012 14:26:34 -0700
Message-ID: <CAPYLRzh2edEpdBEd0zX-UtVV6h6NgYnA7X=1pCrkEyUxyQVGEQ@mail.gmail.com>
References: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:52021 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab2JPV0f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:26:35 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4525221lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:26:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 16, 2012 at 2:17 PM, Sage Weil <sage@inktank.com> wrote:
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

Can you talk about this in a bit more detail? Do you expect the
clients or the MDS to be doing the setxattr? What about doing it used
to scare you?

> It's also nice because it means we could get rid of the anchor table (used
> for locating files with multiple hard links) entirely and use the
> ancestore xattrs instead.  That means one less thing to fsck, and avoids
> having to invest any time in making the anchor table effectively scale (it
> currently doesn't).

Hurray! I'm not sure how this directly lets us get rid of the anchor
table, though. Is your plan to just stick the inode in every directory
and then mark it so everything that does a stat on that inode goes to
the inode, grabs its primary location out of the inode, and then do a
lookup there? That seems a bit circuitous for a lot of operations...

> Anyone feel like we shouldn't go ahead and do this?
I'm certainly for it with this broad outline. ;)
-Greg
