From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: Re: Quick comparison of Hammer & Infernalis on NVMe
Date: Fri, 27 Nov 2015 13:53:44 +0100
Message-ID: <CADr68WZMePfWw-AmruvEAXziziE9x8mqe3-24=2iQ+P-rJRQSg@mail.gmail.com>
References: <3649A15A2562B54294DE14BCE5AC79120B8FD242@FMSMSX119.amr.corp.intel.com>
	<715619802.10399931.1448546561295.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33863 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbK0Mxq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Nov 2015 07:53:46 -0500
Received: by lffu14 with SMTP id u14so128884862lff.1
        for <ceph-devel@vger.kernel.org>; Fri, 27 Nov 2015 04:53:45 -0800 (PST)
In-Reply-To: <715619802.10399931.1448546561295.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Mark Nelson <mnelson@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>

2015-11-26 15:02 GMT+01:00 Alexandre DERUMIER <aderumier@odiso.com>:
> Thanks for sharing !
>
> Results are impressive, Great to see that write are finally improving.
>
> I just wonder how much you could have with rbd_cache=false.

Do you have rbd_cache_writethrough_until_flush set to false? Otherwise
the fio tests will all run without write cache.

I have a patch for that out at
http://www.spinics.net/lists/fio/msg04385.html, would be great if
someone could test it.
