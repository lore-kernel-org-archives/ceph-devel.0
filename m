From: Sage Weil <sage@inktank.com>
Subject: Re: osd not in tree
Date: Fri, 16 Nov 2012 08:54:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211160852400.30220@cobra.newdream.net>
References: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com> <50A5EE14.6070108@inktank.com> <CAJiejCSiz54N8mzLB1SQyOr9ObsQ4aE4=ZaUahpkd3cOw4X+qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59509 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2KPQyL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 11:54:11 -0500
In-Reply-To: <CAJiejCSiz54N8mzLB1SQyOr9ObsQ4aE4=ZaUahpkd3cOw4X+qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Fri, 16 Nov 2012, Drunkard Zhang wrote:
> 2012/11/16 Josh Durgin <josh.durgin@inktank.com>:
> > On 11/15/2012 11:21 PM, Drunkard Zhang wrote:
> >>
> >> I installed mon x1, mds x1 and osd x11 in one host, then add some osd
> >> from other hosts, But they are not in osd tree, also not usable, how
> >> can I fix this?
> >>
> >> The crush command I used:
> >> ceph osd crush set 11 osd.11 3 pool=data datacenter=dh-1L, room=room1,
> >> row=02, rack=05, host=squid87-log13
> >
> >
> > Remove the commas in that command and it'll work. I fixed the docs for
> > this.
> >
> > Josh
> 
> Got no luck. osd.11.log said nothing useful. Do I have to edit
> crushmap manually? If so, how should I define host's 'id' value, I
> cannot find docs from ceph.com/docs since yesterday, where's that
> gone?
> 
> squid87-log13 ~ # ceph osd crush set 11 osd.11 3 pool=data
> datacenter=dh-1L room=room1 row=02 rack=05 host=squid87-log13

You're specifying 'pool=data', but:

> updated item id 11 name 'osd.11' weight 3 at location
> {datacenter=dh-1L,host=squid87-log13,pool=data,rack=05,room=room1,row=02}
> to crush map
> squid87-log13 ~ # ceph osd tree
> dumped osdmap tree epoch 467
> # id weight type name up/down reweight
> -1 36 pool default
> -3 36 rack unknownrack
> -2 36 host log3

the existing hierarchy has pool=default.  Change it to default above and 
you'll be okay.  You may want to restructure the existing hosts as well so 
they 'live' in the tree structure.

(This confusion is exactly why it's switched 'root=default' in the new 
releases.)

sage

> 0 3 osd.0 up 3
> 1 3 osd.1 up 3
> 2 3 osd.2 up 3
> 3 3 osd.3 up 3
> 4 3 osd.4 up 3
> 5 3 osd.5 up 3
> 6 3 osd.6 up 3
> 7 3 osd.7 up 3
> 8 3 osd.8 up 3
> 9 3 osd.9 up 3
> 10 3 osd.10 up 3
> 
> 11 0 osd.11 up 3
> 12 0 osd.12 up 3
> 13 0 osd.13 up 3
> 14 0 osd.14 up 3
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
