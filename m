From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd: error finding header
Date: Fri, 13 Jul 2012 17:34:41 -0700
Message-ID: <5000BEA1.3090002@inktank.com>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com> <4FFAB273.6030605@bashkirtsev.com> <4FFB193D.7050207@inktank.com> <4FFBA108.3010009@bashkirtsev.com> <4FFBB74F.2050702@inktank.com> <4FFBF505.4050400@bashkirtsev.com> <4FFC8BBC.6010807@hq.newdream.net> <4FFE3939.2000000@bashkirtsev.com> <4FFE5567.3060807@inktank.com> <CADvuQRH0+AxZEsCePMeRr7Oyr1NWZgwVUEA-OxmKDZwLCBCp-w@mail.gmail.com> <50001D60.7080909@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34920 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2GNAep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 20:34:45 -0400
Received: by yenl2 with SMTP id l2so4136285yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 17:34:45 -0700 (PDT)
In-Reply-To: <50001D60.7080909@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: Tommi Virtanen <tv@inktank.com>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On 07/13/2012 06:06 AM, Vladimir Bashkirtsev wrote:
> On 13/07/12 01:30, Tommi Virtanen wrote:
>> On Wed, Jul 11, 2012 at 9:41 PM, Josh Durgin <josh.durgin@inktank.com>
>> wrote:
>>> You're right about the object name - you can get its offset in the
>>> image that way. Since rbd is thin-provisioned, however, the highest
>>> index object might not be the highest possible object. When you first
>>> create an image, only the header object is created.
>> You can re-create it with a size that's known to be greater than the
>> old size (put in a terabyte extra, or something), and then use a
>> partitioning tool to see what the disk layout really is, and resize
>> based on that.
> Good point. However ceph should not be aware of image internal
> structure. In most installations image would contain partition table
> which obviously may be used to calculate image size but in some cases
> (when whole image is used for something) it may not be. Perhaps good
> point for RBD would be to create first and last object for image when
> RBD header is created. Will waste a bit of space but generally these
> objects will hold partitioning information and just their existence
> would allow to establish boundaries of the image. Does not help with
> snapshots though. But definitely will be helpful for a recovery tool.

Ceph definitely needs to store the image size. Things like qemu need
to know the size of the block device to report to the guest bios. It's
also useful to know how much space your rbd images have allocated. We
can't assume there's a partition table, or that it's accurate. Ceph
shouldn't need to interpret the contents of an image, since it's
defined by the end user.

Since rbd images can have sizes that are not multiples of their object
size, it also wouldn't give you the exact size. Also, using discard/TRIM
support, objects may be deleted.

If you always make your images a multiple of object size, you never use
discard/TRIM, and you write to the end of the image after you create
it, you could tell the size from highest numbered object that exists.

I don't think this buys you much over doing what Tommi suggested.

Josh
