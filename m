From: Nathan Howell <nathan.d.howell@gmail.com>
Subject: Cephfs losing files and corrupting others
Date: Thu, 1 Nov 2012 09:22:59 -0700
Message-ID: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61154 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933996Ab2KAQXA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 12:23:00 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2708599obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 09:22:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

We have a small (3 node) Ceph cluster that occasionally has issues. It
loses files and directories, truncates them or fills the contents with
NULL bytes. So far we haven't been able to build a repro case but it
seems to happen when bulk loading data into the cluster, a process
that is run each evening by a cron job. We've gone about a month
without any issues but had it happen again yesterday during a larger
bulk load.  The data is backed up outside of ceph and can be reloaded
but finding the corrupt files takes quite a while.

Has anyone heard of similar issues before? Should I try upgrading to
0.48.2 or a newer kernel?

ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
Linux _ 3.4.4-gentoo #2 SMP Sun Jul 1 18:28:16 UTC 2012 x86_64
Intel(R) Xeon(R) CPU E31240 @ 3.30GHz GenuineIntel GNU/Linux

I'm using the kernel provided cephfs, mounted with these options:
10.0.2.2:6789:/ on /ceph type ceph (rw,noatime,nodiratime)

thanks,
-n
