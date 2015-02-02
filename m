From: Jens Axboe <axboe@fb.com>
Subject: Re: backing_dev_info cleanups & lifetime rule fixes V2
Date: Mon, 2 Feb 2015 10:08:44 -0700
Message-ID: <54CFAF1C.4050104@fb.com>
References: <1421228561-16857-1-git-send-email-hch@lst.de> <54BEC3C2.7080906@fb.com> <20150201063116.GP29656@ZenIV.linux.org.uk> <20150202080635.GB9851@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150202080635.GB9851@lst.de>
Sender: owner-linux-mm@kvack.org
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 02/02/2015 01:06 AM, Christoph Hellwig wrote:
> On Sun, Feb 01, 2015 at 06:31:16AM +0000, Al Viro wrote:
>> And at that point we finally can make sb_lock and super_blocks static in
>> fs/super.c.  Do you want that in your tree, or would you rather have it
>> done via vfs.git during the merge window after your tree goes in?  It's
>> as trivial as this:
>>
>> Make super_blocks and sb_lock static
>>
>> The only user outside of fs/super.c is gone now
>>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I'd say merge it through the block tree..
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

Added to for-3.20/bdi


-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
