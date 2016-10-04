From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 4 Oct 2016 13:57:12 +0200
Message-ID: <e467d1f1-8a29-1a32-b113-0d71e00d5ec5@digiware.nl>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl>
 <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
 <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl>
 <CAJ4mKGa+wydRuMtvCYiOe823v9UkN2Qk0FkViqHhLAPmGeFoGA@mail.gmail.com>
 <89a9ee77-21db-e955-7bb3-c4adc3bb94bf@digiware.nl>
 <CAJ4mKGboUvhJhf1=bUD=unSAc4Z+1nQPmYXRFb=CfmA-Wk6GEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:15653 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbcJDL51 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Oct 2016 07:57:27 -0400
In-Reply-To: <CAJ4mKGboUvhJhf1=bUD=unSAc4Z+1nQPmYXRFb=CfmA-Wk6GEQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 3-10-2016 19:50, Gregory Farnum wrote:
>> Question here is:
>>   If I ask 'ceph osd dump', I'm actually asking ceph-mon.
>>   And cehp-mon has learned this from (crush?)maps being sent to it by
>>   ceph-osd.
> 
> The monitor has learned about specific IP addresses/nonces/etc via
> MOSDBoot messages from the OSDs. The crush locations are set via
> monitor command messages, generally invoked as part of the init
> scripts. Maps are generated entirely on the monitor. :)
> 
>> Is there an easy way to debug/monitor the content of what ceph-osd sends
>> and ceph-mon receives in the maps?
>> Just to make sure that it is clear where the problem occurs.
> 
> You should be able to see the info going in and out by bumping the
> debug levels up — every message's "print" function is invoked when
> it's sent/received as long as you have "debug ms = 1". It looks like
> the MOSDBoot message doesn't natively dump its addresses but you can
> add them easily if you need to.

Hi Greg,

Thanx for the answer....

I've got debug_ms already pumped up all the way to 20.
So I do get to see what addresses are selected during bind. But still
they do not end up at the MON, and 'ceph osd dump' reports:
	:/0
as bind address.

I'm going to add some more debugs to actually see what MOSDBoot is doing....

It looks like I've tackled most of the EventKqueue forking trouble, by
keeping a full administration.
Got to make some more FreeBSD tests to see if I'm actually solving what
I think is the problem. :)

--WjW
