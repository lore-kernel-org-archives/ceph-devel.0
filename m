From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [devops] the service can not start correctly
Date: Mon, 9 May 2016 20:02:41 -0600
Message-ID: <CALqRxCw4RBjgtT6tnFFgcEjmB=mHShoZxNkmxeygK6Li6PwwdA@mail.gmail.com>
References: <CAKZcxgcjKju=BtbAL-9dFmRSYvv0hHk-D5=n0n=sfrxb80_+NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33387 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbcEJCCn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2016 22:02:43 -0400
Received: by mail-vk0-f42.google.com with SMTP id o133so88681965vka.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2016 19:02:42 -0700 (PDT)
In-Reply-To: <CAKZcxgcjKju=BtbAL-9dFmRSYvv0hHk-D5=n0n=sfrxb80_+NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Jaze,

The Puppet code should be updated to do "systemctl start
ceph-mon@study-4", as you suggest. It should not run "service <foo>"
any more.

- Ken

On Mon, May 9, 2016 at 12:54 AM, Jaze Lee <jazeltq@gmail.com> wrote:
> hi all
>    I test openstack/puppet-ceph to install ceph-10.2.0 and find that,
> when the mon can not start correctly.
>
>    The puppet agent says that
>
>  Error: Could not start Service[ceph-mon-study-4]: Execution of
> 'service ceph start mon.study-4' returned 6: Redirecting to
> /bin/systemctl start  mon.study-4 ceph.service
>
>
>
> The command 'service ceph start mon.study-4' maps to 'systemctl start
> mon.study-4 ceph.service'
> I think here should be systemctl start ceph-mon@study-4.
>
> May be the way i use puppet-ceph is not properly. If not, i think we
> should add some code
> to use systemctl directly rather than use the 'service start ....'.
>
> The code is here
> https://github.com/openstack/puppet-ceph/blob/master/manifests/mon.pp=
#L90
>
>
> Thank a lot.
>
>
>
> --
> =E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
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
