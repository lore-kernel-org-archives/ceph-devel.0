From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to crush_location_hook
Date: Thu, 19 Oct 2017 14:00:49 +0200
Message-ID: <CABZ+qq=pnAjbDKVfHkH_=G3yLpU4-=Ko_Qvyqq8x7XfQ5=pQjw@mail.gmail.com>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:46779 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbdJSMBd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 08:01:33 -0400
Received: by mail-lf0-f43.google.com with SMTP id g70so9315739lfl.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 05:01:32 -0700 (PDT)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com. [209.85.215.47])
        by smtp.gmail.com with ESMTPSA id x18sm1672901lja.55.2017.10.19.05.01.30
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 05:01:30 -0700 (PDT)
Received: by mail-lf0-f47.google.com with SMTP id g70so9315638lfl.3
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 05:01:30 -0700 (PDT)
In-Reply-To: <1406455169.3092.1508155374117@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

Hi Wido,

Unexpected crush location changes can indeed be quite nasty.

With this in mind, I wonder if a crush lock would be useful.

    ceph osd set nocrushchange

With that flag set, osds could still go in and out, but crush
move/add/remove/etc..., also tunables changes, would be blocked.

Thoughts?

-- Dan


On Mon, Oct 16, 2017 at 2:02 PM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.
>
> When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.
>
> Was this an oversight with Luminous or was it intentional?
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
