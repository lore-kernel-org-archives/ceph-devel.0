From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 03/16] libceph: define ceph_decode_string()
Date: Wed, 11 Jul 2012 10:13:53 -0700
Message-ID: <CAC-hyiEx3CRpGT6SNp3TD48FLVBFysHMss84BG8xzONhU63_Rw@mail.gmail.com>
References: <4FFD847C.7070205@inktank.com>
	<4FFD871B.6020704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62847 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab2GKRNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 13:13:54 -0400
Received: by bkwj10 with SMTP id j10so1361225bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 10:13:53 -0700 (PDT)
In-Reply-To: <4FFD871B.6020704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, Jul 11, 2012 at 7:00 AM, Alex Elder <elder@inktank.com> wrote:
> There is no string decoding function defined in <decode.h>, so this
> defines one.
>
> This function is a little different from the others in that the
> length of the encoded string is not known a priori.  So the
> interface is defined a bit like snprintf(), where the value returned
> indicates the space required--even if it's more than the space
> allotted.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  include/linux/ceph/decode.h |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
> index bcbd66c..7ead11fc 100644
> --- a/include/linux/ceph/decode.h
> +++ b/include/linux/ceph/decode.h
> @@ -44,6 +44,42 @@ static inline void ceph_decode_copy(void **p, void
> *pv, size_t n)
>  }
>
>  /*
> + * Decode the wire-encoded string at *p into the buffer "s"
> + * provided, whose size is indicated by "size".  Note that "s" can
> + * be a null pointer if size is 0.  If it fits, the resulting string
> + * will always be terminated with '\0'; otherwise the buffer will
> + * be unchanged.
> + *
> + * Returns the length of the encoded string (which may be greater
> + * than or equal to the buffer size).  The return value does not
> + * include the terminating '\0'.
> + *
> + * If the the return value is less than the size provided, *p will
> + * be advanced past the decoded data; otherwise it is unchanged.
> + * This allows for a two call sequence to be used to allocate
> + * sufficient space for the string.
> + *
> + * NB  It is assumed that *p refers to a block of valid memory
> + *     sufficient to hold the length field followed by the number
> + *     of bytes indicated by that field.
> + */
> +static inline size_t ceph_decode_string(void **p, char *s, size_t size)
> +{
> +       size_t len;
> +
> +       len = get_unaligned_le32(*p);
> +       if (size < len + 1)
> +               return len;
> +
> +       if (len)
> +               memcpy(s, (char *) *p + sizeof (u32), len);
> +       *(s + len) = '\0';
> +       *p += sizeof (u32) + len;
> +
> +       return len;
> +}
> +
> +/*
>   * bounds check input.
>   */
>  static inline int ceph_has_room(void **p, void *end, size_t n)
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
