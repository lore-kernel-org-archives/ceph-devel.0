From: Casey Bodley <cbodley@redhat.com>
Subject: Re: build on centos-7 and trusty
Date: Fri, 8 Dec 2017 09:36:36 -0500
Message-ID: <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com>
References: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44860 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbdLHOgi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 09:36:38 -0500
Received: by mail-wr0-f182.google.com with SMTP id l22so11006133wrc.11
        for <ceph-devel@vger.kernel.org>; Fri, 08 Dec 2017 06:36:37 -0800 (PST)
In-Reply-To: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Kefu! is there anything more we need to do before turning on -std=c++14?

On Fri, Dec 8, 2017 at 12:28 AM, kefu chai <tchaikov@gmail.com> wrote:
> hi developers building master and mimic-dev1 on centos-7 and/or trusty,
>
> please use install-deps.sh to install the gcc-7 for compiling Ceph. as
> from now on, we will need GCC >= 5.1 [1] for better C++11 support.
>
> cheers,
>
> ---
> [1] https://github.com/ceph/ceph/pull/19344
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
