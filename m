From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: request_queue use-after-free - inode_detach_wb()
Date: Thu, 19 Nov 2015 21:56:21 +0100
Message-ID: <CAOi1vP-6X7C=3uFNM7SQCe3TZXwrSST1_Tv3Qm0s1SnC2gBs2w@mail.gmail.com>
References: <CAOi1vP9igmg_jayELVDq_NYXUHtByZz5a4M5+CqCMMHUxF5ofA@mail.gmail.com>
	<20151117205641.GF22864@mtj.duckdns.org>
	<CAOi1vP_mp6wjb+jU_tRADqhXGqf1YTj=w=3ynMBj5=SaVU3o4g@mail.gmail.com>
	<20151118153039.GA11496@mtj.duckdns.org>
	<CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOi1vP_4aUKVjNqvmFxVGVyaif_zuHdVPjzH5RLOJgYMsSirbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Nov 18, 2015 at 4:48 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Wed, Nov 18, 2015 at 4:30 PM, Tejun Heo <tj@kernel.org> wrote:
>> Hello, Ilya.
>>
>> On Wed, Nov 18, 2015 at 04:12:07PM +0100, Ilya Dryomov wrote:
>>> > It's stinky that the bdi is going away while the inode is still there.
>>> > Yeah, blkdev inodes are special and created early but I think it makes
>>> > sense to keep the underlying structures (queue and bdi) around while
>>> > bdev is associated with it.  Would simply moving put_disk() after
>>> > bdput() work?
>>>
>>> I'd think so.  struct block_device is essentially a "block device"
>>> pseudo-filesystem inode, and as such, may not be around during the
>>> entire lifetime of gendisk / queue.  It may be kicked out of the inode
>>> cache as soon as the device is closed, so it makes sense to put it
>>> before putting gendisk / queue, which will outlive it.
>>>
>>> However, I'm confused by this comment
>>>
>>> /*
>>>  * ->release can cause the queue to disappear, so flush all
>>>  * dirty data before.
>>>  */
>>> bdev_write_inode(bdev);
>>>
>>> It's not true, at least since your 523e1d399ce0 ("block: make gendisk
>>> hold a reference to its queue"), right?  (It used to say "->release can
>>> cause the old bdi to disappear, so must switch it out first" and was
>>> changed by Christoph in the middle of his backing_dev_info series.)
>>
>> Right, it started with each layer going away separately, which tends
>> to get tricky with hotunplug, and we've been gradually moving towards
>> a model where the entire stack stays till the last ref is gone, so
>> yeah the comment isn't true anymore.
>
> OK, I'll try to work up a patch to do bdput before put_disk and also
> drop this comment.

Doing bdput before put_disk in fs/block_dev.c helps, but isn't enough.
There is nothing guaranteeing that our bdput in __blkdev_put() is the
last one.  One particular issue is the linkage between /dev inodes and
bdev internal inodes.  /dev inodes hold bdev inodes, so:

186 static void __fput(struct file *file)
187 {
188         struct dentry *dentry = file->f_path.dentry;
189         struct vfsmount *mnt = file->f_path.mnt;
190         struct inode *inode = file->f_inode;
191
192         might_sleep();
193
194         fsnotify_close(file);
195         /*
196          * The function eventpoll_release() should be the first called
197          * in the file cleanup chain.
198          */
199         eventpoll_release(file);
200         locks_remove_file(file);
201
202         if (unlikely(file->f_flags & FASYNC)) {
203                 if (file->f_op->fasync)
204                         file->f_op->fasync(-1, file, 0);
205         }
206         ima_file_free(file);
207         if (file->f_op->release)
208                 file->f_op->release(inode, file);

This translates to blkdev_put().  Suppose in response to this release
block device driver dropped gendisk, queue, etc.  Then we, still in
blkdev_put(), did our bdput and put_disk.  The queue is now gone, but
there's still a ref on the bdev inode - from the /dev inode.  When the
latter gets evicted thanks to dput below, we end up in bd_forget(),
which finishes up with iput(bdev->bd_inode)...

209         security_file_free(file);
210         if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL &&
211                      !(file->f_mode & FMODE_PATH))) {
212                 cdev_put(inode->i_cdev);
213         }
214         fops_put(file->f_op);
215         put_pid(file->f_owner.pid);
216         if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
217                 i_readcount_dec(inode);
218         if (file->f_mode & FMODE_WRITER) {
219                 put_write_access(inode);
220                 __mnt_drop_write(mnt);
221         }
222         file->f_path.dentry = NULL;
223         file->f_path.mnt = NULL;
224         file->f_inode = NULL;
225         file_free(file);
226         dput(dentry);
227         mntput(mnt);
228 }

On Wed, Nov 18, 2015 at 4:56 PM, Tejun Heo <tj@kernel.org> wrote:
> On Wed, Nov 18, 2015 at 04:48:06PM +0100, Ilya Dryomov wrote:
>> Just to be clear, the bdi/wb vs inode lifetime rules are that inodes
>> should always be within bdi/wb?  There's been a lot of churn in this
>
> Yes, that's where *I* think we should be headed.  Stuff in lower
> layers should stick around while upper layer things are around

I think the fundamental problem is the embedding of bdi in the queue.
The lifetime rules (or, rather, expectations) for the two seem to be
completely different and, while used together, they belong to different
subsystems.  Even if we find a way to fix this particular race, there
is a good chance someone will reintroduce it in the future, perhaps in
a more subtle way.

Thanks,

                Ilya
