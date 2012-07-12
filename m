From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v3 04/16] libceph: define ceph_extract_encoded_string()
Date: Thu, 12 Jul 2012 11:20:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207121117140.693@cobra.newdream.net>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com> <4FFDF9B8.5040401@inktank.com> <4FFF05D4.9080006@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47316 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab2GLSUW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 14:20:22 -0400
In-Reply-To: <4FFF05D4.9080006@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 12 Jul 2012, Alex Elder wrote:
> This adds a new utility routine which will return a dynamically-
> allocated buffer containing a string that has been decoded from ceph
> over-the-wire format.  It also returns the length of the string
> if the address of a size variable is supplied to receive it.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v3: Final version.  Sage convinced me that there was no need for
>     ceph_decode_string() other than its use in this function, so
>     now this implements what that function had been doing directly.
> 
>  include/linux/ceph/decode.h |   44
> ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> Index: b/include/linux/ceph/decode.h
> ===================================================================
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -85,6 +85,50 @@ static inline int ceph_has_room(void **p
>  	} while (0)
> 
>  /*
> + * Allocate a buffer big enough to hold the wire-encoded string, and
> + * decode the string into it.  The resulting string will always be
> + * terminated with '\0'.  If successful, *p will be advanced
> + * past the decoded data.  Also, if lenp is not a null pointer, the
> + * length (not including the terminating '\0') will be recorded in
> + * *lenp.  Note that a zero-length string is a valid return value.
> + *
> + * Returns a pointer to the newly-allocated string buffer, or a null
> + * pointer if an error occurs.  Neither *p nor *lenp will have been
> + * updated if NULL is returned.
> + *
> + * There are two possible failures:
> + *   - converting the string would require accessing memory at or
> + *     beyond the "end" pointer provided
> + *   - memory could not be allocated for the result

I think the caller should be able to distinguish between these two cases 
in the return value.  What about:

> + */
> +static inline char *ceph_extract_encoded_string(void **p, void *end,
> +						size_t *lenp, gfp_t gfp)


int ceph_extract_encoded_string(void **p, void *end, char **str, gfp_t gfp)

and return the length, or an error code?  That avoids futzing with ERR_PTR 
and gives you the len a bit less awkwardly...

sage


> +{
> +	u32 len;
> +	void *sp = *p;
> +	char *buf = NULL;
> +
> +	ceph_decode_32_safe(&sp, end, len, out);
> +	if (!ceph_has_room(&sp, end, len))
> +		return NULL;
> +
> +	buf = kmalloc(len + 1, gfp);
> +	if (!buf)
> +		return NULL;
> +
> +	if (len)
> +		memcpy(buf, sp, len);
> +	buf[len] = '\0';
> +
> +	*p = (char *) *p + sizeof (u32) + len;
> +
> +	if (lenp)
> +		*lenp = (size_t) len;
> +out:
> +	return buf;
> +}
> +
> +/*
>   * struct ceph_timespec <-> struct timespec
>   */
>  static inline void ceph_decode_timespec(struct timespec *ts,
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
