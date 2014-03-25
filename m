From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 15:41:50 -0500
Message-ID: <5331EA0E.2040409@ieee.org>
References: <1395736765.2823.29.camel@localhost>	 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>	 <53316D18.7040103@ieee.org>	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>	 <53317BC2.9010700@ieee.org>	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>	 <5331D2E8.6060002@ieee.org>	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com> <1395778894.2076.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:64786 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbaCYUlb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 16:41:31 -0400
Received: by mail-vc0-f170.google.com with SMTP id hu19so1307362vcb.15
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 13:41:31 -0700 (PDT)
In-Reply-To: <1395778894.2076.12.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>, Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 03:21 PM, Olivier Bonvalet wrote:
> Mar 25 21:17:58 murmillia kernel: [ 2205.255933] rbd_img_obj_callback: bad image object request information:
> Mar 25 21:17:58 murmillia kernel: [ 2205.255938] obj_request ffff88025a2b3c48
> Mar 25 21:17:58 murmillia kernel: [ 2205.255940]     ->object_name <rb.0.1536881.238e1f29.000000000439>
> Mar 25 21:17:58 murmillia kernel: [ 2205.255941]     ->offset 0
> Mar 25 21:17:58 murmillia kernel: [ 2205.255943]     ->length 28672
> Mar 25 21:17:58 murmillia kernel: [ 2205.255944]     ->type 0x1
> Mar 25 21:17:58 murmillia kernel: [ 2205.255945]     ->flags 0x3
> Mar 25 21:17:58 murmillia kernel: [ 2205.255946]     ->which 1
> Mar 25 21:17:58 murmillia kernel: [ 2205.255948]     ->xferred 28672
> Mar 25 21:17:58 murmillia kernel: [ 2205.255949]     ->result 0
> Mar 25 21:17:58 murmillia kernel: [ 2205.255950] img_request ffff8802536c4a60
> Mar 25 21:17:58 murmillia kernel: [ 2205.255952]     ->snap 0xffff880257f85ec0
> Mar 25 21:17:58 murmillia kernel: [ 2205.255953]     ->offset 4534026240
> Mar 25 21:17:58 murmillia kernel: [ 2205.255954]     ->length 45056
> Mar 25 21:17:58 murmillia kernel: [ 2205.255955]     ->flags 0x1

The image request has IMG_REQ_CHILD set.  That means it's a request
sent to a parent image.

I see one thing that I'm suspicious of, but I'll need to look at it
a bit to see if it's really a problem.

In rbd_parent_request_destroy(), should this last line:
        rbd_img_request_destroy(kref);
be this instead?
	rbd_img_request_put(parent_request);

And get rid of this line above that:
        img_request_child_clear(parent_request);

Something to look at.  Also the fact that it's a parent
request with two objects involved seems strange, but
again, I'm just speculating at this point.

					-Alex

> Mar 25 21:17:58 murmillia kernel: [ 2205.255957]     ->obj_request_count 1
> Mar 25 21:17:58 murmillia kernel: [ 2205.255958]     ->next_completion 2
> Mar 25 21:17:58 murmillia kernel: [ 2205.255959]     ->xferred 45056
> Mar 25 21:17:58 murmillia kernel: [ 2205.255960]     ->result 0

