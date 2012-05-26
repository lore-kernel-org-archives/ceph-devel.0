From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD format changes and layering
Date: Fri, 25 May 2012 18:43:17 -0700
Message-ID: <4FC03535.8060409@inktank.com>
References: <4FBEBECD.6040403@inktank.com> <4FBF9DC2.8000508@dreamhost.com> <4FBFE9BA.6090905@inktank.com> <Pine.LNX.4.64.1205251513290.5998@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39870 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2EZBnU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 21:43:20 -0400
Received: by pbbrp8 with SMTP id rp8so2414413pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 18:43:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205251513290.5998@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: elder@inktank.com, ceph-devel <ceph-devel@vger.kernel.org>

On 05/25/2012 03:26 PM, Sage Weil wrote:
> On Fri, 25 May 2012, Josh Durgin wrote:
>> On 05/25/2012 07:57 AM, Alex Elder wrote:
>>>> /**
>>>> * Get the metadata about the image required to do I/O
>>>> * to it. In the future this may include extra information for
>>>> * features that require it, like encryption/compression type.
>>>> * This extra data will be added at the end of the response, so
>>>> * clients that don't support it don't interpret it.
>>>> *
>>>> * Features that would require clients to be updated to access
>>>> * the image correctly (such as image bitmaps) are set in
>>>> * the incompat_features field. A client that doesn't understand
>>>> * those features will return an error when they try to open
>>>> * the image.
>>>> *
>>>> * The size and any extra information is read from the appropriate
>>>> * snapshot metadata, if snapid is not CEPH_NOSNAP.
>>>> *
>>>> * Returns __le64 size, __le64 order, __le64 features,
>>>> * __le64 incompat_features, __le64 snapseq and
>>>> * list of __le64 snapids
>>>> */
>>>> get_info(__le64 snapid)
>>>
>>> I think I would prefer to see these bits of information broken
>>> out into a few routines that group related information, or to
>>> separate what's supplied based on the time or frequency it might
>>> need to be accessed, or the "effort" involved in collecting it.
>>
>> I was thinking that we might want these all in one operation for
>> atomicity, but we could add support for multi-operation transactions to
>> the kernel instead. These were added to userspace a few months ago.
>
> I would prefer separate operations too (e.g., get-size, get-order,
> get-features, etc.).  IIRC there is already some infrastructure to handle
> compound operations already.  Atomicity shouldn't be a concern, either
> way.  This makes it simple to expand the header with other infos without
> creating a get-info2 command or something similar.
>
> A couple other comments:
>
> - The pools currently can't be renamed, but there isn't any reason why
> they couldn't be... at least until we start refering to them by name in
> the rbd parent pointers.  I'd rather use the pool ids to keep our options
> open.

Sounds good.

> - Requiring parents be snapshots seems fine to me.  It just means the
> child lists need to be per-snapshot, so that we know when it is safe to
> remove snaps on the parent.
>
> - I don't think that creating snapshots on the child needs to touch the
> parent (if that is still the plan).  The child can remove itself as a
> child one the final reference (head or snap) is removed; no need to bother
> the parent with that information.  (It could also cause a lot of noise for
> the parent 12.04 image with 10,000 children getting snapped regularly.)
>
> - I wonder if it makes sense to create an 'open' method (and maybe
> corresponding 'close').  I'm imagining future *compat* features (e.g.,
> bitmaps), where a new client creates some bitmaps, and then an old client
> mounts the image.  The bitmap doesn't have to be incompat if the old
> client invalidates it (e.g., via open with old feature set).

This sounds like a good idea too. I imagine when we add compat features
like this, we might want extra methods to add them to existing images
too.

> This might be useful also when we add locking (so that clients get EBUSY
> if multiple hosts try to map).
>
> - Will we have class methods for rbd_directory as well?  That seems like
> the simplest way to maintain backwards compatibility.  Also, if we keep
> the name, maybe rbd_header.* and rbd_data.* are more consistent.

Not sure what you mean about the object names.

We can add a class method for rbd_directory too, so we can change its
format when the old format is removed.
