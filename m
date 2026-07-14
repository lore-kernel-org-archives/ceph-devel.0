Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACBF25783C
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999065; cv=pass; b=sYD9PlVv4iSnr5RljWfgTlZjOYngZq5FFgQtWyfY4jeMt0nTOkjOOfnQZEGvURrA1ymQ2kuZhlbmNYth9bU+5fRAC9LwifKKDqGEhpA4lJ6mz191DND1Nmea35Vk183Tn0GPRDpfvV8bZ5OLGFQ5zhnNdPAQzEenUFivfKPHqdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999065; c=relaxed/simple;
	bh=/tvioB5L1wmO61WMM8Edoyy0r/mT4ad6Q2xD6UeNtSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJZj1nELdmNQNbIX8tSTnGvm+UUlHdCd+/+uo4YZOOqEXBH3GCyofjc7RVZ4nSJseglwv5MEHg0CJ1I50Ke8baS8xS2GvEDsKK20yjjzqiWnnONoxaPUfcTrqhWI3FWHj8x7ZILKtqM4j0aE7b6o+g5pdD9myxDAI41y2+bt3IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=SzgpBkwP; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="SzgpBkwP"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso533508a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 20:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783999061; cv=none;
        d=google.com; s=arc-20260327;
        b=QjW7s7CzAT5PS2UndPo2WGMiyzjT8IOg441E3pfisgngmobi2gvY+CHEncPe2a7Itv
         b+cGwJ0DmlIAIgAWlFMMNXc4f3gaJstfpkfF6j4TUdHn2Jg6XXwETnv5hzoIqZpPdq/w
         lowES2OCHE+mtWrwstSWe8VIVMgaNNgwH7epSs5U3XERM7YxyvElIPzIGdNBmeC9TJBN
         qZPf8tKPWbHmF8zZovTPqeuaWJGH5dpuBYoYPrWN7wJeHAxunq7tpSc5x08meHJiKwBT
         eOFiJP8piwRGsm2C23hySlGScGGI24ZOS2hRABDsUONyyiIWRYTMAWflkdU8lEVJidso
         93rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fagARKoAAxo3rj51kgE4juqTEUuN5lNjSeLyhfpmRDg=;
        fh=QakNoIeExC3YD1Mwx7BqTBiwNoySi6Sh1/4FibovBYw=;
        b=cK+OiO8eso8Ve1Dz0yfINmTaXu6vdz+p4OzJB1BcogOutDqnXXfsy+bcw3JIocolEv
         neNPxjeel/SIMK8DCG6VfIrcsEqBI81myBCjjpvy3/5Y2K5E4AZz8LIVssVrvuQAAtkO
         hrbLL1A+Gq4WWxuj3dEZhxVe+amF2o9k0pEFhQY5M4er8c9BRBUxJx1GVBHFMl5VhmBr
         4PrAW3uxfDwWa60ZxvhvN060jra6m+BhK96w5lW3jDwrfangx3nuyLMk90uOE2uvxdi/
         rVspp+IK405u28Zlh3gOngE6JiGMOhqo8UvLzXD0iGVIP8KZ+HyZtGWyTBym0KDpt4Hf
         KL2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1783999061; x=1784603861; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fagARKoAAxo3rj51kgE4juqTEUuN5lNjSeLyhfpmRDg=;
        b=SzgpBkwPuCAkU13ldT4nesAZS1k/5P4qmsCzuNjI4k9s1enFSktUeywgPXId/Fs9rv
         K6J3m/0k8ZvZ6o1h6X5DNFedlH5fh2NN4BbM3+BCDoIcLPSzy82ykv9wpPwc/8IbC0Vi
         vtNX2nfbtHiFk6UZaLhQrhpf47TrfDcFr3aNGGEh/+bYbuq04WRz6n5rB8cfy0z2dHGs
         ZOWE+CeF3365hoUVlxLGo6BXbHG7cVato+4zwJmVPdSrqF3AASUHxCNF+t5/i4rCsx73
         HLqdUWXjzEAebTRqBsIXLnNOlZDQQynVnO5deewLSYU3dg9hLXtZYVsNhWoiIVd2XID5
         VnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783999061; x=1784603861;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fagARKoAAxo3rj51kgE4juqTEUuN5lNjSeLyhfpmRDg=;
        b=n9x5q80m8gREdDQOIdzzfr7nBJ0zvuiXEPh/IrceRjQClvmu8WsJbed2B/i7yGpMH2
         OwPlpS9eCYpPJnntRDjlw9G45S7ZWTxsgpG3fDsPOT30GOd49IuzE4YM6aPhpmF7aECr
         RAgmXDjsnPeY1wKozLswnIZwRGx0XapSqw3degcnsNlhUp05zKfZPjZHFDc4sdmoGCac
         a8iiKmRQ+27VOjCU2+kcPI0oOWHV40uMG1spqsXo1nrPm9HV1kWnI6V9zauWOHC4+ev8
         nJXwsTaoaXvumyE9voCzJDayOL6MvLmpI2RTPHJI2iBrikRGD80MZhRwoanqLmAyqVzM
         u8qA==
