From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 11:21:25 -0500
Message-ID: <4BFBF905.1030901@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD13C.60605@redhat.com> <4BFBD20E.5060207@codemonkey.ws> <4BFBD2D5.2000201@redhat.com> <4BFBD6CD.3000503@codemonkey.ws> <4BFBD82F.3020404@redhat.com> <4BFBD943.8020704@codemonkey.ws> <4BFBE614.9080306@redhat.com> <4BFBE64F.6020901@codemonkey.ws> <4BFBF7D4.80900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBF7D4.80900@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 11:16 AM, Avi Kivity wrote:
> On 05/25/2010 06:01 PM, Anthony Liguori wrote:
>> On 05/25/2010 10:00 AM, Avi Kivity wrote:
>>> The latter.  Why is it less important?  If you don't inherit the 
>>> memory, you can't access it.
>>>
>>>> You can also pass /dev/shm fd's via SCM_RIGHTs to establish shared 
>>>> memory segments dynamically.
>>>
>>> Doesn't work for anonymous memory.
>>
>> What's wrong with /dev/shm memory?
>
> The kernel treats anonymous and nonymous memory differently for 
> swapping (see /proc/sys/vm/swappiness); transparent hugepages won't 
> work for /dev/shm (though it may be argued that that's a problem with 
> thp); setup (/dev/shm defaults to half memory IIRC, we want mem+swap); 
> different cgroup handling; somewhat clunky (a minor concern to be sure).

Surely, with mmu notifiers, it wouldn't be that hard to share anonymous 
memory via an fd though, no?

Regards,

Anthony Liguori

>
> Nothing is a killer, but we should prefer anonymous memory.
>

