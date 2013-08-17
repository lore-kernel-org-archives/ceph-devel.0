From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: ceph-deploy mon create / gatherkeys problems
Date: Sat, 17 Aug 2013 14:38:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308171435030.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

We're trying to get to the bottom of the problems people have been having 
with ceph-deploy mon create .. and ceph-deploy gatherkeys.  There seem to 
be a series of common pitfalls that are causing these problems.  So far 
we've been chasing them in emails on this list and in various bugs in the 
tracker, but it is hard to keep track!

 * If you are still seeing any problems here, please reply to this thread!

 * If you previously had a problem here and then realized you were doing 
   something not quite right and got it working, please reply and share 
   what it was so we can make sure others avoid the problem!

We have a couple of feature tickets open to streamline this process to be 
simpler (1 or 2 steps instead of 4 or 5), but before we rush off and 
implement it I want to make sure we fully understand where all of the 
problems lay.

Thanks!
sage
