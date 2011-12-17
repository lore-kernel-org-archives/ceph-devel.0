From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: RBD layering needs to work across pools
Date: Fri, 16 Dec 2011 16:26:21 -0800
Message-ID: <4EEBE1AD.5090507@dreamhost.com>
References: <CAORUGqBWQ5Sm1npyq4Jh0eoEHCmNz+Rb1jE+mOrT8KGM+A=CwA@mail.gmail.com> <CAORUGqAudf68yWzQhgFND1Dh1sxM2ArUitbn_s16acsS2W29wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:53477 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab1LQA0W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 19:26:22 -0500
In-Reply-To: <CAORUGqAudf68yWzQhgFND1Dh1sxM2ArUitbn_s16acsS2W29wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/16/2011 03:40 PM, Tommi Virtanen wrote:
> On Fri, Dec 16, 2011 at 14:48, Tommi Virtanen
> <tommi.virtanen@dreamhost.com>  wrote:
>> To support this, we'd need to make sure the RBD layering we're
>> building is able to use base images in a separate pool. (And handle
>> the ugly case where after a misconfiguration the client can't access
>> the base image anymore...)
>>
>> Josh, can you say whether that falls in line with what's been planned
>> for the layering?
>
> Nevermind, I see parent_{pool, image_id, snap_id} in
> http://tracker.newdream.net/issues/1772
>
> Just keep that in mind as a hard requirement.

Also note that the plan includes setting a read-only flag on
images that have clones, so there's no danger of a parent image
being modified underneath a child image.

There is one detail that we didn't realize while planning this
though - our current plan calls for the parent image to keep
track of a list of child images, which needs to be updated
whenever a child image is created or deleted.

We were planning on storing this in the parent's header, which
would be in the parent's pool. This means that cloning an image
or deleting a cloned image would require write access to the
parent's pool. We might need to rethink this a little.
