From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: librbd: error finding header
Date: Tue, 10 Jul 2012 13:08:28 -0700
Message-ID: <4FFC8BBC.6010807@hq.newdream.net>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com> <4FFAB273.6030605@bashkirtsev.com> <4FFB193D.7050207@inktank.com> <4FFBA108.3010009@bashkirtsev.com> <4FFBB74F.2050702@inktank.com> <4FFBF505.4050400@bashkirtsev.com>
Reply-To: joshd@hq.newdream.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53177 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab2GJUI3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 16:08:29 -0400
In-Reply-To: <4FFBF505.4050400@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

On 07/10/2012 02:25 AM, Vladimir Bashkirtsev wrote:
> On 10/07/12 14:32, Dan Mick wrote:
>>
>>
>> On 07/09/2012 08:27 PM, Vladimir Bashkirtsev wrote:
>>> On 10/07/12 03:17, Dan Mick wrote:
>>>> Well, it's not so much those; those are the objects that hold data
>>>> blocks.  You're more interested in the objects whose names end in
>>>> '.rbd'.  These are the header objects, one per image, and are
>>>> interpreted by rbd info, but I'm concerned that one of them may not
>>>> exist.
>>> Right on the ball: .rbd for image concerned just does not exist. So how
>>> can we recover from this? And why it has disappeared in first place? (I
>>> guess latter may be related to some sort of bug)
>>
>> Don't know why it might have disappeared.  Recovery: no easy way. It's
>> possible that image header could be reconstructed, but there aren't
>> any tools written to do it (the header format is pretty uncomplicated).
> Well... Then somehow either I need to rebuild it manually or clean up
> image remains to free up space. Given that rbd tool refuses to do
> anything without .rbd object then clean up appears to be manual as well.
>
> I have run rbd info on the rest of images and excluded rb.* objects
> belonging to good images. Now I know broken image has prefix of rb.0.1
> and technically I can clean out objects belonging to this image. But rbd
> ls seems to pull the list of rbd images from somewhere: broken image
> must be removed from there as well. Not sure where it is stored.

This is stored in the rbd_directory object. 'rbd rm' tries to do
as much as it can when missing the header, including removing the image
from the directory. If you do 'rbd rm image --debug-rbd 2' you should
see this happen. You'll still get the message about the header being
missing, but it should continue and remove it from the rbd_directory
object as well. It can't remove the data objects since it doesn't
know the correct prefix without the header.

> Alternatively how hard it would be to throw together a quick tool which
> picks up these objects and reconstructs .rbd header? Something tells me
> that it should be relatively straight forward.

It's pretty simple if you don't have any snapshots. If you do have
snapshots, you would need to figure out which snapshot ids they have,
and without the header the only way you could do that would be to
examine the rbd data objects on the osds (there's no way to examine
which selfmanaged snapshots exist via librados right now).

Alternatively, you could brute force the snapshot ids by attempting to 
read from each snapshot id for each data object (since not all of them
will have all snapshots). If they all return -ENOENT for a given
snapshot id, that snapshot id doesn't exist in the image.

If any snapshots had different sizes, or in future versions of rbd had 
other metadata change, you might need to recreate that metadata to be 
able to use the snapshot.

If you created a new header ignoring any snapshots that existed,
you would end up with space still being used by the snapshots after
you removed the image.

> I have no pressing need to recover this image - I have pulled the backup
> and now it is on its merry way. But just for future sake we need to get
> this one resolved: another day someone else will hit it.
>
> ----------------------------------
>
> 30 minutes later:
>
> I have looked at structure of rbd_obj_header_ondisk and really it is
> quite simple. Image has no snapshots and so it makes everything straight
> forward. Order is default 22, size - well, unknown but finding object
> with highest index provides some guidance. get rbd header from another
> image, using hexedit changed name and size, put it back and viola -
> image is back and running. Not quite sure about integrity but at least
> now it will allow to remove image cleanly.
>
>>
>> It certainly shouldn't have just happened.  Any idea what operations
>> might have been in progress when it did?
> Obviously not. I am running ceph over last few months trying to get it
> off track and till now had no major issues. VM concerned was running
> while I did upgrade from 0.47.3 to 0.48. After that point I have asked
> the list if it is safe to live migrate VM with rbd cache on. Josh
> confirmed that it is safe to do so. So I have live migrated VM to
> another host. No dramas. Still everything runs. Then I have updated
> hosts (rolling update again - migrating VMs away while rebooting hosts).
> I have around 10 VMs (including heavily loaded) and all of them migrated
> around without any issues. Then suddenly this VM refused to migrate.
> While I was typing it I remembered that there was one issue between
> upgrade of ceph and failure to migrate: one of pgs turned inconsistent.
> pg repair fixed it and I immediately forgot about it. Could it be the
> reason why this .rbd disappeared? (Went to check logs but logrotate
> already removed it).

Yeah, the the inconsistent pg was very likely the problem. If you see
that happen again it would be good to save the osd logs so we can try to
figure out how it happened. PG repair won't be able to replace missing 
objects if they're missing on all replicas.

Josh
