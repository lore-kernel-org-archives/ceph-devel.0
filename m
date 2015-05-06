From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Tue, 05 May 2015 23:49:10 -0500
Message-ID: <55499D46.9040008@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com> <20150505174939.GA21297@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <20150505174939.GA21297@infradead.org>
Sender: target-devel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 05/05/2015 12:49 PM, Christoph Hellwig wrote:
> Can you explain why you want to hook into the lun reset code?  I know
> the PR code needs to issue implicit task aborts, but I don't
> understand the need to do something with lun resets.

I thought if you exported a LU through multiple LIO nodes and its ALUA
state was active optimized/non-optimized on those nodes, then you would
have to do similar cleanup across the cluster. For example, don't we
have to fail commands on those other nodes, and then also depending on
the TAS bit value return task aborted statuses?

> As for the API:  I would much prefer to have things at the block layer
> in some form than adding side band protocol for specific functionality.
> 

Ok. For what you need for your NFS cluster work, will you have a
request_queue or block_device or gendisk?
