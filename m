From: Samuel Just <sam.just@inktank.com>
Subject: Re: endless flying slow requests
Date: Sun, 2 Dec 2012 14:02:00 -0800
Message-ID: <CA+4uBUap0H3BuHcEDOLdw4Scf58G6PnaZCxvLAs=SBeY5tM6_A@mail.gmail.com>
References: <50A3607A.6050209@profihost.ag>
	<alpine.DEB.2.00.1211140656590.6512@cobra.newdream.net>
	<50A4A351.8020506@profihost.ag>
	<alpine.DEB.2.00.1211150657110.4011@cobra.newdream.net>
	<alpine.DEB.2.00.1211271751290.23594@cobra.newdream.net>
	<CABYiri9M86SHr6yY+2FtXEWbp7-bK6+TJs6DJC7QJyi7GRGOLA@mail.gmail.com>
	<CA+4uBUYsCyfwXQahgEPsUFt9K9XADbe5x981iY-k-RRECwrM4Q@mail.gmail.com>
	<CA+4uBUZK2wS29M0TTroQFvQDrgCfd+WBm=xTRjWDtUeAqjRKJQ@mail.gmail.com>
	<CABYiri85PFnWdrBVh2mY_ujsxdSyqsoTKHET++okTVqfaJeLxA@mail.gmail.com>
	<CA+4uBUbcvj7xJ98ojfZpBOxL-2qet0Jep987DmyBAdZWaJ0Q2g@mail.gmail.com>
	<alpine.DEB.2.00.1212011915570.24631@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59134 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab2LBWCC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Dec 2012 17:02:02 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so1039690vby.19
        for <ceph-devel@vger.kernel.org>; Sun, 02 Dec 2012 14:02:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212011915570.24631@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Looks good, pushed.
-Sam

