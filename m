From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: Monitor issue
Date: Tue, 30 Oct 2012 10:06:13 +0400
Message-ID: <508F6E55.4020101@gmail.com>
References: <508E9742.8040303@gmail.com> <508E99BC.6050807@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62827 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2J3GGR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 02:06:17 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4359838lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 23:06:15 -0700 (PDT)
In-Reply-To: <508E99BC.6050807@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On 29.10.2012 18:59, Wido den Hollander wrote:
>
>
> On 10/29/2012 03:48 PM, Roman Alekseev wrote:
>> Hello,
>>
>> I have 3 monitors on different nodes and when 'mon.a' was stopped whole
>> cluster stopped work too.
>> My conf: http://pastebin.com/hT3qEhUF
>>
>> Could someone explain how to fix such kind of failure?
>
> Could you explain a bit more about the setup?
>
> Which version are you running?
>
> What do you mean with failure? Is the ceph -s command still working?
>
> How sure are you that you didn't catch a bug that killed all three 
> monitors? Are those processes actually up and running?
>
> Did you check the logs of the monitors?
>
> Could you let us know?
>
> Thanks!
>
> Wido

Hi Wido,

I'm running ceph version 0.48.1argonaut.
The "ceph -s" command doesn't work until I start that monitor again. 
Under failure I mean that ceph commands (such as ceph -s , -w, ceph mon 
dump etc) don't respond. I've re-added all three mons and found the 
following situations:

Situation A:
1) mon.a is disabled:
health HEALTH_WARN 1 mons down, quorum 1,2 b,c (cluster works)
2) mon.b is disabled:
health HEALTH_WARN 1 mons down, quorum 0,1 a,c (cluster works)
3) mon.c is disabled:
health HEALTH_WARN 1 mons down, quorum 0,2 a,b (cluster works)

Situation B:
If 2 mons are disabled all cluster stop working.
So cluster works only when 2 monitors are running.

Is it correct ?

-- 
Kind regards,

R. Alekseev

