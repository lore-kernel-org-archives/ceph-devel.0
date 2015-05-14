From: Samuel Just <sjust@redhat.com>
Subject: Re: which osds get used for ec pool reads?
Date: Thu, 14 May 2015 16:20:27 -0400 (EDT)
Message-ID: <1682320147.21315899.1431634827875.JavaMail.zimbra@redhat.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166448682@SATLEXDAG01.amd.com> <1146045701.21089476.1431622348438.JavaMail.zimbra@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8C782@SACMBXIP01.sdcorp.global.sandisk.com> <CAC6JEv_xsOVPh2RxRgGD=K2Q0bj_u13TmgkAhP1Jn5CEWMJLgw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8C854@SACMBXIP01.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1505141255410.10788@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:43672 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161074AbbENUUj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 16:20:39 -0400
In-Reply-To: <alpine.DEB.2.00.1505141255410.10788@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Gregory Farnum <greg@gregs42.com>, Tom Deneau <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

It should really be a pool property.
-Sam

----- Original Message -----
From: "Sage Weil" <sage@newdream.net>
To: "Somnath Roy" <Somnath.Roy@sandisk.com>
Cc: "Gregory Farnum" <greg@gregs42.com>, "Samuel Just" <sjust@redhat.com>, "Tom Deneau" <tom.deneau@amd.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Thursday, May 14, 2015 12:56:51 PM
Subject: RE: which osds get used for ec pool reads?

On Thu, 14 May 2015, Somnath Roy wrote:
> Greg,
> I think the Yahoo data missing an important factor what is the cpu 
> overhead of doing that since we have to decode everytime..In flash 
> environment cpu is an important factor as we can run of that 
> easily..Yes, it is reducing tail latencies but probably not every 
> application is latency sensitive..
> It will be good if we can evaluate every pros/cons of this approach..IMO 
> there should be a config option of selecting one over another..In that 
> case, we can easily evaluate the benefits.

Dont worry, there is a config option need to enable this and it's off by 
default.

sage


> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Gregory Farnum [mailto:greg@gregs42.com] 
> Sent: Thursday, May 14, 2015 11:34 AM
> To: Somnath Roy
> Cc: Samuel Just; Tom Deneau; ceph-devel
> Subject: Re: which osds get used for ec pool reads?
> 
> On Thu, May 14, 2015 at 11:23 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Sam,
> > It seems the current code is optimized for performance. So, what's the advantage the new changes are bringing ?
> > Every time we will be doing decoding then ?
> 
> If you read every block, you increase the amount of data accessed but can avoid the long tail latencies. There are a bunch of research papers about these tradeoffs and the surprising latency improvements you can get on the aggregate read, and Yahoo! talked about this in their blog post on their use of Ceph. :) -Greg
> 
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org 
> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Samuel Just
> > Sent: Thursday, May 14, 2015 9:52 AM
> > To: Tom Deneau
> > Cc: ceph-devel
> > Subject: Re: which osds get used for ec pool reads?
> >
> > There is a branch which may merge soonish which will optionally read from all shards and use the first N.  It's not merged yet.  If the pgs are healthy, the current behavior is to read from the data shards (since you don't need to perform a decode in that case).
> > -Sam
> >
> > ----- Original Message -----
> > From: "Tom Deneau" <tom.deneau@amd.com>
> > To: "ceph-devel" <ceph-devel@vger.kernel.org>
> > Sent: Thursday, May 14, 2015 9:27:14 AM
> > Subject: which osds get used for ec pool reads?
> >
> > I am looking at disk activity on reads from an erasure coded pool (k=2, m=1).
> > I have a contrived setup where I am reading a bunch of names that are all in the same PG.  I see disk activity only from the 2 K osds, not the M osd.
> >
> > As I understand http://ceph.com/docs/master/architecture/,  in this situation all 3 osds would be read and the first two to return would be used but that is not what I see.
> >
> > In this particular contrived setup, all of the OSDs are on a single node, would that be causing the 2-OSD read behavior that I am seeing?
> >
> > -- Tom Deneau
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> > ________________________________
> >
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> >
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


