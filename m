From: Sage Weil <sage@newdream.net>
Subject: Re: cosd dying after start
Date: Tue, 10 Aug 2010 14:04:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008101358280.9792@cobra.newdream.net>
References: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
 <AANLkTi=_kCreuSdkywt2xgcPrHebR6tBODvNnguhXFrU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43527 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0HJVEU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Aug 2010 17:04:20 -0400
In-Reply-To: <AANLkTi=_kCreuSdkywt2xgcPrHebR6tBODvNnguhXFrU@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 10 Aug 2010, Christian Brunner wrote:

> After a bit more debuging I've found out that there seems to be a file
> missing from the filestore:
> 
> 10.08.10_18:14:07.862190 7f568d3e5710 filestore(/ceph/osd/osd02)
> getattr /ceph/osd/osd02/current/3.f2_head/rb.0.1d6.00000000000e_head
> '_' = -2

There was a bug last week in the kernel client rbd branch that was 
improperly encoding osd write operation payloads.  Can you check that your 
rbd client is running 79c49720, which fixes it?

That error above was probably just because that object hadn't been written 
yet, and isn't a fatal error.  There is a 'scrub' function that verifies 
that most of the osd metadata is in order and replication is accurate: 
'ceph osd scrub <osdnum>' and watch 'ceph -w' to see the success or error 
messages go by for each pg (or tail $mon_data/log on any monitor)

Thanks
sage



> 
> Is there something like fsck.cephfs ?
> 
> Christian
> 
> 2010/8/10 Christian Brunner <chb@muc.de>:
> > Hi,
> >
> > we have a problem with one cosd instance (v0.21) in our test
> > environment: It is dying 3 seconds after start with the message:
> >
> > terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'
> >
> > When I run with debugging on, the output looks like this:
> >
> > [...]
> > 10.08.10_17:25:33.187255 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).writer: state = 2 policy.server=1
> > 10.08.10_17:25:33.187331 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).writer encoding 1 0x7fac980ff6e0 osd_map(210,210) v1
> > 10.08.10_17:25:33.187396 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).writer sending 1 0x7fac980ff6e0
> > 10.08.10_17:25:33.187448 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).write_message 0x7fac980ff6e0
> > 10.08.10_17:25:33.187522 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).writer: state = 2 policy.server=1
> > 10.08.10_17:25:33.187559 7fac762e1710 -- 10.165.254.22:6800/2773 >>
> > 10.165.254.132:0/23863 pipe(0x7fac7c003f50 sd=25 pgs=70 cs=1
> > l=1).writer sleeping
> > terminate called after throwing an instance of 'ceph::buffer::end_of_buffer*'
> > 10.08.10_17:25:33.188116 7faca9b34710 -- 10.165.254.22:6800/2773 -->
> > client711674 10.165.254.131:0/1510 -- osd_map(210,210) v1 -- ?+0
> > 0x7fac98002260
> > 10.08.10_17:25:33.188162 7faca9b34710 -- 10.165.254.22:6800/2773
> > submit_message osd_map(210,210) v1 remote, 10.165.254.131:0/1510, have
> > pipe.
> > Aborted
> >
> > Any ideas?
> >
> > Thank you,
> >
> > Christian
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
