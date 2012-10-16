From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: parent xattrs on file objects
Date: Tue, 16 Oct 2012 14:47:39 -0700
Message-ID: <CAC-hyiH7RZP9MQo6dH5Q=PV9LWLrFy1vLMPJGXiRuVaQrM_2qA@mail.gmail.com>
References: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
	<CAPYLRzh2edEpdBEd0zX-UtVV6h6NgYnA7X=1pCrkEyUxyQVGEQ@mail.gmail.com>
	<alpine.DEB.2.00.1210161430130.5342@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55054 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab2JPVrl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:47:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so3249575bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:47:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210161430130.5342@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Oct 16, 2012 at 2:35 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 16 Oct 2012, Gregory Farnum wrote:
>> On Tue, Oct 16, 2012 at 2:17 PM, Sage Weil <sage@inktank.com> wrote:
>> > Hey-
>> >
>> > One of the design goals of the ceph fs was to keep metadata separate from
>> > data.  This means, among other things, that when a client is creating a
>> > bunch of files, it creates the inode via the mds and writes the file data
>> > to the OSD, but no mds->osd interaction is necessary.
>> >
>> > One of the challenges we currently have is that it is difficult to lookup
>> > an inode by ino.  Normally clients traverse the hierarchy to get there, so
>> > things are fine for native ceph clients, but when reexporting via NFS we
>> > can get ESTALE because we an ancient nfs file handle can be presented and
>> > the ceph MDS won't know where to find it.  We have a similar problem with
>> > the fsck design in that it is not always possible to discover orphaned
>> > children of directory that was somehow lost.
>> >
>> > One option is to put an ancestor xattr on the first object for each file,
>> > similar to what we do for directories.  This basically means that each
>> > file creation will be followed (eventually) by a setxattr osd operation.
>> > This used to scare me, but now it's seeming like a pretty small price to
>> > pay for robust NFS reexport and additional information for fsck to
>> > utilize.
>>
>> Can you talk about this in a bit more detail? Do you expect the
>> clients or the MDS to be doing the setxattr? What about doing it used
>> to scare you?
>
> For untarring small files, it doubles the number of osd operations, and
> means we have to think about the setxattr timing wrt warm caches, etc.
>
>> > It's also nice because it means we could get rid of the anchor table (used
>> > for locating files with multiple hard links) entirely and use the
>> > ancestore xattrs instead.  That means one less thing to fsck, and avoids
>> > having to invest any time in making the anchor table effectively scale (it
>> > currently doesn't).
>>
>> Hurray! I'm not sure how this directly lets us get rid of the anchor
>> table, though. Is your plan to just stick the inode in every directory
>> and then mark it so everything that does a stat on that inode goes to
>> the inode, grabs its primary location out of the inode, and then do a
>> lookup there? That seems a bit circuitous for a lot of operations...
>
> We would build a generic lookup_by_ino framework based on these xattrs
> (first try local mds, then try object xattrs, then try other mds caches,
> then try object xattr again.. something like that).  Like the anchor
> lookups, this would iteratively look for parents so that we can
> traverse to the given file.
>

Will that be able to cover all cases, or are there still cases where
we'd end up with ESTALE?

Yehuda
