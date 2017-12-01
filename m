From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 01 Dec 2017 02:25:38 +0000 (UTC)
Message-ID: <5a20bda22888f_69383273282442c@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o1.hv1nn.shared.sendgrid.net ([167.89.100.169]:16325 "EHLO
        o1.hv1nn.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751007AbdLACZj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Nov 2017 21:25:39 -0500
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0015p1las1.sendgrid.net (SG) with ESMTP id Mb1CjPPJQN-Ks7WYWeaAIg
        for <ceph-devel@vger.kernel.org>; Fri, 01 Dec 2017 02:25:38.408 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

347 new defect(s) introduced to ceph found with Coverity Scan.
880 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 347 defect(s)


** CID 716914:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/CInode.cc: 450 in CInode::project_past_snaprealm_parent(SnapRealm *)()


________________________________________________________________________________________________________
*** CID 716914:  Null pointer dereferences  (FORWARD_NULL)
/home/brad/working/src/ceph/src/mds/CInode.cc: 450 in CInode::project_past_snaprealm_parent(SnapRealm *)()
444      if parent DNE, we need to find what the parent actually is and fill that in */
445     void CInode::project_past_snaprealm_parent(SnapRealm *newparent)
446     {
447       sr_t *new_snap = project_snaprealm();
448       SnapRealm *oldparent;
449       if (!snaprealm) {
>>>     CID 716914:  Null pointer dereferences  (FORWARD_NULL)
>>>     Assigning: "oldparent" = "this->find_snaprealm()".
450         oldparent = find_snaprealm();
451         new_snap->seq = oldparent->get_newest_seq();
452       }
453       else
454         oldparent = snaprealm->parent;
455     

** CID 1192618:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()


________________________________________________________________________________________________________
*** CID 1192618:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1192618:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()

** CID 1219627:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()


________________________________________________________________________________________________________
*** CID 1219627:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 749 in main()
743       if ((r = update_mgrmap(st))) {
744         return r;
745       }
746       return 0;
747     }
748     
>>>     CID 1219627:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
749     int main(int argc, char **argv) {
750       int err = 0;
751       po::options_description desc("Allowed options");
752       string store_path, cmd;
753       vector<string> subcmds;
754       desc.add_options()

** CID 1225100:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 662 in MDLog::trim(int)()
/home/brad/working/src/ceph/src/mds/MDLog.cc: 662 in MDLog::trim(int)()


________________________________________________________________________________________________________
*** CID 1225100:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 662 in MDLog::trim(int)()
656           p = segments.lower_bound(last_seq + 1);
657         }
658       }
659     
660       // discard expired segments and unlock submit_mutex
661       _trim_expired_segments();
>>>     CID 1225100:    (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
662     }
663     
664     class C_MaybeExpiredSegment : public MDSInternalContext {
665       MDLog *mdlog;
666       LogSegment *ls;
667       int op_prio;
/home/brad/working/src/ceph/src/mds/MDLog.cc: 662 in MDLog::trim(int)()
656           p = segments.lower_bound(last_seq + 1);
657         }
658       }
659     
660       // discard expired segments and unlock submit_mutex
661       _trim_expired_segments();
>>>     CID 1225100:    (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
662     }
663     
664     class C_MaybeExpiredSegment : public MDSInternalContext {
665       MDLog *mdlog;
666       LogSegment *ls;
667       int op_prio;

** CID 1225101:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()


________________________________________________________________________________________________________
*** CID 1225101:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()
522     
523       if (recovery_thread.is_started() && !recovery_thread.am_self()) {
524         mds->mds_lock.Unlock();
525         recovery_thread.join();
526         mds->mds_lock.Lock();
527       }
>>>     CID 1225101:    (LOCK)
>>>     Returning without unlocking "this->mds->mds_lock._m".
528     }
529     
530     
531     // -----------------------------
532     // segments
533     
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()
522     
523       if (recovery_thread.is_started() && !recovery_thread.am_self()) {
524         mds->mds_lock.Unlock();
525         recovery_thread.join();
526         mds->mds_lock.Lock();
527       }
>>>     CID 1225101:    (LOCK)
>>>     Returning without unlocking "this->mds->mds_lock._m".
528     }
529     
530     
531     // -----------------------------
532     // segments
533     
/home/brad/working/src/ceph/src/mds/MDLog.cc: 528 in MDLog::shutdown()()
522     
523       if (recovery_thread.is_started() && !recovery_thread.am_self()) {
524         mds->mds_lock.Unlock();
525         recovery_thread.join();
526         mds->mds_lock.Lock();
527       }
>>>     CID 1225101:    (LOCK)
>>>     Returning without unlocking "this->mds->mds_lock._m".
528     }
529     
530     
531     // -----------------------------
532     // segments
533     

