From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Thu, 30 Jul 2015 07:55:16 -0700
Message-ID: <20150730145516.GB12744@infradead.org>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
 <20150729175515.GA16804@infradead.org>
 <55B95ACC.2030306@redhat.com>
 <55B96451.30706@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <target-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B96451.30706@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 29, 2015 at 06:40:01PM -0500, Mike Christie wrote:
> I guess I was viewing this similar to cephfs where it does not use rbd
> and the block layer. It just makes ceph/rados calls directly using
> libceph. I am using rbd.c for its helper/wrapper functions around the
> libceph ones, but I could just make libceph calls directly too.
> 
> Were you saying because for lio support we need to do more block
> layer'ish operations like write same, compare and write, etc than
> cephfs, then I should not do the lio backend and we should always go
> through rbd for lio support?

I'd really prefer that.  We have other users for these facilities as
well, and I'd much prefer having block layer support rather than working
around it.

> Is that for all operations? For distributed TMFs and PRs then are you
> thinking I should make those more block layer based (some sort of queue
> or block deivce callouts or REQ_ types), or should those still have some
> sort of lio callouts which could call different locking/cluster APIs
> like libceph?

Yes.  FYI, I've pushed out my WIP work for PRs here:

http://git.infradead.org/users/hch/scsi.git/shortlog/refs/heads/pr-api

TMFs are a bit of boderline case, but instead of needing special
bypasses I'd rather find a way to add them.  For example we already
have TMF ioctls for SCSI, so we might as well pull this up to the block
layer.
