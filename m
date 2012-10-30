From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Monitor issue
Date: Tue, 30 Oct 2012 10:32:36 +0000
Message-ID: <508FACC4.1080402@inktank.com>
References: <508E9742.8040303@gmail.com> <508E99BC.6050807@widodh.nl> <508F6E55.4020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ye0-f174.google.com ([209.85.213.174]:57282 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128Ab2J3KdC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 06:33:02 -0400
Received: by mail-ye0-f174.google.com with SMTP id m12so9305yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 03:33:01 -0700 (PDT)
In-Reply-To: <508F6E55.4020101@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On 10/30/2012 06:06 AM, Roman Alekseev wrote:
> On 29.10.2012 18:59, Wido den Hollander wrote:
>>
>>
>> On 10/29/2012 03:48 PM, Roman Alekseev wrote:
>>> Hello,
>>>
>>> I have 3 monitors on different nodes and when 'mon.a' was stopped whole
>>> cluster stopped work too.
>>> My conf: http://pastebin.com/hT3qEhUF
>>>
>>> Could someone explain how to fix such kind of failure?
>>
>> Could you explain a bit more about the setup?
>>
>> Which version are you running?
>>
>> What do you mean with failure? Is the ceph -s command still working?
>>
>> How sure are you that you didn't catch a bug that killed all three
>> monitors? Are those processes actually up and running?
>>
>> Did you check the logs of the monitors?
>>
>> Could you let us know?
>>
>> Thanks!
>>
>> Wido
> 
> Hi Wido,
> 
> I'm running ceph version 0.48.1argonaut.
> The "ceph -s" command doesn't work until I start that monitor again.
> Under failure I mean that ceph commands (such as ceph -s , -w, ceph mon
> dump etc) don't respond. I've re-added all three mons and found the
> following situations:
> 
> Situation A:
> 1) mon.a is disabled:
> health HEALTH_WARN 1 mons down, quorum 1,2 b,c (cluster works)
> 2) mon.b is disabled:
> health HEALTH_WARN 1 mons down, quorum 0,1 a,c (cluster works)
> 3) mon.c is disabled:
> health HEALTH_WARN 1 mons down, quorum 0,2 a,b (cluster works)
> 
> Situation B:
> If 2 mons are disabled all cluster stop working.
> So cluster works only when 2 monitors are running.
> 
> Is it correct ?
> 

In a nutshell, yes.

You need to have a majority of monitors up and running, and in the
quorum, for the cluster to work.

So, in 'A', you always have 2 out of the 3 existing monitors up; this
means a majority is up and quorum can be formed.

In 'B' however, you have only one monitor. Given there are 3 monitors in
the monmap, you don't have enough monitors to form a quorum (N+1/2, N
being the total number of monitors in your cluster, which is 3 in your
case).

Same rules apply if you had, say, 5 monitors: you'd need 3 up for the
cluster to work; if you only had 2, the monitors wouldn't be able to
form quorum.

And by the way, the cluster doesn't work because unless you have a
healthy monitor cluster, with formed quorum, the monitors that are up
and running will basically refuse to answer any kind of requests made to
them (aside from specific commands made through the admin socket, that
are targeted at one specific monitor).

Hope this helps.

  -Joao
