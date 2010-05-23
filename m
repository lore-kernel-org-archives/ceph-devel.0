From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Sun, 23 May 2010 15:01:59 +0300
Message-ID: <4BF91937.2070801@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com> <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com> <4BF5A9D2.5080609@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4BF5A9D2.5080609@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Christian Brunner <chb@muc.de>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/21/2010 12:29 AM, Anthony Liguori wrote:
>
> I'd be more interested in enabling people to build these types of 
> storage systems without touching qemu.
>
> Both sheepdog and ceph ultimately transmit I/O over a socket to a 
> central daemon, right? 

That incurs an extra copy.

> So could we not standardize a protocol for this that both sheepdog and 
> ceph could implement?

The protocol already exists, nbd.  It doesn't support snapshotting etc. 
but we could extend it.

But IMO what's needed is a plugin API for the block layer.

-- 
error compiling committee.c: too many arguments to function

