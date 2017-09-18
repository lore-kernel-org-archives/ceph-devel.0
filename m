From: Jin Cai <caijin.laurence@gmail.com>
Subject: Re: Ceph RDMA Memory Leakage
Date: Mon, 18 Sep 2017 19:27:37 +0800
Message-ID: <CAGRcXKY+0ecs+6EHKh1VSqC5uMqCD2vR0J_Xi0up45ggGyv4Cw@mail.gmail.com>
References: <CAGRcXKaZJBFnTtDVKzPyfVyK3Wrnve0Un83TjAWq4opdGaT+yA@mail.gmail.com>
 <CACJqLyYBCbvBMK9heRvTn4tmo6jusEA2C6dWFh5H1ysoYfSg-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:51220 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbdIRL1k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 07:27:40 -0400
Received: by mail-lf0-f52.google.com with SMTP id y187so197049lfc.8
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 04:27:39 -0700 (PDT)
In-Reply-To: <CACJqLyYBCbvBMK9heRvTn4tmo6jusEA2C6dWFh5H1ysoYfSg-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Adir Lev <adirl@mellanox.com>

Oops, I forgot including the version information of ceph in my mail.
The Ceph Version we use is: 12.2.0



2017-09-18 18:13 GMT+08:00 Haomai Wang <haomai@xsky.com>:
> which version do you use? I think we have fixed some memory problem on masater
>
> On Mon, Sep 18, 2017 at 2:09 PM, Jin Cai <caijin.laurence@gmail.com> wrote:
>> Hi, cephers
>>
>>     We are testing the RDMA ms type of Ceph.
>>
>>     The OSDs and MONs are always marked down by their peers because
>> they don't have enough buffer to use in the memory buffer pool to
>> reply the heartbeat ping message from their peers.
>>     And the log always shows "no enough buffer in worker" even though
>> the whole cluster is idle without any I/Os from external.
>>
>>     Ceph configuration about RDMA is as following:
>>         ms_async_rdma_roce_ver = 1
>>         ms_async_rdma_sl = 5
>>         ms_async_rdma_dscp = 136
>>         ms_async_rdma_send_buffers = 1024
>>         ms_async_rdma_receive_buffers = 1024
>>
>>    Even we adjust the value of ms_async_rdma_send_buffers to 32,768,
>> the 'no enough buffer in worker' log still exists.
>>
>>    After a deep analysis, we think it is because when a
>> RDMAConnectedSocketImpl instance is destructed, its queue pair is
>> added to the dead_queue_pair vector container. And the items of
>> dead_queue_pair are deleted in the polling thread.
>>
>> From the doc of rdmamojo:
>> When a QP is destroyed any outstanding Work Requests, in either the
>> Send or Receive Queues, won't be processed anymore by the RDMA device
>> and Work Completions won't be generated for them. It is up to the user
>> to clean all of the associated resources of those Work Requests (i.e.
>> memory buffers)
>>
>> We can know the problem here is that when there are still outstanding
>> work request in the queue pair to be deleted, the memory buffer
>> occupied by these outstanding work request will never be returned to
>> memory buffer pool because work completions won't be generated for
>> them. So the memory leakage happens.
>>
>> A more elegant way before destroying a queue pair is set the queue
>> pair into error state and wait for the affiliated event
>> IBV_EVENT_QP_LAST_WQE_REACHED, finally destroy the queue pair.
>>
>> Do you have any suggestions or ideas? Thanks in advance.
