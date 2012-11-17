From: Sage Weil <sage@inktank.com>
Subject: Re: osd not in tree
Date: Fri, 16 Nov 2012 16:57:30 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211161654480.26514@cobra.newdream.net>
References: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com> <50A5EE14.6070108@inktank.com> <CAJiejCSiz54N8mzLB1SQyOr9ObsQ4aE4=ZaUahpkd3cOw4X+qA@mail.gmail.com> <alpine.DEB.2.00.1211160852400.30220@cobra.newdream.net>
 <CAJiejCRddL_-u32uBxD8vuNXJxc4=36+aneW_L4wAa0OO6atOQ@mail.gmail.com> <alpine.DEB.2.00.1211161558040.26514@cobra.newdream.net> <CAJiejCRFD0+qMwVWXX5rSKAU9-8d6LZf545g9Vi88Vyb=uaRoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36660 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2KQA5b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 19:57:31 -0500
In-Reply-To: <CAJiejCRFD0+qMwVWXX5rSKAU9-8d6LZf545g9Vi88Vyb=uaRoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Hi,

Okay, it looks something in the past added the host entry but for some 
reason didn't give it a parent.  Did you previously modify the crush map 
by hand, or did you only manipulate it via the 'ceph osd crush ...' 
commands?

Unfortuantely the fix is manually edit it.

ceph osd getcrushmap -o /tmp/foo
crushtool -d /tmp/foo -o /tmp/foo.txt
edit foo.txt.  remove the host bucket (squid87-log13) and all of it's 
children.
crushtool -c /tmp/foo.txt -o /tmp/foo.new
cpeh osd setcrushmap -i /tmp/foo.new

and then you can re-run those 'ceph osd crush set ...' commands and you'll 
be back in business.

I just found a bug in the 'ceph osd crush move ...' command that prevents 
us from repairing that way; that fix will be in bobtail.

sage



