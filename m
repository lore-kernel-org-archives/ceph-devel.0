From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 0/3] fix some rbd-fuse related issues
Date: Mon, 28 Jan 2013 15:23:10 -0800
Message-ID: <5107085E.9010603@inktank.com>
References: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de> <DF8EC7BE-68C4-46B9-8F42-4F32165458A7@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43342 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3A1XXO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 18:23:14 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so1782796pbc.7
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 15:23:13 -0800 (PST)
In-Reply-To: <DF8EC7BE-68C4-46B9-8F42-4F32165458A7@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Actually Sage merged them into master.  Thanks again.

On 01/28/2013 09:45 AM, Dan Mick wrote:
> Thanks Danny, I'll look at these today.
>
> On Jan 28, 2013, at 7:33 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
>
>> Here three patches to fix some issues with the new rbd-fuse
>> code and an issues with the fuse handling in configure.
>>
>> Danny Al-Gaaf (3):
>>   configure: fix check for fuse_getgroups()
>>   rbd-fuse: fix usage of conn->want
>>   rbd-fuse: fix printf format for off_t and size_t
>>
>> configure.ac            |  8 ++++----
>> src/rbd_fuse/rbd-fuse.c | 12 +++++++-----
>> 2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> --
>> 1.8.1.1
>>
