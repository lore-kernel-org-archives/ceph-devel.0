From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 10/33] libceph: fixup error handling in osdmap_apply_incremental()
Date: Fri, 28 Mar 2014 16:58:23 +0200
Message-ID: <CALFYKtCZVTdsCiGVgzD=mWbOi=S-KfJNUvNmKyWcwM2tEaOZHQ@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-11-git-send-email-ilya.dryomov@inktank.com>
	<533480CC.5060707@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:47009 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbaC1O6Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 10:58:24 -0400
Received: by mail-qg0-f53.google.com with SMTP id z60so983008qgd.40
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 07:58:23 -0700 (PDT)
In-Reply-To: <533480CC.5060707@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 9:49 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:17 PM, Ilya Dryomov wrote:
>> The existing error handling scheme requires resetting err to -EINVAL
>> prior to calling any ceph_decode_* macro.  This is ugly and fragile,
>> and there already are a few places where we would return 0 on error,
>> due to a missing reset.  Follow osdmap_decode() and fix this by adding
>> a special e_inval label to be used by all ceph_decode_* macros.
>
> Same comments as last time.  Otherwise, looks good.

Replied to the osdmap_decode() comment.

Thanks,

                Ilya
