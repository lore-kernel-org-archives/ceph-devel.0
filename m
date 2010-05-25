From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 15:13:48 +0300
Message-ID: <4BFBBEFC.5080104@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de> <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com> <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com> <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <20100525120315.GA6773@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20039 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676Ab0EYMOD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 08:14:03 -0400
In-Reply-To: <20100525120315.GA6773@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org

On 05/25/2010 03:03 PM, Christoph Hellwig wrote:
> On Tue, May 25, 2010 at 02:25:53PM +0300, Avi Kivity wrote:
>    
>> Currently if someone wants to add a new block format, they have to
>> upstream it and wait for a new qemu to be released.  With a plugin API,
>> they can add a new block format to an existing, supported qemu.
>>      
> So?  Unless we want a stable driver ABI which I fundamentally oppose as
> it would make block driver development hell

We'd only freeze it for a major release.

> they'd have to wait for
> a new release of the block layer.  It's really just going to be a lot
> of pain for no major gain.  qemu releases are frequent enough, and if
> users care enough they can also easily patch qemu.
>    

May not be so easy for them, they lose binary updates from their distro 
and have to keep repatching.

-- 
error compiling committee.c: too many arguments to function

