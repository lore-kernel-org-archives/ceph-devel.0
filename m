From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ubuntu upstart hang due xfs mount hang
Date: Thu, 27 Oct 2016 11:40:13 -0600
Message-ID: <CALqRxCzfYei7Lh0-xfnboWOeFPHEm4=x3Tsjguv57JzmC_Nm-Q@mail.gmail.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314ECB05@H3CMLB12-EX.srv.huawei-3com.com>
 <alpine.DEB.2.11.1610271509180.14316@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33576 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbcJ0Rkv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Oct 2016 13:40:51 -0400
Received: by mail-vk0-f52.google.com with SMTP id d65so6438982vkg.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Oct 2016 10:40:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610271509180.14316@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Zhangzengran <zhangzengran@h3c.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Oct 27, 2016 at 9:10 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 27 Oct 2016, Zhangzengran wrote:
>> >On Thu, 27 Oct 2016, Zhangzengran wrote:
>> >> Hi Sage & all:
>> >>   There is a data disk on ceph host with xfs, it’s EFIs corrupt in an
>> >> unexpected power outage.when the host power on again, system(ubuntu)
>> >> hang in upstart’s console, we learn that upstart try to do `ceph-disk activate-all` and mount that disk in ceph-osd-all series jobs,but the mount hang indefinite. there is also a S20ceph script called by rc series jobs,and the tty1.conf start on `stoped rc`,so we cant login from console.
>> >>
>> >> I saw there is a Patch for ceph-disk,it provided a timeout to mkfs.So
>> >> I think,  do we also need to provide a timeout for mount?because if ceph-disk hang in upstart, no osd  daemon could start on that host.
>>
>> >What version of ubuntu and Ceph is this? Since jewel we are all systemd, and the activate etc jobs are all async systemd tasks, so I don't think this should happen.
>>
>> Ubuntu is 14.04, Ceph is Hammer 0.94.5
>
> Ah.  This will all go away once you upgrade to jewel.  In the meantime,
> you can probably remove the S20 file.. though I don't think it should be
> doing anything anyway since you're using upstart.

jewel + Ubuntu 16.04, right?
