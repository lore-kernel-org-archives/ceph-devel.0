From: Gregory Farnum <greg@inktank.com>
Subject: Re: primary pg and replica pg are placed on the same node under
 "ssd-primary" rule
Date: Tue, 12 Feb 2013 12:46:17 -0800
Message-ID: <CAPYLRzia2wL9a0FpJwQwQyq1mHSvW16eDOpNaX_NBnBQ-dOhsQ@mail.gmail.com>
References: <CAA4Vorr0wN32_-xOmsCQivT5q3WbLbB2WqS2uUK7znjKengtgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:64473 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3BLUqS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 15:46:18 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so1858275qab.9
        for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 12:46:17 -0800 (PST)
In-Reply-To: <CAA4Vorr0wN32_-xOmsCQivT5q3WbLbB2WqS2uUK7znjKengtgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ymorita000@gmail.com" <ymorita000@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Unfortunately this part doesn't fit into the CRUSH language. In order
to do it and segregate properly by node you need to have separate SSD
and HDD nodes, rather than interspersing them. (Or if you were brave
you could set up some much more specified rules and pull each replica
from a different rack/row, but that would take a bit of work and
enough machines for that mechanism to be useful.)
-Greg

On Tue, Feb 12, 2013 at 12:40 PM, ymorita000@gmail.com
<ymorita000@gmail.com> wrote:
> Hi,
>
> I am trying to test a storage tiering using the following
> "ssd-primary" rule set introduced in the Ceph page. However, there
> seems to be a chance that primary pg and replica pg are placed on the
> same node.
>
> Is there any way to avoid this at this point in time?
>
>       rule ssd-primary {
>               ruleset 4
>               type replicated
>               min_size 0
>               max_size 10
>               step take ssd
>               step chooseleaf 1 type host
>               step emit
>               step take platter
>               step chooseleaf -1 type host
>               step emit
>       }
>
> Ceph - CRUSH Maps
> http://ceph.com/docs/master/rados/operations/crush-map/#placing-different-pools-on-different-osds
>
> Thank you.
> Yuji
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
