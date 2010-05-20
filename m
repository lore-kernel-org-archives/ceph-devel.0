From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Thu, 20 May 2010 16:29:54 -0500
Message-ID: <4BF5A9D2.5080609@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com> <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Christian Brunner <chb@muc.de>
Cc: Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/20/2010 04:18 PM, Christian Brunner wrote:
> Thanks for your comments. I'll send an updated patch in a few days.
>
> Having a central storage system is quite essential in larger hosting
> environments, it enables you to move your guest systems from one node
> to another easily (live-migration or dynamic restart). Traditionally
> this has been done using SAN, iSCSI or NFS. However most of these
> systems don't scale very well and and the costs for high-availability
> are quite high.
>
> With new approaches like Sheepdog or Ceph, things are getting a lot
> cheaper and you can scale your system without disrupting your service.
> The concepts are quite similar to what Amazon is doing in their EC2
> environment, but they certainly won't publish it as OpenSource anytime
> soon.
>
> Both projects have advantages and disadvantages. Ceph is a bit more
> universal as it implements a whole filesystem. Sheepdog is more
> feature complete in regards of managing images (e.g. snapshots). Both
> projects require some additional work to become stable, but they are
> on a good way.
>
> I would really like to see both drivers in the qemu tree, as they are
> the key to a design shift in how storage in the datacenter is being
> built.
>    

I'd be more interested in enabling people to build these types of 
storage systems without touching qemu.

Both sheepdog and ceph ultimately transmit I/O over a socket to a 
central daemon, right?  So could we not standardize a protocol for this 
that both sheepdog and ceph could implement?

Regards,

Anthony Liguori

> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

