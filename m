From: Ning Yao <zay11022@gmail.com>
Subject: Re: [ceph-disk]how to specific cluster name when active an osd?
Date: Thu, 13 Oct 2016 11:58:45 +0800
Message-ID: <CALZt5jzzjpi07dLXc9636zeMwN4b9Qmo_JBnN-3ePvZqqO72OA@mail.gmail.com>
References: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:35273 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbcJMEEt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 00:04:49 -0400
Received: by mail-it0-f46.google.com with SMTP id e203so110253734itc.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 21:04:48 -0700 (PDT)
In-Reply-To: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>, Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yeah,

If we want to use a different cluster name instead of the default
cluster name 'ceph'. we need to modify the ceph-osd@.service file to
make sure the cluster name is what we use.
Any ideas to solve the issue under systemd?  @Loic
Regards
Ning Yao


2016-10-12 15:18 GMT+08:00 Jaze Lee <jazeltq@gmail.com>:
> If using systemd, we can not specific cluster name when active an osd...
> Is there a way to send in the ENV CLUSTER by systemctl?
>
>
> Thank a lot
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
