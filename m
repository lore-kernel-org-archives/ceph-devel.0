From: Sage Weil <sage@newdream.net>
Subject: Re: Stopping clusters in developer mode
Date: Tue, 6 Jun 2017 20:58:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706062057450.3646@piezo.novalocal>
References: <CAODUPsFSha2ER_EBgkguGnfaLLtJNf3ZU+Y2bYsNcZckPnZt6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59711 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFFU6b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 16:58:31 -0400
In-Reply-To: <CAODUPsFSha2ER_EBgkguGnfaLLtJNf3ZU+Y2bYsNcZckPnZt6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 6 Jun 2017, Oleg Kolosov wrote:
> Hi
> I'm writing an erasure code and would like to test it. I've built it
> (make) and brought up a virtual cluster (with vstart.sh). However, I
> can't stop an osd.
> My problem is that init-ceph exits here:
> 
> test -f $LIBEXECDIR/ceph_common.sh || exit 0
> 
> ceph_common.sh doesn't exist and I wonder what might be the reason for this.
> As I've mentioned, "make" is done successfully.

If you use the default locations then init-ceph and vstart should be able 
to find everything.

 git clone https://github.com/ceph/ceph
 cd ceph
 ./do_cmake.sh
 cd build
 make
 ../src/vstart.sh ...
 bin/init-ceph stop

sage
