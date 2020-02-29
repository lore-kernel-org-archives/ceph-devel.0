From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: unsafe list walking in __kick_flushing_caps?
Date: Sat, 29 Feb 2020 10:34:13 +0800
Message-ID: <30fddf35-49ff-3009-f6a8-fd4ea6c65e05@redhat.com>
References: <4a4d32dc5c4a44cca4ed31bb66d9cfcb0b1092c7.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgB2CeW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2020 21:34:22 -0500
In-Reply-To: <4a4d32dc5c4a44cca4ed31bb66d9cfcb0b1092c7.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2/29/20 5:39 AM, Jeff Layton wrote:
> Hi Zheng,
> 
> I've been going over the cap handling code, and noticed some sketchy
> looking locking in __kick_flushing_caps that was added by this patch:
> 
> 
> commit e4500b5e35c213e0f97be7cb69328c0877203a79
> Author: Yan, Zheng <zyan@redhat.com>
> Date:   Wed Jul 6 11:12:56 2016 +0800
> 
>      ceph: use list instead of rbtree to track cap flushes
>      
>      We don't have requirement of searching cap flush by TID. In most cases,
>      we just need to know TID of the oldest cap flush. List is ideal for this
>      usage.
>      
>      Signed-off-by: Yan, Zheng <zyan@redhat.com>
> 
> While walking ci->i_cap_flush_list, __kick_flushing_caps drops and
> reacquires the i_ceph_lock on each iteration. It looks like
> __kick_flushing_caps could (e.g.) race with a reply from the MDS that
> removes the entry from the list. Is there something that prevents that
> that I'm not seeing?
>

I think it's protected by s_mutex. I checked the code only
ceph_kick_flushing_caps() is not protected by s_mutex. it should be 
easy to fix.

> Thanks,
> 
