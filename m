From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: RE: Ceph and bonnie++
Date: Sat, 30 Oct 2010 14:34:53 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6A6E@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
References: <14C7F4F06DB5814AB0DE29716C4F6D6710AA6958@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
 <AANLkTikRkB8oXoTdaxgTRB8vAdXJPOUHnyUH0wxf2_U6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail6.alcatel.fr ([64.208.49.42]:41166 "EHLO smail6.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab0J3Mi6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Oct 2010 08:38:58 -0400
In-Reply-To: <AANLkTikRkB8oXoTdaxgTRB8vAdXJPOUHnyUH0wxf2_U6@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

3 servers with each 2 OSDs, 1 MON and 1 MDS.

- Jan 

-----Original Message-----
From: gfarnum@gmail.com [mailto:gfarnum@gmail.com] On Behalf Of Gregory Farnum
Sent: vrijdag 29 oktober 2010 21:50
To: Smets, Jan (Jan)
Cc: ceph-devel@vger.kernel.org
Subject: Re: Ceph and bonnie++

On Fri, Oct 29, 2010 at 6:37 AM, Smets, Jan (Jan) <jan.smets@alcatel-lucent.com> wrote:
> client0:/mnt/ceph# bonnie -s 40 -r 10 -u root -f Using uid:0, gid:0.
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
Are you running this with one or many MDSes? It should be fine under a single MDS.

bonnie++ is one of the workloads we've had issues with on a multi-mds
system, although I thought we had it working at this point. I'll run our tests again now and see if I can reproduce locally.
-Greg
