From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: fix sizeof(struct tYpO *) typo
Date: Fri, 25 Jul 2014 17:27:31 +0400
Message-ID: <CALFYKtC34zP_EijD4ewyzkBAC7OK8fJH7sFsT2vuqnEEGQY-xg@mail.gmail.com>
References: <1406280385-30275-1-git-send-email-ilya.dryomov@inktank.com>
	<53D25310.4090001@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:45920 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759996AbaGYN1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 09:27:31 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so4482275qab.8
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 06:27:31 -0700 (PDT)
In-Reply-To: <53D25310.4090001@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Yan Zheng <zheng.z.yan@intel.com>

On Fri, Jul 25, 2014 at 4:52 PM, Alex Elder <elder@ieee.org> wrote:
> On 07/25/2014 04:26 AM, Ilya Dryomov wrote:
>> struct ceph_xattr -> struct ceph_inode_xattr
>
> Looks good.  I can't find the definition of ceph_xattr.

That's the point of the patch ;)

Thanks,

                Ilya
