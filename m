From: Christoph Hellwig <hch@infradead.org>
Subject: Re: v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 02:22:26 -0700
Message-ID: <20140716092226.GA23561@infradead.org>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org

On Tue, Jul 15, 2014 at 04:45:59PM -0700, Sage Weil wrote:
> This Firefly point release fixes an potential data corruption problem
> when ceph-osd daemons run on top of XFS and service Firefly librbd
> clients.  A recently added allocation hint that RBD utilizes triggers
> an XFS bug on some kernels (Linux 3.2, and likely others) that leads
> to data corruption and deep-scrub errors (and inconsistent PGs).  This
> release avoids the situation by disabling the allocation hint until we
> can validate which kernels are affected and/or are known to be safe to
> use the hint on.

I've not really seen an report for that on the XFS list, could it be
that you're running into the issue fixed by

 "xfs: Use preallocation for inodes with extsz hints"

(commit aff3a9edb7080f69f07fe76a8bd089b3dfa4cb5d)?

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
