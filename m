From: Sage Weil <sage@inktank.com>
Subject: Re: osd not in tree
Date: Fri, 16 Nov 2012 20:55:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211162053570.31628@cobra.newdream.net>
References: <CAJiejCR3CocWucemBR1++dAohOASLSidnwCc9G=2cREFuTTXXQ@mail.gmail.com> <50A5EE14.6070108@inktank.com> <CAJiejCSiz54N8mzLB1SQyOr9ObsQ4aE4=ZaUahpkd3cOw4X+qA@mail.gmail.com> <alpine.DEB.2.00.1211160852400.30220@cobra.newdream.net>
 <CAJiejCRddL_-u32uBxD8vuNXJxc4=36+aneW_L4wAa0OO6atOQ@mail.gmail.com> <alpine.DEB.2.00.1211161558040.26514@cobra.newdream.net> <CAJiejCRFD0+qMwVWXX5rSKAU9-8d6LZf545g9Vi88Vyb=uaRoA@mail.gmail.com> <alpine.DEB.2.00.1211161654480.26514@cobra.newdream.net>
 <CAJiejCTDh9FkKm65sjy6xy6nVr1A6m0wys2_JMkA6GV8p__qig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38615 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab2KQEzT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 23:55:19 -0500
In-Reply-To: <CAJiejCTDh9FkKm65sjy6xy6nVr1A6m0wys2_JMkA6GV8p__qig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Drunkard Zhang <gongfan193@gmail.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Sat, 17 Nov 2012, Drunkard Zhang wrote:
> 2012/11/17 Sage Weil <sage@inktank.com>:
> > Hi,
> >
> > Okay, it looks something in the past added the host entry but for some
> > reason didn't give it a parent.  Did you previously modify the crush map
> > by hand, or did you only manipulate it via the 'ceph osd crush ...'
> > commands?
> >
> > Unfortuantely the fix is manually edit it.
> >
> > ceph osd getcrushmap -o /tmp/foo
> > crushtool -d /tmp/foo -o /tmp/foo.txt
> > edit foo.txt.  remove the host bucket (squid87-log13) and all of it's
> > children.
> > crushtool -c /tmp/foo.txt -o /tmp/foo.new
> > cpeh osd setcrushmap -i /tmp/foo.new
> >
> > and then you can re-run those 'ceph osd crush set ...' commands and you'll
> > be back in business.
> >
> Great, it works. now I remember I was trying to add host by hand while
> 'ceph osd crush set ...' failed (maybe command is wrong).
> 
> Another problem: is there any chance to change 'rack'? Or how to
> create a new rack? If I have to create a new rack first, I made
> mistake, or maybe buggy again.
> 
> Before change rack:
> log3 ~ # ceph osd tree
> dumped osdmap tree epoch 611
> # id weight type name up/down reweight
> -1 45 pool default
> -3 45 rack rack0205
> -2 33 host log3
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
> -4 12 host squid87-log13
> 11 3 osd.11 up 3
> 12 3 osd.12 up 3
> 13 3 osd.13 up 3
> 14 3 osd.14 up 3
> 
> Looks reasonable, but log3 miss set rack, I wanna change rack=rack0205
> to rack=rack0206),  reset use this command, but not works:
> for i in {0..10}; do ceph osd crush set $i osd.$i 3 pool=data
> datacenter=dh-1L room=room1 row=02 rack=rack0206 host=log3; done

'ceph osd crush set ...' will only move the device itself; it won't move 
any of its parents.  If you want to move a non-leaf item in the tree, use 
'ceph osd crush move <name> <location ...>'.  Something like

 ceph osd crush move squid87-log13 rack=0206 pool=default
 ceph osd crush move log3 rack=0206 pool=default

sage

