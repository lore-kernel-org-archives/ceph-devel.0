From: Gregory Farnum <greg@inktank.com>
Subject: Re: Any way to list the keys&values of omap in certain range?
Date: Mon, 27 Oct 2014 10:55:59 -0700
Message-ID: <CAPYLRzjyhzO3Zw9oW71xL+yjLvCNPJL1+xgWq3nhQZJH1Q_SHQ@mail.gmail.com>
References: <CAJu7gM1M=He7Qzxc9q8-wLEGqSVoJH-MCr_2UsE_G5GRJuLjNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:41869 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbaJ0R4A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 13:56:00 -0400
Received: by mail-qc0-f171.google.com with SMTP id m20so4243221qcx.30
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 10:55:59 -0700 (PDT)
In-Reply-To: <CAJu7gM1M=He7Qzxc9q8-wLEGqSVoJH-MCr_2UsE_G5GRJuLjNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Plato Zhang <sangongs@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Software Engineer #42 @ http://inktank.com | http://ceph.com
On Mon, Oct 27, 2014 at 1:52 AM, Plato Zhang <sangongs@gmail.com> wrote:
> Hi, all!
>
> We are trying to utilize omap to store kv map.
>
> However, we couldn't find a proper way to scan a certain key range of omap.
>
> We do can use arg `max_return' to finish this job by iterating .
> But if `max_return' is set too large, then there will be io waste
> while the number of keys is few.
> On the contrary, if it is set too small, then there will also be waste
> while the number of keys is too many.
>
> Is there any solution?

This functionality is not implemented in RADOS right now. It sounds
like a good feature though! You can submit feature requests at
tracker.ceph.com, or send in PRs. I think this should be fairly simple
to implement, based on the "CEPH_OSD_OP_OMAPGETKEYS" section of
ReplicatedPG::do_osd_ops, and then following the patterns in exposing
it via librados.
-Greg
