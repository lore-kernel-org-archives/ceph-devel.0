From: Tejun Heo <tj@kernel.org>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Wed, 18 Nov 2015 10:56:34 -0500
Message-ID: <20151118155634.GB11496@mtj.duckdns.org>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
 <20151117205641.GF22864@mtj.duckdns.org>
 <CAOi1vP_mp6wjb+jU_tRADqhXGqf1YTj=w=3ynMBj5=SaVU3o4g@mail.gmail.com>
 <20151118153039.GA11496@mtj.duckdns.org>
 <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hello, Ilya.

On Wed, Nov 18, 2015 at 04:48:06PM +0100, Ilya Dryomov wrote:
> Just to be clear, the bdi/wb vs inode lifetime rules are that inodes
> should always be within bdi/wb?  There's been a lot of churn in this

Yes, that's where *I* think we should be headed.  Stuff in lower
layers should stick around while upper layer things are around.

> and related areas recently, including in block drivers: 6cd18e711dd8
> ("block: destroy bdi before blockdev is unregistered"), b02176f30cd3
> ("block: don't release bdi while request_queue has live references"),
> so I want to fully get my head around this.

End-of-life issue has always been a bit of mess in the block layer.
Thanks a lot for working on this.

-- 
tejun
