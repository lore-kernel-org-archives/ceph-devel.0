From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 10:14:54 -0700
Message-ID: <4FDF620E.7030704@inktank.com>
References: <4FDB9FBB.9000807@inktank.com> <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64511 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2FRRPC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 13:15:02 -0400
Received: by dady13 with SMTP id y13so7214317dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 10:15:02 -0700 (PDT)
In-Reply-To: <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/18/2012 10:00 AM, Tommi Virtanen wrote:
> On Fri, Jun 15, 2012 at 1:48 PM, Josh Durgin<josh.durgin@inktank.com>  wrote:
>>     $ rbd unpreserve pool/image@snap
>>     Error unpreserving: child images rely on this image
>
> UX nit: this should also say what image it found.
>
> rbd: Cannot unpreserve: Still in use by pool2/image2

Agreed.

>>     $ rbd list_children pool/image@snap
>>     pool2/child1
>>     pool2/child2
>
> How about just "rbd children"? Especially the underscore makes me unhappy.

Yeah, that sounds better.

>>     $ rbd copyup pool2/child1
>
> Does "copyup" make sense to everyone? Every time you say it, my brain
> needs to flip the image inside the other way around -- I naturally
> imagine a tree with the parent at the top, and children and
> grandchildren down from it, but then I can't call that operation
> "copyup" without wrecking my mental image.
>
> I also can't seem to google good evidence that the term would be in
> widespread use in the enterprisey block storage world, outside of the
> unionfs world.. What do people call the un-dedupping, un-thinning of
> copy-on-write thin provisioning?
>
> "unshare"?

I'm not sure what best term is, but there's probably something better 
than copyup.

>> In addition to knowing which parent a given image has, we want to be
>> able to tell if a preserved image still has children. This is
>> accomplished with a new per-pool object, `rbd_children`, which maps
>> (parent pool, parent id, parent snapshot id) to a list of child
>> image ids.
>
> So the omap value is a list, and you need to support atomic add/remove
> on the list members? Are you thinking of using an rbd class method
> that does read-modify-write for that?
>
> My instincts would have gone for (parent_pool, parent_id,
> parent_snapshot_id, child_id) ->  None, to get atomic operations for
> free.

The reason for making it a class method is more about hiding the
implementation from clients. It could be the mapping you describe in
an omap.
