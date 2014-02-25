From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 4/6] rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
Date: Tue, 25 Feb 2014 14:53:12 +0200
Message-ID: <CALFYKtA7jNHk1OoPtvEd+SC-UK-sELBqJBhn=Ybbs5nzu61srg@mail.gmail.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
	<1393008946-7931-5-git-send-email-ilya.dryomov@inktank.com>
	<530B5E3E.7010101@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:48604 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaBYMxN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 07:53:13 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so306890qaq.29
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 04:53:12 -0800 (PST)
In-Reply-To: <530B5E3E.7010101@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 24, 2014 at 4:59 PM, Alex Elder <elder@ieee.org> wrote:
> On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
>> CEPH_OSD_MAX_OP value in rbd_osd_req_callback() is hard-coded to 2.
>> Fix it.
>
> Please squash this in with the previous patch (at least).
> Change the BUG_ON() to rbd_assert() while you're at it
> (and invert the logic).

Done.

Thanks,

                Ilya
