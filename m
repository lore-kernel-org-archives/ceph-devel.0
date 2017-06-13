From: sheng qiu <herbert1984106@gmail.com>
Subject: Fwd: About dmClock tests confusion after integrating dmClock QoS
 library into ceph codebase
Date: Tue, 13 Jun 2017 09:08:34 -0700
Message-ID: <CAB7xdikrrXp5rw7xqtJ0FPhHLYLdWKup2pYJ4dyVt2g6Qd1pWQ@mail.gmail.com>
References: <509B214C5E2CEA4D9C41C1AB2A76BDD1A36B38B0@H3CMLB12-EX.srv.huawei-3com.com>
 <5a40a1e8-c1c5-1bc1-86ce-4f5d2593d2d4@redhat.com> <CAB7xdinyGMQMnORDfNknEg4a_y5EpW_ibndNZUyWtRhS9TNgFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36492 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdFMQIg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jun 2017 12:08:36 -0400
Received: by mail-vk0-f52.google.com with SMTP id y70so28359362vky.3
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jun 2017 09:08:35 -0700 (PDT)
In-Reply-To: <CAB7xdinyGMQMnORDfNknEg4a_y5EpW_ibndNZUyWtRhS9TNgFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Eric,

we are also very interested in your dmclock work in ceph. May I ask if
this branch wip_dmclock_clients has both clients and OSD support for
dmclock?
we want to fully test this implementations.

thanks for your help.

Sheng

On Tue, Jun 13, 2017 at 7:14 AM, J. Eric Ivancich <ivancich@redhat.com> wro=
te:
>
> On 06/02/2017 03:36 AM, Lijie wrote:
> > Hi Eric,
> >
> > Our team has developed QOS feature on ceph using the dmclock library
> > from community. We treat a rbd as a dmclock client instead of pool as .
> > We tested our code and the result is   confusing .
> >
> >
> >
> > Testing environment: single server with 16 cores  , RAM of 32G, 8
> > non-systerm disks,each runs one OSD. We set
> > osd_op_num_threads_per_shard=3D2, osd_op_num_shards=3D5 on each OSD. Th=
e
> > Size of our RBD is 100G. The qos params of RBD is =EF=BC=88r:1K, p:100,=
 l:2k=EF=BC=89,
> > rbd_cache =3D false , allow_limit_break =3D false.
> >
> >
> >
> > Conclusion:   we only got 1500 IOPS while the system serves much more
> > than the limit value 2000.
> >
> > We used fio and adjusted  osd_op_num_shards .And we found that iops run=
s
> > bigger along as the growth of osd_op_num_shards. Finally it can break
> > the limit value .( fio iops =3D 2300 while osd_op_num_shards =3D 20) .
> >
> >
> >
> > So would you mind to provide your test environment and result about
> > dmclock library? And we would be appreciated if you offer some other
> > direction . It will really be a great help for us.
>
>
>
> Are you using src/common/mClockPriorityQueue.h? Because it makes sure
> allow_limit_break is true and asserts that as long as the dmclock queue
> is not empty, it will retrieve a request when pull_request is called
> (assert(pr.is_retn());). If allow_limit_break is false, that assert can
> fail.
>
> I'm guessing you've created your own interface to the dmclock library,
> because of the issue outlined above.
>
> The dmclock library has a simulator built on top of it, which you can
> use to design various scenarios and see how it works.
>
> You can run it, for example, by:
>
>     $ git clone git@github.com:ceph/dmclock.git
>     $ cd dmclock/
>     $ mkdir build
>     $ cd build
>     $ cmake ..
>     $ make dmclock-sims
>     $ sim/dmc_sim -c ../sim/dmc_sim_100th.conf
>
> where the file dmc_sim_100th.conf describes the scenario being simulated.
>
> I'm not fully clear I understand your approach. If you can describe it
> in more detail, I'll try to address any questions.
>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
