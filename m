From: Dan Mick <dan.mick@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 16:07:16 -0700
Message-ID: <4FDFB4A4.1080107@inktank.com>
References: <4FDB9FBB.9000807@inktank.com> <CADvuQRH0J2y2-G5wWbaUiHy79y_H=wMBLnyW1ZKNdo8J2aSiKw@mail.gmail.com> <4FDF620E.7030704@inktank.com> <Pine.LNX.4.64.1206181059040.11790@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62906 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2FRXHU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 19:07:20 -0400
Received: by pbbrp8 with SMTP id rp8so8828119pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 16:07:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206181059040.11790@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Tommi Virtanen <tv@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/18/2012 11:01 AM, Sage Weil wrote:
> On Mon, 18 Jun 2012, Josh Durgin wrote:
>>>>      $ rbd copyup pool2/child1
>>>
>>> Does "copyup" make sense to everyone? Every time you say it, my brain
>>> needs to flip the image inside the other way around -- I naturally
>>> imagine a tree with the parent at the top, and children and
>>> grandchildren down from it, but then I can't call that operation
>>> "copyup" without wrecking my mental image.
>>>
>>> I also can't seem to google good evidence that the term would be in
>>> widespread use in the enterprisey block storage world, outside of the
>>> unionfs world.. What do people call the un-dedupping, un-thinning of
>>> copy-on-write thin provisioning?
>>>
>>> "unshare"?
>>
>> I'm not sure what best term is, but there's probably something better than
>> copyup.
>
> "flatten"?  My mental model is stuck on the "layering" analogy, where the
> child is a copy-on-write layer on top of a read-only parent.
>
> Someday we may want to support the ability to add a parent to an existing
> image and do a sort of "dedup", so having an opposite for whatever term we
> pick would be a bonus.

"disown" and "adopt"?  :)  (actually I started as a joke, but really I 
kinda like that; fits with the parent-child name)


