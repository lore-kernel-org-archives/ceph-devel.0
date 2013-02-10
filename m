From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 5/6] SyntheticClient.cc: fix some memory leaks in the
 error handling
Date: Sat, 9 Feb 2013 22:04:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302092203440.11665@cobra.newdream.net>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de> <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54249 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab3BJGEN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 01:04:13 -0500
In-Reply-To: <1360340703-7170-6-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Fri, 8 Feb 2013, Danny Al-Gaaf wrote:
> Fix some memory leaks in case of error handling due to failed
> client->open() calls.
> 
> Error from cppcheck was:
> [src/client/SyntheticClient.cc:1980]: (error) Memory leak: buf
> [src/client/SyntheticClient.cc:2040]: (error) Memory leak: buf
> [src/client/SyntheticClient.cc:2090]: (error) Memory leak: buf
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/client/SyntheticClient.cc | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/src/client/SyntheticClient.cc b/src/client/SyntheticClient.cc
> index b2a936f..0da8bed 100644
> --- a/src/client/SyntheticClient.cc
> +++ b/src/client/SyntheticClient.cc
> @@ -1977,7 +1977,10 @@ int SyntheticClient::write_file(string& fn, int size, loff_t wrsize)   // size i
>  
>    int fd = client->open(fn.c_str(), O_RDWR|O_CREAT);
>    dout(5) << "writing to " << fn << " fd " << fd << dendl;
> -  if (fd < 0) return fd;
> +  if (fd < 0) {
> +    delete[] buf;
> +    return fd;
> +  }
>    
>    utime_t from = ceph_clock_now(g_ceph_context);
>    utime_t start = from;
> @@ -2037,7 +2040,10 @@ int SyntheticClient::write_fd(int fd, int size, int wrsize)   // size is in MB,
>    uint64_t chunks = (uint64_t)size * (uint64_t)(1024*1024) / (uint64_t)wrsize;
>  
>    //dout(5) << "SyntheticClient::write_fd: writing to fd " << fd << dendl;
> -  if (fd < 0) return fd;
> +  if (fd < 0) {
> +    return fd;
> +    delete[] buf;

oops, wrong order...

> +  }
>  
>    for (unsigned i=0; i<chunks; i++) {
>      if (time_to_stop()) {
> @@ -2087,7 +2093,10 @@ int SyntheticClient::read_file(const std::string& fn, int size,
>  
>    int fd = client->open(fn.c_str(), O_RDONLY);
>    dout(5) << "reading from " << fn << " fd " << fd << dendl;
> -  if (fd < 0) return fd;
> +  if (fd < 0) {
> +    return fd;
> +    delete[] buf;

here too!

> +  }
>  
>    utime_t from = ceph_clock_now(g_ceph_context);
>    utime_t start = from;
> -- 
> 1.8.1.2
> 
> 
