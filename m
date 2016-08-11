From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD not coming back up again
Date: Thu, 11 Aug 2016 13:13:54 +0200
Message-ID: <fa2b6a34-bad3-dd3a-bdbb-bb104e9b54c1@digiware.nl>
References: <bdb93e87-8338-e485-a68d-f988d00f6785@digiware.nl>
 <453729567.2335.1470896803201@ox.pcextreme.nl>
 <a8d8e5cf-bfdb-6f73-e2a5-a2cc8a3e02af@digiware.nl>
 <301395781.2383.1470913324040@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50081 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbcHKLOI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 07:14:08 -0400
In-Reply-To: <301395781.2383.1470913324040@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11-8-2016 13:02, Wido den Hollander wrote:
>> Right before setting the osd to down, the newest map is 173.
>> So some maps have been exchanged....
>>
>> How does the OSD decide that it is healthy?
>> If it gets peer (ping) messages that is is up?
>>
> 
> Not 100% sure, but waiting for healthy is something I haven't seen before.
> 
> Is it incrementing the newest_map when the cluster advances?
> 
>>> Maybe try debug_osd = 20
>>
>> But then still I need to know what to look for, since 20 generates
>> serious output.
>>
> True, it will. But I don't know exactly what to look for. debug_osd = 20 might reveal more information there.
> 
> It might be a very simple log line which tells you what is going on.

See my other mail, log did not reveal much.
Other than that it made me look at the sockets.

But looking at the socket-states, I think the sockets on the OSD that is
going down are not correctly closed. And so osd.0 thinks it is still
connected. And osd.1 and osd.2 are without connection to osd.0, so they
are correct in suggesting that it is dead.

--WjW


