From: Takuya ASADA <syuu@dokukino.com>
Subject: Re: Java binding for RADOS API
Date: Tue, 16 Nov 2010 04:17:56 +0900
Message-ID: <AANLkTim9zEcF-bVFSZCDrKRb9SJPUjqBGnwFBPGM6pCy@mail.gmail.com>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
 <1289568944.4894.16.camel@wido-desktop> <AANLkTins-08+N4Wqj-0qSE4XrZ1LaestckCd4RL9w+R2@mail.gmail.com>
 <1289808125.1367.2.camel@wido-laptop.pcextreme.nl> <AANLkTimbogvHcoZsFTUPQ9imKcvt9eafOoCp08-dpDgE@mail.gmail.com>
 <1289827282.3070.20.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55647 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900Ab0KOTSS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 14:18:18 -0500
Received: by ewy8 with SMTP id 8so922460ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Nov 2010 11:18:17 -0800 (PST)
In-Reply-To: <1289827282.3070.20.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi,

> The general rule is to split objects up into smaller pieces of 4MB,
> that's what the filesystem Ceph and RBD do.
>
> You could refer to the RBD code, but i'm not fully into RBD, Yehuda
> Sadeh might be able to tell you more.
>
> The problem is, that when you put everything in one RADOS object, it
> might fill up a single OSD.
>
> For example, you have ten OSD's, all with a 500GB disk, this would give
> you 5TB of storage. But when you create a image of 1TB (which is mapped
> into a single RADOS object), this object would grow over 500GB and fill
> up that OSD.
>
> When splitting it into smaller object, these can be striped over the
> OSD's, giving you more space, but also more performance.

Okay, I'll think about it.

>> > Yes, the radosgw from Ceph is proof-of-concept, what RADOS/Ceph is
>> > capable of. Do you have your Walrus integration online somewhere?
>>
>> Well, currently my testing environment is on the internal network.
>> If you want to test it I can setup.
>
> Oh no, I meant the code to implement it into Walrus, is that available
> somewhere?

Oops, sorry I misunderstood.

I implemented it for Eucalyptus-2.0.0, wrote a little install document:
https://code.launchpad.net/~syuu/eucalyptus/rados4eucalyptus-2.0.0
http://r4eucalyptus.wikia.com/wiki/RADOS4Eucalyptus_Wiki

And now I'm trying to merge it to -devel tree of Eucalyptus, just sent
the diff at last Friday.
It's not clear that will be merged or not until I haven't received
reply, unfortunately.

syuu
