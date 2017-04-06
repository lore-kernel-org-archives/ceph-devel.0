From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Sparse file info in filestore not propagated to other OSDs
Date: Thu, 6 Apr 2017 11:50:00 -0400
Message-ID: <CA+aFP1AtPUyxX9e6-gQGfO-FbGPTndFkWTq8ypmUotyGw=nfOQ@mail.gmail.com>
References: <beaf4408-2322-b0f1-3265-0d9e411c5bf9@corp.ovh.com>
 <alpine.DEB.2.11.1704061322330.2999@piezo.novalocal> <db761315-61b5-bcac-e9ae-519ae8f769dc@corp.ovh.com>
 <alpine.DEB.2.11.1704061353070.2999@piezo.novalocal> <b7d71b5e-ebd6-23c1-962c-59375038ce5b@corp.ovh.com>
 <alpine.DEB.2.11.1704061426480.2999@piezo.novalocal>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36752 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdDFPuD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 11:50:03 -0400
Received: by mail-lf0-f42.google.com with SMTP id x137so28861045lff.3
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 08:50:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1704061426480.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>

I don't recall a configuration option, but librbd always uses sparse
reads when the cache is disabled and never uses sparse reads for
cache-based reads. I'm pretty sure there wasn't a rationale for the
split -- instead, I've always assumed it was an oversight when that
feature was added years ago.

On Thu, Apr 6, 2017 at 10:27 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> On 04/06/2017 03:55 PM, Sage Weil wrote:
>> > On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> > > On 04/06/2017 03:25 PM, Sage Weil wrote:
>> > > > On Thu, 6 Apr 2017, Piotr Dałek wrote:
>> > > > > Hello,
>> > > > >
>> > > > > We recently had an interesting issue with RBD images and filestore on
>> > > > > Jewel
>> > > > > 10.2.5:
>> > > > > We have a pool with RBD images, all of them mostly untouched (large
>> > > > > areas
>> > > > > of
>> > > > > those images unused), and once we added 3 new OSDs to cluster, objects
>> > > > > representing these images grew substantially on new OSDs: objects
>> > > > > hosting
>> > > > > unused areas of these images on original OSDs remained small (~8K of
>> > > > > space
>> > > > > actually used, 4M allocated), but on new OSDs were large (4M allocated
>> > > > > *and*
>> > > > > actually used). After investigation we concluded that Ceph didn't
>> > > > > propagate
>> > > > > sparse file information during cluster rebalance, resulting in correct
>> > > > > data
>> > > > > contents on all OSDs, but no sparse file data on new OSDs, hence disk
>> > > > > space
>> > > > > usage increase on those.
>> > > > >
>> > > > > [..]
>> > > >
>> > > > I think the solution here is to use sparse_read during recovery.  The
>> > > > PushOp data representation already supports it; it's just a matter of
>> > > > skipping the zeros.  The recovery code could also have an option to
>> > > > check
>> > > > for fully-zero regions of the data and turn those into holes as well.
>> > > > For
>> > > > ReplicatedBackend, see build_push_op().
>> > >
>> > > Can we abuse that to reduce amount of regular (client/inter-osd) network
>> > > traffic?
>> >
>> > Yeah... I wouldn't call it abuse :).  sparse_read() will use
>> > SEEK_HOLE/SEEK_DATA on filestore (if enabled).  On bluestore we have the
>> > metadata on-hand.  It may be a bit slower, though... more complexity
>> > and such.  They recently implemented something like this for the kernel
>> > NFS server and found it was faster for very sparse files but the rest of
>> > the time it was a fair bit slower.
>>
>> I was wondering if we could modify regular reads in a way that makes them work
>> as it used to work, but not transmit zeroed out pages/blocks/objects (in other
>> words, you still would get bufferptrs full of zeroes, but they wouldn't be
>> transmitted as such over the wire; specialized case of RLE compression). That
>> shouldn't be so much slower. But I don't really see how that would work
>> without protocol change... Well, at least it's possible to replace some of
>> calls to read with sparse read, utilizing filesystem/file store metadata to do
>> heavy lifting for us.
>
> IIRC librbd used to have an option to do sparse-read all the time instead
> of read (I think this was in ObjectCacher somewhere?) but I think it got
> turned off for some reason?  Memory is very fuzzy here.  In any case,
> changing the client to use sparse-read is the way to do it, I think.
> I'm a bit skeptical that this will have much of an impact, though.
>
> sage



-- 
Jason
