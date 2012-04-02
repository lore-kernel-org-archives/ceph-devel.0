From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Failed HD, automate procedure?
Date: Mon, 2 Apr 2012 09:23:04 -0700
Message-ID: <CAORUGqAoX1XR_TfqQ0i37ji3Wzm2Ab4YexsFJrX-dw6+p6DaXw@mail.gmail.com>
References: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40199 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab2DBQXZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 12:23:25 -0400
Received: by vbbff1 with SMTP id ff1so1803168vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Apr 2012 09:23:24 -0700 (PDT)
In-Reply-To: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marco Aroldi <marco.aroldi@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 2, 2012 at 03:31, Marco Aroldi <marco.aroldi@gmail.com> wrote:
> i'm looking the procedure to replace a failed HD
> (http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD)
> and I was wondering if the procedure could be more automated like:
>
> 1- The operator replaces the failed hd, say osd.23
> 2- Give a new command like "ceph reborn osd.23"

To echo what Wido said, this is definitely in the plan. The goal is
something like this:

- failed disk is unmounted and the "service light" is set (where available)
- a technician pulls out the failed disk and plugs in a prepared new one
- new disk is automatically taken into use, a new osd is started
- later, the failed disk can be examined and recovered, if desired; OR
  the osd that used that disk is deleted from the monitors and the disk
  discarded
