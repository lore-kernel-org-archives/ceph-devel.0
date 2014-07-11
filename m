From: Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Subject: Re: I have PGs that I can't deep-scrub
Date: Fri, 11 Jul 2014 12:20:22 +1000
Message-ID: <20140711022022.GA4156@onthe.net.au>
References: <CADHZLBa3z-7k28iL2SArQ+KYyBF0aUZEiAbASika8OEevpLk+A@mail.gmail.com>
	<alpine.DEB.2.00.1406110539520.2197@cobra.newdream.net>
	<CADHZLBa-gY++kzBko9pyDJdzHvXb5A85qEH9shpknKWjTdVrLQ@mail.gmail.com>
	<CADHZLBaZD2+6S5u2OYLAhnibSCBswY+gZdj7rAWAcmsO0_zgoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADHZLBaZD2+6S5u2OYLAhnibSCBswY+gZdj7rAWAcmsO0_zgoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Cc: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Craig,

On Thu, Jul 10, 2014 at 03:09:51PM -0700, Craig Lewis wrote:
> I fixed this issue by reformatting all of the OSDs.  I changed the mkfs
> options from
> 
> [osd]
>   osd mkfs type = xfs
>   osd mkfs options xfs = -l size=1024m -n size=64k -i size=2048 -s size=4096
> 
> to
> [osd]
>   osd mkfs type = xfs
>   osd mkfs options xfs = -s size=4096
> 
> (I have a mix of 512 and 4k sector drives, and I want to treat them all
> like 4k sector).
> 
> 
> Now deep scrub runs to completion, and CPU usage of the daemon never goes
> over 30%.  I did have to restart a few OSDs when I scrubbed known problem
> PGs, but they scrubbed the 2nd time successfully.  The cluster is still
> scrubbing, but it's completed half with no more issues.

I suspect it was the "-n size=64k" causing this behaviour, potentially using
too much CPU and starving the OSD processes:

http://xfs.org/index.php/XFS_FAQ#Q:_Performance:_mkfs.xfs_-n_size.3D64k_option

Cheers,

Chris
