From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:55:25 -0500
Message-ID: <4BFBD6CD.3000503@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws> <4BFBD13C.60605@redhat.com> <4BFBD20E.5060207@codemonkey.ws> <4BFBD2D5.2000201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBD2D5.2000201@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

On 05/25/2010 08:38 AM, Avi Kivity wrote:
> On 05/25/2010 04:35 PM, Anthony Liguori wrote:
>> On 05/25/2010 08:31 AM, Avi Kivity wrote:
>>>> A protocol based mechanism has the advantage of being more robust 
>>>> in the face of poorly written block backends so if it's possible to 
>>>> make it perform as well as a plugin, it's a preferable approach.
>>>
>>> May be hard due to difficulty of exposing guest memory.
>>
>> If someone did a series to add plugins, I would expect a very strong 
>> argument as to why a shared memory mechanism was not possible or at 
>> least plausible.
>>
>> I'm not sure I understand why shared memory is such a bad thing wrt 
>> KVM.  Can you elaborate?  Is it simply a matter of fork()?
>
> fork() doesn't work in the with of memory hotplug.  What else is there?
>

Is it that fork() doesn't work or is it that fork() is very expensive?

Regards,

Anthony Liguori
