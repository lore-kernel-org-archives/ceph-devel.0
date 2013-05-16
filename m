From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Fix some little/big endian issues
Date: Wed, 15 May 2013 23:03:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305152303390.26171@cobra.newdream.net>
References: <1368629764-10838-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52952 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab3EPGDv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 02:03:51 -0400
In-Reply-To: <1368629764-10838-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Merged this into master, thanks!  Will backport after it cycles through 
qa.

sage


On Wed, 15 May 2013, Li Wang wrote:

> Ceph uses little endian, this patch fixes some endian issues
> while Ceph running on big endian machine.
> 
> Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
> Signed-off-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  src/include/encoding.h |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/src/include/encoding.h b/src/include/encoding.h
> index eb445e3..67c9af5 100644
> --- a/src/include/encoding.h
> +++ b/src/include/encoding.h
> @@ -88,11 +88,12 @@ inline void decode(bool &v, bufferlist::iterator& p) {
>  
>  #define WRITE_INTTYPE_ENCODER(type, etype)				\
>    inline void encode(type v, bufferlist& bl, uint64_t features=0) {	\
> -    __##etype e = init_##etype(v);					\
> +    ceph_##etype e;					                \
> +    e = v;                                                              \
>      encode_raw(e, bl);							\
>    }									\
>    inline void decode(type &v, bufferlist::iterator& p) {		\
> -    __##etype e;							\
> +    ceph_##etype e;							\
>      decode_raw(e, p);							\
>      v = e;								\
>    }
> @@ -338,7 +339,7 @@ inline void encode(const std::list<T>& ls, bufferlist& bl)
>        n++;
>        encode(*p, bl);
>      }
> -    __le32 en;
> +    ceph_le32 en;
>      en = n;
>      bl.copy_in(pos, sizeof(en), (char*)&en);
>    } else {
> @@ -373,7 +374,7 @@ inline void encode(const std::list<std::tr1::shared_ptr<T> >& ls, bufferlist& bl
>        n++;
>        encode(**p, bl);
>      }
> -    __le32 en;
> +    ceph_le32 en;
>      en = n;
>      bl.copy_in(pos, sizeof(en), (char*)&en);
>    } else {
> @@ -696,7 +697,8 @@ inline void decode(std::deque<T>& ls, bufferlist::iterator& p)
>    __u8 struct_v = v, struct_compat = compat;		     \
>    ::encode(struct_v, bl);				     \
>    ::encode(struct_compat, bl);				     \
> -  __le32 struct_len = 0;				     \
> +  ceph_le32 struct_len;				             \
> +  struct_len = 0;                                            \
>    ::encode(struct_len, bl);				     \
>    buffer::list::iterator struct_len_it = bl.end();	     \
>    struct_len_it.advance(-4);				     \
> -- 
> 1.7.9.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
