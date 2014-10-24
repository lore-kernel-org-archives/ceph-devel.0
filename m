From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Fri, 24 Oct 2014 10:55:52 -0700
Message-ID: <544a92a83b3e7_4426b55338883e1@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:50590 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932608AbaJXRzx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Oct 2014 13:55:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

26 new defect(s) introduced to ceph found with Coverity Scan.
114 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 26 defect(s)


** CID 717128:  Wrong sizeof argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 228 in test_ls(void *, unsigned long, ...)()

** CID 717147:  Uncaught exception  (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 141 in main()

** CID 717246:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 204 in EMetaBlob::nullbit::nullbit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, bool)()

** CID 717248:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 168 in EMetaBlob::remotebit::remotebit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, inodeno_t, unsigned char, bool)()

** CID 717264:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientReply.h: 129 in InodeStat::InodeStat()()

** CID 717270:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MDirUpdate.h: 55 in MDirUpdate::MDirUpdate(int, dirfrag_t, int, std::set<int, std::less<int>, std::allocator<int>> &, filepath &, bool)()

** CID 717275:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MExportDirDiscover.h: 36 in MExportDirDiscover::MExportDirDiscover()()

** CID 717289:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MMDSLoadTargets.h: 30 in MMDSLoadTargets::MMDSLoadTargets()()

** CID 1026810:  Uninitialized pointer field  (UNINIT_CTOR)
/mds/MDCache.h: 332 in MDCache::umaster::umaster()()

** CID 1026811:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 107 in EMetaBlob::fullbit::fullbit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, const inode_t &, const fragtree_t &, const std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::ptr, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::ptr>>> &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const ceph::buffer::list &, unsigned char, std::map<snapid_t, old_inode_t, std::less<snapid_t>, std::allocator<std::pair<const snapid_t, old_inode_t>>>*)()

** CID 1128407:  Dereference before null check  (REVERSE_INULL)
/client/Client.cc: 5180 in Client::_readdir_get_frag(dir_result_t *)()

** CID 1128412:  Resource leak  (RESOURCE_LEAK)
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()

** CID 1160849:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/CDir.cc: 1447 in C_Dir_OMAP_Fetched::C_Dir_OMAP_Fetched(CDir *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()

** CID 1188129:  Logically dead code  (DEADCODE)
/client/Client.cc: 8504 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, ceph_file_layout *, unsigned long, unsigned int)()

** CID 1188130:  Logically dead code  (DEADCODE)
/client/Client.cc: 8500 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, ceph_file_layout *, unsigned long, unsigned int)()

** CID 1192611:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()

** CID 1192612:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_dump.cc: 1076 in main()

** CID 1192613:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()

** CID 1192614:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_tool.cc: 48 in main()

** CID 1201374:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1097 in MDSMonitor::prepare_command(MMonCommand *)()


________________________________________________________________________________________________________
*** CID 717128:  Wrong sizeof argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 228 in test_ls(void *, unsigned long, ...)()
222     {
223       int num_images, i, j;
224       char *names, *cur_name;
225       va_list ap;
226       size_t max_size = 1024;
227     
>>>     CID 717128:  Wrong sizeof argument  (SIZEOF_MISMATCH)
>>>     Passing argument "8192UL /* sizeof (char *) * 1024 */" to function "malloc" and then casting the return value to "char *" is suspicious.
228       names = (char *) malloc(sizeof(char *) * 1024);
229       int len = rbd_list(io_ctx, names, &max_size);
230     
231       for (i = 0, num_images = 0, cur_name = names; cur_name < names + len; i++) {
232         printf("image: %s\n", cur_name);
233         cur_name += strlen(cur_name) + 1;

________________________________________________________________________________________________________
*** CID 717147:  Uncaught exception  (UNCAUGHT_EXCEPT)
/ceph_mds.cc: 141 in main()
135     static void handle_mds_signal(int signum)
136     {
137       if (mds)
138         mds->handle_signal(signum);
139     }
140     
>>>     CID 717147:  Uncaught exception  (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **)" an exception of type "ceph::buffer::end_of_buffer" is thrown and never caught.
141     int main(int argc, const char **argv) 
142     {
143       vector<const char*> args;
144       argv_to_vec(argc, argv, args);
145       env_to_vec(args);
146     

________________________________________________________________________________________________________
*** CID 717246:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 204 in EMetaBlob::nullbit::nullbit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, bool)()
198           _enc(128) {
199           ::encode(d, _enc);
200           ::encode(df, _enc);
201           ::encode(dl, _enc);
202           ::encode(v, _enc);
203           ::encode(dr, _enc);
>>>     CID 717246:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "dirty" is not initialized in this constructor nor in any functions that it calls.
204         }
205         nullbit(bufferlist::iterator &p) { decode(p); }
206         nullbit(): dnfirst(0), dnlast(0), dnv(0), dirty(false) {}
207     
208         void encode(bufferlist& bl) const;
209         void decode(bufferlist::iterator &bl);

________________________________________________________________________________________________________
*** CID 717248:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 168 in EMetaBlob::remotebit::remotebit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, inodeno_t, unsigned char, bool)()
162           ::encode(df, _enc);
163           ::encode(dl, _enc);
164           ::encode(v, _enc);
165           ::encode(i, _enc);
166           ::encode(dt, _enc);
167           ::encode(dr, _enc);
>>>     CID 717248:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "dirty" is not initialized in this constructor nor in any functions that it calls.
168         }
169         remotebit(bufferlist::iterator &p) { decode(p); }
170         remotebit(): dnfirst(0), dnlast(0), dnv(0), ino(0),
171     	d_type('\0'), dirty(false) {}
172     
173         void encode(bufferlist& bl) const;