X-Gm-Message-State: AOJu0Yw/9DRmNrtA3TSiL9RfEqBEJUk+2+/iOn/mHWlS0JazYA59FRHF
	K3pj9toYNKAn5ys1fDPFmqIiGckkR4YrUQSzr7/YpLGzd5ZpKbssDCNfal1tGNfXQmmHBAP0qcV
	+IjWt1UfTuId+q/TopAxQ4NJsEYl9fSZ2SxtF8hL+QA==
X-Gm-Gg: AfdE7cluETa20636XNwcfep20Ph1eiexzDN9gw/xLf0z27LQFNDGR8bi/JR6tLFVYQE
	ra6Osu9K9Wrl29qMQk8QkKiwYfMYct4EZeO0itBMPRdE/ZEwlI/AyQS4ZCIuEXgU3qI6WLlNmX8
	Wf44UVG/aghOU5yaaGrtJgVNeOkukNaVP5yMIhpeeYK26naT8j46qpEIMAaNuVsSRvbrSmdh9Kd
	Q9JHB6X2qkM0pVPjR0qLCE2ZRreqXI61lpdPQYwJuwjQP3flHxXEZOmjAptKUM3vN2zWQ==
X-Received: by 2002:a17:907:3d11:b0:c16:5bec:c844 with SMTP id
 a640c23a62f3a-c165beccfbfmr127476066b.22.1783999060798; Mon, 13 Jul 2026
 20:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143843.1980879-1-amarkuze@redhat.com> <20260706143843.1980879-2-amarkuze@redhat.com>
In-Reply-To: <20260706143843.1980879-2-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 14 Jul 2026 11:17:28 +0800
X-Gm-Features: AUfX_myHSmHk2FkK9tPbsGfwDyu9JeScgYfH1eEPQ0yNSo24EimNeM1j9hVs42I
Message-ID: <CAOJNxRJ9xqNRRumZdwAkQD=twTKkfn_8xwO+UKhXw4dVm=DADg@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] ceph: add BLOG public headers
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Mon, 6 Jul 2026 at 22:38, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Add the public header files for the binary logging (BLOG) subsystem:
>
>   blog.h          - core types: blog_logger, blog_log_entry,
>                     blog_tls_ctx, blog_source_info, blog_log_iter,
>                     blog_source_id_cache; core API prototypes
>   blog_ser.h      - type-safe serialization macros (blog_ser,
>                     blog_cnt) with compile-time type dispatch
>   blog_des.h      - deserialization prototypes
>   blog_batch.h    - per-CPU magazine batch allocator types
>   blog_pagefrag.h - page-fragment allocator types
>   blog_module.h   - per-module context types (blog_task_entry,
>                     blog_module_context) and the __BLOG_LOG_CTX
>                     macro that drives the per-callsite fast path
>

[......]

> +int blog_pagefrag_init_with_buffer(struct blog_pagefrag *pf, void *buffer, size_t size);
> +int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n);
> +void blog_pagefrag_publish(struct blog_pagefrag *pf, u64 publish_head);
> +void blog_pagefrag_reset(struct blog_pagefrag *pf);
> +void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val);
> +
> +#endif /* _LINUX_CEPH_BLOG_PAGEFRAG_H */
> diff --git a/include/linux/ceph/blog_ser.h b/include/linux/ceph/blog_ser.h
> new file mode 100644
> index 000000000000..1d570388ff09
> --- /dev/null
> +++ b/include/linux/ceph/blog_ser.h
> @@ -0,0 +1,270 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Binary Logging Serialization
> + */
> +#ifndef _LINUX_CEPH_BLOG_SER_H
> +#define _LINUX_CEPH_BLOG_SER_H
> +
> +#include <linux/string.h>
> +#include <linux/kernel.h>

