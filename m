From: huang jun <hjwsm1989@gmail.com>
Subject: Re: [ceph-users] How do I restart node that I've killed in
 development mode
Date: Wed, 12 Oct 2016 15:06:58 +0800
Message-ID: <CABAwU-b_a437kTm5pWm-qJmcPTphBS5Msmjj8q1CQ9gBpop-FQ@mail.gmail.com>
References: <CAJ+86MPR6Ux6RW_JyX4vmAWjMygCbV6SHf1YuSJnzrmUFBeYCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33368 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbcJLHHA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2016 03:07:00 -0400
Received: by mail-qk0-f176.google.com with SMTP id n189so18389429qke.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 00:06:59 -0700 (PDT)
In-Reply-To: <CAJ+86MPR6Ux6RW_JyX4vmAWjMygCbV6SHf1YuSJnzrmUFBeYCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: agung Laksono <agung.smarts@gmail.com>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

./init-ceph start mon.a

2016-10-12 14:54 GMT+08:00 agung Laksono <agung.smarts@gmail.com>:
> Hi Ceph Users,
>
> I deploy development cluster using vstart with 3 MONs and 3 OSDs.
> On my experiment, Kill one of the monitor nodes by its pid. like this:
>
>   $ kill -SIGSEGV 27557
>
> After a new monitor leader is chosen, I would like to re-run the monitor
> that I've killed in the previous step. How do I do this?
>
>
> Thanks
>
> --
> Cheers,
>
> Agung Laksono
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Thank you!
HuangJun
