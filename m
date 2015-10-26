From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: why package ceph-fuse needs packages ceph?
Date: Mon, 26 Oct 2015 20:48:23 +0800
Message-ID: <CAAM7YAkQo985xG1ctnheoQn4Vq4pA4nmDa1tZAW9yJq+vO1T0g@mail.gmail.com>
References: <CAKZcxgdm9fQEDqV3=t36_YfxoejzxAyEUL6MNCXn0MwEzCGjkQ@mail.gmail.com>
	<alpine.DEB.2.00.1510260014500.3986@cobra.newdream.net>
	<562E0118.5000405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33225 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbbJZMsZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 08:48:25 -0400
Received: by lffv3 with SMTP id v3so146538201lff.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 05:48:23 -0700 (PDT)
In-Reply-To: <562E0118.5000405@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jevon Qiao <scaleqiao@gmail.com>
Cc: Sage Weil <sage@newdream.net>, Jaze Lee <jazeltq@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 26, 2015 at 6:31 PM, Jevon Qiao <scaleqiao@gmail.com> wrote:
> Hi Sage,
>
> Here comes another question, does ceph-fuse support Unix OS(like HP-UNIX or
> AIX)?

It supports OSX and FreeBSD. (I tested it a few weeks ago. current
development branch may require some minor modification)

>
> Thanks,
> Jevon
>
> On 26/10/15 15:19, Sage Weil wrote:
>>
>> On Mon, 26 Oct 2015, Jaze Lee wrote:
>>>
>>> Hello,
>>>      I think the ceph-fuse is just a client, why it needs packages ceph?
>>>      I found when i install ceph-fuse, it will install package ceph.
>>>      But when i install ceph-common, it will not install package ceph.
>>>
>>>      May be ceph-fuse is not just a ceph client?
>>>
>> It is, and the Debian packaging works as expected.  This is a simple
>> error in the spec file.  I'll submit a patch.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
