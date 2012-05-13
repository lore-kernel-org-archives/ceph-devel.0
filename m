From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: waiting for sub ops
Date: Sun, 13 May 2012 20:04:32 +0200
Message-ID: <4FAFF7B0.2030400@profihost.ag>
References: <4FACB96F.3050309@profihost.ag> <Pine.LNX.4.64.1205121714120.21796@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:54982 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab2EMSEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 May 2012 14:04:16 -0400
In-Reply-To: <Pine.LNX.4.64.1205121714120.21796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

Am 13.05.2012 02:15, schrieb Sage Weil:
> On Fri, 11 May 2012, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> while doing some stress testing with bonnie++ i'm seeing always these
>> messages accross all osd's here is just an example for osd.2.
>>
>> All machines are connected with 2x 1Gbit/s bonding mode 6 to a HP switch.
>
> These are just telling you that some operations are taking>  30 seconds.
> The 'waiting for sub ops' means that it is waiting for the write/update to
> be acked by other replicas.  Either there is some load imbalance (some
> osds are more busy than others), or everyone is similarly loaded and the
> request queues are just long across the board.

mhm but there must be something wrong in my testsetup.

1.) th osd bench shows 150MB/s per osd
2.) iperf shows constant 930Mbit/s per eth
3.) when i write 16GB with dd to the ceph mount i see spikes to 450Mbit/ 
and drops to 90kb/s for long periods of time. The overall dd speed is 
then 40Mbit/s
4.) the speed drops to 90kb/s while seeing the
"[WRN] slow request received at 2012-05-13 20:01:55.227811: 
osd_op(client.4102.1:38432 10000000004.000003ae [write 0~4194304] 
0.5f4dfca8 snapc 1=[]) currently waiting for sub ops"
messages.

The client shows this in dmesg:
[2012-05-13 19:55:26]  libceph:  tid 38132 timed out on osd2, will reset osd
[2012-05-13 19:55:46]  libceph:  tid 38400 timed out on osd0, will reset osd
[2012-05-13 19:56:31]  libceph:  tid 38886 timed out on osd2, will reset osd

greets and thanks
Stefan
