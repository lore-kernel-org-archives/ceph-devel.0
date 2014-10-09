From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 09 Oct 2014 06:23:42 -0700
Message-ID: <54368c5e4f8b8_4b4392731847432@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:62552 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaJINXn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Oct 2014 09:23:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

3 new defect(s) introduced to ceph found with Coverity Scan.
4 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1244227:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7011 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
/mds/Server.cc: 7130 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()

** CID 1244228:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/MDSAuthCaps.h: 29 in MDSCapSpec::MDSCapSpec()()

** CID 1244229:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MDirUpdate.h: 55 in MDirUpdate::MDirUpdate(mds_rank_t, dirfrag_t, int, std::set<int, std::less<int>, std::allocator<int>> &, filepath &, bool)()


________________________________________________________________________________________________________
*** CID 1244227:  Dereference after null check  (FORWARD_NULL)
/mds/Server.cc: 7011 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
7005       // slave
7006       assert(!destdn || destdn->authority().first != whoami);
7007       assert(!straydn || straydn->authority().first != whoami);
7008     
7009       bool force_journal_src = false;
7010       bool force_journal_dest = false;
>>>     CID 1244227:  Dereference after null check  (FORWARD_NULL)
>>>     Passing null pointer "srcdn" to "authority", which dereferences it. (The dereference happens because this is a virtual function call.)
7011       if (in && in->is_dir() && srcdn->authority().first != whoami)
7012         force_journal_src = _need_force_journal(in, false);
7013       if (in && target && target->is_dir())
7014         force_journal_dest = _need_force_journal(in, true);
7015       
7016       version_t srcdnpv = 0;
/mds/Server.cc: 7130 in Server::do_rename_rollback(ceph::buffer::list &, mds_rank_t, std::tr1::shared_ptr<MDRequestImpl> &, bool)()
7124         le->commit.add_primary_dentry(target->get_projected_parent_dn(), target, true);
7125       }
7126     
7127       if (force_journal_dest) {
7128         dout(10) << " noting rename target ino " << target->ino() << " in metablob" << dendl;
7129         le->commit.renamed_dirino = target->ino();
>>>     CID 1244227:  Dereference after null check  (FORWARD_NULL)
>>>     Passing null pointer "srcdn" to "authority", which dereferences it. (The dereference happens because this is a virtual function call.)
7130       } else if (force_journal_src || (in && in->is_dir() && srcdn->authority().first == whoami)) {
7131         dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
7132         le->commit.renamed_dirino = in->ino();
7133       }
7134       
7135       if (target && target->is_dir()) {

________________________________________________________________________________________________________
*** CID 1244228:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/MDSAuthCaps.h: 29 in MDSCapSpec::MDSCapSpec()()
23     
24     struct MDSCapSpec {
25       bool read;
26       bool write;
27       bool any;
28     
>>>     CID 1244228:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "read" is not initialized in this constructor nor in any functions that it calls.
29       MDSCapSpec() : write(false), any(false) {}
30       MDSCapSpec(bool r_, bool w_, bool a_) : read(r_), write(w_), any(a_) {}
31     
32       bool allow_all() const {return any;}
33     };
34     

________________________________________________________________________________________________________
*** CID 1244229:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MDirUpdate.h: 55 in MDirUpdate::MDirUpdate(mds_rank_t, dirfrag_t, int, std::set<int, std::less<int>, std::allocator<int>> &, filepath &, bool)()
49         this->from_mds = f;
50         this->dirfrag = dirfrag;
51         this->dir_rep = dir_rep;
52         this->dir_rep_by = dir_rep_by;
53         if (discover) this->discover = 5;
54         this->path = path;
>>>     CID 1244229:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "discover" is not initialized in this constructor nor in any functions that it calls.
55       }
56     private:
57       ~MDirUpdate() {}
58     
59     public:
60       const char *get_type_name() const { return "dir_update"; }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



