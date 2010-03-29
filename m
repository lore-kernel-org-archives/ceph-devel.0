From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Sun, 28 Mar 2010 17:58:21 -0700
Message-ID: <24075.1269824301@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Martin Millnert <martin@millnert.se>
Cc: cdunwoody@graphstream.com, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


Hello Martin,

martin writes:
>while this does not match your G1, G2 or G3, there is a G4 absolutely
>worth considering IMO:
>  Maximize storage area and transfer speed divided by hardware
>investment + MRU.
...
>I think you have to figure out what it is you need done for your
>specific application, and back-track from there. Because there is no
>single optimal configuration of a distributed file system such as Ceph,
>for all applications.

Thanks very much for your comments.

Sorry that I wasn't familiar with your use of the term "MRU" -- please
help me understand.

I agree completely that details of Ceph node and cluster configs that
are most efficient for a specific application, will depend on many
details of that application's requirements.

Craig Dunwoody
cdunwoody@graphstream.com

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
