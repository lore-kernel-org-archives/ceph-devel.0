From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/8] include/buffer.h: fix operator=
Date: Tue, 5 Feb 2013 21:47:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302052146570.22404@cobra.newdream.net>
References: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de> <1360104750-16098-5-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37358 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab3BFFr7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 00:47:59 -0500
In-Reply-To: <1360104750-16098-5-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>

On Tue, 5 Feb 2013, Danny Al-Gaaf wrote:
> Fix operator=: return "iterator&" instead of 'iterator'. Also set last_p and
> other.append_buffer and check if 'this' equals 'other' before set anything.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  src/include/buffer.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/src/include/buffer.h b/src/include/buffer.h
> index 9a635bd..448d947 100644
> --- a/src/include/buffer.h
> +++ b/src/include/buffer.h
> @@ -248,7 +248,7 @@ public:
>  					p(other.p),
>  					p_off(other.p_off) {}
>  
> -      iterator operator=(const iterator& other) {
> +      iterator& operator=(const iterator& other) {
>  	if (this != &other) {
>  	  bl = other.bl;
>  	  ls = other.ls;
> @@ -305,8 +305,12 @@ public:
>      
>      list(const list& other) : _buffers(other._buffers), _len(other._len), last_p(this) { }
>      list& operator= (const list& other) {
> -      _buffers = other._buffers;
> -      _len = other._len;
> +      if (this != &other) {
> +        _buffers = other._buffers;
> +        _len = other._len;
> +        last_p = other.last_p;
> +	append_buffer = other.append_buffer;

These two fields shouldn't be copied.  append_buffer is a private buffer 
we are writing into when we call the encode() helpers, and having two 
lists sharing it would allow them to clobber each other in hard-to-debug 
ways.  last_p is in the same category.

> +      }
>        return *this;
>      }
>  
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
