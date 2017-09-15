From: John Spray <jspray@redhat.com>
Subject: Re: [ceph-users] mon health status gone from display
Date: Fri, 15 Sep 2017 19:41:54 +0100
Message-ID: <CALe9h7cEAXP+iKxmDesW9W7WC3Yhz3RzrHQY+5b92CgizZvamw@mail.gmail.com>
References: <CADb9450qop5MYwHeg-Gw4GR=3bDNx-BPzFNC37kvpLbwpVTnMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:50356 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdIOSmR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 14:42:17 -0400
Received: by mail-wm0-f42.google.com with SMTP id v142so10431811wmv.5
        for <ceph-devel@vger.kernel.org>; Fri, 15 Sep 2017 11:42:17 -0700 (PDT)
In-Reply-To: <CADb9450qop5MYwHeg-Gw4GR=3bDNx-BPzFNC37kvpLbwpVTnMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Gorbachev <ag@iss-integration.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 15, 2017 at 7:01 PM, Alex Gorbachev <ag@iss-integration.com> wrote:
> In Jewel and prior there was a health status for MONs in ceph -s JSON
> output, this seems to be gone now.  Is there a place where a status of
> a given monitor is shown in Luminous?

Can you say which fields specifically you're missing?  We still have
the quorum/quorum_names bits that let you work out whether the mon
cluster is up by comparison to the mon map.

I think we also used to have the clock skew data there, but I think we
dropped it because it was kind of an obscure thing and didn't fit
neatly into the new health checks format.

John

>
> Thank you
> --
> Alex Gorbachev
> Storcium
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
