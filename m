From: Ketor D <d.ketor@gmail.com>
Subject: Re: [Issue]Ceph cluster hang due to network partition
Date: Thu, 16 Apr 2015 23:20:38 +0800
Message-ID: <CAM9_UU8XYwUYPWh3VXE-c8A=31m42MxohhVEakhZyFpb6p89aA@mail.gmail.com>
References: <CAM9_UU9SwjQ1FxYHcT2wrXwi1oCH5xuwRJQ9D-rwHwATTusTZw@mail.gmail.com>
 <alpine.DEB.2.00.1504140816011.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35543 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbDPPVJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 11:21:09 -0400
Received: by obbfy7 with SMTP id fy7so43654588obb.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 08:21:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1504140816011.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
      Thanks for you reply.
      Finally we fixed the network and ceph goes HEALTH_OK.
      We will improve our ops to get rid of network parition to fix
this problem.

Ketor


On Tue, Apr 14, 2015 at 11:18 PM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 14 Apr 2015, Ketor D wrote:
>> Hi Sage,
>>       We recently meet a network partition problem, cause our ceph
>> cluster can not service rbd service.
>>        We are running 0.67.5 on our customer cluster. And the network
>> partition is 3 osd can connect mon, but can not connect with all other
>> osds.
>>        Then many PGs fall in peering status, and rbd I/O is hang.
>>
>>         Before we operate the cluster , I set nout flag and stop the 3
>> OSDs. After operating the 3 OSDs memory and OS bootup, the network is
>> partition. The 3 OSDs start, then many PGs went to peering.
>> I stoped the 3 OSDs process, but the PGs fall in peering.
>
> One possibility is that those PGs were all on the partitioned side; in
> that case you would have seen stale+peering+... states.
> Another possibility is that there was not sufficient PG [meta]data on
> the other side of the partition and the PGs got stuck in down+... or
> incomplete+... states.
>
> Or, there was another partition somewhere or cofusion such that there were
> OSDs that were unreachable but still in the 'up' state.
>
> sage
>
>
>>         After network partition is fixed, all PG get active+clean, all is OK.
>>
>>         I can't explain this, because I think the OSD can judge if the
>> other OSD is alive, and I can see 3OSD is marked down in 'ceph osd
>> tree'.
>>         Why did these PGs fall in peering?
>>
>> Thanks!
>> Ketor
>>
>>
