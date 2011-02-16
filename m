From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: problem with ceph init scripts
Date: Wed, 16 Feb 2011 14:01:51 -0800
Message-ID: <AANLkTin8AtFLV4euxMr9PS0Xfd6fonXmSaVPmHgoVdFg@mail.gmail.com>
References: <AANLkTi=kvS=Oxou=1ZKeN+NW-0jMcYOtTQS-rzTZf2-9@mail.gmail.com>
	<AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38997 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1BPWCI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Feb 2011 17:02:08 -0500
Received: by fxm20 with SMTP id 20so1911332fxm.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Feb 2011 14:02:07 -0800 (PST)
In-Reply-To: <AANLkTikuEbwkmaPDKiMALRvzoxGzx9a86xejzx3TjHfi@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Upendra Moturi <upendra.m@hexagrid.com>
Cc: sage@newdream.net, ceph-devel@vger.kernel.org, Suresh Mandava <suresh@hexagrid.com>

On Wed, Feb 16, 2011 at 1:41 PM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> On Wed, Feb 16, 2011 at 6:44 AM, Upendra Moturi <upendra.m@hexagrid.c=
om> wrote:
>> But if we want to start a particular osd or mon or mds ,its not
>> working and there is no error
>> eg:/etc/init.d/ceph start osd1 =A0does not start osd1 and don't get =
any error
>
> That is expected, unless you are running init-ceph on the same node a=
s
> osd1 is on.
>
> It might be nice to have some kind of interface like "run command X o=
n
> osd1", but init-ceph is not that.
>
>> /etc/init.d/ceph -a stop also does not stop ceph on all nodes.It sto=
ps
>> on current node only
>> where as
>> /etc/init.d/ceph -a killall works fine.
>
> That sounds like a bug. I'll see if I can fix it.

I'm afraid I can't reproduce this.

I ran /etc/init.d/ceph -a stop

and it stopped ceph daemons running on remote nodes too. Looking at
the code, it looks correct.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
