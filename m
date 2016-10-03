From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Mon, 3 Oct 2016 10:50:23 -0700
Message-ID: <CAJ4mKGboUvhJhf1=bUD=unSAc4Z+1nQPmYXRFb=CfmA-Wk6GEQ@mail.gmail.com>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl> <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
 <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl> <CAJ4mKGa+wydRuMtvCYiOe823v9UkN2Qk0FkViqHhLAPmGeFoGA@mail.gmail.com>
 <89a9ee77-21db-e955-7bb3-c4adc3bb94bf@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:36631 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbcJCRuZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2016 13:50:25 -0400
Received: by mail-it0-f46.google.com with SMTP id 188so41325500iti.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Oct 2016 10:50:25 -0700 (PDT)
In-Reply-To: <89a9ee77-21db-e955-7bb3-c4adc3bb94bf@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 28, 2016 at 5:01 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 13-9-2016 22:35, Gregory Farnum wrote:
>> On Tue, Sep 13, 2016 at 1:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> On 13-9-2016 21:52, Gregory Farnum wrote:
>>>> Is osd.0 actually running? If so it *should* have a socket, unless
>>>> you've disabled them somehow. Check the logs and see if there are
>>>> failures when it gets set up, I guess?
>>>>
>>>> Anyway, something has indeed gone terribly wrong here. I know at one
>>>> point you had some messenger patches you were using to try and get
>>>> stuff going on BSD; if you still have some there I think you need to
>>>> consider them suspect. Otherwise, uh...the network stack is behaving
>>>> very differently than Linux's?
>>>
>>> So what is the expected result of an osd down/up?
>>>
>>> Before it is connected to ports like:
>>>         127.0.0.1:{6800,,6801,6802}/{nonce=pid-like}
>>> after the osd has gone down/up the sockets work be:
>>>         127.0.0.1:{6800,,6801,6802}/{(nonce=pid-like)+1000000}
>>>
>>> or are the ports also incremented?
>>
>> IIRC, it should usually be the same ports and different nonce. But the
>> port is *allowed* to change; that happens sometimes if there was an
>> unclean shutdown and the port is still considered in-use by the OS for
>> instance.
>>
> ATM, I have the feeling that I'm even more off track.
>
> In FreeBSD I have:
> 119: starting osd.0 at :/0 osd_data testdir/osd-bench/0
> testdir/osd-bench/0/journal
> 119: create-or-move updating item name 'osd.0' weight 1 at location
> {host=localhost,root=default} to crush map
> 119: 0
> 119: epoch 5
> 119: fsid 6e5ab220-d761-4636-b4b0-27eacadb41e3
> 119: created 2016-09-28 02:32:44.704630
> 119: modified 2016-09-28 02:32:49.971511
> 119: flags sortbitwise,require_jewel_osds,require_kraken_osds
> 119: pool 1 'rbd' replicated size 3 min_size 2 crush_ruleset 0
> object_hash rjenkins pg_num 4 pgp_num 4 last_change 3 flags hashpspool
> stripe_width 0
> 119: max_osd 1
> 119: osd.0 down out weight 0 up_from 0 up_thru 0 down_at 0
> last_clean_interval [0,0) :/0 :/0 :/0 :/0 exists,new
> 1dddf568-c6dd-47d1-b4b4-584867a8b48d
>
> Where as in Linux I have, at the same point in the script:
> 130: starting osd.0 at :/0 osd_data testdir/osd-bench/0
> testdir/osd-bench/0/journal
> 130: create-or-move updating item name 'osd.0' weight 1 at location
> {host=localhost,root=default} to crush map
> 130: 0
> 130: osd.0 up   in  weight 1 up_from 6 up_thru 6 down_at 0
> last_clean_interval [0,0) 127.0.0.1:6800/19815 127.0.0.1:6801/19815
> 127.0.0.1:6802/19815 127.0.0.1:6803/19815 exists,up
> 084e3410-9eb9-4fc3-b395-e46e9587d351
>
> Question here is:
>   If I ask 'ceph osd dump', I'm actually asking ceph-mon.
>   And cehp-mon has learned this from (crush?)maps being sent to it by
>   ceph-osd.

The monitor has learned about specific IP addresses/nonces/etc via
MOSDBoot messages from the OSDs. The crush locations are set via
monitor command messages, generally invoked as part of the init
scripts. Maps are generated entirely on the monitor. :)

> Is there an easy way to debug/monitor the content of what ceph-osd sends
> and ceph-mon receives in the maps?
> Just to make sure that it is clear where the problem occurs.

You should be able to see the info going in and out by bumping the
debug levels up — every message's "print" function is invoked when
it's sent/received as long as you have "debug ms = 1". It looks like
the MOSDBoot message doesn't natively dump its addresses but you can
add them easily if you need to.
-Greg
