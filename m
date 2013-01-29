From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 1/2] utime: fix narrowing conversion compiler warning
 in sleep()
Date: Tue, 29 Jan 2013 12:52:36 +0100
Message-ID: <5107B804.5020306@bisect.de>
References: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de> <1359320252-2445-2-git-send-email-danny.al-gaaf@bisect.de>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43072 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755917Ab3A2Lwk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Jan 2013 06:52:40 -0500
In-Reply-To: <1359320252-2445-2-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Hi,

could someone cherry-pick this patch to the bobtail branch? I see the
same issue there.

Thanks!

Danny


Am 27.01.2013 21:57, schrieb Danny Al-Gaaf:
> Fix compiler warning:
> ./include/utime.h: In member function 'void utime_t::sleep()':
> ./include/utime.h:139:50: warning: narrowing conversion of
>  '((utime_t*)this)->utime_t::tv.utime_t::<anonymous struct>::tv_sec' from
>  '__u32 {aka unsigned int}' to '__time_t {aka long int}' inside { } is
>  ill-formed in C++11 [-Wnarrowing]
> ./include/utime.h:139:50: warning: narrowing conversion of
>  '((utime_t*)this)->utime_t::tv.utime_t::<anonymous struct>::tv_nsec' from
>  '__u32 {aka unsigned int}' to 'long int' inside { } is
>  ill-formed in C++11 [-Wnarrowing]
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/include/utime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/include/utime.h b/src/include/utime.h
> index 526dec5..f433fff 100644
> --- a/src/include/utime.h
> +++ b/src/include/utime.h
> @@ -136,7 +136,7 @@ public:
>    }
>  
>    void sleep() {
> -    struct timespec ts = { tv.tv_sec, tv.tv_nsec };
> +    struct timespec ts = { (__time_t)tv.tv_sec, (long)tv.tv_nsec };
>      nanosleep(&ts, &ts);
>    }
>  
> 

