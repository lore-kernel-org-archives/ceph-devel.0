From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: fix for issue with RGW on larger than 528k downloads
Date: Wed, 18 Dec 2013 08:11:56 -0800
Message-ID: <CABBk=J9Lg8ekDmGYisC0Sq+UaWWoBm6_vHXADeXG1yTrOgznQg@mail.gmail.com>
References: <CAC96waHg9nm3txHCDdqMeKZboBKgt1c-DoVQ+irJ3u7fWrGD5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45611 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab3LRQL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 11:11:57 -0500
Received: by mail-qc0-f174.google.com with SMTP id n7so6175558qcx.5
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 08:11:56 -0800 (PST)
In-Reply-To: <CAC96waHg9nm3txHCDdqMeKZboBKgt1c-DoVQ+irJ3u7fWrGD5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pawel Stefanski <pejotes@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 18, 2013 at 1:53 AM, Pawel Stefanski <pejotes@gmail.com> wrote:
> hello!
>
> We are struggling with issue on downloading bigger files since some
> time, on ceph-users there were some complains about this but without
> any conclusions or with misunderstood cause (as a solution there was
> proposed new http serwer for example nginx, where the cause is
> somewhere in radosgw).
>
> I see that cluster at dreamhost suffered the same issue recently,
> could community get the same path/workaround for the stalling download
> issue ?
>

Sure. It's not on a proper release yet. but it's out there if you want
to give it a try (wip-rgw-getobj-cb). We'll get it on a proper release
soon.

Yehuda
