From: Tejun Heo <tj@kernel.org>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Thu, 19 Nov 2015 16:18:31 -0500
Message-ID: <20151119211831.GA4885@mtj.duckdns.org>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
 <20151117205641.GF22864@mtj.duckdns.org>
 <CAOi1vP_mp6wjb+jU_tRADqhXGqf1YTj=w=3ynMBj5=SaVU3o4g@mail.gmail.com>
 <20151118153039.GA11496@mtj.duckdns.org>
 <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
 <CAOi1vP-6X7C=3uFNM7SQCe3TZXwrSST1_Tv3Qm0s1SnC2gBs2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOi1vP-6X7C=3uFNM7SQCe3TZXwrSST1_Tv3Qm0s1SnC2gBs2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Hello, Ilya.

On Thu, Nov 19, 2015 at 09:56:21PM +0100, Ilya Dryomov wrote:
> > Yes, that's where *I* think we should be headed.  Stuff in lower
> > layers should stick around while upper layer things are around
> 
> I think the fundamental problem is the embedding of bdi in the queue.
> The lifetime rules (or, rather, expectations) for the two seem to be
> completely different and, while used together, they belong to different
> subsystems.  Even if we find a way to fix this particular race, there
> is a good chance someone will reintroduce it in the future, perhaps in
> a more subtle way.

You're right.  This is nasty.  Hmmm... the root problem is that beyond
the last __blkdev_put() the bdev and disk don't really have anything
to do with each other but the bdev is still pointing to it.  We are
already guaranteeing that the underlying disk hangs around while there
are bdevs associated with it.

We already know that the bdev is idle once bd_openers hits zero and
the inode gets flushed, so at that point, the problem is bdev's
inode->i_wb is still pointing to something that the bdev doesn't have
anything to do with.  So, can we do inode_detach_wb() after flushing
the inode?

Thanks.

-- 
tejun
