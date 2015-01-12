From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ceph_test_librbd_fsx fails with thrasher
Date: Mon, 12 Jan 2015 09:28:00 -0800
Message-ID: <54B40420.7020603@inktank.com>
References: <54B3D9B0.2050906@dachary.org>	<54B3FD59.6070808@inktank.com> <CALFYKtDPdH4NHmEFQiVxjOx-qieYPxfoKjg0rLmj03d7GwRJGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63032 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbALR2D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 12:28:03 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so31526632pdi.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 09:28:03 -0800 (PST)
In-Reply-To: <CALFYKtDPdH4NHmEFQiVxjOx-qieYPxfoKjg0rLmj03d7GwRJGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 01/12/2015 09:13 AM, Ilya Dryomov wrote:
> Speaking of fsx and thrasher.  Last time I tried fsx (both kernel and
> librbd) couldn't survive thrashing due to watch/notify troubles.  Are
> all the new watch/notify pieces that were supposed to fix this in?

There's just one bug left afaik: https://github.com/ceph/ceph/pull/3281

