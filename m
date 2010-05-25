From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 15:53:01 +0200
Message-ID: <4BFBD63D.5040900@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com> <4BFBAE46.5050801@redhat.com> <4BFBB3C1.9020905@redhat.com> <4BFBCFAC.9070807@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BFBCFAC.9070807@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Avi Kivity <avi@redhat.com>, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

Am 25.05.2010 15:25, schrieb Anthony Liguori:
> On 05/25/2010 06:25 AM, Avi Kivity wrote:
>> On 05/25/2010 02:02 PM, Kevin Wolf wrote:
>>>
>>>>
>>>>> So could we not standardize a protocol for this that both sheepdog and
>>>>> ceph could implement?
>>>> The protocol already exists, nbd.  It doesn't support snapshotting etc.
>>>> but we could extend it.
>>>>
>>>> But IMO what's needed is a plugin API for the block layer.
>>> What would it buy us, apart from more downstreams and having to maintain
>>> a stable API and ABI?
>>
>> Currently if someone wants to add a new block format, they have to 
>> upstream it and wait for a new qemu to be released.  With a plugin 
>> API, they can add a new block format to an existing, supported qemu.
> 
> Whether we have a plugin or protocol based mechanism to implement block 
> formats really ends up being just an implementation detail.
> 
> In order to implement either, we need to take a subset of block 
> functionality that we feel we can support long term and expose that.  
> Right now, that's basically just querying characteristics (like size and 
> geometry) and asynchronous reads and writes.
> 
> A protocol based mechanism has the advantage of being more robust in the 
> face of poorly written block backends so if it's possible to make it 
> perform as well as a plugin, it's a preferable approach.
> 
> Plugins that just expose chunks of QEMU internal state directly (like 
> BlockDriver) are a really bad idea IMHO.

I'm still not convinced that we need either. I share Christoph's concern
that we would make our life harder for almost no gain. It's probably a
very small group of users (if it exists at all) that wants to add new
block drivers themselves, but at the same time can't run upstream qemu.

But if we were to decide that there's no way around it, I agree with you
that directly exposing the internal API isn't going to work.

Kevin
