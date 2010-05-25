From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 13:02:30 +0200
Message-ID: <4BFBAE46.5050801@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab0EYLC4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 07:02:56 -0400
In-Reply-To: <4BF91937.2070801@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

Am 23.05.2010 14:01, schrieb Avi Kivity:
> On 05/21/2010 12:29 AM, Anthony Liguori wrote:
>>
>> I'd be more interested in enabling people to build these types of 
>> storage systems without touching qemu.
>>
>> Both sheepdog and ceph ultimately transmit I/O over a socket to a 
>> central daemon, right? 
> 
> That incurs an extra copy.
> 
>> So could we not standardize a protocol for this that both sheepdog and 
>> ceph could implement?
> 
> The protocol already exists, nbd.  It doesn't support snapshotting etc. 
> but we could extend it.
> 
> But IMO what's needed is a plugin API for the block layer.

What would it buy us, apart from more downstreams and having to maintain
a stable API and ABI? Hiding block drivers somewhere else doesn't make
them stop existing, they just might not be properly integrated, but
rather hacked in to fit that limited stable API.

Kevin
