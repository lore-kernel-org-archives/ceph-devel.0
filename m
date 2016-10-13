From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: [ceph-disk]how to specific cluster name when active an osd?
Date: Thu, 13 Oct 2016 15:51:49 +0200
Message-ID: <CAPed3OG_Aj5GCs21RXUfXu+Kk9h9xp2QcrRKAboooMh3_0ahBw@mail.gmail.com>
References: <CAKZcxgdYG__w1f_YEu0fcO8CpRWejBnadRP-giVLY7MC7QYsEw@mail.gmail.com>
 <CALZt5jzzjpi07dLXc9636zeMwN4b9Qmo_JBnN-3ePvZqqO72OA@mail.gmail.com> <alpine.DEB.2.11.1610131335410.19763@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33142 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbcJMOHt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 10:07:49 -0400
Received: by mail-vk0-f65.google.com with SMTP id 83so2467604vkd.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 07:07:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610131335410.19763@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ning Yao <zay11022@gmail.com>, Jaze Lee <jazeltq@gmail.com>, Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 13, 2016 at 3:36 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 13 Oct 2016, Ning Yao wrote:
>> Yeah,
>>
>> If we want to use a different cluster name instead of the default
>> cluster name 'ceph'. we need to modify the ceph-osd@.service file to
>> make sure the cluster name is what we use.
>> Any ideas to solve the issue under systemd?  @Loic
>
> I believe you can set the cluster name in /etc/default/ceph or
> /etc/sysconfig/ceph, but I'm not sure if it's tested.
>
> sage
>

FWIW, at least on CentOS this works fine:

$ grep CLUSTER /etc/sysconfig/ceph

CLUSTER="hlm1-ceph01"

I did need to add --cluster to various commands when setting up the
cluster though, for instance ceph-disk prepare --cluster $cluster.
There was no need to modify any systemd units after that.

Kind regards,

Ruben
