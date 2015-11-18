From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Wed, 18 Nov 2015 16:48:06 +0100
Message-ID: <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
	<20151117205641.GF22864@mtj.duckdns.org>
	<CAOi1vP_mp6wjb+jU_tRADqhXGqf1YTj=w=3ynMBj5=SaVU3o4g@mail.gmail.com>
	<20151118153039.GA11496@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151118153039.GA11496@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Nov 18, 2015 at 4:30 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Ilya.
>
> On Wed, Nov 18, 2015 at 04:12:07PM +0100, Ilya Dryomov wrote:
>> > It's stinky that the bdi is going away while the inode is still there.
>> > Yeah, blkdev inodes are special and created early but I think it makes
>> > sense to keep the underlying structures (queue and bdi) around while
>> > bdev is associated with it.  Would simply moving put_disk() after
>> > bdput() work?
>>
>> I'd think so.  struct block_device is essentially a "block device"
>> pseudo-filesystem inode, and as such, may not be around during the
>> entire lifetime of gendisk / queue.  It may be kicked out of the inode
>> cache as soon as the device is closed, so it makes sense to put it
>> before putting gendisk / queue, which will outlive it.
>>
>> However, I'm confused by this comment
>>
>> /*
>>  * ->release can cause the queue to disappear, so flush all
>>  * dirty data before.
>>  */
>> bdev_write_inode(bdev);
>>
>> It's not true, at least since your 523e1d399ce0 ("block: make gendisk
>> hold a reference to its queue"), right?  (It used to say "->release can
>> cause the old bdi to disappear, so must switch it out first" and was
>> changed by Christoph in the middle of his backing_dev_info series.)
>
> Right, it started with each layer going away separately, which tends
> to get tricky with hotunplug, and we've been gradually moving towards
> a model where the entire stack stays till the last ref is gone, so
> yeah the comment isn't true anymore.

OK, I'll try to work up a patch to do bdput before put_disk and also
drop this comment.

Just to be clear, the bdi/wb vs inode lifetime rules are that inodes
should always be within bdi/wb?  There's been a lot of churn in this
and related areas recently, including in block drivers: 6cd18e711dd8
("block: destroy bdi before blockdev is unregistered"), b02176f30cd3
("block: don't release bdi while request_queue has live references"),
so I want to fully get my head around this.

Thanks,

                Ilya