________________________________________________________________________________________________________
*** CID 717264:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MClientReply.h: 129 in InodeStat::InodeStat()()
123     
124       ceph_dir_layout dir_layout;
125     
126       //map<string, bufferptr> xattrs;
127     
128      public:
>>>     CID 717264:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member field "dir_layout.dl_unused3" is not initialized in this constructor nor in any functions that it calls.
129       InodeStat() {}
130       InodeStat(bufferlist::iterator& p, uint64_t features) {
131         decode(p, features);
132       }
133     
134       void decode(bufferlist::iterator &p, uint64_t features) {

________________________________________________________________________________________________________
*** CID 717270:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MDirUpdate.h: 55 in MDirUpdate::MDirUpdate(int, dirfrag_t, int, std::set<int, std::less<int>, std::allocator<int>> &, filepath &, bool)()
49         this->from_mds = f;
50         this->dirfrag = dirfrag;
51         this->dir_rep = dir_rep;
52         this->dir_rep_by = dir_rep_by;
53         if (discover) this->discover = 5;
54         this->path = path;
>>>     CID 717270:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "discover" is not initialized in this constructor nor in any functions that it calls.
55       }
56     private:
57       ~MDirUpdate() {}
58     
59     public:
60       const char *get_type_name() const { return "dir_update"; }

________________________________________________________________________________________________________
*** CID 717275:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MExportDirDiscover.h: 36 in MExportDirDiscover::MExportDirDiscover()()
30       filepath& get_path() { return path; }
31     
32       bool started;
33     
34       MExportDirDiscover() :     
35         Message(MSG_MDS_EXPORTDIRDISCOVER),
>>>     CID 717275:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "from" is not initialized in this constructor nor in any functions that it calls.
36         started(false) { }
37       MExportDirDiscover(dirfrag_t df, filepath& p, int f, uint64_t tid) :
38         Message(MSG_MDS_EXPORTDIRDISCOVER),
39         from(f), dirfrag(df), path(p), started(false) {
40         set_tid(tid);
41       }

________________________________________________________________________________________________________
*** CID 717289:  Uninitialized scalar field  (UNINIT_CTOR)
/messages/MMDSLoadTargets.h: 30 in MMDSLoadTargets::MMDSLoadTargets()()
24     
25     class MMDSLoadTargets : public PaxosServiceMessage {
26      public:
27       uint64_t global_id;
28       set<int32_t> targets;
29     
>>>     CID 717289:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "global_id" is not initialized in this constructor nor in any functions that it calls.
30       MMDSLoadTargets() : PaxosServiceMessage(MSG_MDS_OFFLOAD_TARGETS, 0) {}
31     
32       MMDSLoadTargets(uint64_t g, set<int32_t>& mds_targets) :
33         PaxosServiceMessage(MSG_MDS_OFFLOAD_TARGETS, 0),
34         global_id(g), targets(mds_targets) {}
35     private:

________________________________________________________________________________________________________
*** CID 1026810:  Uninitialized pointer field  (UNINIT_CTOR)
/mds/MDCache.h: 332 in MDCache::umaster::umaster()()
326         set<int> slaves;
327         LogSegment *ls;
328         list<Context*> waiters;
329         bool safe;
330         bool committing;
331         bool recovering;
>>>     CID 1026810:  Uninitialized pointer field  (UNINIT_CTOR)
>>>     Non-static class member "safe" is not initialized in this constructor nor in any functions that it calls.
332         umaster() : committing(false), recovering(false) {}
333       };
334       map<metareqid_t, umaster>                 uncommitted_masters;         // master: req -> slave set
335     
336       set<metareqid_t>		pending_masters;
337       map<int, set<metareqid_t> >	ambiguous_slave_updates;

