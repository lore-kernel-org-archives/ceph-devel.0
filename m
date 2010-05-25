From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 16:31:40 +0300
Message-ID: <4BFBD13C.60605@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932370Ab0EYNbw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 09:31:52 -0400
In-Reply-To: <4BFBCFAC.9070807@codemonkey.ws>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 04:25 PM, Anthony Liguori wrote:
>> Currently if someone wants to add a new block format, they have to 
>> upstream it and wait for a new qemu to be released.  With a plugin 
>> API, they can add a new block format to an existing, supported qemu.
>
>
> Whether we have a plugin or protocol based mechanism to implement 
> block formats really ends up being just an implementation detail.

True.

> In order to implement either, we need to take a subset of block 
> functionality that we feel we can support long term and expose that.  
> Right now, that's basically just querying characteristics (like size 
> and geometry) and asynchronous reads and writes.

Unfortunately, you're right.

> A protocol based mechanism has the advantage of being more robust in 
> the face of poorly written block backends so if it's possible to make 
> it perform as well as a plugin, it's a preferable approach.

May be hard due to difficulty of exposing guest memory.

>
> Plugins that just expose chunks of QEMU internal state directly (like 
> BlockDriver) are a really bad idea IMHO.

Also, we don't want to expose all of the qemu API.  We should default 
the visibility attribute to "hidden" and expose only select functions, 
perhaps under their own interface.  And no inlines.

-- 
error compiling committee.c: too many arguments to function

