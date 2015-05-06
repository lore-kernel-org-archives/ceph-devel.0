From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Tue, 5 May 2015 23:48:12 -0700
Message-ID: <20150506064812.GA5181@infradead.org>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
 <20150505174939.GA21297@infradead.org>
 <55499D46.9040008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <target-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55499D46.9040008@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Tue, May 05, 2015 at 11:49:10PM -0500, Mike Christie wrote:
> On 05/05/2015 12:49 PM, Christoph Hellwig wrote:
> > Can you explain why you want to hook into the lun reset code?  I know
> > the PR code needs to issue implicit task aborts, but I don't
> > understand the need to do something with lun resets.
> 
> I thought if you exported a LU through multiple LIO nodes and its ALUA
> state was active optimized/non-optimized on those nodes, then you would
> have to do similar cleanup across the cluster. For example, don't we
> have to fail commands on those other nodes, and then also depending on
> the TAS bit value return task aborted statuses?

Oh, you're actually implementing active/active exports.  Yes, in that
case we'll need to distribute LUN resets.

> > As for the API:  I would much prefer to have things at the block layer
> > in some form than adding side band protocol for specific functionality.
> > 
> 
> Ok. For what you need for your NFS cluster work, will you have a
> request_queue or block_device or gendisk?

All of them.  It's just another consumer of the in-kernel block devices
interface.
