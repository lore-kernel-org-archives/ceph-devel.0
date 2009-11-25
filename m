From: Vitaly Shishakov <shift@cmpd2.phys.msu.su>
Subject: build ceph 0.17 on OpenSuSE 11.0 (success)
Date: Wed, 25 Nov 2009 07:35:28 +0300
Message-ID: <4B0CB410.7070701@cmpd2.phys.msu.su>
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
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

I tried to build ceph-0.17 on OpenSUSE 11.0 (default kernel - 2.6.25, 
libfuse 2.8 upgraded from repository, default version is 2.7)

to do that i had to make the following changes:

1) install more fresh version on BOOST (default version was 1.34, i 
installed 1.39 from repositories),
and other prereqs, like libedit-devel,  fuse-devel, etc.
2) change  src/include/object.h -- add  #include <stdio.h>  -- to 
suppress error about not found sprintf function
3) change dependencies in  ceph.spec --
(i actually removed them, only left build_reqs and relied on automagical 
dependency discovery)
4) in .spec file I commented out everything about kernel client, due to 
some kernel requirements
(like unaligned access functions. at first i )
i only left FUSE client, and added those files, that were missing.

then i built rpms, which i used to distribute along my cluster nodes.
20 nodes, 1 managing server, 1Gbit network.
each node has 6x640GB SATA HDD !

so far i tested with 4 nodes, each hosting 1 OSD based on ext3 volume. + 
1mon and 1msd.
i have to say, that bonnie++ went successfully, showing 50MB/sec,
same as NFS on the same network (seems like bad ethernet card or bad switch)

more tests to come.
the only problem so far:  cfuse-mounted filesystem refuse to unmount. 
(says that device is busy)

I have to admit:  far more easier deployment, than with Lustre!


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
