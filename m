From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Fri, 2 Aug 2019 10:05:54 +0200
Message-ID: <20190802080554.GD2332@hirez.programming.kicks-ass.net>
References: <20190802021653.4882-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190802021653.4882-1-jhubbard@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: john.hubbard@gmail.com
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-nfs@vger.kernel.orgne
List-Id: ceph-devel.vger.kernel.org

On Thu, Aug 01, 2019 at 07:16:19PM -0700, john.hubbard@gmail.com wrote:

> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions"). That commit
> has an extensive description of the problem and the planned steps to
> solve it, but the highlites are:

That is one horridly mangled Changelog there :-/ It looks like it's
partially duplicated.

Anyway; no objections to any of that, but I just wanted to mention that
there are other problems with long term pinning that haven't been
mentioned, notably they inhibit compaction.

A long time ago I proposed an interface to mark pages as pinned, such
that we could run compaction before we actually did the pinning.
