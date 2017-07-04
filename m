From: Jin Cai <caijin.laurence@gmail.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Tue, 4 Jul 2017 20:35:06 +0800
Message-ID: <CAGRcXKbCc3h53dxrh=SXhwhZ1zCbE6YKc_4X0BrnsbNYd7uoFw@mail.gmail.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
 <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com> <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
 <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com> <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com>
 <b26c6cec-d021-01ce-0a2b-77484e267635@redhat.com> <CAB7xdinUB6dTtc+ncfn7YAH0KKcAg03oxu778NbjHiafiqRnKQ@mail.gmail.com>
 <9c1d41e7-a218-d52b-f17f-0490c3a94d50@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36297 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbdGDMfH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jul 2017 08:35:07 -0400
Received: by mail-vk0-f49.google.com with SMTP id y70so109516093vky.3
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jul 2017 05:35:07 -0700 (PDT)
In-Reply-To: <9c1d41e7-a218-d52b-f17f-0490c3a94d50@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: sheng qiu <herbert1984106@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi, Eric
     We are now testing the mclock priority queue that you contributed
several days ago.
     Our test environment consists of four machines: one machine for
the monitor and mgr daemon, two OSDs in each of the left three ones.
     mclock-related configurations are as the following:

    osd_op_queue = mclock_opclass
    osd_op_queue_mclock_client_op_res = 20000.0
    osd_op_queue_mclock_client_op_wgt = 0.0
    osd_op_queue_mclock_client_op_lim = 30000.0
    osd_op_queue_mclock_recov_res = 0.0
    osd_op_queue_mclock_recov_wgt = 0.0
    osd_op_queue_mclock_recov_lim = 2000.0


   When we kiledl one OSD daemon to test the effects of recovery on
the client op, other OSDs crashed as well because of assert semantics:

   ceph version 12.0.3-2318-g32ab095
(32ab09536207b4b261874c0063b3275b97537045) luminous (dev)
 1: (()+0x9e86b1) [0x7f4287e846b1]
 2: (()+0xf100) [0x7f4284d18100]
 3: (gsignal()+0x37) [0x7f4283d415f7]
 4: (abort()+0x148) [0x7f4283d42ce8]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x284) [0x7f4287ec2364]
 6: (ceph::mClockQueue<std::pair<spg_t, PGQueueable>,
ceph::mClockOpClassQueue::osd_op_type_t>::dequeue()+0x45f)
[0x7f4287baac3f]
 7: (ceph::mClockOpClassQueue::dequeue()+0xd) [0x7f4287baacfd]
 8: (OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*)+0x314) [0x7f428798a174]
 9: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x8e9)
[0x7f4287ec7d39]
 10: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0x7f4287ec9ec0]
 11: (()+0x7dc5) [0x7f4284d10dc5]
 12: (clone()+0x6d) [0x7f4283e02ced]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.


However, if the value of osd_op_queue was set to wpq or prio, it worked well.
So do you know why the assert semantics was triggered.

Thanks very much.




2017-06-30 2:03 GMT+08:00 J. Eric Ivancich <ivancich@redhat.com>:
> On 06/28/2017 02:55 PM, sheng qiu wrote:
>> May I ask do you have any plan to implement client side logic for a
>> true "D"mclock, seems to me know it's mclock on each individual OSD.
>> And each client also has a common iops config. We are planing to
>> working on that part and integrate with your current work.
>
> That is not a high priority in the short-term. Our main goal with
> integrating dmclock/mclock was to better manage priorities among
> operation classes.
>
> Developers at SK Telecom have done some work towards this, though. For
> example, see here:
>
>     https://github.com/ivancich/ceph/pull/1
>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
