From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Thu, 27 Jul 2017 16:24:48 -0400
Message-ID: <EA67929A-7A8A-4507-AE10-6826BDCBAD73@redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com> <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com> <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com> <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com> <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com> <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com> <b26c6cec-d021-01ce-0a2b-77484e267635@redhat.com> <CAB7xdi=PwRLuE+rYfbAJyd+18fbqObPyZ7n=H1MyaU__VZie_g@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:37899 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdG0UYv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jul 2017 16:24:51 -0400
Received: by mail-io0-f172.google.com with SMTP id g13so83118867ioj.5
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 13:24:51 -0700 (PDT)
In-Reply-To: <CAB7xdi=PwRLuE+rYfbAJyd+18fbqObPyZ7n=H1MyaU__VZie_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sheng,

I’ll interleave responses below.

> On Jul 11, 2017, at 2:14 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> We are trying to evaluate dmclock's effect on controlling the recovery
> traffic in order to reducing impact on client io.
> However, we are experiencing some problem and didn't get our expected results.
> 
> we setup a small cluster, with several OSD machines. In our
> configurations, we set recovery limit = 0.001 or even smaller, and
> res=0.0, wgt=1.0.
> we set client res = 20k or even higher, limit=0.0, wgt=500.

As presently implemented limits are not enforced. There is a PR that makes modification to enforce them (https://github.com/ceph/ceph/pull/16242), which I’m still evaluating. You can see some discussion of the issue (see: http://marc.info/?l=ceph-devel&m=149867479701646&w=2).

> Then we killed osd while doing fio on client side and bring it back to
> trigger recovery. We saw fio iops still reduced a lot comparable to
> not using dmclock queue. We did some debugging and saw that when
> recovery is active, fio requests enqueued much less frequent than
> before.

Are you saying that fio requests from the client slow down? I assume you’re using the fio tool. If so, what is max-jobs set to?

Also, are you saying that that fio iops had lower values with mclock compared with the weighted priority queue (“wpq”)?

> overall, seems dmclock's configuration on recovery part does not show
> any differences. Since the enqueue rate of fio requests are reduced,
> when dmclock try to dequeue a request, there's less chance to pull a
> fio request.

Theoretically, at least, with a higher reservation value, the request tags should have smaller reservation tags, which should bias mclock to dequeueing them. So I’d like to know more about your experiment.

Thank you,

Eric
