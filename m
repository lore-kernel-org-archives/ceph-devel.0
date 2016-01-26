From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: pg rebalancing after taking osds out
Date: Tue, 26 Jan 2016 23:37:20 +0000
Message-ID: <DM2PR12MB0556F1A40510707BA6E06B819BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
References: <DM2PR12MB0556E3531B9E94EAF8131BCB9BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
 <alpine.DEB.2.11.1601261743440.6524@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0067.outbound.protection.outlook.com ([207.46.100.67]:63424
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752120AbcAZXh0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 18:37:26 -0500
In-Reply-To: <alpine.DEB.2.11.1601261743440.6524@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I noticed that if I actually remove the osds from the crush map,
(after using ceph osd out), that everything works as I would expect.

So at the time of the behavior mentioned below, (without removing from crush map)
the tree looked something like the following:  Sorry, I don't have the pg state
saved from that time, I could recreate it if needed.

ID WEIGHT   TYPE NAME                         UP/DOWN REWEIGHT PRIMARY-AFFINITY
-1 37.98688 root default
-2 12.66229     host node-01
 0  1.80890         osd.0                          up  1.00000          1.00000
 1  1.80890         osd.1                          up  1.00000          1.00000
 2  1.80890         osd.2                          up  1.00000          1.00000
 3  1.80890         osd.3                          up  1.00000          1.00000
 4  1.80890         osd.4                          up  1.00000          1.00000
 5  1.80890         osd.5                          up        0          1.00000
 6  1.80890         osd.6                          up        0          1.00000
-3 12.66229     host node-02
 7  1.80890         osd.7                          up  1.00000          1.00000
 8  1.80890         osd.8                          up  1.00000          1.00000
 9  1.80890         osd.9                          up  1.00000          1.00000
10  1.80890         osd.10                         up  1.00000          1.00000
11  1.80890         osd.11                         up  1.00000          1.00000
12  1.80890         osd.12                         up        0          1.00000
13  1.80890         osd.13                         up        0          1.00000
-4 12.66229     host node-03
14  1.80890         osd.14                         up  1.00000          1.00000
15  1.80890         osd.15                         up  1.00000          1.00000
16  1.80890         osd.16                         up  1.00000          1.00000
17  1.80890         osd.17                         up  1.00000          1.00000
18  1.80890         osd.18                         up  1.00000          1.00000
19  1.80890         osd.19                         up        0          1.00000
20  1.80890         osd.20                         up        0          1.00000

-- Tom


> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Tuesday, January 26, 2016 4:44 PM
> To: Deneau, Tom
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: pg rebalancing after taking osds out
> 
> On Tue, 26 Jan 2016, Deneau, Tom wrote:
> > I have a replicated x2 pool with the crush step of host.
> > When the pool was created there were 3 hosts with 7 osds each, and
> > looking at the pg-by-pool for that pool I can see that every pg has
> > copies on two different hosts.
> >
> > Now I want to take 2 osds out of each node, which I did using the osd
> > out command. (So there are then 5 osds per host node).
> >
> > Now I rerun ceph pg ls-by-pool for that pool and it shows that some
> > pgs have both their copies on the same node.
> >
> > Is this normal?  My expectation was that each pg still had its two
> > copies on two different hosts.
> 
> There those PGs in the 'remapped' state?  What does the tree look like
> ('ceph osd tree')?
> 
> sage
