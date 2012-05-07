From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Possible memory leak in mon?
Date: Mon, 07 May 2012 10:23:25 +0930
Message-ID: <4FA71D05.7050305@bashkirtsev.com>
References: <4FA1B50B.8080603@bashkirtsev.com> <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com> <4FA22490.5060001@bashkirtsev.com> <A1BA6F85E3224387AFB0C24A7786B470@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:57508 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab2EGAxm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 May 2012 20:53:42 -0400
In-Reply-To: <A1BA6F85E3224387AFB0C24A7786B470@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 03/05/12 16:23, Greg Farnum wrote:
> On Wednesday, May 2, 2012 at 11:24 PM, Vladimir Bashkirtsev wrote:
>> Greg,
>>
>> Apologies for multiple emails: my mail server is backed by ceph now =
and
>> it struggled this morning (separate issue). So my mail server report=
ed
>> back to my mailer that sending of email failed when obviously it was=
 not
>> the case.
> Interesting =E2=80=94 I presume you're using the file system? That's =
not something we've heard of anybody doing with Ceph before. :)
>
>>
>> [root@gamma ~]# ceph -s
>> 2012-05-03 15:46:55.640951 mds e2666: 1/1/1 up {0=3D1=3Dup:active}, =
1
>> up:standby
>> 2012-05-03 15:46:55.647106 osd e10728: 6 osds: 6 up, 6 in
>> 2012-05-03 15:46:55.654052 log 2012-05-03 15:46:26.557084 mon.2
>> 172.16.64.202:6789/0 2878 : [INF] mon.2 calling new monitor election
>> 2012-05-03 15:46:55.654425 mon e7: 3 mons at
>> {0=3D172.16.64.200:6789/0,1=3D172.16.64.201:6789/0,2=3D172.16.64.202=
:6789/0}
>> 2012-05-03 15:46:56.961624 pg v1251669: 600 pgs: 2 creating, 598
>> active+clean; 309 GB data, 963 GB used, 1098 GB / 2145 GB avail
>>
>> Loggin is on but nothing obvious in there: logs quite small. Number =
of
>> ceph health logged (ceph monitored by nagios and so this record appe=
ars
>> every 5 minutes), monitors periodically call for election (different
>> periods between 1 to 15 minutes as it looks). That's it.
> Hrm. Generally speaking the monitors shouldn't call for elections unl=
ess something changes (one of them crashes) or the leader monitor is sl=
owing down.
> Can you increase the debug_mon to 20, the debug_ms to 1, and post one=
 of the logs somewhere? The "Live Debugging" section of http://ceph.com=
/wiki/Debugging should give you what you need. :)
Here's the logs and core dumps:
http://www.bashkirtsev.com/logs-2012-05-07.tar.bz2

Mons grown to 1.2GB and 2GB of memory.
>
>>
>> Regards,
>> Vladimir
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
