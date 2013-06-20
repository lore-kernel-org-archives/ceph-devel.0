From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] Ceph: Punch hole support
Date: Thu, 20 Jun 2013 13:18:59 +1000
Message-ID: <20130620031859.GP29338@dastard>
References: <1371224186-4809-1-git-send-email-liwang@ubuntukylin.com>
 <1371224340-4926-1-git-send-email-liwang@ubuntukylin.com>
 <alpine.DEB.2.00.1306140902490.26467@cobra.newdream.net>
 <51C1DB17.6040803@ubuntukylin.com>
 <alpine.DEB.2.00.1306190929350.27900@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1306190929350.27900@cobra.newdream.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: Li Wang <liwang@ubuntukylin.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Jun 19, 2013 at 09:31:21AM -0700, Sage Weil wrote:
> Hi Li,
> 
> There is a version of fsx.c floating around that tests hole punching... 
> have you tried running that on top of this patch?  Ideally, we should 
> build a test (ceph.git/qa/workunits/rbd/hole_punch.sh or similar) that 
> tests the hole punch both with a default file layout and with a more 
> complicated striping pattern (e.g. object_size=1048576 stripe_unit=65536 
> stripe_count=7).

The version in xfstests has hole punch support, as does the version
of fsstress. There are also some corner case tests for punch
behaviour, so running the generic tests in xfstests
should shake out most bugs....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
