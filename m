From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: why package ceph-fuse needs packages ceph?
Date: Mon, 26 Oct 2015 18:31:52 +0800
Message-ID: <562E0118.5000405@gmail.com>
References: <CAKZcxgdm9fQEDqV3=t36_YfxoejzxAyEUL6MNCXn0MwEzCGjkQ@mail.gmail.com>
 <alpine.DEB.2.00.1510260014500.3986@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36439 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634AbbJZKb5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 06:31:57 -0400
Received: by pacfv9 with SMTP id fv9so193362103pac.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Oct 2015 03:31:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510260014500.3986@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jaze Lee <jazeltq@gmail.com>, ceph-devel@vger.kernel.org

Hi Sage,

Here comes another question, does ceph-fuse support Unix OS(like HP-UNIX 
or AIX)?

Thanks,
Jevon
On 26/10/15 15:19, Sage Weil wrote:
> On Mon, 26 Oct 2015, Jaze Lee wrote:
>> Hello,
>>      I think the ceph-fuse is just a client, why it needs packages ceph?
>>      I found when i install ceph-fuse, it will install package ceph.
>>      But when i install ceph-common, it will not install package ceph.
>>
>>      May be ceph-fuse is not just a ceph client?
>>
> It is, and the Debian packaging works as expected.  This is a simple
> error in the spec file.  I'll submit a patch.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

