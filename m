From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: rbd export speed limit
Date: Tue, 12 Feb 2013 23:45:08 +0300
Message-ID: <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com>
References: <511AA47B.3020309@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:63381 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864Ab3BLUpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 15:45:31 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so321087vbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 12:45:30 -0800 (PST)
In-Reply-To: <511AA47B.3020309@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

you may be interested in throttle(1) as a side solution with stdout
export option. By the way, on which interconnect you have manage to
get such speeds, if you mean 'commited' bytes(e.g. not almost empty
allocated image)?

On Wed, Feb 13, 2013 at 12:22 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi,
>
> is there a speed limit option for rbd export? Right now i'm able to produce
> several SLOW requests from IMPORTANT valid requests while just exporting a
> snapshot which is not really important.
>
> rbd export runs with 2400MB/s and each OSD with 250MB/s so it seems to block
> valid normal read / write operations.
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
