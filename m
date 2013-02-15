From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [ceph-users] snapshot, clone and mount a VM-Image
Date: Thu, 14 Feb 2013 18:03:08 -0800
Message-ID: <511D975C.7040703@inktank.com>
References: <5118C6BF.70207@risc-software.at> <5118FA0D.606@42on.com> <5118FB31.6020902@risc-software.at> <alpine.DEB.2.00.1302110624370.5429@cobra.newdream.net> <511D3A35.7090702@mermaidconsulting.dk> <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:58158 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759880Ab3BOCDT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 21:03:19 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so407685pbc.25
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 18:03:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302141241020.22023@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 02/14/2013 12:53 PM, Sage Weil wrote:
> Hi Jens-
>
> On Thu, 14 Feb 2013, Jens Kristian S?gaard wrote:
>> Hi Sage,
>>
>>> block device level.  We plan to implement an incremental backup function for
>>> the relative change between two snapshots (or a snapshot and the head).
>>> It's O(n) the size of the device vs the number of files, but should be more
>>> efficient for all but the most sparse of images.  The implementation should
>>> be simple; the challenge is mostly around the incremental file format,
>>> probably.
>>> That doesn't help you now, but would be a relatively self-contained piece of
>>> functionality for someone to contribute to RBD.  This isn't a top
>>
>> I'm very interesting in having an incremental backup tool for Ceph, so if it
>> is possible for me to do, I would like to take a shot at implementing it. It
>> will be a spare time project, so I cannot say how fast it will progress
>> though.
>>
>> If you have any details on how you would like to see the implementation work,
>> please let me know!
>
> Great to hear you're interested in this!  There is a feature in the
> tracker open:
>
> 	http://tracker.ceph.com/issues/4084
>
> (Not that there is much information there yet!)
>
> I think this breaks down into a few different pieces:
>
> 1) Decide what output format to use.  We want to use something that is
> resembles a portable, standard way of representing an incremental set of
> changes to a block device (or large file).  I'm not sure what is out
> there, but we should look carefully before making up our own format.
>
> 2) Expose changes objects between rados snapshots.  This is some generic
> functionality we would bake into librbd that would probably work similarly
> to how read_iterate() currently does (you specify a callback).  We
> probably also want to provide this information directly to a user, so that
> they can get a dump of (offsets, length) pairs for integration with their
> own tool.  I expect this is just a core librbd method.

It'd be nice to implement it as more than one request at once (unlike
read_iterate()'s current implementation). The interface could still
be the same though.

> 3) Write a dumper based on #2 that outputs in format from #1.  The
> callback would (instead of printing file offsets) write the data to the
> output stream with appropriate metadata indicating which part of the image
> it is.  Ideally the output part would be modular, too, so that we can come
> back later and implement support for new formats easily.  The output data
> stream should be able to be directed at stdout or a file.
>
> 4) Write an importer for #1.  It would take as input an existing image,
> assumed to be in the state of the reference snapshot, and write all the
> changed bits.  Take input from stdin or a file.

I think it'd be good to have some kind of safety check here by default. 
Storing a checksum of the original snapshot with the backup and
comparing to the image being restored onto would work, but would be
pretty slow. Any ideas for better ways to do this?

> 5) If necessary, extend the above so that image resize events are properly
> handled.

Couldn't this be handled by storing the size of the original snapshot
in the diff, and resizing to the size of the diff when restoring? Is
there another issue you're thinking of?

> Probably the trickiest bit here is #2, as it will probably involve adding
> some low-level rados operations to efficiently query the snapshot state
> from the client.  With this (and any of the rest), we can help figure out
> how to integrate it cleanly.  My suggestion is to start with #1, though
> (and make sure the rest of this all makes sense to everyone).
>
> THanks!
> sage


