From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Sat, 10 Dec 2016 01:39:13 +0100
Message-ID: <1a42b836-94c8-b265-66af-d2b563cc9c7d@digiware.nl>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl>
 <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
 <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl>
 <CAJ4mKGa+wydRuMtvCYiOe823v9UkN2Qk0FkViqHhLAPmGeFoGA@mail.gmail.com>
 <89a9ee77-21db-e955-7bb3-c4adc3bb94bf@digiware.nl>
 <CAJ4mKGboUvhJhf1=bUD=unSAc4Z+1nQPmYXRFb=CfmA-Wk6GEQ@mail.gmail.com>
 <e467d1f1-8a29-1a32-b113-0d71e00d5ec5@digiware.nl>
 <CAJE9aOO5N4w=EZer310DYa9+rnszwR-afTx7M_dRjOtyS78pWw@mail.gmail.com>
 <ced59373-1ebf-554e-a383-bfe266067a22@digiware.nl>
 <CAJE9aONPZGj0ZXZRMiVnzW3RYGoOi8K5bW1caxa5vy=FJQV-ig@mail.gmail.com>
 <390636b2-3bcf-a3c0-1d50-9e62e53bbda8@digiware.nl>
 <822ea89a-d556-9ff1-5302-115ef05890cc@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:38212 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbcLJAjV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 19:39:21 -0500
