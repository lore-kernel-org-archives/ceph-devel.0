From: Paul Cuzner <pcuzner@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Tue, 21 Mar 2017 14:31:33 +1300
Message-ID: <CAO=rSOsB79vfxieoVvWQO5noo0ypu5nqOv4Dn_t-GTPR7TBnUg@mail.gmail.com>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com>
 <CAPed3OFuG4+g5nrZJOEmf9iMx3SEgzk62H1dNuxPc-pSWKXxbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36179 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754834AbdCUBdJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 21:33:09 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11so1681799wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 18:31:34 -0700 (PDT)
In-Reply-To: <CAPed3OFuG4+g5nrZJOEmf9iMx3SEgzk62H1dNuxPc-pSWKXxbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ruben Kerkhof <ruben@rubenkerkhof.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm working on downstream stuff (RHEL) which made the plugins a little
harder to find - but yes, I've tried the ceph plugin (@ 5.7).

With the plugin on a mon I can see all the counters from perf dump,
but since I'm working on benchmarking, I wanted more :)

- how many hosts in the cluster
- what's the client ops performance look like, by pool and total
- what recovery work is going on, by pool and total

tbh, I haven't used the plugin on the osd nodes - I've been looking
for higher level metrics to try and get cluster wide view.




On Tue, Mar 21, 2017 at 3:20 AM, Ruben Kerkhof <ruben@rubenkerkhof.com> wrote:
> On Fri, Mar 10, 2017 at 3:37 AM, Paul Cuzner <pcuzner@redhat.com> wrote:
>> Hi,
>
> Hi Paul,
>
>>
>> I've been putting together a collectd plugin for ceph - since the old
>> one's I could find no longer work.
>
> Did you try the ceph plugin in upstream collectd?
> It has been in collectd since 5.5.
>
> Kind regards,
>
> Ruben Kerkhof
