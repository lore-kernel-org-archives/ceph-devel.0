From: Sage Weil <sage@newdream.net>
Subject: RE: historic ops showing up on unexpected osds
Date: Tue, 26 Jan 2016 09:41:45 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601260941140.6524@cpach.fuggernut.com>
References: <DM2PR12MB0556411468778691D8ED4CA79BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966091AbcAZOlf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 09:41:35 -0500
In-Reply-To: <DM2PR12MB0556411468778691D8ED4CA79BD80@DM2PR12MB0556.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "cbt@lists.ceph.com" <cbt@lists.ceph.com>

On Tue, 26 Jan 2016, Deneau, Tom wrote:
> And I assume when I see an op with a description like
>    "MOSDECSubOpRead(3.23s1 305 ECSubRead..."
> that this is the reading of the second chunk in a k=2,m=1 erasure pool?

Yes (although you can't tell k and m from the pgid--only that it's shard 
1).

sage


> 
> -- Tom
> 
> 
> > -----Original Message-----
> > From: Deneau, Tom
> > Sent: Monday, January 25, 2016 4:54 PM
> > To: ceph-devel@vger.kernel.org
> > Cc: cbt@lists.ceph.com
> > Subject: historic ops showing up on unexpected osds
> > 
> > I was looking at a performance discrepancy with reading objects
> > and I was looking at some historic ops and noticed several like this.
> > This is an erasure pool with k=2, m=1 so 3 chunks for each object.
> > 
> > When I look at the  pg mapping for this object shown below on this pool,
> > it is [12,14,6].
> > And indeed when I look at the actual pieces on disk, they are on the disks
> > that map to osds 12, 14, and 6.
> > 
> > Yet this osd for which this particular historic op showed up was osd 11.
> > And I have seen other historic ops mapped to this same pg, which showed up
> > for instance on osd 15.
> > Why would osd 11 or ods 15 be involved in this object at all?
> > 
> > -- Tom
> > 
> > 
> >         {
> >             "description": "osd_op(client.13056.0:2691 0-ggggjbjm []
> > 3.a3ebd1b8 ack+read+known_if_redirected e305)",
> >             "initiated_at": "2016-01-25 13:01:15.824133",
> >             "age": 60.812474,
> >             "duration": 8.913674,
> >             "type_data": [
> >                 "started",
> >                 {
> >                     "client": "client.13056",
> >                     "tid": 2691
> >                 },
> >                 [
> >                     {
> >                         "time": "2016-01-25 13:01:15.824133",
> >                         "event": "initiated"
> >                     },
> >                     {
> >                         "time": "2016-01-25 13:01:15.824258",
> >                         "event": "queued_for_pg"
> >                     },
> >                     {
> >                         "time": "2016-01-25 13:01:23.056172",
> >                         "event": "reached_pg"
> >                     },
> >                     {
> >                         "time": "2016-01-25 13:01:23.082064",
> >                         "event": "started"
> >                     },
> >                     {
> >                         "time": "2016-01-25 13:01:24.737807",
> >                         "event": "done"
> >                     }
> >                 ]
> >             ]
> >         },
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
