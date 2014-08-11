From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RadosGW storage format
Date: Mon, 11 Aug 2014 10:27:24 -0700
Message-ID: <CABBk=J-bk60c4aq4ACR9bFPbSzwAVXcePG5as2V2DcH=JSdsBg@mail.gmail.com>
References: <CAF6-1L5XC+dFeOAx3bV34qL8T=cFif1xPg=o_L=NotZO4ehx+A@mail.gmail.com>
	<CABBk=J8UUxTPgQ7uprpVMs2nQea9m78_bezNBMxqV7_ShCwu8g@mail.gmail.com>
	<CAF6-1L5_N6UyP-xa0Z4Mo2G=NdFPC-mvAO7EDp3KG1gEaLPtOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:62808 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaHKR1Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 13:27:25 -0400
Received: by mail-ie0-f169.google.com with SMTP id rd18so10251822iec.14
        for <ceph-devel@vger.kernel.org>; Mon, 11 Aug 2014 10:27:24 -0700 (PDT)
In-Reply-To: <CAF6-1L5_N6UyP-xa0Z4Mo2G=NdFPC-mvAO7EDp3KG1gEaLPtOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 8, 2014 at 8:57 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
>> I don't think there's one document that describes everything.
>> Definitely not one that is up to date. It would really be great to
>> have something like that. Some of the stuff was described in messages
>> to the mailing list when it was conceived, but things have since might
>> have gone major revisions and changes.
>> As a starting point, I can provide a few pointers.
>
> Thanks a lot for the detailed explanation !
>
> Another question though : How are object listed ? It is just the
> .dir.xxx objects that "represent" the bucket by itself ?
>

There are a few objects that are created for every bucket, but at the
moment the .dir.xxx object contains the list of objects.
>
>
>>  - what rados features are used
>>
>> This is a very general question and it is hard to answer. Can you be
>> more specific?
>>
>
> Like: Does it only use rados object and their content, or does it also
> use the xattr on them, or what about the omap key/val ?
>
rgw objects are contained in rados objects, and we use xattrs to hold
objects metadata. The gateway does not use omap explicitly on the
objects themselves.

>
> I'm looking into doing a couple of maintenance tools for it like a
> fsck that checks different things, or also a tool that allows me to
> move a bucket(s) from one pool to another, or merge two pools.

Bucket index pools or data pools? If it's the latter then you'll end
up copying data anyway.


Yehuda

>
> Due to some "bad" decisions in the beginning, we ended up with too
> many pools (and so too much PGs, causing stress on the OSD) and I'd
> like the option to merge them at some point without having to go
> through the S3 interface (it would double the network xfer required
> and also modify the mtime of all the objects which I'm hoping I can
> keep intact with direct rados ops).
>
> But to do all of this, I need to know exactly what needs copying :p
>
>
> Cheers,
>
>    Sylvain
