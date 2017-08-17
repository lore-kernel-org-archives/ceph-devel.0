From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: [Ceph-maintainers] [ceph-users] v12.1.4 Luminous (RC) released
Date: Thu, 17 Aug 2017 09:42:38 -0700
Message-ID: <CAKPXa=ZPeMST83ekgUkYbO5yz-ic3q_guY__0=tY7PSwmk-4YA@mail.gmail.com>
References: <062fdb6f788298b7458db9d07ead19d2@suse.com> <CAJ4mKGa7SK+YNE-sdEPKAj+NnTGtZSmxVZJiVXQoSnKF13TNJw@mail.gmail.com>
 <CAKOnarmpOgZL7PtHnW-xOEH589aPyNPoGkguYpWbhAgV5RcwQw@mail.gmail.com>
 <CAC-Np1xzdfEVQOszKttVEx8KNEspqJ+aBdS9RRVuA--QEEd9Gg@mail.gmail.com>
 <CAJ4mKGZqB+2ocK3Eo2fLbA8ebzrAuvFFw3Pf2sy-zantTdTkrQ@mail.gmail.com>
 <CAC-Np1xMKD7TNpXKCy2AyatDOkGubGzifRX_TYyF0D48SG+pEg@mail.gmail.com>
 <DF101E47-D98F-4DF1-8337-6FC44B86676E@TERADATA.COM> <a6a7dd77-8b36-b2fb-183a-ecce43f3b8d7@redhat.com>
 <B693BFC0-9A9B-4338-BF7D-C9710665350C@TERADATA.COM> <238bc116-e706-031e-ab11-06e2383a9a04@redhat.com>
 <469DEC9D-7E3D-49C5-8AE6-71877039B3AC@TERADATA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35243 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdHQQmj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 12:42:39 -0400
Received: by mail-oi0-f44.google.com with SMTP id e124so72304664oig.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 09:42:39 -0700 (PDT)
In-Reply-To: <469DEC9D-7E3D-49C5-8AE6-71877039B3AC@TERADATA.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: Dan Mick <dmick@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 17, 2017 at 9:18 AM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
>
> On 8/16/17, 6:42 PM, "Dan Mick" <dmick@redhat.com> wrote:
>
>
>     >     >     "overall": {
>     >     >         "ceph version 12.1.0 (262617c9f16c55e863693258061c5b25dea5b086) luminous (dev)": 50,
>     >     >         "ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)": 3
>     >     >     }
>     >     > }
>     >     >
>     >     >
>     >     > # ceph-osd --version
>     >     > ceph version 12.1.4 (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc)
>     >     >
>     >     > Why is it showing old 12.1.0 version for the 50 osds, while all the nodes show ceph osd version as 12.1.4?
>     >
>     >     You didn't say you restarted the osds.  Did you?
>     >
>     > Yes, I did restart them, and that too more than once.
>
>     Dunno, then.  That seems impossible.
>
> It is showing the version of OSD before the upgrade.
> Is it possible the old version gets cached somewhere, and that is not getting updated after upgrade?
I wonder if its a systemd issue, Does the systemd restart actually
change the process id? (output of ps before/after would be good),
Hopefully all the pkgs are properly updated when you query them and
you dont see any old traces left behind.

>
> Nitin
>