In-Reply-To: <822ea89a-d556-9ff1-5302-115ef05890cc@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, kefu chai <tchaikov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 9-12-2016 13:02, Willem Jan Withagen wrote:
> On 9-12-2016 10:22, Willem Jan Withagen wrote:
>> On 9-12-2016 09:59, kefu chai wrote:
>>> On Thu, Dec 8, 2016 at 8:30 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> On 8-12-2016 11:03, kefu chai wrote:
>>>>> On Tue, Oct 4, 2016 at 7:57 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>>> On 3-10-2016 19:50, Gregory Farnum wrote:
>>>>>>>> Question here is:
>>>>>>>>   If I ask 'ceph osd dump', I'm actually asking ceph-mon.
>>>>>>>>   And cehp-mon has learned this from (crush?)maps being sent to it by
>>>>>>>>   ceph-osd.
>>>>>>> The monitor has learned about specific IP addresses/nonces/etc via
>>>>>>> MOSDBoot messages from the OSDs. The crush locations are set via
>>>>>>> monitor command messages, generally invoked as part of the init
>>>>>>> scripts. Maps are generated entirely on the monitor. :)
>>>>>>>
>>>>>>>> Is there an easy way to debug/monitor the content of what ceph-osd sends
>>>>>>>> and ceph-mon receives in the maps?
>>>>>>>> Just to make sure that it is clear where the problem occurs.
>>>>>>> You should be able to see the info going in and out by bumping the
>>>>>>> debug levels up — every message's "print" function is invoked when
>>>>>>> it's sent/received as long as you have "debug ms = 1". It looks like
>>>>>>> the MOSDBoot message doesn't natively dump its addresses but you can
>>>>>>> add them easily if you need to.
>>>>>> Hi Greg,
>>>>>>
>>>>>> Thanx for the answer....
>>>>>>
>>>>>> I've got debug_ms already pumped up all the way to 20.
>>>>>> So I do get to see what addresses are selected during bind. But still
>>>>>> they do not end up at the MON, and 'ceph osd dump' reports:
>>>>>>         :/0
>>>>>> as bind address.
>>>>>>
>>>>>> I'm going to add some more debugs to actually see what MOSDBoot is doing....
>>>>> there are multiple messengers used by ceph-osd, the one connected by
>>>>> rados client is the external/public messenger. it is also used by osd
>>>>> to talk with the monitor.
>>>>>
>>>>> the nonce of the external address of an OSD does not change after it's
>>>>> up: it's always the pid of ceph-osd process. and the (peer) address of
>>>>> the booting OSD collected by monitor comes from the connection's
>>>>> peer_addr field, which is set when the monitor accepts the connection
>>>>> from OSD. see STATE_ACCEPTING_WAIT_BANNER_ADDR case block in
>>>>> AsyncConnection::_process_connection().
>>>>>
>>>>> but there are chances that an OSD is restarted and fail to bind its
>>>>> external messenger to the specified the port. in that case, ceph-osd
>>>>> will try with another port, but keep the nonce the same. but when it
>>>>> comes to other messengers used by ceph-osd, their nonces increase by
>>>>> 1000000 every time they rebind. that's why "ceph osd thrash" can
>>>>> change the nonces of the cluster_addr, heartbeat_back_addr and
>>>>> heartbeat_front_addr. the PR of
>>>>> https://github.com/ceph/ceph/pull/11706 actually changes the behavior
>>>>> of the messengers of these three messengers. and it has nothing to do
>>>>> with the external messenger to which the ceph cli client is
>>>>> connecting.
>>>>>
>>>>> so you might want to check
>>>>> 1) how/why the nonce of the messenger in MonClient is 1000000 + $pid
>>>>> 2) while the nonce of the same messenger is $pid when the ceph cli
>>>>> connects to it.
>>>>>
>>>>> my PR of https://github.com/ceph/ceph/pull/11804 is more of a cleanup.
>>>>> it avoids setting the nonce before the rebind finishes. and i tried
>>>>> with your producer on my linux box, no luck =(
>>>> Right,
>>>>
>>>> You gave me a lot of things to think about, and to start figuring out.
>>>>
>>>> And you are right that something really bad needs to happen to an OSD to
>>>> get in this state. But that is what the tests actually do: They just
>>>> down/up or kill OSDs and restart.
>>>>
>>>> And from previous discussions I "learned" that if the process doesn't
>>>> die but needs to rebind on the port, the OSD stays at the same port but
>>>> increments the nonce to indicate that it is a fresh connection. And log
>>> the external messenger should *not* increment its nonce.
>>>
>>>> printing actually shows that the code is going thru a rebind.
>>> and it should *not* go through rebind().
>> I have to dig thru the testscript but as far as I can tell just about
>> all of the daemons are getting reboots in this test.
>>
>> So when would I get a rebind?
>>
>> I thought it was because I had an OSD incorrectly marked down:
>> ./src/osd/OSD.cc:7074:                 << " wrongly marked me down";
>> This I found in the logs, and then I got a rebind.
>>
>> Wido suggested looking for this message, on my question why my OSDs were
>> not getting UP after a good hustle with all OSDs and MONs.
>>
>> And that is one of the tests in cephtool-test-mon.sh.
>> right before the 'ceph tell osd.0 version' there are tests like:
>>   ceph osd set noup
>>   ceph osd down 0
>>   ceph osd dump | grep 'osd.0 down'
>>   ceph osd unset noup
>> and
>>   ceph osd reweight osd.0 .5
>>   ceph osd dump | grep ^osd.0 | grep 'weight 0.5'
>>   ceph osd out 0
>>   ceph osd in 0
>>   ceph osd dump | grep ^osd.0 | grep 'weight 0.5'
>>
>>
>>>> Now the bad thing is that the Linux and FreeBSD log do comparable things
>>>> with my (small) change to the setting of addr. And the nonce is indeed
>>>> incremented, which increment is actually picked up by all ceph components.
>> So now I have 2 challenges??
>>
>> 1) Find out why I get a rebind, where you think I should not.
>>    For that I'll have to collect all maltreatment that is done in
>>    cephtool-test-mon.sh. And again compare the Linux and FreeBSD logs
>>    to see what is up.
>> 2) If we get a rebind...
>>    Why doesn't the FreeBSD version end up with consistent noncees.
>>
>> "Good thing" about the previous code was that I could tweak it, and at
>> least get it to Work for FreeBSD. Have not had the time to see if I
>> could again with this code....
> So the smallest sequence I can find that demonstrates the problem:
> function test_mon_rebind()
> {
>   ceph osd set noup
>   ceph osd down 0
>   ceph osd dump | grep 'osd.0 down'
>   ceph osd unset noup
>   max_run=1000
>   for ((i=0; i < $max_run; i++)); do
>     if ! ceph osd dump | grep 'osd.0 up'; then
>       echo "waiting for osd.0 to come back up ($i/$max_run)"
>       sleep 1
>     else
>       break
>     fi
>   done
>   ceph osd dump | grep 'osd.0 up'
>
>   for id in `ceph osd ls` ; do
>     retry_eagain 5 map_enxio_to_eagain ceph tell osd.$id version
>   done
> }
>
> Which matches with what I thought I knew:
>   OSD down => up => rebind
> which follows from the log where the osd complains about being marked
> down incorrectly.
> search for
>    log_channel(cluster) log [WRN] : map e8 wrongly marked me down
> in the osd.0.log
>

