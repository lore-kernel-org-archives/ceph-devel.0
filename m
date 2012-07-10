From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: librbd: error finding header
Date: Tue, 10 Jul 2012 18:55:25 +0930
Message-ID: <4FFBF505.4050400@bashkirtsev.com>
References: <4FFA6F35.4040102@bashkirtsev.com> <4FFA9E6D.7030207@inktank.com> <4FFAB273.6030605@bashkirtsev.com> <4FFB193D.7050207@inktank.com> <4FFBA108.3010009@bashkirtsev.com> <4FFBB74F.2050702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:42955 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab2GJJZm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 05:25:42 -0400
In-Reply-To: <4FFBB74F.2050702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/07/12 14:32, Dan Mick wrote:
>
>
> On 07/09/2012 08:27 PM, Vladimir Bashkirtsev wrote:
>> On 10/07/12 03:17, Dan Mick wrote:
>>> Well, it's not so much those; those are the objects that hold data
>>> blocks.  You're more interested in the objects whose names end in
>>> '.rbd'.  These are the header objects, one per image, and are
>>> interpreted by rbd info, but I'm concerned that one of them may not
>>> exist.
>> Right on the ball: .rbd for image concerned just does not exist. So how
>> can we recover from this? And why it has disappeared in first place? (I
>> guess latter may be related to some sort of bug)
>
> Don't know why it might have disappeared.  Recovery: no easy way. It's 
> possible that image header could be reconstructed, but there aren't 
> any tools written to do it (the header format is pretty uncomplicated).
Well... Then somehow either I need to rebuild it manually or clean up 
image remains to free up space. Given that rbd tool refuses to do 
anything without .rbd object then clean up appears to be manual as well.

I have run rbd info on the rest of images and excluded rb.* objects 
belonging to good images. Now I know broken image has prefix of rb.0.1 
and technically I can clean out objects belonging to this image. But rbd 
ls seems to pull the list of rbd images from somewhere: broken image 
must be removed from there as well. Not sure where it is stored.

Alternatively how hard it would be to throw together a quick tool which 
picks up these objects and reconstructs .rbd header? Something tells me 
that it should be relatively straight forward.

I have no pressing need to recover this image - I have pulled the backup 
and now it is on its merry way. But just for future sake we need to get 
this one resolved: another day someone else will hit it.

----------------------------------

30 minutes later:

I have looked at structure of rbd_obj_header_ondisk and really it is 
quite simple. Image has no snapshots and so it makes everything straight 
forward. Order is default 22, size - well, unknown but finding object 
with highest index provides some guidance. get rbd header from another 
image, using hexedit changed name and size, put it back and viola - 
image is back and running. Not quite sure about integrity but at least 
now it will allow to remove image cleanly.

>
> It certainly shouldn't have just happened.  Any idea what operations 
> might have been in progress when it did?
Obviously not. I am running ceph over last few months trying to get it 
off track and till now had no major issues. VM concerned was running 
while I did upgrade from 0.47.3 to 0.48. After that point I have asked 
the list if it is safe to live migrate VM with rbd cache on. Josh 
confirmed that it is safe to do so. So I have live migrated VM to 
another host. No dramas. Still everything runs. Then I have updated 
hosts (rolling update again - migrating VMs away while rebooting hosts). 
I have around 10 VMs (including heavily loaded) and all of them migrated 
around without any issues. Then suddenly this VM refused to migrate. 
While I was typing it I remembered that there was one issue between 
upgrade of ceph and failure to migrate: one of pgs turned inconsistent. 
pg repair fixed it and I immediately forgot about it. Could it be the 
reason why this .rbd disappeared? (Went to check logs but logrotate 
already removed it).
