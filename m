From: Florian Haas <florian@hastexo.com>
Subject: Re: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Mon, 14 Jan 2013 14:41:56 +0100
Message-ID: <CAPUexz8c4rOB3C=K8E8yWQudQbXh1o5h1f4AATX0OLfv2sMWMQ@mail.gmail.com>
References: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
	<B1D1B77B-F5D7-4048-9C07-CDC9EEB3F224@netspot.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:60609 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab3ANNl5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 08:41:57 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so3542022iad.41
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 05:41:56 -0800 (PST)
In-Reply-To: <B1D1B77B-F5D7-4048-9C07-CDC9EEB3F224@netspot.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Lanyon <tom@netspot.com.au>
Cc: ceph-devel@vger.kernel.org

Hi Tom,

On Mon, Jan 14, 2013 at 2:28 PM, Tom Lanyon <tom@netspot.com.au> wrote:
> On 14/01/2013, at 10:47 PM, Florian Haas <florian@hastexo.com> wrote:
> <snip>
>> http://www.hastexo.com/resources/hints-and-kinks/solid-state-drives-and-ceph-osd-journals
>>
>> It's probably easiest to comment directly on that page, but if you
>> prefer instead to just respond in this thread, that's perfectly fine
>> too.
> <snip>
>
>
> Hi Florian,
>
> Thanks for putting this together.

Pleasure!

> A couple of minor questions/comments:
>
> * One of the conclusions is to use the SSDs (assuming 2) un-RAIDed, but the article doesn't actually explain why using them in a RAID-1 is a poor idea.

Added paragraph starting with "putting your journal SSDs in a RAID set
looks like a good idea at first", does that explain the situation
better?

> * Should the end of this sentence:
>         "Another option is to use, say, one partition on each of your SSD in a RAID for the operating system installation, and then chop up the rest of your SSDs an non-RAIDed Ceph OSDs."
>
> ...instead read:
>
>         "Another option is to use, say, one partition on each of your SSD in a RAID for the operating system installation, and then chop up the rest of your SSDs an non-RAIDed Ceph **OSD journals**." ?

Sure. Fixed.

Btw: coming to LCA? If you are, please find me and say hello. :)

Cheers,
Florian

-- 
Helpful information? Let us know!
http://www.hastexo.com/shoutbox
