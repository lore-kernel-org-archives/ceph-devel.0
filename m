From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 13 Sep 2016 22:21:49 +0200
Message-ID: <8a50f2a2-ccca-0640-68e6-ac7d44366632@digiware.nl>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl>
 <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:22294 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932561AbcIMUWH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Sep 2016 16:22:07 -0400
In-Reply-To: <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 13-9-2016 21:52, Gregory Farnum wrote:
> On Tue, Sep 13, 2016 at 2:00 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 13-9-2016 04:29, Haomai Wang wrote:
>>> On Tue, Sep 13, 2016 at 6:59 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> Hi
>>>>
>>>> When running  cephtool-test-mon.sh, part of it executes:
>>>>   ceph tell osd.0 version
>>>> I see reports on the commandline, I guess that this is the OSD
>>>> complaining that things are wrong:
>>>>
>>>> 2016-09-12 23:50:39.239037 814e50e00  0 -- 127.0.0.1:0/1925715881 >>
>>>> 127.0.0.1:6800/26384 conn(0x814fde800 sd=18 :-1
>>>> s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0
>>>> l=1)._process_connection connect claims to be 127.0.0.1:6800/1026384 not
>>>> 127.0.0.1:6800/26384 - wrong node!
>>>>
>>>> Which it will run until it is shot down.... after 3600 secs.
>>>>
>>>> the nonce is incremented with 1000000 on every rebind.
>>>>
>>>> But what I do not understand is how this mismatch has occurred.
>>>> I would expect port 6800 to be the port on which the OSD is connected
>>>> too, so the connecting party (ceph in this case) thinks the nonce to be
>>>> 1026384. Did the MON have this information? And where did the MON then
>>>> get it from....
>>>>
>>>> Somewhere one of the parts did not receive the new nonce, or did not
>>>> also increment it?
>>>
>>> nonce is a part of ceph_entity_addr, so OSDMap will take this
>>
>> Right, but then the following is also suspicious???
>>
>> ====
>> # ceph osd dump
>> epoch 188
>> fsid 2e02472d-ecbb-43ac-a687-bbf2523233d9
>> created 2016-09-13 10:28:07.970254
>> modified 2016-09-13 10:34:57.318988
>> flags sortbitwise,require_jewel_osds,require_kraken_osds
>> pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash
>> rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_width 0
>> max_osd 10
>> osd.0 up   in  weight 1 up_from 175 up_thru 185 down_at 172
>> last_clean_interval [8,174) 127.0.0.1:6800/36565 127.0.0.1:6800/1036565
>> 127.0.0.1:6804/1036565 127.0.0.1:6805/1036565 exists,up
>> e0e44b9c-9869-49d8-8afb-bdb71c04ea27
>> osd.1 up   in  weight 1 up_from 10 up_thru 184 down_at 0
>> last_clean_interval [0,0) 127.0.0.1:6804/36579 127.0.0.1:6805/36579
>> 127.0.0.1:6806/36579 127.0.0.1:6807/36579 exists,up
>> b554849c-2cf1-4cf7-a5fd-3529d33345ff
>> osd.2 up   in  weight 1 up_from 12 up_thru 185 down_at 0
>> last_clean_interval [0,0) 127.0.0.1:6808/36593 127.0.0.1:6809/36593
>> 127.0.0.1:6810/36593 127.0.0.1:6811/36593 exists,up
>> 2d6648ba-72e1-4c53-ae10-929a9d13a3dd
>> ====
>>
>> osd.0 has:
>>         127.0.0.1:6800/36565
>>         127.0.0.1:6800/1036565
>>         127.0.0.1:6804/1036565
>>         127.0.0.1:6805/1036565
>>
>> So I guess that one nonce did not get updated, because I would expect
>> all ports te be rebound, and incr the nonce?
>>
>> The other bad thing is that ports 6804 and 6805 are now both in osd.0
>> and osd.1, which is going to create some trouble also I would guess.
>>
>> So this is what the osdmap distributes?
>> And then MON reports to clients?
>>
>> How would I retrieve the dump from osd.0 itself?
>> Trying:
>> # ceph -c ceph.conf daemon osd.0 dump
>> Can't get admin socket path: [Errno 2] No such file or directory
>>
>> Using the admin-socket directly does work.
>> But there is not really a command to get something equal to:
>> ====
>> osd.0 up   in  weight 1 up_from 175 up_thru 185 down_at 172
>> last_clean_interval [8,174) 127.0.0.1:6800/36565 127.0.0.1:6800/1036565
>> 127.0.0.1:6804/1036565 127.0.0.1:6805/1036565 exists,up
>> e0e44b9c-9869-49d8-8afb-bdb71c04ea27
>> ====
>> So that one can see what the OSD itself thinks it is....
> 
> Is osd.0 actually running? If so it *should* have a socket, unless
> you've disabled them somehow. Check the logs and see if there are
> failures when it gets set up, I guess?

Yup, the OSD is/are up. I needed to work on the EventKqueue() stuff
because events could not be submitted once threads were formed.

> Anyway, something has indeed gone terribly wrong here. I know at one
> point you had some messenger patches you were using to try and get
> stuff going on BSD; if you still have some there I think you need to
> consider them suspect. Otherwise, uh...the network stack is behaving
> very differently than Linux's?

Well a large part of the challenge is that Linux is using EventEpoll()
and on FreeBSD EventKqueue() is the choice. (if only because FreeBSD
does not have Epoll() )

On of the problems is that the descriptor for reading/writing the events
does not survive a fork. And thus any setup and or events that are done
before threads are forked will be lost.

So yes, my patches are incomplete, that much I know. But I'm gathering
knowledge to see how to beter diagnose the problem, and have the tools
to see that the fix really works.
Hence my question if there is a ceph argument that delivers more or less
the same OSD dump output, directly from the OSD itself.

I'm discussing this also with Haomai Wang, who did the first version of
EventKqueue...

--WjW