On Sat, 17 Nov 2012, Drunkard Zhang wrote:
> 2012/11/17 Sage Weil <sage@inktank.com>:
> > On Sat, 17 Nov 2012, Drunkard Zhang wrote:
> >> 2012/11/17 Sage Weil <sage@inktank.com>:
> >> > On Fri, 16 Nov 2012, Drunkard Zhang wrote:
> >> >> 2012/11/16 Josh Durgin <josh.durgin@inktank.com>:
> >> >> > On 11/15/2012 11:21 PM, Drunkard Zhang wrote:
> >> >> >>
> >> >> >> I installed mon x1, mds x1 and osd x11 in one host, then add some osd
> >> >> >> from other hosts, But they are not in osd tree, also not usable, how
> >> >> >> can I fix this?
> >> >> >>
> >> >> >> The crush command I used:
> >> >> >> ceph osd crush set 11 osd.11 3 pool=data datacenter=dh-1L, room=room1,
> >> >> >> row=02, rack=05, host=squid87-log13
> >> >> >
> >> >> >
> >> >> > Remove the commas in that command and it'll work. I fixed the docs for
> >> >> > this.
> >> >> >
> >> >> > Josh
> >> >>
> >> >> Got no luck. osd.11.log said nothing useful. Do I have to edit
> >> >> crushmap manually? If so, how should I define host's 'id' value, I
> >> >> cannot find docs from ceph.com/docs since yesterday, where's that
> >> >> gone?
> >> >>
> >> >> squid87-log13 ~ # ceph osd crush set 11 osd.11 3 pool=data
> >> >> datacenter=dh-1L room=room1 row=02 rack=05 host=squid87-log13
> >> >
> >> > You're specifying 'pool=data', but:
> >> >
> >> >> updated item id 11 name 'osd.11' weight 3 at location
> >> >> {datacenter=dh-1L,host=squid87-log13,pool=data,rack=05,room=room1,row=02}
> >> >> to crush map
> >> >> squid87-log13 ~ # ceph osd tree
> >> >> dumped osdmap tree epoch 467
> >> >> # id weight type name up/down reweight
> >> >> -1 36 pool default
> >> >> -3 36 rack unknownrack
> >> >> -2 36 host log3
> >> >
> >> > the existing hierarchy has pool=default.  Change it to default above and
> >> > you'll be okay.  You may want to restructure the existing hosts as well so
> >> > they 'live' in the tree structure.
> >> >
> >> Still no luck. I'm using 0.51, not update yet. Set host=log3 make
> >> osd.{11..14} usable, so I'm thinking I have to create the
> >> host=squid87-log13 first, how could I create the host, modify
> >> crushmap?
> >>
> >> log3 ~ # for i in {11..14}; do ceph osd crush set $i osd.$i 3
> >> pool=default datacenter=dh-1L room=room1 row=02 rack=rack0205
> >> host=squid87-log13; done
> >> updated item id 11 name 'osd.11' weight 3 at location
> >> {datacenter=dh-1L,host=squid87-log13,pool=default,rack=rack0205,room=room1,row=02}
> >> to crush map
> >> updated item id 12 name 'osd.12' weight 3 at location
> >> {datacenter=dh-1L,host=squid87-log13,pool=default,rack=rack0205,room=room1,row=02}
> >> to crush map
> >> updated item id 13 name 'osd.13' weight 3 at location
> >> {datacenter=dh-1L,host=squid87-log13,pool=default,rack=rack0205,room=room1,row=02}
> >> to crush map
> >> updated item id 14 name 'osd.14' weight 3 at location
> >> {datacenter=dh-1L,host=squid87-log13,pool=default,rack=rack0205,room=room1,row=02}
> >> to crush map
> >> log3 ~ # ceph osd tree
> >> dumped osdmap tree epoch 559
> >> # id weight type name up/down reweight
> >> -1 33 pool default
> >> -3 33 rack rack0205
> >> -2 33 host log3
> >> 0 3 osd.0 up 3
> >> 1 3 osd.1 up 3
> >> 2 3 osd.2 up 3
> >> 3 3 osd.3 up 3
> >> 4 3 osd.4 up 3
> >> 5 3 osd.5 up 3
> >> 6 3 osd.6 up 3
> >> 7 3 osd.7 up 3
> >> 8 3 osd.8 up 3
> >> 9 3 osd.9 up 3
> >> 10 3 osd.10 up 3
> >>
> >> 11 0 osd.11 up 3
> >> 12 0 osd.12 up 3
> >> 13 0 osd.13 up 3
> >> 14 0 osd.14 up 3
> >
> > Can you do
> >
> >  ceph osd getcrushmap -o /tmp/foo
> >  crushtool -d /tmp/foo
> >
> > and attach the output?
> >
> # begin crush map
> 
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> device 4 osd.4
> device 5 osd.5
> device 6 osd.6
> device 7 osd.7
> device 8 osd.8
> device 9 osd.9
> device 10 osd.10
> device 11 osd.11
> device 12 osd.12
> device 13 osd.13
> device 14 osd.14
> 
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 row
> type 4 room
> type 5 datacenter
> type 6 pool
> 
> # buckets
> host log3 {
> id -2 # do not change unnecessarily
> # weight 33.000
> alg straw
> hash 0 # rjenkins1
> item osd.0 weight 3.000
> item osd.1 weight 3.000
> item osd.2 weight 3.000
> item osd.3 weight 3.000
> item osd.4 weight 3.000
> item osd.5 weight 3.000
> item osd.6 weight 3.000
> item osd.7 weight 3.000
> item osd.8 weight 3.000
> item osd.9 weight 3.000
> item osd.10 weight 3.000
> }
> rack rack0205 {
> id -3 # do not change unnecessarily
> # weight 33.000
> alg straw
> hash 0 # rjenkins1
> item log3 weight 33.000
> }
> pool default {
> id -1 # do not change unnecessarily
> # weight 33.000
> alg straw
> hash 0 # rjenkins1
> item rack0205 weight 33.000
> }
> host squid87-log13 {
> id -4 # do not change unnecessarily
> # weight 12.000
> alg straw
> hash 0 # rjenkins1
> item osd.12 weight 3.000
> item osd.13 weight 3.000
> item osd.14 weight 3.000
> item osd.11 weight 3.000
> }
> 
> # rules
> rule data {
> ruleset 0
> type replicated
> min_size 1
> max_size 10
> step take default
> step choose firstn 0 type osd
> step emit
> }
> rule metadata {
> ruleset 1
> type replicated
> min_size 1
> max_size 10
> step take default
> step choose firstn 0 type osd
> step emit
> }
> rule rbd {
> ruleset 2
> type replicated
> min_size 1
> max_size 10
> step take default
> step choose firstn 0 type osd
> step emit
> }
> # end crush map
> 
> I tried to add squid87-log13 into rack0205, but failed. Just add one
> line "item squid87-log13 weight 12.000" into rack rack0205 section.
> 
> log3 ~ # crushtool -c crushmap-1117-txt -o crushmap-1117-new
> item 'squid87-log13' in bucket 'rack0205' is not defined
> item 'rack0205' in bucket 'default' is not defined
> in rule 'data' item 'default' not defined
> in rule 'metadata' item 'default' not defined
> in rule 'rbd' item 'default' not defined
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
