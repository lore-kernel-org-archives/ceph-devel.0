From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: v0.87.2 released
Date: Mon, 27 Apr 2015 14:49:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504271447580.4298@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This is the second (and possibly final) point release for Giant.

We recommend all v0.87.x Giant users upgrade to this release.

Notable Changes
---------------

* ceph-objectstore-tool: only output unsupported features when 
  incompatible (#11176 David Zafman)
* common: do not implicitly unlock rwlock on destruction (Federico 
  Simoncelli)
* common: make wait timeout on empty queue configurable (#10818 Samuel 
  Just)
* crush: pick ruleset id that matches and rule id (Xiaoxi Chen)
* crush: set_choose_tries = 100 for new erasure code rulesets (#10353 Loic 
  Dachary)
* librados: check initialized atomic safely (#9617 Josh Durgin)
* librados: fix failed tick_event assert (#11183 Zhiqiang Wang)
* librados: fix looping on skipped maps (#9986 Ding Dinghua)
* librados: fix op submit with timeout (#10340 Samuel Just)
* librados: pybind: fix memory leak (#10723 Billy Olsen)
* librados: pybind: keep reference to callbacks (#10775 Josh Durgin)
* librados: translate operation flags from C APIs (Matthew Richards)
* libradosstriper: fix write_full on ENOENT (#10758 Sebastien Ponce)
* libradosstriper: use strtoll instead of strtol (Dongmao Zhang)
* mds: fix assertion caused by system time moving backwards (#11053 Yan, 
  Zheng)
* mon: allow injection of random delays on writes (Joao Eduardo Luis)
* mon: do not trust small osd epoch cache values (#10787 Sage Weil)
* mon: fail non-blocking flush if object is being scrubbed (#8011 Samuel 
  Just)
* mon: fix division by zero in stats dump (Joao Eduardo Luis)
* mon: fix get_rule_avail when no osds (#10257 Joao Eduardo Luis)
* mon: fix timeout rounds period (#10546 Joao Eduardo Luis)
* mon: ignore osd failures before up_from (#10762 Dan van der Ster, Sage 
  Weil)
* mon: paxos: reset accept timeout before writing to store (#10220 Joao 
  Eduardo Luis)
* mon: return if fs exists on 'fs new' (Joao Eduardo Luis)
* mon: use EntityName when expanding profiles (#10844 Joao Eduardo Luis)
* mon: verify cross-service proposal preconditions (#10643 Joao Eduardo 
  Luis)
* mon: wait for osdmon to be writeable when requesting proposal (#9794 
  Joao Eduardo Luis)
* mount.ceph: avoid spurious error message about /etc/mtab (#10351 Yan, 
  Zheng)
* msg/simple: allow RESETSESSION when we forget an endpoint (#10080 Greg 
  Farnum)
* msg/simple: discard delay queue before incoming queue (#9910 Sage Weil)
* osd: clear_primary_state when leaving Primary (#10059 Samuel Just)
* osd: do not ignore deleted pgs on startup (#10617 Sage Weil)
* osd: fix FileJournal wrap to get header out first (#10883 David Zafman)
* osd: fix PG leak in SnapTrimWQ (#10421 Kefu Chai)
* osd: fix journalq population in do_read_entry (#6003 Samuel Just)
* osd: fix operator== for op_queue_age_hit and fs_perf_stat (#10259 Samuel 
  Just)
* osd: fix rare assert after split (#10430 David Zafman)
* osd: get pgid ancestor from last_map when building past intervals 
  (#10430 David Zafman)
* osd: include rollback_info_trimmed_to in {read,write}_log (#10157 Samuel 
  Just)
* osd: lock header_lock in DBObjectMap::sync (#9891 Samuel Just)
* osd: requeue blocked op before flush it was blocked on (#10512 Sage 
  Weil)
* osd: tolerate missing object between list and attr get on backfill 
  (#10150 Samuel Just)
* osd: use correct atime for eviction decision (Xinze Chi)
* rgw: flush XML header on get ACL request (#10106 Yehuda Sadeh)
* rgw: index swift keys appropriately (#10471 Hemant Bruman, Yehuda Sadeh)
* rgw: send cancel for bucket index pending ops (#10770 Baijiaruo, Yehuda 
  Sadeh)
* rgw: swift: support X_Remove_Container-Meta-{key} (#01475 Dmytro 
  Iurchenko)

For more detailed information, see

  http://ceph.com/docs/master/_downloads/v0.87.2.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.87.2.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
