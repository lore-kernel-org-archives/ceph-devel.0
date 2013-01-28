From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [PATCH 0/2] fix some compiler warnings
Date: Mon, 28 Jan 2013 10:47:34 -0800
Message-ID: <0F30AF19-99C9-479D-A457-A93A43CEDF92@inktank.com>
References: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:39264 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3A1Srm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 13:47:42 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so1680633pad.31
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jan 2013 10:47:42 -0800 (PST)
In-Reply-To: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

I'd just noticed utime on my laptop 32-bit build and was trying to figure out why our 32-bit nightly didn't see it. And Greg had seen the system build problem where I didn't, and I was isolating differences there as well. 

I purposely didn't spend time on the system() error handling because I was thinking of those calls as best-effort, if they fail the map will likely fail anyway, but there's no harm in handling errors, particularly if it'll shit the compiler up :)

On Jan 27, 2013, at 12:57 PM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:

> Attached two patches to fix some compiler warnings.
> 
> Danny Al-Gaaf (2):
>  utime: fix narrowing conversion compiler warning in sleep()
>  rbd: don't ignore return value of system()
> 
> src/include/utime.h |  2 +-
> src/rbd.cc          | 36 ++++++++++++++++++++++++++++++------
> 2 files changed, 31 insertions(+), 7 deletions(-)
> 
> -- 
> 1.8.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