In kernel.h header file there is one comment about "it's highly
recommended NOT to include this header inside another header file,
especially under generic or architectural include/ directory."
I think you just need pr_err/pr_warn from linux/printk.h and round_up
from linux/math.h instead directly ?


> +
> +#define IS_CONST_STR_PTR(t) \
> +       __builtin_types_compatible_p(typeof(t), const char *)
> +
> +#define IS_STR_PTR(t) \
> +       __builtin_types_compatible_p(typeof(t), char *)
> +
> +#define IS_STR(t) \
> +       (__builtin_types_compatible_p(typeof(t), const char *) || \
> +       __builtin_types_compatible_p(typeof(t), char *))
> +

[......]

> +
> +#define IS_STR_ARRAY(t) \
> +       __builtin_types_compatible_p(typeof(t), char [])
> +
> +#define IS_DYNAMIC_CHAR_PTR(t) \
> +       (__builtin_classify_type((t)) == 14 && \
> +        __builtin_types_compatible_p(typeof(t), char *) && \
> +        !__builtin_constant_p((t)))
> +

It seems the above macro is dead code?


> +#define IS_STATIC_CHAR_ARRAY(t) \
> +       (__builtin_classify_type((t)) == 5 && \
> +        __builtin_types_compatible_p(typeof(t), char[]) && \
> +        __builtin_constant_p((t)))
> +
> +#define IS_DYNAMIC_CHAR_ARRAY(t) \
> +       (__builtin_classify_type((t)) == 5 && \
> +        __builtin_types_compatible_p(typeof(t), char[]) && \
> +        !__builtin_constant_p((t)))
> +

And also this one. Will them be used somewhere in the future?

Thanks
Xiubo Li

- Xiubo

