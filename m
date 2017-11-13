From: Mohamad Gebai <mgebai@suse.de>
Subject: Re: There is no rbd_aio_write_traced function in librbd
Date: Mon, 13 Nov 2017 10:03:34 -0500
Message-ID: <14a67866-77cb-06e0-5676-400fb2e2ac82@suse.de>
References: <etPan.5a031888.68a50b91.14a87@didichuxing.com>
 <508574095.32701832.1510176307240.JavaMail.zimbra@redhat.com>
 <etPan.5a09aa47.14289424.ace2@didichuxing.com>
 <etPan.5a09aae5.1b3506af.ace2@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbdKMPDh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Nov 2017 10:03:37 -0500
In-Reply-To: <etPan.5a09aae5.1b3506af.ace2@didichuxing.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p2O6YC46LaFKOWfuuehgOW5s+WPsOmDqCk=?= <liyichao@didichuxing.com>, Ali Maredia <amaredia@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

+ceph-devel

Hi,

Do you want to run LTTng on production or on a vstart cluster? If you
want to start with a vstart cluster, make sure to have a recent version
of Ceph as some fixes for tracing were introduced "recently". That blog
post is kind of old, so I'll  reiterate the steps here as there were
changes since it was written. With LTTng (not Blkin), it should be
straightforward:

- get a recent version of Ceph source code
- make sure to have WITH_LTTNG=ON (and optionally WITH_BABELTRACE=ON) in
your cmake command
- build Ceph
- add osd_tracing = true to ceph.conf
- launch the vstart cluster without LD_PRELOAD or any other "unusual"
setting
    + LD_PRELOAD=lttng-ust-fork isn't required anymore when tracing Ceph
with LTTng (not Blkin)
- "lttng list -u" should list the available tracepoints



As for Blkin, I'm not sure about its current state. Last time I tried, I
wasn't able to get it to work, and I ran into issues at different layers
(Ceph, LTTng, python libraries, Zipkin server). If you have a recent
version of Ceph, tracing should work (but not analyzing the trace using
Zipkin, at least for me). These are the steps:

- get a recent version of Ceph source code
- make sure to have WITH_BLKIN=ON in your cmake command
- build Ceph
- add osd_blkin_trace_all=true and other *blkin_trace*=true options as
needed
- launch the vstart cluster without LD_PRELOAD
    + linking against lttng-ust-fork *is* required for Blkin, but it was
added by default recently
- "lttng list -u" should list the available tracepoints


If you want to use LTTng or Blkin on an already deployed cluster, it
might be trickier. The first step would be to know which version of Ceph
you're using.

Mohamad



