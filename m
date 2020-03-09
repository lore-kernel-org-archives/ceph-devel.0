From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] Re: ceph rbd volumes/images IO details
Date: Mon, 9 Mar 2020 11:17:22 +0100
Message-ID: <CAOi1vP_WNn2eSqwm-9Nvo+Gzv9MUYGmPaMGRpAsd3EKSdHBb3Q@mail.gmail.com>
References: <CANA9Uk54Ygo98sjozbU_HcAGjocSV2ui=-=imrDTCpdLOHhx6Q@mail.gmail.com>
 <CANA9Uk5eR41ZBYU_XGpgQoLwO8MnGTFuu6L+OKKvEBhs2YXCiA@mail.gmail.com>
 <B6D7DD2C-7F32-40D0-A24B-CE955B33438F@me.com> <CANA9Uk76E6D-nznLF+ij9aoJgbpckKqc5gtUu0p4jfPOWCGWbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:38351 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKRW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2020 06:17:22 -0400
Received: by mail-io1-f65.google.com with SMTP id s24so8537866iog.5
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2020 03:17:22 -0700 (PDT)
In-Reply-To: <CANA9Uk76E6D-nznLF+ij9aoJgbpckKqc5gtUu0p4jfPOWCGWbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: XuYun <yunxu@me.com>, ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, Ceph Community <ceph-community@lists.ceph.com>

On Sun, Mar 8, 2020 at 5:13 PM M Ranga Swami Reddy <swamireddy@gmail.com> w=
rote:
>
> Iam using the Luminous 12.2.11 version with prometheus.
>
> On Sun, Mar 8, 2020 at 12:28 PM XuYun <yunxu@me.com> wrote:
>
> > You can enable prometheus module of mgr if you are running Nautilus.
> >
> > > 2020=E5=B9=B43=E6=9C=888=E6=97=A5 =E4=B8=8A=E5=8D=882:15=EF=BC=8CM Ra=
nga Swami Reddy <swamireddy@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, Mar 6, 2020 at 1:06 AM M Ranga Swami Reddy <swamireddy@gmail.=
com
> > >
> > > wrote:
> > >
> > >> Hello,
> > >> Can we get the IOPs of any rbd image/volume?
> > >>
> > >> For ex: I have created volumes via OpenStack Cinder. Want to know
> > >> the IOPs of these volumes.
> > >>
> > >> In general - we can get pool stats, but not seen the per volumes sta=
ts.
> > >>
> > >> Any hint here? Appreciated.

Per image/volume stats are available since nautilus [1].  There is
no automated way to do it in luminous.  Since you are using openstack,
you can probably set up some generic I/O monitoring at instance level
(i.e. external to ceph) and possibly apply disk I/O limits (again at
instance level, enforced in qemu).

[1] https://ceph.io/rbd/new-in-nautilus-rbd-performance-monitoring/

Thanks,

                Ilya
