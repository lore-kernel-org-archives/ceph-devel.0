From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: fix sizeof(struct tYpO *) typo
Date: Fri, 25 Jul 2014 10:53:59 -0500
Message-ID: <53D27D97.4040700@ieee.org>
References: <1406280385-30275-1-git-send-email-ilya.dryomov@inktank.com>	<53D25310.4090001@ieee.org> <CALFYKtC34zP_EijD4ewyzkBAC7OK8fJH7sFsT2vuqnEEGQY-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:64793 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbaGYPx7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 11:53:59 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn18so994816igb.9
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 08:53:58 -0700 (PDT)
In-Reply-To: <CALFYKtC34zP_EijD4ewyzkBAC7OK8fJH7sFsT2vuqnEEGQY-xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yan Zheng <zheng.z.yan@intel.com>

On 07/25/2014 08:27 AM, Ilya Dryomov wrote:
> On Fri, Jul 25, 2014 at 4:52 PM, Alex Elder <elder@ieee.org> wrote:
>> On 07/25/2014 04:26 AM, Ilya Dryomov wrote:
>>> struct ceph_xattr -> struct ceph_inode_xattr
>>
>> Looks good.  I can't find the definition of ceph_xattr.
> 
> That's the point of the patch ;)

Well, I thought the point was that the type was
wrong; I was surprised that the type was non-existent.

					-Alex

> Thanks,
> 
>                 Ilya
> 

