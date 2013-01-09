From: Sage Weil <sage@inktank.com>
Subject: Re: recoverying from 95% full osd
Date: Tue, 8 Jan 2013 22:52:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301082251590.2227@cobra.newdream.net>
References: <CAD5ewroRv5-F0ZxBUmXqjz77zNenHQsrBacJ7LgXCqyduoxHsQ@mail.gmail.com> <CAPYLRzjv2tjndJCAgCqj8uBcGdC4vCiU1hd3oG2MdqLA7fW3Yg@mail.gmail.com> <CAD5ewrrKB0kxMDq2Hg-XStQUdVhjtgTWvmb3OoZTzHcZ3wpUrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60546 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab3AIGwx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 01:52:53 -0500
In-Reply-To: <CAD5ewrrKB0kxMDq2Hg-XStQUdVhjtgTWvmb3OoZTzHcZ3wpUrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 9 Jan 2013, Roman Hlynovskiy wrote:
> Thanks a lot Greg,
> 
> that was the black magic command I was looking for )
> 
> I deleted some obsolete data and reached those figures:
> 
> chef@cephgw:~$ ./clu.sh exec "df -kh"|grep osd
> /dev/mapper/vg00-osd  252G  153G  100G  61% /var/lib/ceph/osd/ceph-0
> /dev/mapper/vg00-osd  252G  180G   73G  72% /var/lib/ceph/osd/ceph-1
> /dev/mapper/vg00-osd  252G  213G   40G  85% /var/lib/ceph/osd/ceph-2
> 
> which in comparison to previous one:
> 
> /dev/mapper/vg00-osd  252G  173G   80G  69% /var/lib/ceph/osd/ceph-0
> /dev/mapper/vg00-osd  252G  203G   50G  81% /var/lib/ceph/osd/ceph-1
> /dev/mapper/vg00-osd  252G  240G   13G  96% /var/lib/ceph/osd/ceph-2
> 
> show that 20gig were removed from osd-1, 23gig from osd-2 and 27gig from osd-3.
> So, cleaned up space also has some disproportion.
> 
> at the same time:
> chef@cephgw:~$ ceph osd tree
> 
> # id    weight    type name    up/down    reweight
> -1    3    pool default
> -3    3        rack unknownrack
> -2    1            host ceph-node01
> 0    1                osd.0    up    1
> -4    1            host ceph-node02
> 1    1                osd.1    up    1
> -5    1            host ceph-node03
> 2    1                osd.2    up    1
> 
> 
> all osd weights are the same. I guess there is no automatic way to
> balance storage usage for my case and I have to play with osd weights
> using 'ceph osd reweight-by-utilization xx' until storage is used more
> or less equally and when get the weights back to 1?

How many pgs do you have?  ('ceph osd dump | grep ^pool').

You might also adjust the crush tunables, see

	http://ceph.com/docs/master/rados/operations/crush-map/?highlight=tunable#tunables

sage

