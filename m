From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 11:34:13 -0600
Message-ID: <7b337443-f6bc-d005-a17b-43bd11481f04@redhat.com>
References: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752020AbcLOReO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Dec 2016 12:34:14 -0500
In-Reply-To: <ce95a133-7fae-34fc-b493-fbabdc272c55@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 12/15/2016 11:24 AM, Igor Fedotov wrote:
> Sage et al,
>
> shouldn't we have bluestore_cache_metadata_ratio set to 1 by default? To
> concentrate on metadata caching..

I would contend that it should be high (we've already bumped it up, I'd 
go higher still), but isn't 1 a little excessive?  Ultimately this 
should all be automatic based on heuristics imho.

>
> IMHO Onode caching is much more important and profitable than user data
> one. It's rather a client misbehavior to cause cache hit when accessing
> user data but it's  highly expected for onode metadata.

We should take care not to run into the same problem the kernel does. 
With too many cached entries things can get slow.  It's another 
trade-off we need to watch out for.  There may need to be a (hopefully 
automatically generated) soft limit, and potentially a hard limit.

>
> Moreover user data caching is probably already exists at block device
> level hence we rather duplicate disk cache....
>
> What do you think?
>
> Thanks,
>
> Igor
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
