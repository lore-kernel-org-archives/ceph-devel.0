From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: ceph-disk vs keyvaluestore
Date: Tue, 30 Sep 2014 10:23:07 +0800
Message-ID: <CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:44651 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbaI3CXJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 22:23:09 -0400
Received: by mail-we0-f171.google.com with SMTP id w61so1369355wes.30
        for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 19:23:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>

No problem, I would like do it.

On Tue, Sep 30, 2014 at 7:48 AM, Sage Weil <sweil@redhat.com> wrote:
> Hi Haomai,
>
> Not sure if you saw
>
>         http://tracker.ceph.com/issues/9580
>
> which came from an issue Mark had getting ceph-disk to work with the
> keyvaluestore backend.  I think the answer is to make a command
> like
>
>         ceph-osd -i 123 --check-needs-journal
>
> to query whether the configured backend wants a journal backend.  That
> would let ceph-disk skip the work.  Would need to be careful to
> distinguish between errors and a true/false answer.
>
> Any interest in wiring that up?
> sage
>



-- 
Best Regards,

Wheat
