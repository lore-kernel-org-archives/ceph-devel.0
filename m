From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 14/14] libceph: drop osd ref when canceling con work
Date: Tue, 8 Jul 2014 15:22:13 +0400
Message-ID: <CALFYKtCRNkD78E7m5Bky0Jn5dY9r-c82gRc9KuYgXY-UQYLENw@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-15-git-send-email-ilya.dryomov@inktank.com>
	<53BB216D.2010207@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:52908 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaGHLWO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 07:22:14 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so4785367qac.35
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 04:22:13 -0700 (PDT)
In-Reply-To: <53BB216D.2010207@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 8, 2014 at 2:38 AM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> queue_con() bumps osd ref count.  We should do the reverse when
>> canceling con work.
>
> Kind of unrelated to the rest of the series, but it looks
> good.  Good to have a same-level-of-abstraction function
> for it as well.

This series is really "everything I stumbled upon while fixing #6628" ;)

Thanks,

                Ilya