On Sat, Dec 1, 2012 at 7:18 PM, Sage Weil <sage@inktank.com> wrote:
> I pushed another fix that plugs a leak when requests race with peering
> that fixed the 'slow request' for osd_sub_op messages for me.  It's in
> wip-osd-leak.
>
> Sam, when you get a chance, can you take a look and push it to next if it
> looks okay?
>
> Thanks!
> sage
>
>
> On Fri, 30 Nov 2012, Samuel Just wrote:
>
>> I've pushed a fix to next, 49f32cee647c5bd09f36ba7c9fd4f481a697b9d7.
>> Let me know if the problem persists with this patch.
>> -Sam
>>
>> On Wed, Nov 28, 2012 at 2:04 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> > On Thu, Nov 29, 2012 at 1:12 AM, Samuel Just <sam.just@inktank.com> wrote:
>> >> Also, these clusters aren't mixed argonaut and next, are they?  (Not
>> >> that that shouldn't work, but it would be a useful data point.)
>> >> -Sam
>> >>
>> >> On Wed, Nov 28, 2012 at 1:11 PM, Samuel Just <sam.just@inktank.com> wrote:
>> >>> Did you observe hung io along with that error?  Both sub_op_commit and
>> >>> sub_op_applied have happened, so the sub_op_reply should have been
>> >>> sent back to the primary.  This looks more like a leak.  If you also
>> >>> observed hung io, then it's possible that the problem is occurring
>> >>> between the sub_op_applied event and the response.
>> >>> -Sam
>> >>>
>> >
>> > It is relatively easy to check if one of client VMs has locked one or
>> > more cores to iowait or just hangs, so yes, these ops are related to
>> > real commit operations and they are hanged.
>> > I`m using all-new 0.54 cluster, without mixing of course. Does
>> > everyone who hit that bug readjusted cluster before bug shows
>> > itself(say, in a day-long distance)?
>> >
>> >>> On Tue, Nov 27, 2012 at 11:47 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> >>>> On Wed, Nov 28, 2012 at 5:51 AM, Sage Weil <sage@inktank.com> wrote:
>> >>>>> Hi Stefan,
>> >>>>>
>> >>>>> On Thu, 15 Nov 2012, Sage Weil wrote:
>> >>>>>> On Thu, 15 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> >>>>>> > Am 14.11.2012 15:59, schrieb Sage Weil:
>> >>>>>> > > Hi Stefan,
>> >>>>>> > >
>> >>>>>> > > I would be nice to confirm that no clients are waiting on replies for
>> >>>>>> > > these requests; currently we suspect that the OSD request tracking is the
>> >>>>>> > > buggy part.  If you query the OSD admin socket you should be able to dump
>> >>>>>> > > requests and see the client IP, and then query the client.
>> >>>>>> > >
>> >>>>>> > > Is it librbd?  In that case you likely need to change the config so that
>> >>>>>> > > it is listening on an admin socket ('admin socket = path').
>> >>>>>> >
>> >>>>>> > Yes it is. So i have to specify admin socket at the KVM host?
>> >>>>>>
>> >>>>>> Right.  IIRC the disk line is a ; (or \;) separated list of key/value
>> >>>>>> pairs.
>> >>>>>>
>> >>>>>> > How do i query the admin socket for requests?
>> >>>>>>
>> >>>>>> ceph --admin-daemon /path/to/socket help
>> >>>>>> ceph --admin-daemon /path/to/socket objecter_dump     (i think)
>> >>>>>
>> >>>>> Were you able to reproduce this?
>> >>>>>
>> >>>>> Thanks!
>> >>>>> sage
>> >>>>
>> >>>> Meanwhile, I did. :)
>> >>>> Such requests will always be created if you have restarted or marked
>> >>>> an osd out and then back in and scrub didn`t happen in the meantime
>> >>>> (after such operation and before request arrival).
>> >>>> What is more interesting, the hangup happens not exactly at the time
>> >>>> of operation, but tens of minutes later.
>> >>>>
>> >>>>         { "description": "osd_sub_op(client.1292013.0:45422 4.731
>> >>>> a384cf31\/rbd_data.1415fb1075f187.00000000000000a7\/head\/\/4 [] v
>> >>>> 16444'21693 snapset=0=[]:[] snapc=0=[])",
>> >>>>           "received_at": "2012-11-28 03:54:43.094151",
>> >>>>           "age": "27812.942680",
>> >>>>           "duration": "2.676641",
>> >>>>           "flag_point": "started",
>> >>>>           "events": [
>> >>>>                 { "time": "2012-11-28 03:54:43.094222",
>> >>>>                   "event": "waiting_for_osdmap"},
>> >>>>                 { "time": "2012-11-28 03:54:43.386890",
>> >>>>                   "event": "reached_pg"},
>> >>>>                 { "time": "2012-11-28 03:54:43.386894",
>> >>>>                   "event": "started"},
>> >>>>                 { "time": "2012-11-28 03:54:43.386973",
>> >>>>                   "event": "commit_queued_for_journal_write"},
>> >>>>                 { "time": "2012-11-28 03:54:45.360049",
>> >>>>                   "event": "write_thread_in_journal_buffer"},
>> >>>>                 { "time": "2012-11-28 03:54:45.586183",
>> >>>>                   "event": "journaled_completion_queued"},
>> >>>>                 { "time": "2012-11-28 03:54:45.586262",
>> >>>>                   "event": "sub_op_commit"},
>> >>>>                 { "time": "2012-11-28 03:54:45.770792",
>> >>>>                   "event": "sub_op_applied"}]}]}
>> >>>>
>> >>>>
>> >>>>>
>> >>>>>
>> >>>>>>
>> >>>>>> sage
>> >>>>>>
>> >>>>>> >
>> >>>>>> > Stefan
>> >>>>>> >
>> >>>>>> >
>> >>>>>> > > On Wed, 14 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> >>>>>> > >
>> >>>>>> > > > Hello list,
>> >>>>>> > > >
>> >>>>>> > > > i see this several times. Endless flying slow requests. And they never
>> >>>>>> > > > stop
>> >>>>>> > > > until i restart the mentioned osd.
>> >>>>>> > > >
>> >>>>>> > > > 2012-11-14 10:11:57.513395 osd.24 [WRN] 1 slow requests, 1 included below;
>> >>>>>> > > > oldest blocked for > 31789.858457 secs
>> >>>>>> > > > 2012-11-14 10:11:57.513399 osd.24 [WRN] slow request 31789.858457 seconds
>> >>>>>> > > > old,
>> >>>>>> > > > received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> >>>>>> > > > rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> >>>>>> > > > currently delayed
>> >>>>>> > > > 2012-11-14 10:11:58.513584 osd.24 [WRN] 1 slow requests, 1 included below;
>> >>>>>> > > > oldest blocked for > 31790.858646 secs
>> >>>>>> > > > 2012-11-14 10:11:58.513586 osd.24 [WRN] slow request 31790.858646 seconds
>> >>>>>> > > > old,
>> >>>>>> > > > received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> >>>>>> > > > rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> >>>>>> > > > currently delayed
>> >>>>>> > > > 2012-11-14 10:11:59.513766 osd.24 [WRN] 1 slow requests, 1 included below;
>> >>>>>> > > > oldest blocked for > 31791.858827 secs
>> >>>>>> > > > 2012-11-14 10:11:59.513768 osd.24 [WRN] slow request 31791.858827 seconds
>> >>>>>> > > > old,
>> >>>>>> > > > received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> >>>>>> > > > rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> >>>>>> > > > currently delayed
>> >>>>>> > > > 2012-11-14 10:12:00.513909 osd.24 [WRN] 1 slow requests, 1 included below;
>> >>>>>> > > > oldest blocked for > 31792.858971 secs
>> >>>>>> > > > 2012-11-14 10:12:00.513916 osd.24 [WRN] slow request 31792.858971 seconds
>> >>>>>> > > > old,
>> >>>>>> > > > received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> >>>>>> > > > rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> >>>>>> > > > currently delayed
>> >>>>>> > > > 2012-11-14 10:12:01.514061 osd.24 [WRN] 1 slow requests, 1 included below;
>> >>>>>> > > > oldest blocked for > 31793.859124 secs
>> >>>>>> > > > 2012-11-14 10:12:01.514063 osd.24 [WRN] slow request 31793.859124 seconds
>> >>>>>> > > > old,
>> >>>>>> > > > received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> >>>>>> > > > rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> >>>>>> > > > currently delayed
>> >>>>>> > > >
>> >>>>>> > > > When i now restart osd 24 they go away and everything is fine again.
>> >>>>>> > > >
>> >>>>>> > > > Stefan
>> >>>>>> > > > --
>> >>>>>> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>>>> > > > the body of a message to majordomo@vger.kernel.org
>> >>>>>> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>> > > >
>> >>>>>> > > >
>> >>>>>> > > --
>> >>>>>> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>>>> > > the body of a message to majordomo@vger.kernel.org
>> >>>>>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>> > >
>> >>>>>> > --
>> >>>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>>>> > the body of a message to majordomo@vger.kernel.org
>> >>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>> >
>> >>>>>> >
>> >>>>>> --
>> >>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>>
>> >>>>>>
>> >>>>> --
>> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>>> the body of a message to majordomo@vger.kernel.org
>> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>>> --
>> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >>>> the body of a message to majordomo@vger.kernel.org
>> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
