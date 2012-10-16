From: Gregory Farnum <greg@inktank.com>
Subject: Re: parent xattrs on file objects
Date: Tue, 16 Oct 2012 14:54:09 -0700
Message-ID: <CAPYLRzi5CMcgDXOmKq-KZHwpk4X5ecPQ_ReK--G64NiA5b=0ig@mail.gmail.com>
References: <alpine.DEB.2.00.1210161410490.5344@cobra.newdream.net>
	<CAPYLRzh2edEpdBEd0zX-UtVV6h6NgYnA7X=1pCrkEyUxyQVGEQ@mail.gmail.com>
	<alpine.DEB.2.00.1210161430130.5342@cobra.newdream.net>
	<CAC-hyiH7RZP9MQo6dH5Q=PV9LWLrFy1vLMPJGXiRuVaQrM_2qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62045 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935Ab2JPVyK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 17:54:10 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so4615820lbo.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 14:54:09 -0700 (PDT)
In-Reply-To: <CAC-hyiH7RZP9MQo6dH5Q=PV9LWLrFy1vLMPJGXiRuVaQrM_2qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Tue, Oct 16, 2012 at 2:47 PM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Tue, Oct 16, 2012 at 2:35 PM, Sage Weil <sage@inktank.com> wrote:
>> On Tue, 16 Oct 2012, Gregory Farnum wrote:
>>> On Tue, Oct 16, 2012 at 2:17 PM, Sage Weil <sage@inktank.com> wrote:
>>> > Hey-
>>> >
>>> > One of the design goals of the ceph fs was to keep metadata separate from
>>> > data.  This means, among other things, that when a client is creating a
>>> > bunch of files, it creates the inode via the mds and writes the file data
>>> > to the OSD, but no mds->osd interaction is necessary.
>>> >
>>> > One of the challenges we currently have is that it is difficult to lookup
>>> > an inode by ino.  Normally clients traverse the hierarchy to get there, so
>>> > things are fine for native ceph clients, but when reexporting via NFS we
>>> > can get ESTALE because we an ancient nfs file handle can be presented and
>>> > the ceph MDS won't know where to find it.  We have a similar problem with
>>> > the fsck design in that it is not always possible to discover orphaned
>>> > children of directory that was somehow lost.
>>> >
>>> > One option is to put an ancestor xattr on the first object for each file,
>>> > similar to what we do for directories.  This basically means that each
>>> > file creation will be followed (eventually) by a setxattr osd operation.
>>> > This used to scare me, but now it's seeming like a pretty small price to
>>> > pay for robust NFS reexport and additional information for fsck to
>>> > utilize.
>>>
>>> Can you talk about this in a bit more detail? Do you expect the
>>> clients or the MDS to be doing the setxattr? What about doing it used
>>> to scare you?
>>
>> For untarring small files, it doubles the number of osd operations, and
>> means we have to think about the setxattr timing wrt warm caches, etc.
>>
>>> > It's also nice because it means we could get rid of the anchor table (used
>>> > for locating files with multiple hard links) entirely and use the
>>> > ancestore xattrs instead.  That means one less thing to fsck, and avoids
>>> > having to invest any time in making the anchor table effectively scale (it
>>> > currently doesn't).
>>>
>>> Hurray! I'm not sure how this directly lets us get rid of the anchor
>>> table, though. Is your plan to just stick the inode in every directory
>>> and then mark it so everything that does a stat on that inode goes to
>>> the inode, grabs its primary location out of the inode, and then do a
>>> lookup there? That seems a bit circuitous for a lot of operations...
>>
>> We would build a generic lookup_by_ino framework based on these xattrs
>> (first try local mds, then try object xattrs, then try other mds caches,
>> then try object xattr again.. something like that).  Like the anchor
>> lookups, this would iteratively look for parents so that we can
>> traverse to the given file.
>>
>
> Will that be able to cover all cases, or are there still cases where
> we'd end up with ESTALE?

Assuming an ancestor xattr that stores a lazily-updated path in
addition to the actual inode of the parent, and assuming that we
always update the actual parent inode synchronously with a move of the
inode to a different parent, then that lets us cover all lookup cases
since we can just keep hopping back up the object backpointers to the
root.
A malicious workload of inode moves could slow the lookup down quite a
bit; I'm still working through in my head if we can guarantee forward
progress when we have to do lookups from bottom to top but we need to
do locks from top to bottom...