________________________________________________________________________________________________________
*** CID 1026811:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/events/EMetaBlob.h: 107 in EMetaBlob::fullbit::fullbit(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, snapid_t, snapid_t, unsigned long, const inode_t &, const fragtree_t &, const std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::ptr, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::ptr>>> &, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, const ceph::buffer::list &, unsigned char, std::map<snapid_t, old_inode_t, std::less<snapid_t>, std::allocator<std::pair<const snapid_t, old_inode_t>>>*)()
101     	::encode(sbl, _enc);
102           }
103           ::encode(st, _enc);
104           ::encode(oi ? true : false, _enc);
105           if (oi)
106     	::encode(*oi, _enc);
>>>     CID 1026811:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "state" is not initialized in this constructor nor in any functions that it calls.
107         }
108         fullbit(bufferlist::iterator &p) {
109           decode(p);
110         }
111         fullbit() {}
112         ~fullbit() {}

________________________________________________________________________________________________________
*** CID 1128407:  Dereference before null check  (REVERSE_INULL)
/client/Client.cc: 5180 in Client::_readdir_get_frag(dir_result_t *)()
5174       
5175       ldout(cct, 10) << "_readdir_get_frag " << dirp << " on " << dirp->inode->ino << " fg " << fg
5176     	   << " next_offset " << dirp->next_offset
5177     	   << dendl;
5178     
5179       int op = CEPH_MDS_OP_READDIR;
>>>     CID 1128407:  Dereference before null check  (REVERSE_INULL)
>>>     Null-checking "dirp->inode" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
5180       if (dirp->inode && dirp->inode->snapid == CEPH_SNAPDIR)
5181         op = CEPH_MDS_OP_LSSNAP;
5182     
5183       Inode *diri = dirp->inode;
5184     
5185       MetaRequest *req = new MetaRequest(op);

