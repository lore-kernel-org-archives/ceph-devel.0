From: Andreas Hirczy <ahi@itp.tugraz.at>
Subject: Re: users, 2.6.34
Date: Wed, 03 Mar 2010 11:11:59 +0100
Message-ID: <8atysxn28g.fsf@faepop29.tu-graz.ac.at>
References: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1003011019020.10267@cobra.newdream.net> (Sage
	Weil's message of "Tue\, 2 Mar 2010 11\:27\:11 -0800 \(PST\)")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

Sage Weil <sage@newdream.net> writes:

> If you've tried v0.19, can you take a minute to let us know what your 
> experience has been?  Did you get the system up and running?  Were there 
> problems along the way?  What size system are you testing and/or planning?

Hi!

I have started on a test cluster (16 OSD, 2.1 TiByte), but currently not
implemented because of time constraints. Single OSD worked as expected. Our
Plan is to harvest otherwise unused disk space from workstations as a scratch
volume for batch jobs.

In the long run this should replace one of our NFS servers, with about 80
machines acting as OSD and client at the same time.

Security is not of prime importance for us, since for the moment its just a
complement to our existing AFS services.

Sincerely
Andreas
-- 
Andreas Hirczy <ahi@itp.tugraz.at>                   http://itp.tugraz.at/~ahi/
Graz University of Technology                        phone: +43/316/873-   8190
Institute of Theoretical and Computational Physics     fax: +43/316/873-10 8190
Petersgasse 16, A-8010 Graz                         mobile: +43/664/859 23 57

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
