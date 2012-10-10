From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 14:47:09 -0400
Message-ID: <CACkq2mo02-N6h3fZXyXdhN0d-XOKha7E9=W5eECFuo4NXSTbkw@mail.gmail.com>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
 <CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com> <CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60204 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab2JJSra (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 14:47:30 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so669488qch.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 11:47:30 -0700 (PDT)
In-Reply-To: <CAPYLRzja7=nnk4pp0=YGL4AhxVKdnM91U1W4GD5qcoORw+oKDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: Damien Churchill <damoxc@gmail.com>, ceph-devel@vger.kernel.org

Thanks for the input, Gregory and Josh.

What I am hearing is that this has everything to do with the
filesystem, and nothing to do with the block device on Ceph.

Thanks again,

 - Travis

On Wed, Oct 10, 2012 at 1:55 PM, Gregory Farnum <greg@inktank.com> wrote:
> I don't know the ext4 internals at all, but filesystems tend to
> require allocation tables of various sorts (for managing extents,
> etc). 7.5GB out of 500GB seems a little large for that metadata, but
> isn't ridiculously so...
>
> On Wed, Oct 10, 2012 at 10:28 AM, Damien Churchill <damoxc@gmail.com> wrote:
>> On 10 October 2012 18:10, Travis Rhoden <trhoden@gmail.com> wrote:
>>> Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
>>> the huge discrepancy?  I don't expect the numbers to add up exact due
>>> to rounding from kB, MB, GB, etc, but they should be darn close, a la
>>
>> ext4 keeps some reserved space, 5% by default, for when the disk is
>> full so you are still able to use the filesystem and clean it up.
>>
>> 500G * 0.05 = 25G
>> 500G - (25G + 7.5G) = 467G
>>
>> Can't tell you where the 7.5G comes from though!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