> +#define char_ptr(str) __suppress_cast_warning(char *, (str))
> +
> +#ifndef _BLOG_SER_HELPERS_DEFINED
> +#define _BLOG_SER_HELPERS_DEFINED
> +
> +union null_str_u {
> +       char str[8];
> +       unsigned long force_align;
> +};
> +
> +static const union null_str_u null_str = {
> +       .str = "(NULL) \0"
> +};
> +
> +static inline size_t write_null_str(char *dst)
> +{
> +       *(union null_str_u *)dst = null_str;
> +       static_assert(sizeof(null_str.str) == sizeof(unsigned long),
> +                    "null_str.str size must match unsigned long for proper alignment");
> +       return __builtin_strlen(null_str.str);
> +}
> +
> +static inline size_t strscpy_n(char *dst, const char *src)
> +{
> +       size_t count = 0;
> +
> +       while (count < STR_MAX_SIZE - 1) {
> +               dst[count] = src[count];
> +               if (src[count] == '\0')
> +                       goto out;
> +               count++;
> +       }
> +
> +       dst[count] = '\0';
> +       pr_warn("blog_ser: string truncated, exceeded max size %d\n", STR_MAX_SIZE);
> +out:
> +       return count + 1;
> +}
> +
> +static inline ssize_t __strscpy(char *dst, const char *src)
> +{
> +       if (src != NULL)
> +               return strscpy_n(dst, src);
> +       return write_null_str(dst);
> +}
> +
> +static inline void *strscpy_n_update(char *dst, const char *src, const char *file, int line)
> +{
> +       ssize_t ret = __strscpy(dst, src);
> +
> +       if (unlikely(ret <= 0 || ret >= STR_MAX_SIZE)) {
> +               pr_err("blog_ser: string handling error ret=%zd at %s:%d :: dst='%s' src='%s'\n",
> +                      ret, file, line, dst, src ? src : "(null)");
> +               if (ret >= STR_MAX_SIZE) {
> +                       dst[STR_MAX_SIZE - 1] = '\0';
> +                       ret = STR_MAX_SIZE;
> +               } else {
> +                       dst[0] = '\0';
> +                       ret = 1;
> +               }
> +       }
> +       return dst + round_up(ret, 4);
> +}
> +
> +#endif /* _BLOG_SER_HELPERS_DEFINED */
> +
> +#define __blog_ser_type(__buffer, __t)                          \
> +       (__builtin_choose_expr(IS_STATIC_CHAR_ARRAY((__t)),               \
> +               ((__buffer) = (void *)strscpy_n_update((__buffer),            \
> +                                               char_ptr(__t),                             \
> +                                               kbasename(__FILE__),                      \
> +                                               __LINE__)),                               \
> +       __builtin_choose_expr(IS_STR((__t)),               \
> +               ((__buffer) = (void *)strscpy_n_update((__buffer),            \
> +                                               char_ptr(__t),                             \
> +                                               kbasename(__FILE__),                      \
> +                                               __LINE__)),                               \
> +       __builtin_choose_expr(IS_STR_ARRAY((__t)),               \
> +                ((__buffer) = (void *)strscpy_n_update((__buffer),        \
> +                                               char_ptr(__t),                       \
> +                                               kbasename(__FILE__),                \
> +                                               __LINE__)),                          \
> +       __builtin_choose_expr(sizeof((__t)) == 1,                         \
> +               (*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
> +                (__buffer) = (void *)((char *)(__buffer) + 4)),            \
> +       __builtin_choose_expr(sizeof((__t)) == 2,                         \
> +               (*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
> +                (__buffer) = (void *)((char *)(__buffer) + 4)),            \
> +       __builtin_choose_expr(sizeof((__t)) == 4,                         \
> +               (*(u32 *)(__buffer) = __suppress_cast_warning(u32, (__t)), \
> +                (__buffer) = (void *)((char *)(__buffer) + 4)),            \
> +       __builtin_choose_expr(sizeof((__t)) == 8,                         \
> +               (*(u64 *)(__buffer) = __suppress_cast_warning(u64, (__t)), \
> +                (__buffer) = (void *)((char *)(__buffer) + 8)),            \
> +               (pr_err("UNSUPPORTED_TYPE: %s:%d: unsupported type size %zu\n",       \
> +                       kbasename(__FILE__), __LINE__, sizeof(__t)))              \
> +       ))))))))
> +
> +/* Serialization macros */
> +#define ___blog_ser0(__buffer)
> +#define ___blog_ser1(__buffer, __t)           (__blog_ser_type(__buffer, __t))
> +#define ___blog_ser2(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser1(__buffer, __args))
> +#define ___blog_ser3(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser2(__buffer, __args))
> +#define ___blog_ser4(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser3(__buffer, __args))
> +#define ___blog_ser5(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser4(__buffer, __args))
> +#define ___blog_ser6(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser5(__buffer, __args))
> +#define ___blog_ser7(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser6(__buffer, __args))
> +#define ___blog_ser8(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser7(__buffer, __args))
> +#define ___blog_ser9(__buffer, __t, __args...)    \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser8(__buffer, __args))
> +#define ___blog_ser10(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser9(__buffer, __args))
> +#define ___blog_ser11(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser10(__buffer, __args))
> +#define ___blog_ser12(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser11(__buffer, __args))
> +#define ___blog_ser13(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser12(__buffer, __args))
> +#define ___blog_ser14(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser13(__buffer, __args))
> +#define ___blog_ser15(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser14(__buffer, __args))
> +#define ___blog_ser16(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser15(__buffer, __args))
> +#define ___blog_ser17(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser16(__buffer, __args))
> +#define ___blog_ser18(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser17(__buffer, __args))
> +#define ___blog_ser19(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser18(__buffer, __args))
> +#define ___blog_ser20(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser19(__buffer, __args))
> +#define ___blog_ser21(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser20(__buffer, __args))
> +#define ___blog_ser22(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser21(__buffer, __args))
> +#define ___blog_ser23(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser22(__buffer, __args))
> +#define ___blog_ser24(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser23(__buffer, __args))
> +#define ___blog_ser25(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser24(__buffer, __args))
> +#define ___blog_ser26(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser25(__buffer, __args))
> +#define ___blog_ser27(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser26(__buffer, __args))
> +#define ___blog_ser28(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser27(__buffer, __args))
> +#define ___blog_ser29(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser28(__buffer, __args))
> +#define ___blog_ser30(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser29(__buffer, __args))
> +#define ___blog_ser31(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser30(__buffer, __args))
> +#define ___blog_ser32(__buffer, __t, __args...)   \
> +       (__blog_ser_type(__buffer, __t), ___blog_ser31(__buffer, __args))
> +#define ___blog_ser(__buffer, ...)   \
> +       ___blog_apply(___blog_ser, blog_narg(__VA_ARGS__))(__buffer, ##__VA_ARGS__)
> +#define blog_ser(...)  ___blog_ser(__VA_ARGS__)
> +
> +#endif /* _LINUX_CEPH_BLOG_SER_H */
> --
> 2.34.1
>
