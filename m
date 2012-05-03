From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Possible memory leak in mon?
Date: Thu, 03 May 2012 15:54:16 +0930
Message-ID: <4FA22490.5060001@bashkirtsev.com>
References: <4FA1B50B.8080603@bashkirtsev.com> <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:54406 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2ECGZc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 02:25:32 -0400
In-Reply-To: <07C999FE3BF7420ABC05B7CFF88B06AD@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Greg,

Apologies for multiple emails: my mail server is backed by ceph now and 
it struggled this morning (separate issue). So my mail server reported 
back to my mailer that sending of email failed when obviously it was not 
the case.

[root@gamma ~]# ceph -s
2012-05-03 15:46:55.640951   mds e2666: 1/1/1 up {0=1=up:active}, 1 
up:standby
2012-05-03 15:46:55.647106   osd e10728: 6 osds: 6 up, 6 in
2012-05-03 15:46:55.654052   log 2012-05-03 15:46:26.557084 mon.2 
172.16.64.202:6789/0 2878 : [INF] mon.2 calling new monitor election
2012-05-03 15:46:55.654425   mon e7: 3 mons at 
{0=172.16.64.200:6789/0,1=172.16.64.201:6789/0,2=172.16.64.202:6789/0}
2012-05-03 15:46:56.961624    pg v1251669: 600 pgs: 2 creating, 598 
active+clean; 309 GB data, 963 GB used, 1098 GB / 2145 GB avail

Loggin is on but nothing obvious in there: logs quite small. Number of 
ceph health logged (ceph monitored by nagios and so this record appears 
every 5 minutes), monitors periodically call for election (different 
periods between 1 to 15 minutes as it looks). That's it.

Regards,
Vladimir

On 03/05/12 09:52, Greg Farnum wrote:
> On Wednesday, May 2, 2012 at 3:28 PM, Vladimir Bashkirtsev wrote:
>> Dear devs,
>>
>> I have three mons and two of them suddenly consumed around 4G of RAM
>> while third one happily lived with 150M. This immediately prompts few
>> questions:
>>
>> 1. What is expected memory use of mon? I believed that mon merely
>> directs clients to relevant OSDs and should not consume a lot of
>> resources - please correct me if I am wrong.
>> 2. In both cases where mon consumed a lot of memory it was preceded by
>> disk-full condition and both machines where incidents happened are 64
>> bit, rest of cluster 32 bit. mon fs and log files happened to be in the
>> same partition - ceph osd produced a lot of messages, filled up disk,
>> mon crashed (no core as disk was full), manually deleted logs, restarted
>> mon without any issue, some time later found mon using 4G of RAM.
>> Running 0.45. Should I deliberately recreate conditions and crash mon to
>> get more debug info (if you need it of course, and if yes then what)?
>> 3. Does figure 4G per process coming from 32 bit pointers in mon? Or mon
>> potentially can consume more than 4G?
>>
>> Regards,
>> Vladimir
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> First: one email is enough.
>
> Second: in normal use your monitors should not consume very much memory. It sounds like something's wrong. Can you please provide the output of "ceph -s"?
> Also, do you have any monitor logging on? My best guess is that for some reason the monitors aren't all communicating with each other and so they are buffering messages.
> -Greg
>