> 
> 
> 
> 2013/1/8 Gregory Farnum <greg@inktank.com>:
> > On Tue, Jan 8, 2013 at 2:42 AM, Roman Hlynovskiy
> > <roman.hlynovskiy@gmail.com> wrote:
> >> Hello,
> >>
> >> I am running ceph v0.56 and at the moment trying to recover ceph which
> >> got completely stuck after 1 osd got filled by 95%. Looks like the
> >> distribution algorithm is not perfect since all 3 OSD's I user are
> >> 256Gb each, however one of them got filled faster than others:
> >>
> >> osd-1:
> >> Filesystem            Size  Used Avail Use% Mounted on
> >> /dev/mapper/vg00-osd  252G  173G   80G  69% /var/lib/ceph/osd/ceph-0
> >>
> >> osd-2:
> >> Filesystem            Size  Used Avail Use% Mounted on
> >> /dev/mapper/vg00-osd  252G  203G   50G  81% /var/lib/ceph/osd/ceph-1
> >>
> >> osd-3:
> >> Filesystem            Size  Used Avail Use% Mounted on
> >> /dev/mapper/vg00-osd  252G  240G   13G  96% /var/lib/ceph/osd/ceph-2
> >>
> >>
> >> by the moment mds is showing the following behaviour:
> >> 2013-01-08 16:25:47.006354 b4a73b70  0 mds.0.objecter  FULL, paused
> >> modify 0x9ba63c0 tid 23448
> >> 2013-01-08 16:26:47.005211 b4a73b70  0 mds.0.objecter  FULL, paused
> >> modify 0xca86c30 tid 23449
> >>
> >> so, it does not respond to any mount requests
> >>
> >> I've played around with all types of commands like:
> >> ceph mon tell \* injectargs '--mon-osd-full-ratio 98'
> >> ceph mon tell \* injectargs '--mon-osd-full-ratio 0.98'
> >>
> >> and
> >>
> >> 'mon osd full ratio = 0.98' in mon configuration for each mon
> >>
> >> however
> >>
> >> chef@ceph-node03:/var/log/ceph$ ceph health detail
> >> HEALTH_ERR 1 full osd(s)
> >> osd.2 is full at 95%
> >>
> >> mds still believes 95% is the threshold, so no responses to mount requests.
> >>
> >> chef@ceph-node03:/var/log/ceph$ rados -p data bench 10 write
> >>  Maintaining 16 concurrent writes of 4194304 bytes for at least 10 seconds.
> >>  Object prefix: benchmark_data_ceph-node03_3903
> >> 2013-01-08 16:33:02.363206 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa467ff0 tid 1
> >> 2013-01-08 16:33:02.363618 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa468780 tid 2
> >> 2013-01-08 16:33:02.363741 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa468f88 tid 3
> >> 2013-01-08 16:33:02.364056 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa469348 tid 4
> >> 2013-01-08 16:33:02.364171 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa469708 tid 5
> >> 2013-01-08 16:33:02.365024 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa469ac8 tid 6
> >> 2013-01-08 16:33:02.365187 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46a2d0 tid 7
> >> 2013-01-08 16:33:02.365296 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46a690 tid 8
> >> 2013-01-08 16:33:02.365402 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46aa50 tid 9
> >> 2013-01-08 16:33:02.365508 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46ae10 tid 10
> >> 2013-01-08 16:33:02.365635 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46b1d0 tid 11
> >> 2013-01-08 16:33:02.365742 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46b590 tid 12
> >> 2013-01-08 16:33:02.365868 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46b950 tid 13
> >> 2013-01-08 16:33:02.365975 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46bd10 tid 14
> >> 2013-01-08 16:33:02.366096 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46c0d0 tid 15
> >> 2013-01-08 16:33:02.366203 b6be3710  0 client.9958.objecter  FULL,
> >> paused modify 0xa46c490 tid 16
> >>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg lat
> >>      0      16        16         0         0         0         -         0
> >>      1      16        16         0         0         0         -         0
> >>      2      16        16         0         0         0         -         0
> >>
> >> rados doesn't work.
> >>
> >> chef@ceph-node03:/var/log/ceph$ ceph osd reweight-by-utilization
> >> no change: average_util: 0.812678, overload_util: 0.975214. overloaded
> >> osds: (none)
> >>
> >> this one also.
> >>
> >>
> >> is there any chance to recover ceph?
> >
> > "ceph pg set_full_ratio 0.98"
> >
> > However, as Mark mentioned, you want to figure out why one OSD is so
> > much fuller than the others first. Even in a small cluster I don't
> > think you should be able to see that kind of variance. Simply setting
> > the full ratio to 98% and then continuing to run could cause bigger
> > problems if that OSD continues to get a disproportionate share of the
> > writes and fills up its disk.
> > -Greg
> 
> 
> 
> -- 
> ...WBR, Roman Hlynovskiy
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
