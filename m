From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.67.6 non-release
Date: Fri, 14 Feb 2014 18:29:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402141810381.20749@cobra.newdream.net>
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

Hi all,

We built a v0.67.6 but discovered two problems shortly after it was pushed 
out to the public repository.  We've pulled the packages from the 
repositories (you'll now find 0.67.5 there).  

We will have a v0.67.7 shortly that addresses the problem but not until we 
run it through its paces and verify the upgrade will be safe.

If you installed the v0.67.6 release in the last 24 hours, and it is a 
branc new deployment, we recommend you reinstall.

If it was a live cluster that got upgraded, let us know, as you may want 
to move to a test build instead of waiting for v0.67.7.  Downgrading a 
production cluster from v0.67.6 to v0.67.5 is not recommended.

Specifically, there were two issues with the v0.67.6 build:

 1- A recently backported librbd cache behavior change leaks memory.  
    This is now reverted for v0.67.7.
 2- A backported fix for xattr behavior did not include a follow-on fix, 
    which can cause an incorrect ENOENT reply from the cluster.  The 
    follow-on fix is now in the dumpling branch.

Fixes for both issues are queued up, but as I said we want to make sure it 
goes through its paces in QA before building a follow-on v0.67.7 release.

Thanks!
sage
