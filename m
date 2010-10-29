From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph and bonnie++
Date: Fri, 29 Oct 2010 12:49:59 -0700
Message-ID: <AANLkTikRkB8oXoTdaxgTRB8vAdXJPOUHnyUH0wxf2_U6@mail.gmail.com>
References: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6958@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48614 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761803Ab0J2TuA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 15:50:00 -0400
Received: by qyk12 with SMTP id 12so7072666qyk.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Oct 2010 12:49:59 -0700 (PDT)
In-Reply-To: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6958@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Oct 29, 2010 at 6:37 AM, Smets, Jan (Jan)
<jan.smets@alcatel-lucent.com> wrote:
> client0:/mnt/ceph# bonnie -s 40 -r 10 -u root -f
> Using uid:0, gid:0.
> Writing intelligently...done
> Rewriting...done
> Reading intelligently...done
> start 'em...done...done...done...
> Create files in sequential order...done.
> Stat files in sequential order...Expected 16384 files but only got 0
> Cleaning up test directory after error.
>
>
> Any suggestions? There was a thread about this some time ago:
Are you running this with one or many MDSes? It should be fine under a
single MDS.

bonnie++ is one of the workloads we've had issues with on a multi-mds
system, although I thought we had it working at this point. I'll run
our tests again now and see if I can reproduce locally.
-Greg
