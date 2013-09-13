From: Sage Weil <sage@inktank.com>
Subject: Re: [Ceph-qa] 3 failed, 51 passed in
 teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana
Date: Fri, 13 Sep 2013 11:37:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309131137410.1004@cobra.newdream.net>
References: <20130913065626.D4A4F2812A3@teuthology.front.sepia.ceph.com> <alpine.DEB.2.00.1309130800310.27240@cobra.newdream.net> <CAN04cT4Dfa6S5J_2py58pkq-q9isopoYgxSZO4bG0aPdSs7pkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38777 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3IMShu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Sep 2013 14:37:50 -0400
In-Reply-To: <CAN04cT4Dfa6S5J_2py58pkq-q9isopoYgxSZO4bG0aPdSs7pkg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

yep, i think so!

On Fri, 13 Sep 2013, Roald van Loon wrote:

> Hi,
> 
> I assume this is fixed by #594?
> 
> Roald
> 
> On Fri, Sep 13, 2013 at 5:01 PM, Sage Weil <sage@inktank.com> wrote:
> > afaict the tcmalloc gitbuidler is building against tcmalloc again.  this
> > probably got broken by the Makefile refactor?
> >
> > s
> >
> > On Thu, 12 Sep 2013, teuthworker@teuthology.front.sepia.ceph.com wrote:
> >
> >> Test Run: teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana
> >> =================================================================
> >> logs:   http://qa-proxy.ceph.com/teuthology/teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana/
> >> failed: 3
> >> hung:   0
> >> passed: 51
> >>
> >> Failed
> >> =================================================================
> >> [30719]  fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_dbench.yaml validater/valgrind.yaml}
> >> -----------------------------------------------------------------
> >> time:   2713s
> >> log:    http://qa-proxy.ceph.com/teuthology/teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana/30719/
> >>
> >>     saw valgrind issues
> >>
> >> [30723]  fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/libcephfs_interface_tests.yaml validater/valgrind.yaml}
> >> -----------------------------------------------------------------
> >> time:   783s
> >> log:    http://qa-proxy.ceph.com/teuthology/teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana/30723/
> >>
> >>     saw valgrind issues
> >>
> >> [30721]  fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml validater/valgrind.yaml}
> >> -----------------------------------------------------------------
> >> time:   15816s
> >> log:    http://qa-proxy.ceph.com/teuthology/teuthology-2013-09-11_23:01:12-fs-master-testing-basic-plana/30721/
> >>
> >>     saw valgrind issues
> >>
> >>
> >> Passed
> >> =================================================================
> >> [30675] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_ffsb.yaml}
> >> time:    1210s
> >>
> >> [30674] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_dbench.yaml}
> >> time:    2209s
> >>
> >> [30677] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsx.yaml}
> >> time:    3669s
> >>
> >> [30676] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml}
> >> time:    649s
> >>
> >> [30671] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_misc.yaml}
> >> time:    16092s
> >>
> >> [30670] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_kernel_untar_build.yaml}
> >> time:    9462s
> >>
> >> [30673] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_blogbench.yaml}
> >> time:    758s
> >>
> >> [30672] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_misc_test_o_trunc.yaml}
> >> time:    3166s
> >>
> >> [30712] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/osd-mds-delay.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_trivial_sync.yaml}
> >> time:    193s
> >>
> >> [30713] fs/traceless/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_blogbench.yaml traceless/50pc.yaml}
> >> time:    715s
> >>
> >> [30710] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/osd-mds-delay.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml}
> >> time:    601s
> >>
> >> [30711] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/osd-mds-delay.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_pjd.yaml}
> >> time:    459s
> >>
> >> [30679] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_iogen.yaml}
> >> time:    889s
> >>
> >> [30678] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsync.yaml}
> >> time:    229s
> >>
> >> [30714] fs/traceless/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_dbench.yaml traceless/50pc.yaml}
> >> time:    2183s
> >>
> >> [30715] fs/traceless/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_ffsb.yaml traceless/50pc.yaml}
> >> time:    1153s
> >>
> >> [30688] fs/multiclient/{clusters/three_clients.yaml fs/btrfs.yaml mount/ceph-fuse.yaml tasks/mdtest.yaml}
> >> time:    529s
> >>
> >> [30689] fs/multiclient/{clusters/two_clients.yaml fs/btrfs.yaml mount/ceph-fuse.yaml tasks/ior-shared-file.yaml}
> >> time:    144s
> >>
> >> [30680] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_iozone.yaml}
> >> time:    753s
> >>
> >> [30681] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_pjd.yaml}
> >> time:    370s
> >>
> >> [30682] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_tiobench.yaml}
> >> time:    477s
> >>
> >> [30683] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_truncate_delay.yaml}
> >> time:    157s
> >>
> >> [30684] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_trivial_sync.yaml}
> >> time:    154s
> >>
> >> [30685] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/libcephfs_interface_tests.yaml}
> >> time:    250s
> >>
> >> [30686] fs/basic/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/libcephfs_java.yaml}
> >> time:    172s
> >>
> >> [30687] fs/multiclient/{clusters/three_clients.yaml fs/btrfs.yaml mount/ceph-fuse.yaml tasks/ior-shared-file.yaml}
> >> time:    160s
> >>
> >> [30722] fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/libcephfs_interface_tests.yaml validater/lockdep.yaml}
> >> time:    275s
> >>
> >> [30720] fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml validater/lockdep.yaml}
> >> time:    654s
> >>
> >> [30718] fs/verify/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_dbench.yaml validater/lockdep.yaml}
> >> time:    2186s
> >>
> >> [30709] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/none.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_trivial_sync.yaml}
> >> time:    155s
> >>
> >> [30708] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/none.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_pjd.yaml}
> >> time:    442s
> >>
> >> [30701] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/native.yaml workload/cifs-tiobench.yaml}
> >> time:    568s
> >>
> >> [30700] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/native.yaml workload/cifs-fsstress.yaml}
> >> time:    434s
> >>
> >> [30703] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/noceph.yaml workload/cifs-dbench.yaml}
> >> time:    1635s
> >>
> >> [30702] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/native.yaml workload/smbtorture.yaml}
> >> time:    2470s
> >>
> >> [30705] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/noceph.yaml workload/cifs-tiobench.yaml}
> >> time:    262s
> >>
> >> [30704] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/noceph.yaml workload/cifs-fsstress.yaml}
> >> time:    227s
> >>
> >> [30707] fs/thrash/{ceph/base.yaml ceph-thrash/default.yaml clusters/mds-1active-1standby.yaml fs/btrfs.yaml msgr-failures/none.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml}
> >> time:    1114s
> >>
> >> [30706] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/noceph.yaml workload/smbtorture.yaml}
> >> time:    2045s
> >>
> >> [30716] fs/traceless/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_fsstress.yaml traceless/50pc.yaml}
> >> time:    700s
> >>
> >> [30699] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/native.yaml workload/cifs-dbench.yaml}
> >> time:    1739s
> >>
> >> [30698] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/kclient.yaml workload/smbtorture.yaml}
> >> time:    2079s
> >>
> >> [30697] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/kclient.yaml workload/cifs-tiobench.yaml}
> >> time:    484s
> >>
> >> [30696] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/kclient.yaml workload/cifs-fsstress.yaml}
> >> time:    519s
> >>
> >> [30695] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/kclient.yaml workload/cifs-dbench.yaml}
> >> time:    1681s
> >>
> >> [30694] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/fuse.yaml workload/smbtorture.yaml}
> >> time:    2192s
> >>
> >> [30693] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/fuse.yaml workload/cifs-tiobench.yaml}
> >> time:    595s
> >>
> >> [30692] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/fuse.yaml workload/cifs-fsstress.yaml}
> >> time:    812s
> >>
> >> [30691] fs/samba/{clusters/samba-basic.yaml fs/btrfs.yaml install/install.yaml mount/fuse.yaml workload/cifs-dbench.yaml}
> >> time:    1726s
> >>
> >> [30690] fs/multiclient/{clusters/two_clients.yaml fs/btrfs.yaml mount/ceph-fuse.yaml tasks/mdtest.yaml}
> >> time:    452s
> >>
> >> [30717] fs/traceless/{clusters/fixed-3.yaml fs/btrfs.yaml overrides/whitelist_wrongly_marked_down.yaml tasks/cfuse_workunit_suites_tiobench.yaml traceless/50pc.yaml}
> >> time:    439s
> >> _______________________________________________
> >> Ceph-qa mailing list
> >> Ceph-qa@lists.ceph.com
> >> http://lists.ceph.com/listinfo.cgi/ceph-qa-ceph.com
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