** CID 1238895:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()


________________________________________________________________________________________________________
*** CID 1238895:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238895:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::malformed_input" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238895:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::malformed_input" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238895:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::malformed_input" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;

** CID 1238897:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()


________________________________________________________________________________________________________
*** CID 1238897:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238897:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;

** CID 1238898:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()


________________________________________________________________________________________________________
*** CID 1238898:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238898:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_lexical_cast> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238898:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_lexical_cast> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;

** CID 1238899:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()


________________________________________________________________________________________________________
*** CID 1238899:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238899:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238899:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238899:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238899:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238899:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "boost::exception_detail::clone_impl<boost::exception_detail::error_info_injector<boost::bad_get> >" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;

** CID 1238900:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()


________________________________________________________________________________________________________
*** CID 1238900:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;
/home/brad/working/src/ceph/src/tools/ceph_objectstore_tool.cc: 2584 in main()
2578       }
2579     
2580       cerr << "Finished " << total << "/" << total << " collections" << "\r" << std::endl;
2581       return r;
2582     }
2583     
>>>     CID 1238900:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
2584     int main(int argc, char **argv)
2585     {
2586       string dpath, jpath, pgidstr, op, file, mountpoint, mon_store_path, object;
2587       string target_data_path, fsid;
2588       string objcmd, arg1, arg2, type, format, argnspace, pool;
2589       boost::optional<std::string> nspace;

** CID 1256511:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 730 in MDLog::trim_all()()
/home/brad/working/src/ceph/src/mds/MDLog.cc: 730 in MDLog::trim_all()()


________________________________________________________________________________________________________
*** CID 1256511:    (LOCK)
/home/brad/working/src/ceph/src/mds/MDLog.cc: 730 in MDLog::trim_all()()
724           p = segments.lower_bound(next_seq);
725         }
726       }
727     
728       _trim_expired_segments();
729     
>>>     CID 1256511:    (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
730       return 0;
731     }
732     
733     
734     void MDLog::try_expire(LogSegment *ls, int op_prio)
735     {
/home/brad/working/src/ceph/src/mds/MDLog.cc: 730 in MDLog::trim_all()()
724           p = segments.lower_bound(next_seq);
725         }
726       }
727     
728       _trim_expired_segments();
729     
>>>     CID 1256511:    (LOCK)
>>>     Returning without unlocking "this->submit_mutex._m".
730       return 0;
731     }
732     
733     
734     void MDLog::try_expire(LogSegment *ls, int op_prio)
735     {

** CID 1297739:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mon/Session.h: 160 in MonSessionMap::get_random_osd_session(OSDMap *)()


________________________________________________________________________________________________________
*** CID 1297739:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mon/Session.h: 160 in MonSessionMap::get_random_osd_session(OSDMap *)()
154     
155       MonSession *get_random_osd_session(OSDMap *osdmap) {
156         // ok, this isn't actually random, but close enough.
157         if (by_osd.empty())
158           return 0;
159         int n = by_osd.rbegin()->first + 1;
>>>     CID 1297739:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
160         int r = rand() % n;
161     
162         multimap<int,MonSession*>::iterator p = by_osd.lower_bound(r);
163         if (p == by_osd.end())
164           --p;
165     

** CID 1297760:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 1261 in main()


________________________________________________________________________________________________________
*** CID 1297760:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/tools/ceph_monstore_tool.cc: 1261 in main()
1255           string prefix;
1256           prefix.push_back((i%26)+'a');
1257           for (unsigned j = 0; j < tsize; ++j) {
1258     	stringstream os;
1259     	os << num;
1260     	bufferlist bl;
>>>     CID 1297760:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1261     	for (unsigned k = 0; k < tvalsize; ++k) bl.append(rand());
1262     	t->put(prefix, os.str(), bl);
1263     	++num;
1264           }
1265           t->compact_prefix(prefix);
1266           st.apply_transaction(t);

** CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDCache.h: 1191 in MDCache::hack_pick_random_inode()()


________________________________________________________________________________________________________
*** CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDCache.h: 1191 in MDCache::hack_pick_random_inode()()
1185      public:
1186       void show_cache();
1187       void show_subtrees(int dbl=10);
1188     
1189       CInode *hack_pick_random_inode() {
1190         assert(!inode_map.empty());
>>>     CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1191         int n = rand() % inode_map.size();
1192         auto p = inode_map.begin();
1193         while (n--) ++p;
1194         return p->second;
1195       }
1196     

** CID 1297802:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 1917 in Objecter::wait_for_osd_map()()


________________________________________________________________________________________________________
*** CID 1297802:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/osdc/Objecter.cc: 1917 in Objecter::wait_for_osd_map()()
1911       Cond cond;
1912       bool done;
1913       lock.Lock();
1914       C_SafeCond *context = new C_SafeCond(&lock, &cond, &done, NULL);
1915       waiting_for_map[0].push_back(pair<Context*, int>(context, 0));
1916       l.unlock();
>>>     CID 1297802:  Program hangs  (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
1917       while (!done)
1918         cond.Wait(lock);
1919       lock.Unlock();
1920     }
1921     
1922     struct C_Objecter_GetVersion : public Context {

** CID 1297895:  Incorrect expression  (USELESS_CALL)


________________________________________________________________________________________________________
*** CID 1297895:  Incorrect expression  (USELESS_CALL)
/home/brad/working/src/ceph/src/mds/MDCache.cc: 5716 in MDCache::do_cap_import(Session *, CInode *, Capability *, unsigned long, unsigned int, unsigned int, int, int)()
5710       } else {
5711         dout(10) << "do_cap_import missing past snap parents, delaying " << session->info.inst.name << " mseq "
5712     	     << cap->get_mseq() << " on " << *in << dendl;
5713         in->auth_pin(this);
5714         cap->inc_suppress();
5715         delayed_imported_caps[client].insert(in);
>>>     CID 1297895:  Incorrect expression  (USELESS_CALL)
>>>     Calling "this->missing_snap_parents[in]->size()" is only useful for its return value, which is ignored.
5716         missing_snap_parents[in].size();
5717       }
5718     }
5719     
5720     void MDCache::do_delayed_cap_imports()
5721     {

** CID 1313369:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/osd/OSD.cc: 3606 in OSD::clear_temp_objects()()


________________________________________________________________________________________________________
*** CID 1313369:  Error handling issues  (CHECKED_RETURN)
/home/brad/working/src/ceph/src/osd/OSD.cc: 3606 in OSD::clear_temp_objects()()
3600     }
3601     
3602     void OSD::clear_temp_objects()
3603     {
3604       dout(10) << __func__ << dendl;
3605       vector<coll_t> ls;
>>>     CID 1313369:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "list_collections" without checking return value (as is done elsewhere 9 out of 11 times).
3606       store->list_collections(ls);
3607       for (vector<coll_t>::iterator p = ls.begin(); p != ls.end(); ++p) {
3608         spg_t pgid;
3609         if (!p->is_pg(&pgid))
3610           continue;
3611     

** CID 1316228:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 606 in MDSRank::_dispatch(Message *, bool)()
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 615 in MDSRank::_dispatch(Message *, bool)()
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 640 in MDSRank::_dispatch(Message *, bool)()


________________________________________________________________________________________________________
*** CID 1316228:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 606 in MDSRank::_dispatch(Message *, bool)()
600         CInode *in = mdcache->hack_pick_random_inode();
601     
602         list<CDir*> ls;
603         in->get_dirfrags(ls);
604         if (!ls.empty()) {	// must be an open dir.
605           list<CDir*>::iterator p = ls.begin();
>>>     CID 1316228:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
606           int n = rand() % ls.size();
607           while (n--)
608             ++p;
609           CDir *dir = *p;
610           if (!dir->get_parent_dir()) continue;    // must be linked.
611           if (!dir->is_auth()) continue;           // must be auth.
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 615 in MDSRank::_dispatch(Message *, bool)()
609           CDir *dir = *p;
610           if (!dir->get_parent_dir()) continue;    // must be linked.
611           if (!dir->is_auth()) continue;           // must be auth.
612     
613           mds_rank_t dest;
614           do {
>>>     CID 1316228:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
615             int k = rand() % s.size();
616             set<mds_rank_t>::iterator p = s.begin();
617             while (k--) ++p;
618             dest = *p;
619           } while (dest == whoami);
620           mdcache->migrator->export_dir_nicely(dir,dest);
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 640 in MDSRank::_dispatch(Message *, bool)()
634         if (ls.empty()) continue;                // must be an open dir.
635         CDir *dir = ls.front();
636         if (!dir->get_parent_dir()) continue;    // must be linked.
637         if (!dir->is_auth()) continue;           // must be auth.
638         frag_t fg = dir->get_frag();
639         if (mdsmap->allows_dirfrags()) {
>>>     CID 1316228:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
640           if ((fg == frag_t() || (rand() % (1 << fg.bits()) == 0))) {
641             mdcache->split_dir(dir, 1);
642           } else {
643             balancer->queue_merge(dir);
644           }
645         }

** CID 1316243:  API usage errors  (STREAM_FORMAT_STATE)
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 2382 in MDSRank::_command_dirfrag_get(const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, std::vector<long, std::allocator<long>>, std::vector<double, std::allocator<double>>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::__cxx1
 1::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allo
 cator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, std::vector<long, std::allocator<long>>, std::vector<double, std::allocator<double>>>>>> &, std::basic_ostream<char, std::char_traits<char>>&)()


________________________________________________________________________________________________________
*** CID 1316243:  API usage errors  (STREAM_FORMAT_STATE)
/home/brad/working/src/ceph/src/mds/MDSRank.cc: 2382 in MDSRank::_command_dirfrag_get(const std::map<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, std::vector<long, std::allocator<long>>, std::vector<double, std::allocator<double>>>, std::less<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, boost::variant<std::__cxx1
 1::basic_string<char, std::char_traits<char>, std::allocator<char>>, bool, long, double, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allo
 cator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>>, std::vector<long, std::allocator<long>>, std::vector<double, std::allocator<double>>>>>> &, std::basic_ostream<char, std::char_traits<char>>&)()
2376       }
2377     
2378       CDir *dir = in->get_dirfrag(fg);
2379       if (!dir) {
2380         ss << "frag 0x" << std::hex << in->ino() << "/" << fg << " not in cache ("
2381               "use `dirfrag ls` to see if it should exist)";
>>>     CID 1316243:  API usage errors  (STREAM_FORMAT_STATE)
>>>     Changing format state of stream "ss" for category basefield without later restoring it.
2382         return NULL;
2383       }
2384     
2385       if (!dir->is_auth()) {
2386         ss << "frag " << dir->dirfrag() << " not auth (auth = "
2387            << dir->authority() << ")";

** CID 1322426:  Memory - corruptions  (OVERRUN)


________________________________________________________________________________________________________
*** CID 1322426:  Memory - corruptions  (OVERRUN)
/home/brad/working/src/ceph/src/tools/RadosDump.h: 311 in metadata_section::encode(ceph::buffer::list &) const()
305           missing(missing) {}
306       metadata_section()
307         : struct_ver(0),
308           map_epoch(0) { }
309     
310       void encode(bufferlist& bl) const {
>>>     CID 1322426:  Memory - corruptions  (OVERRUN)
>>>     Overrunning struct type ceph_le32 of 4 bytes by passing it to a function which accesses it at byte offset 7.
311         ENCODE_START(6, 6, bl);
312         ::encode(struct_ver, bl);
313         ::encode(map_epoch, bl);
314         ::encode(info, bl);
315         ::encode(log, bl);
316         ::encode(past_intervals, bl);


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FvArpa8jgG32m9fJAAGhJmWRBU-2B7ohJQkqagyg2FmYgO3f0ismPYBrNT8JkMs7OePVeIgMsIY-2B2ghIecvO75iFy-2Fyu51pjUyrxFyAD65XADCROa0ktimYyVtovlwMCVDnicZHdUtcECAdPPk-2BEWn-2F3m4cpM58rd1fw16DSiFNzQi-2BQzCgLiEfZytLdVAMTiBU-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9OVG2ZVnjrgThgf5hX3GVEkIxvBX-2BorwRZfOftSp7HPfCifRGGak1MlgNFVd3IIPA-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FvArpa8jgG32m9fJAAGhJmWRBU-2B7ohJQkqagyg2FmYgNOtAH3V9ZBIOKgqBm4JITsXN5PSHRmYKxp9uoZKV7Dpjnb3YANzr2Vm2wmu-2BRw7zc8JJf6VMsDuMm-2FEYr1oBYw2FOIlrolHTv6UXf4kmG33wln-2F-2B-2FDz-2BHkH0krRMnmoOm2-2FnPB67Ts-2FlTbZJxLwepU-3D