I ran the code snippet, and it DOES generate a rebind even on Linux
Centos 7.
So I expect that the rebind action is called for?

Also note that at least one nonce is incremented, AND new ports are
selected.
6801,6802,6803 are avoided, and it looks like already connected ports
are avoided as well.
(obvious, since binding on them will not work)

Next is the FreeBSD log, and that one is relatively seriously wrong
since nonce are 0 .
And that must be incorrect.

Last is the log of the current master code with the patch I made of
msg->my_addr, versus addr.
IMHO a change that should be semantical equal?
  return bind(msgr->my_inst.addr, new_avoid);
  // return bind(addr, new_avoid);
One thing that is not working there is the port avoidance. That I have
to look into since there is no reason
why this should not work under FreeBSD.

Linux log:
2016-12-10 00:24:26.971102 7fdf0674e700  0 log_channel(cluster) log
[WRN] : map e20 wrongly marked me down
2016-12-10 00:24:26.971153 7fdf0674e700  1 -- 127.0.0.1:6801/22932
rebind rebind avoid 6801,6802,6803
2016-12-10 00:24:26.971440 7fdf0674e700  1 -- 127.0.0.1:6801/22932
shutdown_connections
2016-12-10 00:24:26.971600 7fdf0674e700  1  Processor -- rebind rebind
avoid 6801,6802,6803
2016-12-10 00:24:26.972454 7fdf0674e700  1  Processor -- bind bind
my_inst.addr is 127.0.0.1:6812/1022932
2016-12-10 00:24:26.972488 7fdf0674e700  1  Processor -- start
2016-12-10 00:24:26.972520 7fdf0674e700  1 -- 127.0.0.1:6802/22932
rebind rebind avoid 6801,6802,6803
2016-12-10 00:24:26.972564 7fdf0674e700  1 -- 127.0.0.1:6802/22932
shutdown_connections
2016-12-10 00:24:26.972599 7fdf0674e700  1  Processor -- rebind rebind
avoid 6801,6802,6803
2016-12-10 00:24:26.973286 7fdf0674e700  1 -- 127.0.0.1:0/22932
learned_addr learned my addr 127.0.0.1:0/22932
2016-12-10 00:24:26.973311 7fdf0674e700  1  Processor -- bind bind
my_inst.addr is 127.0.0.1:6813/1022932
2016-12-10 00:24:26.973318 7fdf0674e700  1  Processor -- start
2016-12-10 00:24:26.973345 7fdf0674e700  1 -- 127.0.0.1:6803/22932
rebind rebind avoid 6801,6802,6803
2016-12-10 00:24:26.973385 7fdf0674e700  1 -- 127.0.0.1:6803/22932
shutdown_connections
2016-12-10 00:24:26.973408 7fdf0674e700  1  Processor -- rebind rebind
avoid 6801,6802,6803
2016-12-10 00:24:26.974099 7fdf0674e700  1 -- 127.0.0.1:0/22932
learned_addr learned my addr 127.0.0.1:0/22932
2016-12-10 00:24:26.974136 7fdf0674e700  1  Processor -- bind bind
my_inst.addr is 127.0.0.1:6814/1022932
2016-12-10 00:24:26.974144 7fdf0674e700  1  Processor -- start
2016-12-10 00:24:26.974172 7fdf0674e700  1 -- 127.0.0.1:0/22932
shutdown_connections
2016-12-10 00:24:26.974249 7fdf0674e700  1 -- 127.0.0.1:0/22932 >>
127.0.0.1:6806/23094 conn(0x7fdf1f21a000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down
2016-12-10 00:24:26.974266 7fdf0674e700  1 -- 127.0.0.1:0/22932 >>
127.0.0.1:6807/23094 conn(0x7fdf1f302000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down
2016-12-10 00:24:26.974274 7fdf0674e700  1 -- 127.0.0.1:0/22932 >>
127.0.0.1:6810/23257 conn(0x7fdf1f303800 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down
2016-12-10 00:24:26.974281 7fdf0674e700  1 -- 127.0.0.1:0/22932 >>
127.0.0.1:6811/23257 conn(0x7fdf1f3aa000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down

The FreeBSD variant in current code looks like:
2016-12-10 00:58:45.612080 bb96d80  0 log_channel(cluster) log [WRN] :
map e19 wrongly marked me down
2016-12-10 00:58:45.612128 bb96d80  1 -- 127.0.0.1:6801/0 rebind Async
rebind avoid 6801,6802,6803
2016-12-10 00:58:45.612175 bb96d80  1 -- 127.0.0.1:6801/0
shutdown_connections
2016-12-10 00:58:45.612331 bb96d80  1 -- 127.0.0.1:6800/0 _finish_bind
bind my_inst.addr is 127.0.0.1:6800/0
2016-12-10 00:58:45.612339 bb96d80  1  Processor -- start
2016-12-10 00:58:45.612366 bb96d80  1 -- 127.0.0.1:6802/0 rebind Async
rebind avoid 6801,6802,6803
2016-12-10 00:58:45.612399 bb96d80  1 -- 127.0.0.1:6802/0
shutdown_connections
2016-12-10 00:58:45.612476 bb96d80  1 -- 127.0.0.1:0/0 learned_addr
learned my addr 127.0.0.1:0/0
2016-12-10 00:58:45.612487 bb96d80  1 -- 127.0.0.1:6804/0 _finish_bind
bind my_inst.addr is 127.0.0.1:6804/0
2016-12-10 00:58:45.612491 bb96d80  1  Processor -- start
2016-12-10 00:58:45.612520 bb96d80  1 -- 127.0.0.1:6803/0 rebind Async
rebind avoid 6801,6802,6803
2016-12-10 00:58:45.612553 bb96d80  1 -- 127.0.0.1:6803/0
shutdown_connections
2016-12-10 00:58:45.612659 bb96d80  1 -- 127.0.0.1:0/0 learned_addr
learned my addr 127.0.0.1:0/0
2016-12-10 00:58:45.612670 bb96d80  1 -- 127.0.0.1:6805/0 _finish_bind
bind my_inst.addr is 127.0.0.1:6805/0
2016-12-10 00:58:45.612674 bb96d80  1  Processor -- start
2016-12-10 00:58:45.612696 bb96d80  1 -- 127.0.0.1:0/40923
shutdown_connections
2016-12-10 00:58:45.612742 bb99600  1 -- 127.0.0.1:0/40923 >>
127.0.0.1:6811/0 conn(0xbd01800 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 00:58:45.612926 bb96d80  1 -- 127.0.0.1:0/40923 >>
127.0.0.1:6806/0 conn(0xbcc4000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 00:58:45.612967 bb96d80  1 -- 127.0.0.1:0/40923 >>
127.0.0.1:6807/0 conn(0xbcc5800 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 00:58:45.612983 bb96d80  1 -- 127.0.0.1:0/40923 >>
127.0.0.1:6810/0 conn(0xbd04800 :-1
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0 l=1).mark_down:2365
2016-12-10 00:58:45.613011 bb96d80  1 -- 127.0.0.1:0/40923 >>
127.0.0.1:6811/0 conn(0xbcda000 :-1 s=STATE_CONNECTING_RE pgs=0 cs=0
l=1).mark_down:2365

And then the current code:
2016-12-10 01:14:01.951312 bb96d80  0 log_channel(cluster) log [WRN] :
map e17 wrongly marked me down
2016-12-10 01:14:01.951431 bb96d80  1 -- 127.0.0.1:6801/43637 rebind
Async rebind avoid 6801,6802,6803
2016-12-10 01:14:01.951477 bb96d80  1 -- 127.0.0.1:6801/43637
shutdown_connections
2016-12-10 01:14:01.951554 bb96d80  1  Processor -- rebind Proc rebind
avoid 6801,6802,6803
2016-12-10 01:14:01.951629 bb96d80  1  Processor -- bind:156 end bind
my_inst.addr is 127.0.0.1:6801/1043637
2016-12-10 01:14:01.951637 bb96d80  1  Processor -- start
2016-12-10 01:14:01.951660 bb96d80  1 -- 127.0.0.1:6802/43637 rebind
Async rebind avoid 6801,6802,6803
2016-12-10 01:14:01.951700 bb96d80  1 -- 127.0.0.1:6802/43637
shutdown_connections
2016-12-10 01:14:01.951727 bb96d80  1  Processor -- rebind Proc rebind
avoid 6801,6802,6803
2016-12-10 01:14:01.951762 bb96d80  1 -- 127.0.0.1:6802/1043637
learned_addr learned my addr 127.0.0.1:6802/1043637
2016-12-10 01:14:01.951773 bb96d80  1  Processor -- bind:156 end bind
my_inst.addr is 127.0.0.1:6802/1043637
2016-12-10 01:14:01.951777 bb96d80  1  Processor -- start
2016-12-10 01:14:01.951797 bb96d80  1 -- 127.0.0.1:6803/43637 rebind
Async rebind avoid 6801,6802,6803
2016-12-10 01:14:01.951827 bb96d80  1 -- 127.0.0.1:6803/43637
shutdown_connections
2016-12-10 01:14:01.951854 bb96d80  1  Processor -- rebind Proc rebind
avoid 6801,6802,6803
2016-12-10 01:14:01.951889 bb96d80  1 -- 127.0.0.1:6803/1043637
learned_addr learned my addr 127.0.0.1:6803/1043637
2016-12-10 01:14:01.951900 bb96d80  1  Processor -- bind:156 end bind
my_inst.addr is 127.0.0.1:6803/1043637
2016-12-10 01:14:01.951904 bb96d80  1  Processor -- start
2016-12-10 01:14:01.951925 bb96d80  1 -- 127.0.0.1:0/43637
shutdown_connections
2016-12-10 01:14:01.952008 bb99600  1 -- 127.0.0.1:0/43637 >>
127.0.0.1:6811/43663 conn(0xbd62000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 01:14:01.952220 bb96d80  1 -- 127.0.0.1:0/43637 >>
127.0.0.1:6806/43650 conn(0xbc6e000 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 01:14:01.952246 bb96d80  1 -- 127.0.0.1:0/43637 >>
127.0.0.1:6807/43650 conn(0xbc6f800 :-1 s=STATE_CLOSED pgs=1 cs=1
l=1).mark_down:2365
2016-12-10 01:14:01.952260 bb96d80  1 -- 127.0.0.1:0/43637 >>
127.0.0.1:6810/43663 conn(0xbc72800 :-1
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0  l=1).mark_down:2365
2016-12-10 01:14:01.952289 bb96d80  1 -- 127.0.0.1:0/43637 >>
127.0.0.1:6811/43663 conn(0xbd65000 :-1
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0 l=1).mark_down:2365

--WjW



