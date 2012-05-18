From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Possible memory leak in mon?
Date: Fri, 18 May 2012 19:37:54 +0930
Message-ID: <4FB61F7A.2080602@bashkirtsev.com>
References: <4FA1B50B.8080603@bashkirtsev.com> <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com> <4FA22490.5060001@bashkirtsev.com> <A1BA6F85E3224387AFB0C24A7786B470@dreamhost.com> <4FA71D05.7050305@bashkirtsev.com> <CAPYLRzgpZmASDE=3XYF+BBydtOopN19nOk8Tkmqk_-EdscmrMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:46946 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757078Ab2ERKJO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 06:09:14 -0400
In-Reply-To: <CAPYLRzgpZmASDE=3XYF+BBydtOopN19nOk8Tkmqk_-EdscmrMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 16/05/12 02:43, Gregory Farnum wrote:
> On Sun, May 6, 2012 at 5:53 PM, Vladimir Bashkirtsev
> <vladimir@bashkirtsev.com>  wrote:
>> On 03/05/12 16:23, Greg Farnum wrote:
>>> On Wednesday, May 2, 2012 at 11:24 PM, Vladimir Bashkirtsev wrote:
>>>> Greg,
>>>>
>>>> Apologies for multiple emails: my mail server is backed by ceph no=
w and
>>>> it struggled this morning (separate issue). So my mail server repo=
rted
>>>> back to my mailer that sending of email failed when obviously it w=
as not
>>>> the case.
>>> Interesting =97 I presume you're using the file system? That's not =
something
>>> we've heard of anybody doing with Ceph before. :)
>>>
>>>> [root@gamma ~]# ceph -s
>>>> 2012-05-03 15:46:55.640951 mds e2666: 1/1/1 up {0=3D1=3Dup:active}=
, 1
>>>> up:standby
>>>> 2012-05-03 15:46:55.647106 osd e10728: 6 osds: 6 up, 6 in
>>>> 2012-05-03 15:46:55.654052 log 2012-05-03 15:46:26.557084 mon.2
>>>> 172.16.64.202:6789/0 2878 : [INF] mon.2 calling new monitor electi=
on
>>>> 2012-05-03 15:46:55.654425 mon e7: 3 mons at
>>>> {0=3D172.16.64.200:6789/0,1=3D172.16.64.201:6789/0,2=3D172.16.64.2=
02:6789/0}
>>>> 2012-05-03 15:46:56.961624 pg v1251669: 600 pgs: 2 creating, 598
>>>> active+clean; 309 GB data, 963 GB used, 1098 GB / 2145 GB avail
>>>>
>>>> Loggin is on but nothing obvious in there: logs quite small. Numbe=
r of
>>>> ceph health logged (ceph monitored by nagios and so this record ap=
pears
>>>> every 5 minutes), monitors periodically call for election (differe=
nt
>>>> periods between 1 to 15 minutes as it looks). That's it.
>>> Hrm. Generally speaking the monitors shouldn't call for elections u=
nless
>>> something changes (one of them crashes) or the leader monitor is sl=
owing
>>> down.
>>> Can you increase the debug_mon to 20, the debug_ms to 1, and post o=
ne of
>>> the logs somewhere? The "Live Debugging" section of
>>> http://ceph.com/wiki/Debugging should give you what you need. :)
>> Here's the logs and core dumps:
>> http://www.bashkirtsev.com/logs-2012-05-07.tar.bz2
>>
>> Mons grown to 1.2GB and 2GB of memory.
> When I look at the logs for mon.0, I see that there are a lot of
> places where mon.0 takes tens of seconds to write something to disk.
> If the disk is just about full, that might make sense (many
> filesystems don't handle a nearly-full disk very well at all); and a
> monitor getting stuck for that long could definitely explain why they
> start using up so much memory (they're buffering messages). I suspect
> that there's not anything particularly wrong here, unless I'm
> misunderstanding the story you're telling me. :) Have you noticed thi=
s
> problem when the monitor's disk partition isn't nearly full?
> -Greg
I have recreated conditions when mon started to consume more memory:=20
everything appears in line with your suspicions. When disk gets almost=20
full, mon slows down and finally crashes quite badly so I cannot recove=
r=20
it. I am forced then to destroy mon all together and create a new one=20
instead.

Long story short: in docs/wiki it should be stated as recommendation NO=
T=20
to keep monfs on the same partition as ceph log (which can grow quickly=
)=20
and preferably keep it on separate partition all together.

In the same time it begs another question: what it recommended partitio=
n=20
size for monfs?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
