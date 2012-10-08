From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: Problem with "ceph osd create <uuid>"
Date: Mon, 8 Oct 2012 16:10:21 -0700
Message-ID: <CA+jddaOWAh8SanYQsWEzyWjGVUyy1CT5BUH6R3KP4wkPXG4paw@mail.gmail.com>
References: <CA+jddaOBZ2cm-R2uQnOCa_yMN+2DDOMAZMB6uNMo4XwFUfYouw@mail.gmail.com>
	<alpine.DEB.2.00.1210081133460.9864@cobra.newdream.net>
	<CA+jddaO_LdTi0Hm8LGdRRU33TJt2y7hE3qLaRwHUDwUrhVuRYQ@mail.gmail.com>
	<CA+jddaNdM+cMCaAoBpoK3S5FayviyMWdKLXL143Yzqk0jWqYQw@mail.gmail.com>
	<alpine.DEB.2.00.1210081549150.9864@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45866 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2JHXKW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Oct 2012 19:10:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so898433iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 08 Oct 2012 16:10:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210081549150.9864@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd dump output:

[root@node-172-20-0-14 ~]# ceph osd dump 2
dumped osdmap epoch 2
epoch 2
fsid d82665b6-3435-44b8-a89e-f7185f78d09d
created 2012-10-08 21:29:52.232400
modifed 2012-10-08 21:29:57.297479
flags

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
64 pgp_num 64 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
pg_num 64 pgp_num 64 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 64
pgp_num 64 last_change 1 owner 0

max_osd 1
osd.0 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
564d7166-07b7-48cc-9b50-46ef7b260d5c


[root@node-172-20-0-14 ~]# ceph osd dump 3
dumped osdmap epoch 3
epoch 3
fsid d82665b6-3435-44b8-a89e-f7185f78d09d
created 2012-10-08 21:29:52.232400
modifed 2012-10-08 21:29:58.299491
flags

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
64 pgp_num 64 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
pg_num 64 pgp_num 64 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 64
pgp_num 64 last_change 1 owner 0

max_osd 1
osd.0 up   in  weight 1 up_from 3 up_thru 0 down_at 0
last_clean_interval [0,0) 172.20.0.13:6800/1723 172.20.0.13:6801/1723
172.20.0.13:6802/1723 exists,up 564d7166-07b7-48cc-9b50-46ef7b260d5c


[root@node-172-20-0-14 ~]# ceph osd dump 4
dumped osdmap epoch 4
epoch 4
fsid d82665b6-3435-44b8-a89e-f7185f78d09d
created 2012-10-08 21:29:52.232400
modifed 2012-10-08 21:29:59.304087
flags

pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
64 pgp_num 64 last_change 1 owner 0 crash_replay_interval 45
pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins
pg_num 64 pgp_num 64 last_change 1 owner 0
pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 64
pgp_num 64 last_change 1 owner 0

max_osd 3
osd.0 up   in  weight 1 up_from 3 up_thru 0 down_at 0
last_clean_interval [0,0) 172.20.0.13:6800/1723 172.20.0.13:6801/1723
172.20.0.13:6802/1723 exists,up 564d7166-07b7-48cc-9b50-46ef7b260d5c
osd.1 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
3351a0f0-f6e8-430a-b7a4-ea613a3ddf35
osd.2 down out weight 0 up_from 0 up_thru 0 down_at 0
last_clean_interval [0,0) :/0 :/0 :/0 exists,new
3f04cdbe-a468-42d3-a465-2487cc369d90




On Mon, Oct 8, 2012 at 3:49 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 8 Oct 2012, Mandell Degerness wrote:
>> Sorry, I should have used the https link:
>>
>> https://gist.github.com/af546ece91be0ba268d3
>
> What do 'ceph osd dump 2', 'ceph osd dump 3', and 'ceph osd dump 4' say?
>
> thanks!
> sage
>
>>
>> On Mon, Oct 8, 2012 at 3:20 PM, Mandell Degerness
>> <mandell@pistoncloud.com> wrote:
>> > Here is the log I got when running with the options suggested by sage:
>> >
>> > git@gist.github.com:af546ece91be0ba268d3.git
>> >
>> > On Mon, Oct 8, 2012 at 11:34 AM, Sage Weil <sage@inktank.com> wrote:
>> >> Hi Mandell,
>> >>
>> >> On Mon, 8 Oct 2012, Mandell Degerness wrote:
>> >>> Hi list,
>> >>>
>> >>> I've run into a bit of a weird error and I'm hoping that you can tell
>> >>> me what is going wrong.  There seems to be a race condition in the way
>> >>> I am using "ceph osd create <uuid>" and actually creating the OSD's.
>> >>> The log from one of the servers is at:
>> >>>
>> >>> https://gist.github.com/528e347a5c0ffeb30abd
>> >>>
>> >>> The process I am trying to follow (for the OSDs) is:
>> >>>
>> >>> 1) Create XFS file system on disk.
>> >>> 2) Use FS UUID as source to get a new OSD id #.
>> >>> 'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
>> >>> (Returns 2.)
>> >>> 3) Pass the UUID and OSD id to the create osd command
>> >>>
>> >>> ceph-osd -c /etc/ceph/ceph.conf --fsid
>> >>> e61c1b11-4a1c-47aa-868d-7b51b1e610d3 --osd-uuid
>> >>> 32895846-ca1c-4265-9ce7-9f2a42b41672 -i 2 --mkfs --osd-journal-size
>> >>> 8192
>> >>> 4) Start the OSD, as part of the start process, I verify that the
>> >>> whoami and osd fsid agree (in case this disk came from a previous
>> >>> cluster, somehow) - should be just a sanity check
>> >>> 'ceph', 'osd', 'create', '32895846-ca1c-4265-9ce7-9f2a42b41672'
>> >>> (Returns 1!)
>> >>>
>> >>> This is clearly a race condition because we have several cluster
>> >>> creations without this happening and then this happens about once
>> >>> every 8 times or so.  Thoughts?
>> >>
>> >> That definitely sounds like a race.  I'm not seeing it by inspection,
>> >> though, and wasn't able to reproduce.  Is it possible to capture a monitor
>> >> log (debug ms = 1, debug mon = 20) of this occurring and share that?
>> >>
>> >> Thanks!
>> >> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
