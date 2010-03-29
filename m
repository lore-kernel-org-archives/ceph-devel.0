From: Craig Dunwoody <cdunwoody@graphstream.com>
Subject: Re: [OLD ceph-devel] Hardware-config suggestions for
	HDD-based OSD node?
Date: Mon, 29 Mar 2010 15:05:24 -0700
Message-ID: <2853.1269900324@n20.hq.graphstream.com>
References: <20100329174649.f9d79f2b.ales-76@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 29 Mar 2010 17:46:49 +0200."
	<20100329174649.f9d79f2b.ales-76@seznam.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: =?UTF-8?B?QWxlxaEgQmzDoWhh?= <ales-76@seznam.cz>
Cc: cdunwoody@graphstream.com, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


Hello Ales, 

Thank you for the additional suggestions.  It will be interesting
to see the similarities and differences between hardware configs that
work best for Lustre, and those that end up working best for Ceph.

Craig Dunwoody
GraphStream Incorporated

ales writes:
>Sure raw numbers for a hardware are often very impressive, but
>it is up to the software to squeeze the performance out of it.
>Experimenting is always the best way to find out, but you can search
>the web to get the picture. I suggest taking a look at Lustre
>setups - the architecture is very similar, they also use mostly
>of-the-shelf componenst. Apparently the common Lustre OSD is rather fat
>- plenty of disks divided into several RAID groups, very much like the
>X4500. Then againg, HPC people are mostly focused on
>streaming writes, so if your application differs then your point of
>diminishing returns might be elsewhere.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
