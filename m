From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 0/2] fix some compiler warnings
Date: Mon, 28 Jan 2013 15:23:47 -0800
Message-ID: <51070883.8040402@inktank.com>
References: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49819 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3A1XXv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 18:23:51 -0500
Received: by mail-pa0-f52.google.com with SMTP id kp6so127650pab.25
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 15:23:51 -0800 (PST)
In-Reply-To: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org

Sage merged these into master.  Thanks!

On 01/27/2013 12:57 PM, Danny Al-Gaaf wrote:
> Attached two patches to fix some compiler warnings.
>
> Danny Al-Gaaf (2):
>    utime: fix narrowing conversion compiler warning in sleep()
>    rbd: don't ignore return value of system()
>
>   src/include/utime.h |  2 +-
>   src/rbd.cc          | 36 ++++++++++++++++++++++++++++++------
>   2 files changed, 31 insertions(+), 7 deletions(-)
>
