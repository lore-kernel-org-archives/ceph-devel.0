From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rgw_rest.cc build failure
Date: Wed, 10 Oct 2012 14:29:01 -0700
Message-ID: <CAC-hyiHqQC3ON=c4zV9PEw4qWLwmqcf8d=YrvOYFjnqbomgA-A@mail.gmail.com>
References: <CAPrxi5-fb2hQeLcgC577JOLxZmMaKT=SYhCxzBwwUEDcxxLBvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39426 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab2JJV3E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 17:29:04 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so599501bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 14:29:02 -0700 (PDT)
In-Reply-To: <CAPrxi5-fb2hQeLcgC577JOLxZmMaKT=SYhCxzBwwUEDcxxLBvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I'll apply this, can I assume you have signed off this patch?

On Wed, Oct 10, 2012 at 2:25 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
>
> This needed for latest master:
>
> diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
> index 53bbeca..3612a9e 100644
> --- a/src/rgw/rgw_rest.cc
> +++ b/src/rgw/rgw_rest.cc
> @@ -1,4 +1,5 @@
>  #include <errno.h>
> +#include <limits.h>
>
>  #include "common/Formatter.h"
>  #include "common/utf8.h"
>
> to fix:
>
>   CXX    radosgw-rgw_rest.o
> rgw/rgw_rest.cc: In static member function =91static int
> RESTArgs::get_uint64(req_state*, const string&, uint64_t, uint64_t*,
> bool*)=92:
> rgw/rgw_rest.cc:326:15: error: =91ULLONG_MAX=92 was not declared in t=
his scope
> rgw/rgw_rest.cc: In static member function =91static int
> RESTArgs::get_int64(req_state*, const string&, int64_t, int64_t*,
> bool*)=92:
> rgw/rgw_rest.cc:351:15: error: =91LLONG_MAX=92 was not declared in th=
is scope
>
> - Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
