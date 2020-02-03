From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 15/15] rbd: switch to blk-mq
Date: Mon, 3 Feb 2020 00:36:22 -0800
Message-ID: <20200203083622.GA5005@infradead.org>
References: <20200131103739.136098-1-hare@suse.de>
 <20200131103739.136098-16-hare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200131103739.136098-16-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>, Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, Jan 31, 2020 at 11:37:39AM +0100, Hannes Reinecke wrote:
> Allocate one queue per CPU and get a performance boost from
> higher parallelism.

Well, the driver already is using blk-mq so your subject is incorrect.
I think you want to say something like "rbd: support multiple queues"
