From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Thu, 24 Mar 2016 13:25:01 -0700
Message-ID: <CAJ4mKGbDQEyRfeMskBwsTxK_qoJY_4GfGfFz1h1ht6h6E0xhSg@mail.gmail.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
	<CAOi1vP89OgUmvozXRO9cvNS-KYaSkBGQRkPS3UeNa2+kgAHkmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35768 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbcCXUZE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 16:25:04 -0400
Received: by mail-vk0-f46.google.com with SMTP id e6so73855269vkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 13:25:02 -0700 (PDT)
In-Reply-To: <CAOi1vP89OgUmvozXRO9cvNS-KYaSkBGQRkPS3UeNa2+kgAHkmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sweil@redhat.com>
Cc: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 24, 2016 at 12:53 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Thu, Mar 24, 2016 at 8:00 AM, Igor.Podoski@ts.fujitsu.com
> <Igor.Podoski@ts.fujitsu.com> wrote:
>> Hi Cephers!
>>
>> Currently when we had a disk failure, assert() and then abort() was triggered and process was killed (ABRT). Other osds will eventually mark dead one as down, but it depends of heartbeat settings and monitor settings (mon_osd_min_down_reporters/mon_osd_min_down_reports). During dead-not-marked-as-down osd you can see blocked IO during writes and reads.
>>
>> Recently I've made https://github.com/ceph/ceph/pull/7740 which is about sending MakrMeDown msg to monitor just before osd is going bye-bye. It prevents blocked IO in above case, and any other assert that is not on message sending path, so I need messenger/pipes/connections working for this. I've made some test and it looks good, when I pull out drive from my cluster during rados bench, IO blocks for less than 1 second or not at all, previously it was > 10 sec (on my cluster settings).
>>
>> Sage pointed me that some time ago was similar PR https://github.com/ceph/ceph/pull/6514 and there was a thought about ceph-watchdog process, that could monitor osd's and send info directly to monitor when they disappear. This would prevent all assert() cases, and other ones like kill -9 or similar.
>>
>> I have a few ideas how such functionality could be implemented, so my question is - does any of you started already doing something similar?
>>
>> Let's have a brain storm about it!
>>
>> Ideas about improving 7740/6514 MarkMeDown internal mechanism:
>> - I think, I could send message with MarkMeDown payload, but in a raw way, not through Messenger path. This could be as good as bad in this case.
>> - I could poke osd-neighbor through signal and neighbor will send Mark(SignalSender)Down message (this won't work If whole hdd controller will be down, all osd will be dead in narrow time window). So it's like instant bad-health heartbeat message. Still depends of Messenger send path of osd-neighbor.
>
>>
>> External ceph-watchdog:
>> Just like Sage wrote https://github.com/ceph/ceph/pull/6514#issuecomment-159372845 Or similar: each osd, during start passes its own PID to ceph-watchdog process through shared memory/socket/named pipe (whatever). Ceph-watchdog checks if current PID exists, by checking changes in /proc/PID or /proc/PID/cmd directory/file (maybe Inotify could handle this). When file or folder is changed(missing) it sends MarkThisOsdDown to monitor and that's all. But this won't be watchdog strict, rather process down notify.
>>
>> Or maybe both ways PR7740 + external ?
>
> I'm not involved in any of this, but since you asked for a brain
> storm... ;)
>
> Is it worth bothering with the corrupted data structures case at all?
> Trying to handle it from within the aborting ceph-osd process is not a
> very easy thing to do ("raw way, not through Messenger", signals, etc)
> and if you do it wrong, you'd mask the original stack trace.  An
> external ceph-watchdog is yet another entity which has to be set up,
> maintained and accounted for.
>
> Why not just distinguish legitimate/expected errors which we check for
> but currently handle with assert(0) and the actual assert failures?  In
> the vast majority of cases that fall into the former bucket all of the
> internal data structures, including the messenger, will be in order and
> so we can send a MarkMeDown message and fail gracefully.  Implementing
> it is just a matter of identifying those sites, but that's not a bad
> exercise to do even on its own.
>
> The actual assert failures can abort() as they do now.  Any such
> failure is a serious bug and there's hopefully not too many of them to
> worry about shrinking the timeout to a minimum, unless there are hard
> numbers that prove otherwise, of course.  And if you kill -9 your OSDs,
> you deserve to wait for MONs to catch up.  Am I missing any use cases
> here?

This is something Sam and I have talked about in the past, but
apparently Sage didn't like that idea in
https://github.com/ceph/ceph/pull/6514 and suggested a daemon watcher
instead?
Personally I tend towards building that kind of functionality into the
daemon, although he's right it will never be quite as good at catching
all cases as an external manager. The upside is that we don't have to
worry about the failure cases between the two of them. ;)
-Greg
