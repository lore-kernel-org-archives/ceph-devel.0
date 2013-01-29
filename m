From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Ceph Production Environment Setup?
Date: Tue, 29 Jan 2013 12:04:45 +0000
Message-ID: <5107BADD.6010107@inktank.com>
References: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:54799 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab3A2MFI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jan 2013 07:05:08 -0500
Received: by mail-lb0-f181.google.com with SMTP id gm6so607917lbb.26
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jan 2013 04:05:06 -0800 (PST)
In-Reply-To: <CAPhYxPxYfsWfY96OvSfzG9mNMphAY8z5U-zYDp3Vw2nZ1yWNjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 01/29/2013 02:56 AM, femi anjorin wrote:
> Please can anyone  an advise  on how exactly a CEPH production
> environment should look like? and what the configuration files should
> be. My hardwares include the following:
>
> Server A, B, C configuration
> CPU - Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz
> RAM - 16GB
> Hard drive -  500GB
> SSD - 120GB
>
> Server D,E,F,G,H,J configuration
> CPU - Intel(R) Atom(TM) CPU D525   @ 1.80GHz
> RAM - 4 GB
> Boot drive -  320gb
> SSD - 120 GB
> Storage drives - 16 X 2 TB
>
> I am thinking of these configurations but i am not sure.
> Server A - MDS and MON
> Server B - MON
> Server C - MON
> Server D, E,F,G,H,J - OSD
>

Those 16GB RAM on the monitor nodes vs the 4GB RAM on the osd nodes seem 
to be a bit wrong to me.  The OSDs tend to require much more RAM, for 
instance for recovery, while the monitor is not as heavy on the memory 
-- if a cluster grows significantly large, the in-memory maps may grow a 
lot too, but that reason alone shouldn't be the reason you would give a 
monitor 16GB RAM and 4GB for an osd.

Furthermore, I see you have 16x2TB storage drives.  Is that per OSD 
node?  I'm assuming that's what you're aiming to do, so how many OSDs 
were you thinking of running on the same host?  Usually we go for 1 OSD 
per drive, but you might have something else on your mind.  I am not an 
expert on server configuration, but my point is that, if you are going 
to have more than one OSD on the same host, your RAM sure looks smaller 
than what I would envision.

BTW, not sure if you're placing SSDs on the monitor/mds nodes with the 
same intent as when you place it on the OSD nodes (keeping the osd 
journal, maybe?), but if you indeed intend to keep the daemons journals 
in them I think you should know that the monitor and the mds don't keep 
a journal.  The monitors do keep a store on disk, but the mds don't even 
do that, instead keeping its data directly on the osds and whatever it 
needs in-memory.

   -Joao





