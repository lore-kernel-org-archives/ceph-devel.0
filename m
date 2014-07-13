From: Dave Chinner <david@fromorbit.com>
Subject: Re: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Sun, 13 Jul 2014 11:26:24 +1000
Message-ID: <20140713012624.GS4453@dastard>
References: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
Content-Disposition: inline
In-Reply-To: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Samuel Just <sam.just@inktank.com>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org

On Sat, Jul 12, 2014 at 06:16:54PM -0700, Samuel Just wrote:
> Hi,
> 
> We are seeing reports of ceph-osd stores on xfs of files with some
> garbage data (possibly misplaced from data elsewhere in the
> filesystem).  There was a bug for a while where the ceph-osd process
> would set a value for fsx_extsize on a non-empty (possibly sparse)
> file using XFS_IOC_FSSETXATTR.  Could that plausibly result in a file
> with garbage data? 

No, setting an extent size on a non-empty file will simply fail
with EINVAL.

Do you have any method of reproducing the bad data in files?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
