From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: problem with ceph init scripts
Date: Wed, 16 Feb 2011 23:36:58 -0800
Message-ID: <AANLkTik4GFBFLWsq_gepb+t7Y=H9gxgm0dssDRFMROA-@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
	<AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43993 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab1BQHg7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 02:36:59 -0500
Received: by fxm20 with SMTP id 20so2296225fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 23:36:58 -0800 (PST)
In-Reply-To: <AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

I'm using head of line from the master branch. But that particular
code hasn't changed since January, which is 0.24.2 is from.

In my ceph.conf, I just had an osd that was on a remote machine, and
everything else local.

If you could post your ceph.conf here or in IRC, perhaps we might spot
an issue that's causing the problems that you see.

Colin


On Wed, Feb 16, 2011 at 11:01 PM, Upendra Moturi <upendra.m@hexagrid.co=
m> wrote:
> Hi Colin
> I am using
> ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d90831bb7
> ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic
>
> Installed ceph form apt source.
>
> With above configurations i still able yo reproduce.
> Can you please share me ur configurations?
>
> On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
>> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cmu.ed=
u> wrote:
>>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagrid=
=2Ecom> wrote:
>>>> But if we want to start a particular osd or mon or mds ,its not
>>>> working and there is no error
>>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't ge=
t any error
>>>
>>> That is expected, unless you are running init-ceph on the same node=
 as
>>> osd1 is on.
>>>
>>> It might be nice to have some kind of interface like "run command X=
 on
>>> osd1", but init-ceph is not that.
>>>
>>>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It s=
tops
>>>> on current node only
>>>> where as
>>>> /etc/init.d/ceph -a killall works fine.
>>>
>>> That sounds like a bug. I'll see if I can fix it.
>>
>> I'm afraid I can't reproduce this.
>>
>> I ran /etc/init.d/ceph -a stop
>>
>> and it stopped ceph daemons running on remote nodes too. Looking at
>> the code, it looks correct.
>>
>> Colin
>>
>
>
>
> --
> Thanks and Regards,
> Upendra.M
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