On 11/13/2017 09:23 AM, 李逸超(基础平台部) wrote:
>
>
> "After I create a new ceph.client.conf” means a ceph.conf without
`osd_tracing=true`.
>
> 在 2017年11月13日 下午10:20:55, 李逸超(基础平台部)
(liyichao@didichuxing.com) 写到:
>>
>> Hi，I tried two things: ceph with lttng and ceph with blkin. I wil
describe the steps and problems I encountered.
>> ceph with lttng
>>
>> There is no doc in ceph, so I basically follow this blog. Problems are:
>>
>>     No trace exists when lttng list -u. Only after some search and
looking at the source did I realize I have to put osd_tracing etc in the
ceph.conf
>>
>>     I have to run with
LD_PRELOAD=/usr/lib64/liblttng-ust-fork.so.0.0.0 ../vstart.sh …, so, is
it possible to do not do this? Then we can start tracing production osd
more easily.
>>
>>     after I set osd_tracing = true and restart the cluster.
./bin/ceph -c ceph.conf osd pool create test4 8 fails with Error EDQUOT:
crush test failed with -122 and with some experience with lttng
architecture and the source code of ./bin/ceph, I guess ./bin/ceph will
link librados but may not do dlopen because it is not osd, so dynamic
linkage with lttng is not working. After I create a new ceph.client.conf
and use ./bin/ceph -c ceph.client.conf, it succeed.
>>
>> ceph with blkin
>>
>> I follow Victor Araujo’s blog。
>>
>>     When I run LD_PRELOAD=/usr/lib64/liblttng-ust-fork.so.0.0.0
../src/vstart.sh -d -k -x -b, I stuck at:
>>
>> …
>> /data/apps/ceph/build-blkin/bin/ceph-mgr -i x -c
/data/apps/ceph/build-blkin/ceph.conf
>> /data/apps/ceph/build-blkin/bin/ceph -c
/data/apps/ceph/build-blkin/ceph.conf -k
/data/apps/ceph/build-blkin/keyring tell mgr restful create-self-signed-cert
>>
>> It is because mgr can not start:
>>    -1> 2017-11-13 22:18:35.647409 7f21df74e700 20 mgr Gil GIL
acquired for thread state 0x7f21f8cae420
>>      0> 2017-11-13 22:18:35.762103 7f21df74e700 -1 *** Caught signal
(Aborted) **
>>  in thread 7f21df74e700 thread_name:mgr-fin
>>
>>  ceph version 12.2.0 (32ce2a3ae5239ee33d6150705cdb24d43bab910c)
luminous (rc)
>>  1: (()+0x3cf501) [0x7f21ee8c1501]
>>  2: (()+0xf100) [0x7f21eb9c9100]
>>  3: (gsignal()+0x37) [0x7f21ea9e65f7]
>>  4: (abort()+0x148) [0x7f21ea9e7ce8]
>>  5: (()+0x2729fb) [0x7f21c9bf69fb]
>>  6: (()+0xf3a3) [0x7f21ee2dd3a3]
>>  7: (()+0x13ab6) [0x7f21ee2e1ab6]
>>  8: (()+0xf1b4) [0x7f21ee2dd1b4]
>>  9: (()+0x131ab) [0x7f21ee2e11ab]
>>  10: (()+0x102b) [0x7f21ed4ba02b]
>>  11: (()+0xf1b4) [0x7f21ee2dd1b4]
>>  12: (()+0x162d) [0x7f21ed4ba62d]
>>  13: (dlopen()+0x31) [0x7f21ed4ba0c1]
>>
>> So I start it manually with /data/apps/ceph/build-blkin/bin/ceph-mgr
-i x -c /data/apps/ceph/build-blkin/ceph.conf, and the traces are
successfully shown.
>>
>>
>>
>>
>> 在 2017年11月9日 上午5:25:11, Ali Maredia (amaredia@redhat.com) 写到:
>>> Mohamad



On 11/08/2017 04:25 PM, Ali Maredia wrote:
> Hello,
>
> Could you give me more details about what you are trying
> to do? Maybe all the steps for it. Are you trying to trace
> just the RBD?
>
> Some of the work Victor did a couple summers ago was going
> through the RBD code and put tracepoints in t.
>
> I understand those 2 PRs were not merged but related work
> was I think.
>
> I added Mohamad to this email who was working on tracing
> stuff recently.
>
> Best,
>
> Ali
>
> ----- Original Message -----
>> From: "李逸超(基础平台部)" <liyichao@didichuxing.com>
>> To: amaredia@redhat.com
>> Sent: Wednesday, November 8, 2017 9:45:31 AM
>> Subject: There is no rbd_aio_write_traced function in librbd
>>
>> Recently I am researching ceph tracing, and find this link
>> http://victoraraujo.me/babeltrace-zipkin/ ,following the steps it
provides,
>> I fail to build fio with rbd blkin. The error is: `undefined reference to
>> `rbd_aio_write_traced’`, and I search ceph source code, there indeed
is not
>> this function,
>>
https://github.com/ceph/ceph/search?q=rbd_aio_write_traced&type=Issues&utf8=%E2%9C%93
>> 。there is only two issues which are not merged.
>>
>


