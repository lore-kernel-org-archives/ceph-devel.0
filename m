From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 12:22:14 +0300
Message-ID: <4BFB96C6.8030006@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <AANLkTimrjccJqeTSosYsG8VihDjpyVT69bRN7NJdX-uR@mail.gmail.com> <4BFA5D07.8030309@redhat.com> <4BFAD146.9090708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFAD146.9090708@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/24/2010 10:19 PM, Anthony Liguori wrote:
> On 05/24/2010 06:03 AM, Avi Kivity wrote:
>> On 05/24/2010 11:27 AM, Stefan Hajnoczi wrote:
>>> On Sun, May 23, 2010 at 1:01 PM, Avi Kivity<avi@redhat.com>  wrote:
>>>> On 05/21/2010 12:29 AM, Anthony Liguori wrote:
>>>>> I'd be more interested in enabling people to build these types of 
>>>>> storage
>>>>> systems without touching qemu.
>>>>>
>>>>> Both sheepdog and ceph ultimately transmit I/O over a socket to a 
>>>>> central
>>>>> daemon, right?
>>>> That incurs an extra copy.
>>> Besides a shared memory approach, I wonder if the splice() family of
>>> syscalls could be used to send/receive data through a storage daemon
>>> without the daemon looking at or copying the data?
>>
>> Excellent idea.
>
> splice() eventually requires a copy.  You cannot splice() to linux-aio 
> so you'd have to splice() to a temporary buffer and then call into 
> linux-aio.  With shared memory, you can avoid ever bringing the data 
> into memory via O_DIRECT and linux-aio.

If the final destination is a socket, then you end up queuing guest 
memory as an skbuff.  In theory we could do an aio splice to block 
devices but I don't think that's realistic given our experience with aio 
changes.

-- 
error compiling committee.c: too many arguments to function

