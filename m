From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Wed, 28 Jun 2017 14:33:11 -0400
Message-ID: <b26c6cec-d021-01ce-0a2b-77484e267635@redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
 <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
 <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
 <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com>
 <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36769 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdF1SdO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 14:33:14 -0400
Received: by mail-qt0-f178.google.com with SMTP id i2so56717487qta.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 11:33:13 -0700 (PDT)
In-Reply-To: <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/27/2017 05:21 PM, sheng qiu wrote:
> i am appreciated to your kind reply.
> 
> In our test, we set the following in the ceph.conf:
> 
> osd_op_queue = mclock_client
> osd_op_queue_cut_off = high
> osd_op_queue_mclock_client_op_lim = 100.0
> osd_op_queue_mclock_client_op_res = 50.0
> osd_op_num_shards = 1
> osd_op_num_threads_per_shard = 1
> 
> 
> in this setup, all io requests should go to one mclock_client queue
> and using the mclock scheduling (osd_op_queue_cut_off = high).
> we use fio for test, we set job=1, bs=4k, qd=1 or 16.
> 
> we are expecting the visible iops by fio should < 100, while we see a
> much higher value.
> Did we understand your work correctly? or did we miss anything?

Hi Sheng,

I think you understand things well, but there is one additional detail
you may not have noticed yet. And that is what should be done when all
clients have reached their limit momentarily and the ObjectStore would
like another op to keep itself busy? We either a) refuse to provide it
with an op, or b) give it the op the op that's most appropriate by
weight. The ceph code currently is not designed to handle a) and it's
not even clear that we should starve the ObjectStore in that manner. So
we do b), and that means we can exceed the limit.

dmclock's PullPriorityQueue constructors have a parameter
_allow_limit_break, which ceph sets to true. That is how we do b) above.
If you ever wanted to set that to false you'd need to make other changes
to the ObjectStore ceph code to handle cases with the op queue is not
empty but not ready/willing to return an op when one is requested.

Eric
