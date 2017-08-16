From: Dan Mick <dmick@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Wed, 16 Aug 2017 16:18:42 -0700
Message-ID: <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com>
 <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
 <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
 <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752514AbdHPXSm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Aug 2017 19:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4513AC2D5
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 23:18:42 +0000 (UTC)
Received: from [10.17.96.100] (angus.lax.redhat.com [10.17.96.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90CF2619C0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 23:18:42 +0000 (UTC)
In-Reply-To: <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 08/16/2017 04:01 PM, Kamble, Nitin A wrote:
> After upgrading all the ceph nodes to v12.1.4 I see that OSD versions are still shown as older version.
> # ceph versions
> {
>     "mon": {
>         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>     },
>     "mgr": {
>         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>     },
>     "osd": {
>         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50
>     },
>     "mds": {
>         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 1
>     },
>     "overall": {
>         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50,
>         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 3
>     }
> }
> 
> 
> # ceph-osd --version
> ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
> 
> Why is it showing old 12.1.0 version for the 50 osds, while all the nodes show ceph osd version as 12.1.4?

You didn't say you restarted the osds.  Did you?

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
