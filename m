From: Sage Weil <sage@newdream.net>
Subject: Re: OSD crashing on startup (hammer)
Date: Tue, 13 Dec 2016 12:44:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612131243310.32565@piezo.novalocal>
References: <CADr68Wayt7JNGDUa8-=gbh0HOiqLFJwQcTOPT5O3QBUHcgCSJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56724 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcLMMpA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 07:45:00 -0500
In-Reply-To: <CADr68Wayt7JNGDUa8-=gbh0HOiqLFJwQcTOPT5O3QBUHcgCSJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Rosenboom <j.rosenboom@x-ion.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 13 Dec 2016, Jens Rosenboom wrote:
> We have seen an issue similar to http://tracker.ceph.com/issues/13594
> on a cluster running 0.94.7, where the OSD fails to start after we
> needed the powercycle the server. Can the issue be reopened as
> affecting hammer or shall I open a new issue?
> 
> ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0xbb1fab]
>  2: (PG::peek_map_epoch(ObjectStore*, spg_t, unsigned int*,
> ceph::buffer::list*)+0x885) [0x7c19b5]
>  3: (OSD::load_pgs()+0x9b7) [0x6b9cd7]
>  4: (OSD::init()+0x17c7) [0x6bd777]
>  5: (main()+0x2a31) [0x6480e1]
>  6: (__libc_start_main()+0xf5) [0x7f9711c9cf45]
>  7: /usr/bin/ceph-osd() [0x661147]
> 
> Updating to 0.94.9 has not helped.

It's unclear from the above with if it is really 13594 or something else.  
Can you capture a core file (ulimit -c unlimited ; ceph-osd -i NNN -f), 
install debug symbols (yum install ceph-debuginfo | apt-get install 
ceph-dbg), gdb, and post the backtrace?  'p values' from the crashing 
context.

Thanks!
sage

