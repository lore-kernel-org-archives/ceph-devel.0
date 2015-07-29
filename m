From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 10:55:15 -0700
Message-ID: <20150729175515.GA16804@infradead.org>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <target-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 29, 2015 at 04:23:38AM -0500, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> LIO uses scatterlist for its page/data management. This patch
> adds a scatterlist messenger data type, so LIO can pass its sg
> down directly to rbd.

Just as I mentioned for David's patches this is the wrong way to attack
your problem.  The block layer already supports WRITE SAME, and COMPARE
and WRITE nees to be supported at that level too insted of creating
artifical bypasses.
