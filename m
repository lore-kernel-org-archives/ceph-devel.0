From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 14:41:38 -0500
Message-ID: <4FC677F2.6020702@inktank.com>
References: <4FBE415E.8030702@profihost.ag>	<4FC54CDB.1000506@inktank.com>	<4FC5BF27.5060704@profihost.ag>	<CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>	<4FC5C941.6010105@profihost.ag>	<CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>	<4FC5FEC1.90103@profihost.ag>	<4FC60FC8.207@inktank.com>	<4FC61596.3050703@profihost.ag>	<CADdPHGsmr8Ht1pTWH1Oe8=NmAyM81SSdH+c_GV89D8ntfyUmgA@mail.gmail.com>	<4FC61E69.2030408@profihost.ag> <CADdPHGvxCmuViy+0==Vkdz_QjC1K+kD5kD1m7+0tYM2YDTtJbw@mail.gmail.com> <4FC63381.6090300@inktank.com> <4FC63454.3070007@profihost.ag> <4FC6352B.8050501@inktank.com> <4FC6663C.9080301@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37160 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab2E3Tlp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 15:41:45 -0400
Received: by yenm10 with SMTP id m10so181440yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 12:41:44 -0700 (PDT)
In-Reply-To: <4FC6663C.9080301@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Stefan Majer <stefan.majer@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/30/2012 01:26 PM, Stefan Priebe wrote:
> Hi Mark,
>
> Am 30.05.2012 16:56, schrieb Mark Nelson:
>> On 05/30/2012 09:53 AM, Stefan Priebe wrote:
>>> Am 30.05.2012 16:49, schrieb Mark Nelson:
>>>> You could try setting up a pool with a replication level of 1 and see
>>>> how that does. It will be faster in any event, but it would be
>>>> interesting to see how much faster.
>>> is there an easier way than modifying the crush map?
> >
>> something like:
>> ceph osd pool create POOL [pg_num [pgp_num]]
>> then:
>> ceph osd pool set POOL size VALUE
>
> With pool size 1 the writes are constant around 112MB/s:
> http://pastebin.com/raw.php?i=haDPNTfQ
>
> So has it something todo with the replication?
>
> Stefan

Well now that is interesting.  Replication is pretty network heavy.  In 
addition to the client transfers to the OSDs, you have each OSD node 
sending and receiving data from each other.  Based on these results it 
looks like you may be stalling waiting for data to replicate so the 
client stops sending new requests.  If you set the osd, filestore, and 
messenger debugging up to like 20 you'll get a ton of info that may 
provide more clues.

Otherwise, a while ago I started making a list of performance related 
settings and tests that we (Inktank) may want to check for customers.  
Note that this is a work in progress and the values may not be exactly 
right yet.  You could check and see if any of the networking settings 
have changed on your setup between 3.0 and 3.4:

http://ceph.com/wiki/Performance_analysis

Also there was a thread a while back where Jim Schutt saw problems that 
looked like disk performance issues due to tcp autotuning policy:

http://www.spinics.net/lists/ceph-devel/msg05049.html

That seemed to be more an issue with lots of clients and OSDs per node, 
but I thought I'd mention it since some of the effects are similar.

Mark
