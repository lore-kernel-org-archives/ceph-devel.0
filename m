From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 14:25:53 +0300
Message-ID: <4BFBB3C1.9020905@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388Ab0EYL0H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 07:26:07 -0400
In-Reply-To: <4BFBAE46.5050801@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 02:02 PM, Kevin Wolf wrote:
>
>>
>>> So could we not standardize a protocol for this that both sheepdog and
>>> ceph could implement?
>>>        
>> The protocol already exists, nbd.  It doesn't support snapshotting etc.
>> but we could extend it.
>>
>> But IMO what's needed is a plugin API for the block layer.
>>      
> What would it buy us, apart from more downstreams and having to maintain
> a stable API and ABI?

Currently if someone wants to add a new block format, they have to 
upstream it and wait for a new qemu to be released.  With a plugin API, 
they can add a new block format to an existing, supported qemu.

> Hiding block drivers somewhere else doesn't make
> them stop existing, they just might not be properly integrated, but
> rather hacked in to fit that limited stable API.
>    

They would hack it to fit the current API, and hack the API in qemu.git 
to fit their requirements for the next release.

-- 
error compiling committee.c: too many arguments to function

