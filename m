From: Martin Mailand <martin@tuxadero.com>
Subject: Re: Cluster sync doesn't finsh
Date: Fri, 18 Nov 2011 21:17:25 +0100
Message-ID: <4EC6BD55.5050709@tuxadero.com>
References: <4EC57338.9040004@tuxadero.com>	<CAORUGqA888s9u23r6EfHCbMQ5t5QjGW8iNajdAZqK8pp7GqcXw@mail.gmail.com>	<CAF3hT9A2O4xLByS=-sNkgvgV8MsvqgzYvcZf4+J1dXpV97jYVw@mail.gmail.com> <CACLRD_1YxK8R9cRwXnZWK2=3QeQB8oq9-ZeNvtCYYMNpHGTRVg@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:35001 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1KRURe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2011 15:17:34 -0500
In-Reply-To: <CACLRD_1YxK8R9cRwXnZWK2=3QeQB8oq9-ZeNvtCYYMNpHGTRVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Sam,

here the crushmap

http://85.214.49.87/ceph/crushmap.txt
http://85.214.49.87/ceph/crushmap

-martin

Samuel Just schrieb:
> It looks like a crushmap related problem.  Could you send us the crus=
hmap?
>=20
> ceph osd getcrushmap
>=20
> Thanks
> -Sam
>=20
> On Fri, Nov 18, 2011 at 10:13 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Fri, Nov 18, 2011 at 10:05 AM, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>>> On Thu, Nov 17, 2011 at 12:48, Martin Mailand <martin@tuxadero.com>=
 wrote:
>>>> Hi,
>>>> I am doing cluster failure test, where I shut down one OSD an wait=
 for the
>>>> cluster to sync. But the sync never finshed, at around 4-5% it sto=
ps. I
>>>> stoped osd2.
>>> ...
>>>> 2011-11-17 16:42:45.520740    pg v1337: 600 pgs: 547 active+clean,=
 53
>>>> active+clean+degraded; 113 GB data, 184 GB used, 1141 GB / 1395 GB=
 avail;
>>>> 4025/82404 degraded (4.884%)
>>> ...
>>>> The osd log, the ceph.conf, pg dump, osd dump could be found here.
>>>>
>>>> http://85.214.49.87/ceph/
>>> This looks a bit worrying:
>>>
>>> 2011-11-17 17:56:35.771574 7f704c834700 -- 192.168.42.113:0/2424 >>
>>> 192.168.42.114:6802/21115 pipe(0x2596c80 sd=3D17 pgs=3D0 cs=3D0 l=3D=
0).connect
>>> claims to be 192.168.42.114:6802/21507 not 192.168.42.114:6802/2111=
5 -
>>> wrong node!
>>>
>>> So osd.0 is basically refusing to talk to one of the other OSDs. I
>>> don't understand the messenger well enough to know why this would b=
e,
>>> but it wouldn't surprise me if this problem kept the objects degrad=
ed
>>> -- it looks like a breakage in the osd<->osd communication.
>>>
>>> Now if this was the reason, I'd expect a restart of all the OSDs to
>>> get it back in shape; messenger state is ephemeral. Can you confirm
>>> that?
>> Probably not =E2=80=94 that wrong node thing can occur for a lot of =
different
>> reasons, some of which matter and most of which don't. Sam's looking
>> into the problem; there's something going wrong with the CRUSH
>> calculations or the monitor PG placement overrides or something...
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
