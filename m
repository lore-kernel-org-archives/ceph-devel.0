From: Samuel Just <sam.just@inktank.com>
Subject: Re: Slow OSD detection
Date: Fri, 21 Nov 2014 12:58:57 -0800
Message-ID: <CA+4uBUbxsK-TwWvWjr_ynVOjsRic5YD+Qm2CbzwPxgyTWMs7kg@mail.gmail.com>
References: <CALgKBSmF=Au_CPNRBRwvMrDejs2=JuqO4zf-AzQfT04uyqnTtg@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58220 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbaKUU67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Nov 2014 15:58:59 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so4973372lab.32
        for <ceph-devel@vger.kernel.org>; Fri, 21 Nov 2014 12:58:58 -0800 (PST)
In-Reply-To: <CALgKBSmF=Au_CPNRBRwvMrDejs2=JuqO4zf-AzQfT04uyqnTtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sreenath BH <bhsreenath@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's still an open item.  #ceph-devel would be a good place to bounce
ideas.  Through the admin_socket and perf_counter machinery, the osds
already expose a bunch of information about queue length, latency,
etc.  This might actually fit well in calamari, which already gathers
a bunch of those stats.
-Sam

On Thu, Nov 20, 2014 at 9:00 PM, Sreenath BH <bhsreenath@gmail.com> wrote:
> Hi All
>
> Slow OSD detection is mentioned as one of the projects ideas in
> https://wiki.ceph.com/Development/Project_Ideas
>
> I am interested in implementing this. Is this still an open item?
>
> thanks,
> Sreenath
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
