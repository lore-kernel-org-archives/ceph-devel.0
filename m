From: Sage Weil <sage@inktank.com>
Subject: Re: "hit suicide timeout" message after upgrade to 0.56
Date: Tue, 8 Jan 2013 13:36:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301081334490.10771@cobra.newdream.net>
References: <50E578F5.8070805@widodh.nl> <alpine.DEB.2.00.1301030851150.5264@cobra.newdream.net> <CAPYLRzgcyXtQds1YgKfAXxDAX0eSvDn0fecSzsbT+rgKb91Jyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54802 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab3AHVgE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 16:36:04 -0500
In-Reply-To: <CAPYLRzgcyXtQds1YgKfAXxDAX0eSvDn0fecSzsbT+rgKb91Jyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 8 Jan 2013, Gregory Farnum wrote:
> I'm confused. Isn't the HeartbeatMap all about local thread
> heartbeating (so, not pings with other OSDs)? I would assume the
> upgrade and restart just caused a bunch of work and the CPUs got
> overloaded.

It is.  In #3714's case, the OSD was down for a long time, and when it 
started a huge number of maps were queued up for the PGs and then the OSD 
activated (and booted, marked itself up).  The worker threads then had to 
calculate a huge number of prior_intervals (by loading old osdmaps and 
calculating mappings) and timed out.

sage


> -Greg
> 
> On Thu, Jan 3, 2013 at 8:52 AM, Sage Weil <sage@inktank.com> wrote:
> > Hi Wido,
> >
> > On Thu, 3 Jan 2013, Wido den Hollander wrote:
> >> Hi,
> >>
> >> I updated my 10 node 40 OSD cluster from 0.48 to 0.56 yesterday evening and
> >> found out this morning that I had 23 OSDs still up and in.
> >>
> >> Investigating some logs I found these messages:
> >
> > This sounds quite a bit #3714.  You might give wip-3714 a try...
> >
> > sage
> >
> >
> >>
> >> *********************************************************************
> >>     -8> 2013-01-02 21:13:40.528936 7f9eb177a700  1 heartbeat_map is_healthy
> >> 'OSD::op_tp thread 0x7f9ea2f5d700' had timed out after 30
> >>     -7> 2013-01-02 21:13:40.528985 7f9eb177a700  1 heartbeat_map is_healthy
> >> 'OSD::op_tp thread 0x7f9ea375e700' had timed out after 30
> >>     -6> 2013-01-02 21:13:41.311088 7f9eaff77700 10 monclient:
> >> _send_mon_message to mon.pri at [2a00:f10:11b:cef0:230:48ff:fed3:b086]:6789/0
> >>     -5> 2013-01-02 21:13:45.047220 7f9e92282700  0 --
> >> [2a00:f10:11b:cef0:225:90ff:fe32:cf64]:0/2882 >>
> >> [2a00:f10:11b:cef0:225:90ff:fe33:49fe]:6805/2373 pipe(0x9d7ad80 sd=135 :0
> >> pgs=0 cs=0 l=1).fault
> >>     -4> 2013-01-02 21:13:45.049225 7f9e962c2700  0 --
> >> [2a00:f10:11b:cef0:225:90ff:fe32:cf64]:6801/2882 >>
> >> [2a00:f10:11b:cef0:225:90ff:fe33:49fe]:6804/2373 pipe(0x9d99000 sd=104 :44363
> >> pgs=99 cs=1 l=0).fault with nothing to send, going to standby
> >>     -3> 2013-01-02 21:13:45.529075 7f9eb177a700  1 heartbeat_map is_healthy
> >> 'OSD::op_tp thread 0x7f9ea2f5d700' had timed out after 30
> >>     -2> 2013-01-02 21:13:45.529115 7f9eb177a700  1 heartbeat_map is_healthy
> >> 'OSD::op_tp thread 0x7f9ea2f5d700' had suicide timed out after 300
> >>     -1> 2013-01-02 21:13:45.531952 7f9eb177a700 -1 common/HeartbeatMap.cc: In
> >> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const
> >> char*, time_t)' thread 7f9eb177a700 time 2013-01-02 21:13:45.529176
> >> common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> >>
> >>  ceph version 0.56 (1a32f0a0b42f169a7b55ed48ec3208f6d4edc1e8)
> >>  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> >> long)+0x107) [0x796877]
> >>  2: (ceph::HeartbeatMap::is_healthy()+0x87) [0x797207]
> >>  3: (ceph::HeartbeatMap::check_touch_file()+0x23) [0x797453]
> >>  4: (CephContextServiceThread::entry()+0x55) [0x8338d5]
> >>  5: (()+0x7e9a) [0x7f9eb4571e9a]
> >>  6: (clone()+0x6d) [0x7f9eb2ff5cbd]
> >>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> >> interpret this.
> >>
> >>      0> 2013-01-02 21:13:46.314478 7f9eaff77700 10 monclient:
> >> _send_mon_message to mon.pri at [2a00:f10:11b:cef0:230:48ff:fed3:b086]:6789/0
> >> *********************************************************************
> >>
> >> Reading these messages I'm trying to figure out why those messages came along.
> >>
> >> Am I understanding this correctly that the heartbeat updates didn't come along
> >> in time and the OSDs committed suicide?
> >>
> >> I read the code in common/HeartbeatMap.cc and it seems like that.
> >>
> >> During the restart of the cluster the Atom CPUs were very busy, so could it be
> >> that the CPUs were just to busy and the OSDs weren't responding to heartbeats
> >> in time?
> >>
> >> In total 16 of the 17 crashed OSDs are down with these log messages.
> >>
> >> I'm now starting the 16 crashed OSDs one by one and that seems to go just
> >> fine.
> >>
> >> I've set "osd recovery max active = 1" to prevent overloading the CPUs to much
> >> since I know Atoms are not that powerful. I'm just still trying to get it all
> >> working on them :)
> >>
> >> Am I right this is probably a lack of CPU power during the heavy recovery
> >> which causes them to not respond to heartbeat updates in time?
> >>
> >> Wido
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
