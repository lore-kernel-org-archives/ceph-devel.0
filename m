From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Thu, 26 Jun 2014 11:53:20 +0900
Message-ID: <20140626115320.4943c0e0@batzmaru.gol.ad.jp>
References: <539B11C4.1010400@profihost.ag>
	<CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.dentaku.gol.com ([203.216.5.71]:54958 "EHLO
	smtp01.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaFZCxY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 22:53:24 -0400
In-Reply-To: <CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Wed, 25 Jun 2014 17:17:02 -0700 Gregory Farnum wrote:

> Sorry we let this drop; we've all been busy traveling and things.
> 
> There have been a lot of changes to librados between Dumpling and
> Firefly, but we have no idea what would have made it slower. Can you
> provide more details about how you were running these tests?

This sounds a lot like what I saw when going from Emperor to Firefly, see
my post from a month ago:
https://www.mail-archive.com/ceph-users@lists.ceph.com/msg10095.html

Though the decrease in IOPS is even higher.

Regards,

Christian


> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> 
> On Fri, Jun 13, 2014 at 7:59 AM, Stefan Priebe <s.priebe@profihost.ag>
> wrote:
> > Hi,
> >
> > while testint firefly i cam into the sitation where i had a client
> > where the latest dumpling packages where installed (0.67.9).
> >
> > As my pool has hashppool false and the tunables are set to default it
> > can talk to my firefly ceph sotrage.
> >
> > For random 4k writes using fio with librbd and 32 jobs and an iodepth
> > of 32.
> >
> > I get these results:
> >
> > librbd / librados2 from dumpling:
> >   write: io=3020.9MB, bw=103083KB/s, iops=25770, runt= 30008msec
> >   WRITE: io=3020.9MB, aggrb=103082KB/s, minb=103082KB/s,
> > maxb=103082KB/s, mint=30008msec, maxt=30008msec
> >
> > librbd / librados2 from firefly:
> >   write: io=7344.3MB, bw=83537KB/s, iops=20884, runt= 90026msec
> >   WRITE: io=7344.3MB, aggrb=83537KB/s, minb=83537KB/s, maxb=83537KB/s,
> > mint=90026msec, maxt=90026msec
> >
> > Stefan
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 


-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Fusion Communications
http://www.gol.com/