________________________________________________________________________________________________________
*** CID 1128412:  Resource leak  (RESOURCE_LEAK)
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
164           goto done;
165         }
166         if (ret < 0)
167           goto done;
168     
169         string last_pool;
>>>     CID 1128412:  Resource leak  (RESOURCE_LEAK)
>>>     Overwriting "ctx" in "ctx = new librados::IoCtx" leaks the storage that "ctx" points to.
170         ctx = new IoCtx;
171         std::list<cls_rgw_gc_obj_info>::iterator iter;
172         for (iter = entries.begin(); iter != entries.end(); ++iter) {
173           bool remove_tag;
174           cls_rgw_gc_obj_info& info = *iter;
175           std::list<cls_rgw_obj>::iterator liter;
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
164           goto done;
165         }
166         if (ret < 0)
167           goto done;
168     
169         string last_pool;
>>>     CID 1128412:  Resource leak  (RESOURCE_LEAK)
>>>     Overwriting "ctx" in "ctx = new librados::IoCtx" leaks the storage that "ctx" points to.
170         ctx = new IoCtx;
171         std::list<cls_rgw_gc_obj_info>::iterator iter;
172         for (iter = entries.begin(); iter != entries.end(); ++iter) {
173           bool remove_tag;
174           cls_rgw_gc_obj_info& info = *iter;
175           std::list<cls_rgw_obj>::iterator liter;
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
164           goto done;
165         }
166         if (ret < 0)
167           goto done;
168     
169         string last_pool;
>>>     CID 1128412:  Resource leak  (RESOURCE_LEAK)
>>>     Overwriting "ctx" in "ctx = new librados::IoCtx" leaks the storage that "ctx" points to.
170         ctx = new IoCtx;
171         std::list<cls_rgw_gc_obj_info>::iterator iter;
172         for (iter = entries.begin(); iter != entries.end(); ++iter) {
173           bool remove_tag;
174           cls_rgw_gc_obj_info& info = *iter;
175           std::list<cls_rgw_obj>::iterator liter;
/rgw/rgw_gc.cc: 170 in RGWGC::process(int, int)()
164           goto done;
165         }
166         if (ret < 0)
167           goto done;
168     
169         string last_pool;
>>>     CID 1128412:  Resource leak  (RESOURCE_LEAK)
>>>     Overwriting "ctx" in "ctx = new librados::IoCtx" leaks the storage that "ctx" points to.
170         ctx = new IoCtx;
171         std::list<cls_rgw_gc_obj_info>::iterator iter;
172         for (iter = entries.begin(); iter != entries.end(); ++iter) {
173           bool remove_tag;
174           cls_rgw_gc_obj_info& info = *iter;
175           std::list<cls_rgw_obj>::iterator liter;

________________________________________________________________________________________________________
*** CID 1160849:  Uninitialized scalar field  (UNINIT_CTOR)
/mds/CDir.cc: 1447 in C_Dir_OMAP_Fetched::C_Dir_OMAP_Fetched(CDir *, const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&)()
1441       string want_dn;
1442      public:
1443       bufferlist hdrbl;
1444       map<string, bufferlist> omap;
1445       int ret1, ret2;
1446     
>>>     CID 1160849:  Uninitialized scalar field  (UNINIT_CTOR)
>>>     Non-static class member "ret2" is not initialized in this constructor nor in any functions that it calls.
1447       C_Dir_OMAP_Fetched(CDir *d, const string& w) : dir(d), want_dn(w) { }
1448       void finish(int r) {
1449         if (r >= 0) r = ret1;
1450         if (r >= 0) r = ret2;
1451         dir->_omap_fetched(hdrbl, omap, want_dn, r);
1452       }

________________________________________________________________________________________________________
*** CID 1188129:  Logically dead code  (DEADCODE)
/client/Client.cc: 8504 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, ceph_file_layout *, unsigned long, unsigned int)()
8498         while (! done)
8499           cond.Wait(flock);
8500         flock.Unlock();
8501       }
8502     
8503       if (r < 0) {
>>>     CID 1188129:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "return r;".
8504           return r;
8505       } else {
8506           return length;
8507       }
8508     }
8509     

________________________________________________________________________________________________________
*** CID 1188130:  Logically dead code  (DEADCODE)
/client/Client.cc: 8500 in Client::ll_write_block(Inode *, unsigned long, char *, unsigned long, unsigned long, ceph_file_layout *, unsigned long, unsigned int)()
8494     
8495       client_lock.Unlock();
8496       if (!done /* also !sync */) {
8497         flock.Lock();
8498         while (! done)
8499           cond.Wait(flock);
>>>     CID 1188130:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "flock.Unlock();".
8500         flock.Unlock();
8501       }
8502     
8503       if (r < 0) {
8504           return r;
8505       } else {

________________________________________________________________________________________________________
*** CID 1192611:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()
/tools/ceph_filestore_dump.cc: 1076 in main()

________________________________________________________________________________________________________
*** CID 1192612:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_dump.cc: 1076 in main()

________________________________________________________________________________________________________
*** CID 1192613:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()
/tools/ceph_filestore_tool.cc: 48 in main()

________________________________________________________________________________________________________
*** CID 1192614:  Uncaught exception  (UNCAUGHT_EXCEPT)
/tools/ceph_filestore_tool.cc: 48 in main()

________________________________________________________________________________________________________
*** CID 1201374:  Unchecked return value  (CHECKED_RETURN)
/mon/MDSMonitor.cc: 1097 in MDSMonitor::prepare_command(MMonCommand *)()
1091           r = -EINVAL;
1092           poolid = -1;
1093           ss << "cannot remove default data pool";
1094         }
1095     
1096         if (poolid >= 0) {
>>>     CID 1201374:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "cmd_getval" without checking return value (as is done elsewhere 22 out of 25 times).
1097           cmd_getval(g_ceph_context, cmdmap, "poolid", poolid);
1098           r = pending_mdsmap.remove_data_pool(poolid);
1099           if (r == -ENOENT)
1100     	r = 0;
1101           if (r == 0)
1102     	ss << "removed data pool " << poolid << " from mdsmap";


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



