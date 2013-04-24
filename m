From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: cuttlefish countdown
Date: Wed, 24 Apr 2013 16:46:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304241527220.2772@cobra.newdream.net>
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

Hi everyone-

We are down to a handful of urgent bugs (3!) and a cuttlefish release date 
that is less than a week away.  Thank you to everyone who has been 
involved in coding, testing, and stabilizing this release.  We are close!

If you would like to test the current release candidate, your efforts 
would be much appreciated!  For deb systems, you can do

 wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/autobuild.asc' | sudo apt-key add -
 echo deb http://gitbuilder.ceph.com/ceph-deb-$(lsb_release -sc)-x86_64-basic/ref/next $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list

For rpm users you can find packages at

 http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/
 http://gitbuilder.ceph.com/ceph-rpm-fc17-x86_64-basic/ref/next/
 http://gitbuilder.ceph.com/ceph-rpm-fc18-x86_64-basic/ref/next/

A draft of the release notes is up at

 http://ceph.com/docs/master/release-notes/#v0-61

Let me know if I've missed anything!

sage
