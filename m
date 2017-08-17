From: Dan Mick <dmick@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Wed, 16 Aug 2017 18:42:57 -0700
Message-ID: <238bc116-e706-031e-ab11-06e2383a9a04@redhat.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com>
 <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
 <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
 <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM>
 <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com>
 <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751070AbdHQBm6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Aug 2017 21:42:58 -0400
In-Reply-To: <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, ceph-devel <ceph-devel@vger.kernel.org>


>     >     "overall": {
>     >         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50,
>     >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 3
>     >     }
>     > }
>     > 
>     > 
>     > # ceph-osd --version
>     > ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>     > 
>     > Why is it showing old 12.1.0 version for the 50 osds, while all the nodes show ceph osd version as 12.1.4?
>     
>     You didn't say you restarted the osds.  Did you?
> 
> Yes, I did restart them, and that too more than once.

Dunno, then.  That seems impossible.
