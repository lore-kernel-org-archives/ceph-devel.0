From: Gregory Farnum <greg@inktank.com>
Subject: Re: monitor not starting
Date: Wed, 4 Jul 2012 09:25:20 -0700
Message-ID: <D2569975C9B14D6B974C162C58FA7401@inktank.com>
References: <4FF42CD7.1060000@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62919 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084Ab2GDQZS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:25:18 -0400
Received: by pbbrp8 with SMTP id rp8so11252508pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jul 2012 09:25:17 -0700 (PDT)
In-Reply-To: <4FF42CD7.1060000@smart-weblications.de>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel@vger.kernel.org



On Wednesday, July 4, 2012 at 4:45 AM, Smart Weblications GmbH - Florian Wiessner wrote:

> Hi List,
> 
> 
> i today upgraded from 0.43 to 0.48 and now i have one monitor which does not
> want to start up anymore:
> 
> ceph version 0.48argonaut-125-g4e774fb
> (commit:4e774fbcb38fd6883232b72352512a5f8e4a66e8)
> 1: /usr/bin/ceph-mon() [0x52f9c9]
> 2: (()+0xeff0) [0x7fb08dd11ff0]
> 3: (gsignal()+0x35) [0x7fb08c4f41b5]
> 4: (abort()+0x180) [0x7fb08c4f6fc0]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fb08cd88dc5]
> 6: (()+0xcb166) [0x7fb08cd87166]
> 7: (()+0xcb193) [0x7fb08cd87193]
> 8: (()+0xcb28e) [0x7fb08cd8728e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x940)
> [0x55b310]
> 10: /usr/bin/ceph-mon() [0x497317]
> 11: (Monitor::init()+0xc5a) [0x4857fa]
> 12: (main()+0x2789) [0x46ac79]
> 13: (__libc_start_main()+0xfd) [0x7fb08c4e0c8d]
> 14: /usr/bin/ceph-mon() [0x468309]
> NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> 
> --- end dump of recent events ---
> 
> 
> How can i find out why it does not startup anymore? osd and mds is running fine..
Is that all the output you get? There should be a line somewhere which says what the assert is, and what line number it's on. :)

And while you're at it, is the rest of the cluster in fact working? I don't think 0.43 to 0.48 is an upgrade path we tested.

-Greg
