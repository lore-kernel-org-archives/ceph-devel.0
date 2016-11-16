From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and lumninous?
Date: Wed, 16 Nov 2016 10:40:04 -0800
Message-ID: <CAMMFjmE_S0ew2h7wWFF2wQccjffX7iGiJS=sxgkvOcvv86DG6Q@mail.gmail.com>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to> <alpine.DEB.2.11.1611141424060.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35170 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752897AbcKPSkG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 13:40:06 -0500
Received: by mail-wm0-f49.google.com with SMTP id a197so258022129wmd.0
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 10:40:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611141424060.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "Cerza, Zack" <zack@redhat.com>, David Galloway <dgallowa@redhat.com>, "Mick, Dan" <dmick@redhat.com>, Vasu Kulkarni <vasu@redhat.com>

Sage,

We had discussed xenial support in sepia today and right now jobs
asking for it from smithi and mira nodes will fail because there are
no bare-metals provisioned for it.

The question is - how do we split nodes between 14.04, 16.04 and centos ?

Thx
YuriW

On Mon, Nov 14, 2016 at 6:24 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 11 Nov 2016, Sage Weil wrote:
>> Currently the distros we use for upstream testing are
>>
>>  centos 7.x
>>  ubuntu 16.04 (xenial)
>>  ubuntu 14.04 (trusty)
>>
>> We also do some basic testing for Debian 8 and Fedora (some old version).
>>
>> Jewel was the first release that had native systemd and full xenial
>> support, so it's helpful to have both 14.04 and 16.04 supported to provide
>> an upgrade path.  But I think we can safely drop 14.04 now for kraken and
>> luminous.  Our options are
>>
>> 1) keep testing on xenial and trusty, and keep building packages for both
>
> Sounds like we'll keep trusty around for a while.  Thanks, everyone!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
