From: Upendra Moturi <upendra.m@hexagrid.com>
Subject: Re: problem with ceph init scripts
Date: Thu, 17 Feb 2011 12:31:35 +0530
Message-ID: <AANLkTikiWxJyQCkk0DfDRjG29B64GnkS0L0RBy7ObG5n@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
	<AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53948 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1BQHBg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Feb 2011 02:01:36 -0500
Received: by wwa36 with SMTP id 36so2237929wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 23:01:35 -0800 (PST)
In-Reply-To: <AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

Hi Colin
I am using
ceph version 0.24.2 commit:f7572de5cb87eb7157217be4975ae66d90831bb7
ubuntu 11.04 32 bit with upgraded kernal of 2.6.38-2-generic

Installed ceph form apt source.

With above configurations i still able yo reproduce.
Can you please share me ur configurations?

On Thu, Feb 17, 2011 at 3:31 AM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cmu.edu=
> wrote:
>> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagrid.=
com> wrote:
>>> But if we want to start a particular osd or mon or mds ,its not
>>> working and there is no error
>>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't get=
 any error
>>
>> That is expected, unless you are running init-ceph on the same node =
as
>> osd1 is on.
>>
>> It might be nice to have some kind of interface like "run command X =
on
>> osd1", but init-ceph is not that.
>>
>>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It st=
ops
>>> on current node only
>>> where as
>>> /etc/init.d/ceph -a killall works fine.
>>
>> That sounds like a bug. I'll see if I can fix it.
>
> I'm afraid I can't reproduce this.
>
> I ran /etc/init.d/ceph -a stop
>
> and it stopped ceph daemons running on remote nodes too. Looking at
> the code, it looks correct.
>
> Colin
>



--=20
Thanks and Regards,
Upendra.M
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
