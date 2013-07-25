From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.67-rc2 dumpling release candidate
Date: Wed, 24 Jul 2013 22:45:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307230903030.17756@cobra.newdream.net>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

We have a release candidate for v0.67 dumpling!  There are a handful of 
remaining known issues (which I suppose means it is technically *not* an 
actual candidate for the final release), but for the most part we are 
happy with the stability so far, and encourage anyone with test clusters 
to give it a try.

Known issues include:

 * There is a known performance regression due to non-optimal tuning 
   values for the writeback throttling.  We are still playing with the 
   numbers to get good results across all workloads, but do not be 
   surprised if you see throughput drop slightly with -rc1.
 * The metadata sync agent for multi-region radosgw clusters is not quite 
   ready yet.
 * Creating swift containers in the non-master region does not work; fix 
   is already in next.

The v0.67-rc2 release candidate packages are available from:

 http://ceph.com/debian-testing/
 http://ceph.com/rpm-testing/

Note that at any time you can move from this -rc1 to the latest 
pre-dumpling code by switching to the 'next' branch, available at

 http://gitbuilder.ceph.com/ceph-deb-$distro-x86_64-basic/ref/next/

for example,

 http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/next/

The draft release notes for v0.67 dumpling are at

 http://ceph.com/docs/master/release-notes/

You can see our bug queue at

 http://tracker.ceph.com/projects/ceph/issues?query_id=27

Note that 'Pending backport' means it is fixed in next but the cuttlefish 
backport has not landed yet.  Also note that the kernel bugs (kcephfs, 
krbd) are not related to the dumpling release.

Go forth and test!
sage
