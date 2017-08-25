From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: Bug? luminous pkg missing ceph-osd ceph-mon 32bit
Date: Fri, 25 Aug 2017 08:40:07 -0700
Message-ID: <CAKRxpuuNtxA3+P37LD8YffQ3OLiAxj88LqcyiVdDqr=uKe1nxg@mail.gmail.com>
References: <CAKRxpuug+1wc0Js9TczYBv-yevbYWXf+TT26oQmZty2TNYBcCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:37217 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933622AbdHYPkJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Aug 2017 11:40:09 -0400
Received: by mail-io0-f182.google.com with SMTP id d81so483625ioj.4
        for <ceph-devel@vger.kernel.org>; Fri, 25 Aug 2017 08:40:09 -0700 (PDT)
In-Reply-To: <CAKRxpuug+1wc0Js9TczYBv-yevbYWXf+TT26oQmZty2TNYBcCg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

the target osd was a ubuntu 16.04 x32

On Fri, Aug 25, 2017 at 8:35 AM, Two Spirit <twospirit6905@gmail.com> wrote:
> I built 64 bit ubuntu 16.04 and 14.04 (using crush tunables legacy)
> systems, and I tried to build a 32 bit system, and it complained
> about missing packages so if there is such a thing, I think it might
> be related to 32 bit repository. ubuntu 15.04 doesn't work either, but
> I'm not sure if it is supported.
>
> adminhost$ ceph-deploy install --release luminous vm143
>
> [vm143][DEBUG ] Get:2 http://us.archive.ubuntu.com/ubuntu
> xenial-updates InRelease [102 kB]
> [vm143][DEBUG ] Get:3 http://security.ubuntu.com/ubuntu
> xenial-security InRelease [102 kB]
> [vm143][DEBUG ] Get:4 http://us.archive.ubuntu.com/ubuntu
> xenial-backports InRelease [102 kB]
> [vm143][DEBUG ] Hit:5 https://download.ceph.com/debian-luminous xenial InRelease
> [vm143][DEBUG ] Fetched 306 kB in 1s (172 kB/s)
> [vm143][DEBUG ] Reading package lists...
> [vm143][INFO  ] Running command: sudo env
> DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get
> --assume-yes -q --no-install-recommends install -o
> Dpkg::Options::=--force-confnew ceph ceph-osd ceph-mds ceph-mon
> radosgw
> [vm143][DEBUG ] Reading package lists...
> [vm143][DEBUG ] Building dependency tree...
> [vm143][DEBUG ] Reading state information...
> [vm143][WARNING] E: Unable to locate package ceph-osd
> [vm143][WARNING] E: Unable to locate package ceph-mon
> [vm143][ERROR ] RuntimeError: command returned non-zero exit status: 100
> [ceph_deploy][ERROR ] RuntimeError: Failed to execute command: env
> DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get
> --assume-yes -q --no-install-recommends install -o
> Dpkg::Options::=--force-confnew ceph ceph-osd ceph-mds ceph-mon
> radosgw
> <div id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
> <table style="border-top: 1px solid #D3D4DE;">
>         <tr>
>         <td style="width: 55px; padding-top: 13px;"><a
> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
> target="_blank"><img
> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
> alt="" width="46" height="29" style="width: 46px; height: 29px;"
> /></a></td>
>                 <td style="width: 470px; padding-top: 12px; color: #41424e;
> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
> line-height: 18px;">Virus-free. <a
> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
> target="_blank" style="color: #4453ea;">www.avg.com</a>
>                 </td>
>         </tr>
> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
> height="1"></a></div>
