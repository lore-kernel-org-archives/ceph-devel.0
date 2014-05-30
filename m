From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Fri, 30 May 2014 06:54:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405300654040.9065@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-187275292-1401458090=:9065"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44282 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbaE3Nyv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 May 2014 09:54:51 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 885F680452
	for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 06:54:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4E5A880452
	for <ceph-devel@vger.kernel.org>; Fri, 30 May 2014 06:54:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-187275292-1401458090=:9065
Content-Type: TEXT/PLAIN; charset=US-ASCII

I just upgraded the coverity build code because the version I had was too 
old.  These are either accumulated since it last ran (not very long I 
thought?) or new errors that the new version is detecting.

sage
--557981400-187275292-1401458090=:9065
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1405300654041.9065@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id EB17E80452
	for <sage@cobra.newdream.net>; Fri, 30 May 2014 06:49:27 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id E7A541209E7; Fri, 30 May 2014 06:49:27 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdcbdj.dreamhost.com
	[208.97.132.139])
	by destro.newdream.net (Postfix) with ESMTP id DF3B61209DE
	for <sage@newdream.net>; Fri, 30 May 2014 06:49:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id D6FA3FD7904
	for <sage@newdream.net>; Fri, 30 May 2014 06:49:27 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.17])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id Kq9GBGEVCy75 for <sage@newdream.net>;
	Fri, 30 May 2014 06:49:27 -0700 (PDT)
Received: from scanrelay.coverity.com (scanrelay.coverity.com [209.249.196.67])
	by godfather.dreamhost.com (Postfix) with ESMTP id 6A5731B00A3
	for <sage@newdream.net>; Fri, 30 May 2014 06:49:26 -0700 (PDT)
Received: from localhost.localdomain ([208.69.177.215]) by
	scanrelay.coverity.com with Microsoft SMTPSVC(7.5.7601.17514);
	Fri, 30 May 2014 06:51:02 -0700
Date: Fri, 30 May 2014 06:49:25 -0700
From: scan-admin@coverity.com
Message-ID: <53888c65bf97f_37a8f2f3144729e@209.249.196.67.mail>
Subject: New Defects reported by Coverity Scan for ceph
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2014 13:51:02.0087 (UTC)
	FILETIME=[319E2D70:01CF7C0E]
To: undisclosed-recipients:;
X-Spambayes-Classification: ham; 0.00



Hi,


Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

Defect(s) Reported-by: Coverity Scan
Showing 20 of 227 defect(s)


** CID 716871:  Unchecked return value  (CHECKED_RETURN)
/test/multi_stress_watch.cc: 151 in main()

** CID 717110:  Resource leak  (RESOURCE_LEAK)
/test/system/rados_list_parallel.cc: 174 in RadosAddObjectsR::run()()

** CID 717112:  Resource leak  (RESOURCE_LEAK)
/test/system/rados_list_parallel.cc: 93 in RadosDeleteObjectsR::run()()

** CID 717116:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_delete_objs.cc: 60 in StRadosDeleteObjs::run()()

** CID 739605:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_create_pool.cc: 96 in StRadosCreatePool::run()()

** CID 966617:  Resource leak  (RESOURCE_LEAK)
/test/libcephfs/readdir_r_cb.cc: 61 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 60 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 57 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 56 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 55 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 54 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 51 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 50 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 49 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 46 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 45 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 44 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 41 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 40 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 36 in LibCephFS_ReaddirRCB_Test::TestBody()()
/test/libcephfs/readdir_r_cb.cc: 30 in LibCephFS_ReaddirRCB_Test::TestBody()()

** CID 1054844:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 153 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 155 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 156 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 157 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 177 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 179 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 180 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 181 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 166 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 170 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 171 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 172 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 187 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 192 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 197 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 202 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 204 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 205 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 206 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 212 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 217 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 222 in cls_rgw_test_version_inc_cond_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 227 in cls_rgw_test_version_inc_cond_Test::TestBody()()

** CID 1054845:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 51 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 53 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 54 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 55 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 61 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 65 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 66 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 67 in cls_rgw_test_version_inc_read_Test::TestBody()()

** CID 1054846:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 76 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 77 in cls_rgw_test_version_inc_read_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 78 in cls_rgw_test_version_inc_read_Test::TestBody()()

** CID 1054847:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 259 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 261 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 262 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 263 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 271 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 276 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 281 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 286 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 293 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 295 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 296 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 297 in cls_rgw_test_version_inc_check_Test::TestBody()()

** CID 1054848:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 271 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 276 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 281 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 286 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 293 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 295 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 296 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 297 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 305 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 310 in cls_rgw_test_version_inc_check_Test::TestBody()()
/test/cls_version/test_cls_version.cc: 315 in cls_rgw_test_version_inc_check_Test::TestBody()()

** CID 1090104:  Operands don't affect result  (CONSTANT_EXPRESSION_RESULT)
/test/librbd/fsx.c: 840 in save_buffer()

** CID 1128383:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
/mount/mount.ceph.c: 179 in parse_options()

** CID 1128384:  Ignoring number of bytes read  (CHECKED_RETURN)
/arch/neon.c: 23 in get_auxval()

** CID 1128390:  Copy-paste error  (COPY_PASTE_ERROR)
/client/SyntheticClient.cc: 3075 in SyntheticClient::foo()()

** CID 1128391:  Logically dead code  (DEADCODE)
/rgw/rgw_rados.cc: 4258 in RGWRados::prepare_get_obj(void *, rgw_obj &, long *, long *, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> *, const long *, const long *, long *, const char *, const char *, unsigned long *, unsigned long *, RGWObjVersionTracker *, void **, rgw_err *)()

** CID 1128392:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/mds/MDS.cc: 2119 in MDS::_dispatch(Message *)()

** CID 1128395:  Use after close  (USE_AFTER_FREE)
/os/FileJournal.cc: 387 in FileJournal::create()()

** CID 1128396:  Use after free  (USE_AFTER_FREE)
/os/FileJournal.cc: 347 in FileJournal::check()()
/os/FileJournal.cc: 332 in FileJournal::check()()

** CID 1128397:  Use after close  (USE_AFTER_FREE)
/os/FileJournal.cc: 464 in FileJournal::open(unsigned long)()


________________________________________________________________________________________________________
*** CID 716871:  Unchecked return value  (CHECKED_RETURN)
/test/multi_stress_watch.cc: 151 in main()
145       }
146       ret = cluster.conf_parse_env(NULL);
147       if (ret) {
148         std::cerr << "Error " << ret << " in cluster.conf_read_env" << std::endl;
149         return ret;
150       }
>>>     CID 716871:  Unchecked return value  (CHECKED_RETURN)
>>>     Calling "connect" without checking return value (as is done elsewhere 13 out of 15 times).
151       cluster.connect();
152     
153       if (type == "rep")
154         test_replicated(cluster, pool_name, obj_name);
155       else if (type == "ec")
156         test_erasure(cluster, pool_name, obj_name);
157     
158       sem_destroy(&sem);
159       return 0;

________________________________________________________________________________________________________
*** CID 717110:  Resource leak  (RESOURCE_LEAK)
/test/system/rados_list_parallel.cc: 174 in RadosAddObjectsR::run()()
168     	break;
169           int r = rand() % to_add.size();
170           std::map <int, std::string>::iterator d = to_add.begin();
171           for (int i = 0; i < r; ++i)
172     	++d;
173           if (d == to_add.end()) {
>>>     CID 717110:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
174     	return -EDOM;
175           }
176           std::string oid(d->second);
177           to_add.erase(d);
178     
179           std::string buf(StRadosCreatePool::get_random_buf(256));

________________________________________________________________________________________________________
*** CID 717112:  Resource leak  (RESOURCE_LEAK)
/test/system/rados_list_parallel.cc: 93 in RadosDeleteObjectsR::run()()
87     	break;
88           int r = rand() % to_delete.size();
89           std::map <int, std::string>::iterator d = to_delete.begin();
90           for (int i = 0; i < r; ++i)
91     	++d;
92           if (d == to_delete.end()) {
>>>     CID 717112:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
93     	return -EDOM;
94           }
95           std::string oid(d->second);
96           to_delete.erase(d);
97           int ret = rados_remove(io_ctx, oid.c_str());
98           if (ret != 0) {

________________________________________________________________________________________________________
*** CID 717116:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_delete_objs.cc: 60 in StRadosDeleteObjs::run()()
54       rados_pool_create(cl, m_pool_name.c_str());
55       RETURN1_IF_NONZERO(rados_ioctx_create(cl, m_pool_name.c_str(), &io_ctx));
56     
57       for (int i = 0; i < m_num_objs; ++i) {
58         char oid[128];
59         snprintf(oid, sizeof(oid), "%d%s", i, m_suffix.c_str());
>>>     CID 717116:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
60         RETURN1_IF_NONZERO(rados_remove(io_ctx, oid));
61         if (((i % 25) == 0) || (i == m_num_objs - 1)) {
62           printf("%s: deleted object %d...\n", get_id_str(), i);
63         }
64       }
65     

________________________________________________________________________________________________________
*** CID 739605:  Resource leak  (RESOURCE_LEAK)
/test/system/st_rados_create_pool.cc: 96 in StRadosCreatePool::run()()
90         char oid[128];
91         snprintf(oid, sizeof(oid), "%d%s", i, m_suffix.c_str());
92         std::string buf(get_random_buf(256));
93         int ret = rados_write(io_ctx, oid, buf.c_str(), buf.size(), 0);
94         if (ret != 0) {
95           printf("%s: rados_write error %d\n", get_id_str(), ret);
>>>     CID 739605:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "io_ctx" going out of scope leaks the storage it points to.
96           return ret;
97         }
98         if (((i % 25) == 0) || (i == m_num_objects - 1)) {
99           printf("%s: created object %d...\n", get_id_str(), i);
100         }
101       }

________________________________________________________________________________________________________
*** CID 966617:  Resource leak  (RESOURCE_LEAK)
/test/libcephfs/readdir_r_cb.cc: 61 in LibCephFS_ReaddirRCB_Test::TestBody()()
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 60 in LibCephFS_ReaddirRCB_Test::TestBody()()
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 57 in LibCephFS_ReaddirRCB_Test::TestBody()()
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 56 in LibCephFS_ReaddirRCB_Test::TestBody()()
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 55 in LibCephFS_ReaddirRCB_Test::TestBody()()
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 54 in LibCephFS_ReaddirRCB_Test::TestBody()()
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
57       ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
58     
59       // free cmount after finishing testing
60       ASSERT_LE(0, ceph_closedir(cmount, dirp));
61       ASSERT_EQ(0, ceph_unmount(cmount));
62       ASSERT_EQ(0, ceph_release(cmount));
/test/libcephfs/readdir_r_cb.cc: 51 in LibCephFS_ReaddirRCB_Test::TestBody()()
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
56       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
/test/libcephfs/readdir_r_cb.cc: 50 in LibCephFS_ReaddirRCB_Test::TestBody()()
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
55       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
/test/libcephfs/readdir_r_cb.cc: 49 in LibCephFS_ReaddirRCB_Test::TestBody()()
43       // check correctness with one entry
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
52     
53       //check correctness if it needs to split listing
54       ASSERT_LE(0, ceph_closedir(cmount, dirp));
/test/libcephfs/readdir_r_cb.cc: 46 in LibCephFS_ReaddirRCB_Test::TestBody()()
40       ASSERT_LT(0, fd);
41       ASSERT_EQ(0, ceph_close(cmount, fd));
42     
43       // check correctness with one entry
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
51       ASSERT_EQ(-ERANGE, ceph_getdnames(cmount, dirp, buf, 1));
/test/libcephfs/readdir_r_cb.cc: 45 in LibCephFS_ReaddirRCB_Test::TestBody()()
39       int fd = ceph_open(cmount, c_file, O_CREAT, 0777);
40       ASSERT_LT(0, fd);
41       ASSERT_EQ(0, ceph_close(cmount, fd));
42     
43       // check correctness with one entry
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
50       ASSERT_GE(0, ceph_opendir(cmount, c_dir, &dirp));
/test/libcephfs/readdir_r_cb.cc: 44 in LibCephFS_ReaddirRCB_Test::TestBody()()
38       sprintf(c_file, "/readdir_r_cb_tests_%d/foo", getpid());
39       int fd = ceph_open(cmount, c_file, O_CREAT, 0777);
40       ASSERT_LT(0, fd);
41       ASSERT_EQ(0, ceph_close(cmount, fd));
42     
43       // check correctness with one entry
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
47     
48       // check correctness if buffer is too small
49       ASSERT_LE(0, ceph_closedir(cmount, dirp));
/test/libcephfs/readdir_r_cb.cc: 41 in LibCephFS_ReaddirRCB_Test::TestBody()()
35       // . is 2, .. is 3 (for null terminators)
36       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, buflen));
37       char c_file[256];
38       sprintf(c_file, "/readdir_r_cb_tests_%d/foo", getpid());
39       int fd = ceph_open(cmount, c_file, O_CREAT, 0777);
40       ASSERT_LT(0, fd);
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
41       ASSERT_EQ(0, ceph_close(cmount, fd));
42     
43       // check correctness with one entry
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
46       ASSERT_EQ(9, ceph_getdnames(cmount, dirp, buf, buflen)); // ., .., foo
/test/libcephfs/readdir_r_cb.cc: 40 in LibCephFS_ReaddirRCB_Test::TestBody()()
34       char *buf = new char[buflen];
35       // . is 2, .. is 3 (for null terminators)
36       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, buflen));
37       char c_file[256];
38       sprintf(c_file, "/readdir_r_cb_tests_%d/foo", getpid());
39       int fd = ceph_open(cmount, c_file, O_CREAT, 0777);
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
40       ASSERT_LT(0, fd);
41       ASSERT_EQ(0, ceph_close(cmount, fd));
42     
43       // check correctness with one entry
44       ASSERT_LE(0, ceph_closedir(cmount, dirp));
45       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
/test/libcephfs/readdir_r_cb.cc: 36 in LibCephFS_ReaddirRCB_Test::TestBody()()
30       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
31     
32       // dir is empty, check that it only contains . and ..
33       int buflen = 100;
34       char *buf = new char[buflen];
35       // . is 2, .. is 3 (for null terminators)
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
36       ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, buflen));
37       char c_file[256];
38       sprintf(c_file, "/readdir_r_cb_tests_%d/foo", getpid());
39       int fd = ceph_open(cmount, c_file, O_CREAT, 0777);
40       ASSERT_LT(0, fd);
41       ASSERT_EQ(0, ceph_close(cmount, fd));
/test/libcephfs/readdir_r_cb.cc: 30 in LibCephFS_ReaddirRCB_Test::TestBody()()
24       ASSERT_EQ(0, ceph_mount(cmount, "/"));
25     
26       char c_dir[256];
27       sprintf(c_dir, "/readdir_r_cb_tests_%d", getpid());
28       struct ceph_dir_result *dirp;
29       ASSERT_EQ(0, ceph_mkdirs(cmount, c_dir, 0777));
>>>     CID 966617:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "cmount" going out of scope leaks the storage it points to.
30       ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
31     
32       // dir is empty, check that it only contains . and ..
33       int buflen = 100;
34       char *buf = new char[buflen];
35       // . is 2, .. is 3 (for null terminators)

________________________________________________________________________________________________________
*** CID 1054844:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 153 in cls_rgw_test_version_inc_cond_Test::TestBody()()
147       ASSERT_EQ(0, (long long)ver.ver);
148       ASSERT_EQ(0, (int)ver.tag.size());
149       
150       /* inc version */
151       librados::ObjectWriteOperation *op = new_op();
152       cls_version_inc(*op);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
153       ASSERT_EQ(0, ioctx.operate(oid, op));
154     
155       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
156       ASSERT_GT((long long)ver.ver, 0);
157       ASSERT_NE(0, (int)ver.tag.size());
158     
/test/cls_version/test_cls_version.cc: 155 in cls_rgw_test_version_inc_cond_Test::TestBody()()
149       
150       /* inc version */
151       librados::ObjectWriteOperation *op = new_op();
152       cls_version_inc(*op);
153       ASSERT_EQ(0, ioctx.operate(oid, op));
154     
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
155       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
156       ASSERT_GT((long long)ver.ver, 0);
157       ASSERT_NE(0, (int)ver.tag.size());
158     
159       obj_version cond_ver = ver;
160     
/test/cls_version/test_cls_version.cc: 156 in cls_rgw_test_version_inc_cond_Test::TestBody()()
150       /* inc version */
151       librados::ObjectWriteOperation *op = new_op();
152       cls_version_inc(*op);
153       ASSERT_EQ(0, ioctx.operate(oid, op));
154     
155       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
156       ASSERT_GT((long long)ver.ver, 0);
157       ASSERT_NE(0, (int)ver.tag.size());
158     
159       obj_version cond_ver = ver;
160     
161     
/test/cls_version/test_cls_version.cc: 157 in cls_rgw_test_version_inc_cond_Test::TestBody()()
151       librados::ObjectWriteOperation *op = new_op();
152       cls_version_inc(*op);
153       ASSERT_EQ(0, ioctx.operate(oid, op));
154     
155       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
156       ASSERT_GT((long long)ver.ver, 0);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
157       ASSERT_NE(0, (int)ver.tag.size());
158     
159       obj_version cond_ver = ver;
160     
161     
162       /* inc version again! */
/test/cls_version/test_cls_version.cc: 177 in cls_rgw_test_version_inc_cond_Test::TestBody()()
171       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
172       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
173     
174     
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
177       ASSERT_EQ(0, ioctx.operate(oid, op));
178     
179       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
180       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
181       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
182     
/test/cls_version/test_cls_version.cc: 179 in cls_rgw_test_version_inc_cond_Test::TestBody()()
173     
174     
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
177       ASSERT_EQ(0, ioctx.operate(oid, op));
178     
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
179       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
180       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
181       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
182     
183       /* a bunch of conditions that should fail */
184       delete op;
/test/cls_version/test_cls_version.cc: 180 in cls_rgw_test_version_inc_cond_Test::TestBody()()
174     
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
177       ASSERT_EQ(0, ioctx.operate(oid, op));
178     
179       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
180       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
181       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
182     
183       /* a bunch of conditions that should fail */
184       delete op;
185       op = new_op();
/test/cls_version/test_cls_version.cc: 181 in cls_rgw_test_version_inc_cond_Test::TestBody()()
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
177       ASSERT_EQ(0, ioctx.operate(oid, op));
178     
179       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
180       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
181       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
182     
183       /* a bunch of conditions that should fail */
184       delete op;
185       op = new_op();
186       cls_version_inc(*op, cond_ver, VER_COND_EQ);
/test/cls_version/test_cls_version.cc: 166 in cls_rgw_test_version_inc_cond_Test::TestBody()()
160     
161     
162       /* inc version again! */
163       delete op;
164       op = new_op();
165       cls_version_inc(*op);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
166       ASSERT_EQ(0, ioctx.operate(oid, op));
167     
168       obj_version ver2;
169     
170       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
171       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
/test/cls_version/test_cls_version.cc: 170 in cls_rgw_test_version_inc_cond_Test::TestBody()()
164       op = new_op();
165       cls_version_inc(*op);
166       ASSERT_EQ(0, ioctx.operate(oid, op));
167     
168       obj_version ver2;
169     
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
170       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
171       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
172       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
173     
174     
175       /* now check various condition tests */
/test/cls_version/test_cls_version.cc: 171 in cls_rgw_test_version_inc_cond_Test::TestBody()()
165       cls_version_inc(*op);
166       ASSERT_EQ(0, ioctx.operate(oid, op));
167     
168       obj_version ver2;
169     
170       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
171       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
172       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
173     
174     
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
/test/cls_version/test_cls_version.cc: 172 in cls_rgw_test_version_inc_cond_Test::TestBody()()
166       ASSERT_EQ(0, ioctx.operate(oid, op));
167     
168       obj_version ver2;
169     
170       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
171       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
172       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
173     
174     
175       /* now check various condition tests */
176       cls_version_inc(*op, cond_ver, VER_COND_NONE);
177       ASSERT_EQ(0, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 187 in cls_rgw_test_version_inc_cond_Test::TestBody()()
181       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
182     
183       /* a bunch of conditions that should fail */
184       delete op;
185       op = new_op();
186       cls_version_inc(*op, cond_ver, VER_COND_EQ);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
187       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
188     
189       delete op;
190       op = new_op();
191       cls_version_inc(*op, cond_ver, VER_COND_LT);
192       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 192 in cls_rgw_test_version_inc_cond_Test::TestBody()()
186       cls_version_inc(*op, cond_ver, VER_COND_EQ);
187       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
188     
189       delete op;
190       op = new_op();
191       cls_version_inc(*op, cond_ver, VER_COND_LT);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
192       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
193     
194       delete op;
195       op = new_op();
196       cls_version_inc(*op, cond_ver, VER_COND_LE);
197       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 197 in cls_rgw_test_version_inc_cond_Test::TestBody()()
191       cls_version_inc(*op, cond_ver, VER_COND_LT);
192       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
193     
194       delete op;
195       op = new_op();
196       cls_version_inc(*op, cond_ver, VER_COND_LE);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
197       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
198     
199       delete op;
200       op = new_op();
201       cls_version_inc(*op, cond_ver, VER_COND_TAG_NE);
202       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 202 in cls_rgw_test_version_inc_cond_Test::TestBody()()
196       cls_version_inc(*op, cond_ver, VER_COND_LE);
197       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
198     
199       delete op;
200       op = new_op();
201       cls_version_inc(*op, cond_ver, VER_COND_TAG_NE);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
202       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
203     
204       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
205       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
206       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
207     
/test/cls_version/test_cls_version.cc: 204 in cls_rgw_test_version_inc_cond_Test::TestBody()()
198     
199       delete op;
200       op = new_op();
201       cls_version_inc(*op, cond_ver, VER_COND_TAG_NE);
202       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
203     
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
204       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
205       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
206       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
207     
208       /* a bunch of conditions that should succeed */
209       delete op;
/test/cls_version/test_cls_version.cc: 205 in cls_rgw_test_version_inc_cond_Test::TestBody()()
199       delete op;
200       op = new_op();
201       cls_version_inc(*op, cond_ver, VER_COND_TAG_NE);
202       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
203     
204       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
205       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
206       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
207     
208       /* a bunch of conditions that should succeed */
209       delete op;
210       op = new_op();
/test/cls_version/test_cls_version.cc: 206 in cls_rgw_test_version_inc_cond_Test::TestBody()()
200       op = new_op();
201       cls_version_inc(*op, cond_ver, VER_COND_TAG_NE);
202       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, op));
203     
204       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
205       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
206       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
207     
208       /* a bunch of conditions that should succeed */
209       delete op;
210       op = new_op();
211       cls_version_inc(*op, ver2, VER_COND_EQ);
/test/cls_version/test_cls_version.cc: 212 in cls_rgw_test_version_inc_cond_Test::TestBody()()
206       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
207     
208       /* a bunch of conditions that should succeed */
209       delete op;
210       op = new_op();
211       cls_version_inc(*op, ver2, VER_COND_EQ);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
212       ASSERT_EQ(0, ioctx.operate(oid, op));
213     
214       delete op;
215       op = new_op();
216       cls_version_inc(*op, cond_ver, VER_COND_GT);
217       ASSERT_EQ(0, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 217 in cls_rgw_test_version_inc_cond_Test::TestBody()()
211       cls_version_inc(*op, ver2, VER_COND_EQ);
212       ASSERT_EQ(0, ioctx.operate(oid, op));
213     
214       delete op;
215       op = new_op();
216       cls_version_inc(*op, cond_ver, VER_COND_GT);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
217       ASSERT_EQ(0, ioctx.operate(oid, op));
218     
219       delete op;
220       op = new_op();
221       cls_version_inc(*op, cond_ver, VER_COND_GE);
222       ASSERT_EQ(0, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 222 in cls_rgw_test_version_inc_cond_Test::TestBody()()
216       cls_version_inc(*op, cond_ver, VER_COND_GT);
217       ASSERT_EQ(0, ioctx.operate(oid, op));
218     
219       delete op;
220       op = new_op();
221       cls_version_inc(*op, cond_ver, VER_COND_GE);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
222       ASSERT_EQ(0, ioctx.operate(oid, op));
223     
224       delete op;
225       op = new_op();
226       cls_version_inc(*op, cond_ver, VER_COND_TAG_EQ);
227       ASSERT_EQ(0, ioctx.operate(oid, op));
/test/cls_version/test_cls_version.cc: 227 in cls_rgw_test_version_inc_cond_Test::TestBody()()
221       cls_version_inc(*op, cond_ver, VER_COND_GE);
222       ASSERT_EQ(0, ioctx.operate(oid, op));
223     
224       delete op;
225       op = new_op();
226       cls_version_inc(*op, cond_ver, VER_COND_TAG_EQ);
>>>     CID 1054844:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
227       ASSERT_EQ(0, ioctx.operate(oid, op));
228     
229       delete op;
230     }
231     
232     TEST(cls_rgw, test_version_inc_check)

________________________________________________________________________________________________________
*** CID 1054845:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 51 in cls_rgw_test_version_inc_read_Test::TestBody()()
45       ASSERT_EQ(0, (int)ver.tag.size());
46       
47     
48       /* inc version */
49       librados::ObjectWriteOperation *op = new_op();
50       cls_version_inc(*op);
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
51       ASSERT_EQ(0, ioctx.operate(oid, op));
52     
53       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
54       ASSERT_GT((long long)ver.ver, 0);
55       ASSERT_NE(0, (int)ver.tag.size());
56     
/test/cls_version/test_cls_version.cc: 53 in cls_rgw_test_version_inc_read_Test::TestBody()()
47     
48       /* inc version */
49       librados::ObjectWriteOperation *op = new_op();
50       cls_version_inc(*op);
51       ASSERT_EQ(0, ioctx.operate(oid, op));
52     
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
53       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
54       ASSERT_GT((long long)ver.ver, 0);
55       ASSERT_NE(0, (int)ver.tag.size());
56     
57       /* inc version again! */
58       delete op;
/test/cls_version/test_cls_version.cc: 54 in cls_rgw_test_version_inc_read_Test::TestBody()()
48       /* inc version */
49       librados::ObjectWriteOperation *op = new_op();
50       cls_version_inc(*op);
51       ASSERT_EQ(0, ioctx.operate(oid, op));
52     
53       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
54       ASSERT_GT((long long)ver.ver, 0);
55       ASSERT_NE(0, (int)ver.tag.size());
56     
57       /* inc version again! */
58       delete op;
59       op = new_op();
/test/cls_version/test_cls_version.cc: 55 in cls_rgw_test_version_inc_read_Test::TestBody()()
49       librados::ObjectWriteOperation *op = new_op();
50       cls_version_inc(*op);
51       ASSERT_EQ(0, ioctx.operate(oid, op));
52     
53       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
54       ASSERT_GT((long long)ver.ver, 0);
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
55       ASSERT_NE(0, (int)ver.tag.size());
56     
57       /* inc version again! */
58       delete op;
59       op = new_op();
60       cls_version_inc(*op);
/test/cls_version/test_cls_version.cc: 61 in cls_rgw_test_version_inc_read_Test::TestBody()()
55       ASSERT_NE(0, (int)ver.tag.size());
56     
57       /* inc version again! */
58       delete op;
59       op = new_op();
60       cls_version_inc(*op);
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
61       ASSERT_EQ(0, ioctx.operate(oid, op));
62     
63       obj_version ver2;
64     
65       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
66       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
/test/cls_version/test_cls_version.cc: 65 in cls_rgw_test_version_inc_read_Test::TestBody()()
59       op = new_op();
60       cls_version_inc(*op);
61       ASSERT_EQ(0, ioctx.operate(oid, op));
62     
63       obj_version ver2;
64     
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
65       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
66       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
67       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
68     
69       delete op;
70     
/test/cls_version/test_cls_version.cc: 66 in cls_rgw_test_version_inc_read_Test::TestBody()()
60       cls_version_inc(*op);
61       ASSERT_EQ(0, ioctx.operate(oid, op));
62     
63       obj_version ver2;
64     
65       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
66       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
67       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
68     
69       delete op;
70     
71       obj_version ver3;
/test/cls_version/test_cls_version.cc: 67 in cls_rgw_test_version_inc_read_Test::TestBody()()
61       ASSERT_EQ(0, ioctx.operate(oid, op));
62     
63       obj_version ver2;
64     
65       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
66       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054845:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
67       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
68     
69       delete op;
70     
71       obj_version ver3;
72     

________________________________________________________________________________________________________
*** CID 1054846:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 76 in cls_rgw_test_version_inc_read_Test::TestBody()()
70     
71       obj_version ver3;
72     
73       librados::ObjectReadOperation *rop = new_rop();
74       cls_version_read(*rop, &ver3);
75       bufferlist outbl;
>>>     CID 1054846:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
76       ASSERT_EQ(0, ioctx.operate(oid, rop, &outbl));
77       ASSERT_EQ(ver2.ver, ver3.ver);
78       ASSERT_EQ(1, (long long)ver2.compare(&ver3));
79     
80       delete rop;
81     }
/test/cls_version/test_cls_version.cc: 77 in cls_rgw_test_version_inc_read_Test::TestBody()()
71       obj_version ver3;
72     
73       librados::ObjectReadOperation *rop = new_rop();
74       cls_version_read(*rop, &ver3);
75       bufferlist outbl;
76       ASSERT_EQ(0, ioctx.operate(oid, rop, &outbl));
>>>     CID 1054846:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
77       ASSERT_EQ(ver2.ver, ver3.ver);
78       ASSERT_EQ(1, (long long)ver2.compare(&ver3));
79     
80       delete rop;
81     }
82     
/test/cls_version/test_cls_version.cc: 78 in cls_rgw_test_version_inc_read_Test::TestBody()()
72     
73       librados::ObjectReadOperation *rop = new_rop();
74       cls_version_read(*rop, &ver3);
75       bufferlist outbl;
76       ASSERT_EQ(0, ioctx.operate(oid, rop, &outbl));
77       ASSERT_EQ(ver2.ver, ver3.ver);
>>>     CID 1054846:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
78       ASSERT_EQ(1, (long long)ver2.compare(&ver3));
79     
80       delete rop;
81     }
82     
83     

________________________________________________________________________________________________________
*** CID 1054847:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 259 in cls_rgw_test_version_inc_check_Test::TestBody()()
253       ASSERT_EQ(0, (long long)ver.ver);
254       ASSERT_EQ(0, (int)ver.tag.size());
255       
256       /* inc version */
257       librados::ObjectWriteOperation *op = new_op();
258       cls_version_inc(*op);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
259       ASSERT_EQ(0, ioctx.operate(oid, op));
260     
261       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
262       ASSERT_GT((long long)ver.ver, 0);
263       ASSERT_NE(0, (int)ver.tag.size());
264     
/test/cls_version/test_cls_version.cc: 261 in cls_rgw_test_version_inc_check_Test::TestBody()()
255       
256       /* inc version */
257       librados::ObjectWriteOperation *op = new_op();
258       cls_version_inc(*op);
259       ASSERT_EQ(0, ioctx.operate(oid, op));
260     
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
261       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
262       ASSERT_GT((long long)ver.ver, 0);
263       ASSERT_NE(0, (int)ver.tag.size());
264     
265       obj_version cond_ver = ver;
266     
/test/cls_version/test_cls_version.cc: 262 in cls_rgw_test_version_inc_check_Test::TestBody()()
256       /* inc version */
257       librados::ObjectWriteOperation *op = new_op();
258       cls_version_inc(*op);
259       ASSERT_EQ(0, ioctx.operate(oid, op));
260     
261       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
262       ASSERT_GT((long long)ver.ver, 0);
263       ASSERT_NE(0, (int)ver.tag.size());
264     
265       obj_version cond_ver = ver;
266     
267       /* a bunch of conditions that should succeed */
/test/cls_version/test_cls_version.cc: 263 in cls_rgw_test_version_inc_check_Test::TestBody()()
257       librados::ObjectWriteOperation *op = new_op();
258       cls_version_inc(*op);
259       ASSERT_EQ(0, ioctx.operate(oid, op));
260     
261       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver));
262       ASSERT_GT((long long)ver.ver, 0);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
263       ASSERT_NE(0, (int)ver.tag.size());
264     
265       obj_version cond_ver = ver;
266     
267       /* a bunch of conditions that should succeed */
268       librados::ObjectReadOperation *rop = new_rop();
/test/cls_version/test_cls_version.cc: 271 in cls_rgw_test_version_inc_check_Test::TestBody()()
265       obj_version cond_ver = ver;
266     
267       /* a bunch of conditions that should succeed */
268       librados::ObjectReadOperation *rop = new_rop();
269       cls_version_check(*rop, cond_ver, VER_COND_EQ);
270       bufferlist bl;
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
271       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
272     
273       delete rop;
274       rop = new_rop();
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 276 in cls_rgw_test_version_inc_check_Test::TestBody()()
270       bufferlist bl;
271       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
272     
273       delete rop;
274       rop = new_rop();
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
277     
278       delete rop;
279       rop = new_rop();
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 281 in cls_rgw_test_version_inc_check_Test::TestBody()()
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
277     
278       delete rop;
279       rop = new_rop();
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
282     
283       delete rop;
284       rop = new_rop();
285       cls_version_check(*rop, cond_ver, VER_COND_TAG_EQ);
286       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 286 in cls_rgw_test_version_inc_check_Test::TestBody()()
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
282     
283       delete rop;
284       rop = new_rop();
285       cls_version_check(*rop, cond_ver, VER_COND_TAG_EQ);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
286       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
287     
288       obj_version ver2;
289     
290       delete op;
291       op = new_op();
/test/cls_version/test_cls_version.cc: 293 in cls_rgw_test_version_inc_check_Test::TestBody()()
287     
288       obj_version ver2;
289     
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
/test/cls_version/test_cls_version.cc: 295 in cls_rgw_test_version_inc_check_Test::TestBody()()
289     
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
/test/cls_version/test_cls_version.cc: 296 in cls_rgw_test_version_inc_check_Test::TestBody()()
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
301       /* a bunch of conditions that should fail */
/test/cls_version/test_cls_version.cc: 297 in cls_rgw_test_version_inc_check_Test::TestBody()()
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054847:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "op" going out of scope leaks the storage it points to.
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
301       /* a bunch of conditions that should fail */
302       delete rop;

________________________________________________________________________________________________________
*** CID 1054848:  Resource leak  (RESOURCE_LEAK)
/test/cls_version/test_cls_version.cc: 271 in cls_rgw_test_version_inc_check_Test::TestBody()()
265       obj_version cond_ver = ver;
266     
267       /* a bunch of conditions that should succeed */
268       librados::ObjectReadOperation *rop = new_rop();
269       cls_version_check(*rop, cond_ver, VER_COND_EQ);
270       bufferlist bl;
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
271       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
272     
273       delete rop;
274       rop = new_rop();
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 276 in cls_rgw_test_version_inc_check_Test::TestBody()()
270       bufferlist bl;
271       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
272     
273       delete rop;
274       rop = new_rop();
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
277     
278       delete rop;
279       rop = new_rop();
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 281 in cls_rgw_test_version_inc_check_Test::TestBody()()
275       cls_version_check(*rop, cond_ver, VER_COND_GE);
276       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
277     
278       delete rop;
279       rop = new_rop();
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
282     
283       delete rop;
284       rop = new_rop();
285       cls_version_check(*rop, cond_ver, VER_COND_TAG_EQ);
286       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 286 in cls_rgw_test_version_inc_check_Test::TestBody()()
280       cls_version_check(*rop, cond_ver, VER_COND_LE);
281       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
282     
283       delete rop;
284       rop = new_rop();
285       cls_version_check(*rop, cond_ver, VER_COND_TAG_EQ);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
286       ASSERT_EQ(0, ioctx.operate(oid, rop, &bl));
287     
288       obj_version ver2;
289     
290       delete op;
291       op = new_op();
/test/cls_version/test_cls_version.cc: 293 in cls_rgw_test_version_inc_check_Test::TestBody()()
287     
288       obj_version ver2;
289     
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
/test/cls_version/test_cls_version.cc: 295 in cls_rgw_test_version_inc_check_Test::TestBody()()
289     
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
/test/cls_version/test_cls_version.cc: 296 in cls_rgw_test_version_inc_check_Test::TestBody()()
290       delete op;
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
301       /* a bunch of conditions that should fail */
/test/cls_version/test_cls_version.cc: 297 in cls_rgw_test_version_inc_check_Test::TestBody()()
291       op = new_op();
292       cls_version_inc(*op);
293       ASSERT_EQ(0, ioctx.operate(oid, op));
294     
295       ASSERT_EQ(0, cls_version_read(ioctx, oid, &ver2));
296       ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
297       ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
298     
299       delete op;
300     
301       /* a bunch of conditions that should fail */
302       delete rop;
/test/cls_version/test_cls_version.cc: 305 in cls_rgw_test_version_inc_check_Test::TestBody()()
299       delete op;
300     
301       /* a bunch of conditions that should fail */
302       delete rop;
303       rop = new_rop();
304       cls_version_check(*rop, ver, VER_COND_LT);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
305       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
306     
307       delete rop;
308       rop = new_rop();
309       cls_version_check(*rop, cond_ver, VER_COND_LE);
310       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
/test/cls_version/test_cls_version.cc: 310 in cls_rgw_test_version_inc_check_Test::TestBody()()
304       cls_version_check(*rop, ver, VER_COND_LT);
305       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
306     
307       delete rop;
308       rop = new_rop();
309       cls_version_check(*rop, cond_ver, VER_COND_LE);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
310       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
311     
312       delete rop;
313       rop = new_rop();
314       cls_version_check(*rop, cond_ver, VER_COND_TAG_NE);
315       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
316     
317       delete rop;
/test/cls_version/test_cls_version.cc: 315 in cls_rgw_test_version_inc_check_Test::TestBody()()
309       cls_version_check(*rop, cond_ver, VER_COND_LE);
310       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
311     
312       delete rop;
313       rop = new_rop();
314       cls_version_check(*rop, cond_ver, VER_COND_TAG_NE);
>>>     CID 1054848:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "rop" going out of scope leaks the storage it points to.
315       ASSERT_EQ(-ECANCELED, ioctx.operate(oid, rop, &bl));
316     
317       delete rop;

________________________________________________________________________________________________________
*** CID 1090104:  Operands don't affect result  (CONSTANT_EXPRESSION_RESULT)
/test/librbd/fsx.c: 840 in save_buffer()
834     	off_t ret;
835     	ssize_t byteswritten;
836     
837     	if (fd <= 0 || bufferlength == 0)
838     		return;
839     
>>>     CID 1090104:  Operands don't affect result  (CONSTANT_EXPRESSION_RESULT)
>>>     "bufferlength > 9223372036854775807L" is always false regardless of the values of its operands. This occurs as the logical operand of if.
840     	if (bufferlength > SSIZE_MAX) {
841     		prt("fsx flaw: overflow in save_buffer\n");
842     		exit(67);
843     	}
844     
845     	ret = lseek(fd, (off_t)0, SEEK_SET);

________________________________________________________________________________________________________
*** CID 1128383:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
/mount/mount.ceph.c: 179 in parse_options()
173     
174     			/* secret is only added to kernel options as
175     			   backwards compatilbity, if add_key doesn't
176     			   recognize our keytype; hence, it is skipped
177     			   here and appended to options on add_key
178     			   failure */
>>>     CID 1128383:  Buffer not null terminated  (BUFFER_SIZE_WARNING)
>>>     Calling strncpy with a maximum size argument of 1000 bytes on destination array "secret" of size 1000 bytes might leave the destination string unterminated.
179     			strncpy(secret, value, sizeof(secret));
180     			saw_secret = secret;
181     			skip = 1;
182     		} else if (strncmp(data, "name", 4) == 0) {
183     			if (!value || !*value) {
184     				printf("mount option name requires a value.\n");

________________________________________________________________________________________________________
*** CID 1128384:  Ignoring number of bytes read  (CHECKED_RETURN)
/arch/neon.c: 23 in get_auxval()
17     static unsigned long get_auxval(unsigned long type)
18     {
19     	unsigned long result = 0;
20     	FILE *f = fopen("/proc/self/auxv", "r");
21     	if (f) {
22     		ElfW(auxv_t) entry;
>>>     CID 1128384:  Ignoring number of bytes read  (CHECKED_RETURN)
>>>     "fread(void * restrict, size_t, size_t, FILE * restrict)" returns the number of bytes read, but it is ignored.
23     		while (fread(&entry, sizeof(entry), 1, f)) {
24     			if (entry.a_type == type) {
25     				result = entry.a_un.a_val;
26     				break;
27     			}
28     		}

________________________________________________________________________________________________________
*** CID 1128390:  Copy-paste error  (COPY_PASTE_ERROR)
/client/SyntheticClient.cc: 3075 in SyntheticClient::foo()()
3069           int c = rand() % s;
3070           int d = rand() % s;
3071           int e = rand() % s;
3072           int f = rand() % s;
3073           char src[80];
3074           char dst[80];
>>>     CID 1128390:  Copy-paste error  (COPY_PASTE_ERROR)
>>>     ""syn.0.0/dir.%d/dir.%d/file.%d"" in ""syn.0.0/dir.%d/dir.%d/file.%d"" looks like a copy-paste error.
3075           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
3076           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
3077           client->link(src, dst);
3078         }
3079         srand(0);
3080         for (int i=0; i<100; i++) {

________________________________________________________________________________________________________
*** CID 1128391:  Logically dead code  (DEADCODE)
/rgw/rgw_rados.cc: 4258 in RGWRados::prepare_get_obj(void *, rgw_obj &, long *, long *, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char>>>, std::allocator<std::pair<const std::basic_string<char, std::char_traits<char>, std::allocator<char>>, ceph::buffer::list>>> *, const long *, const long *, long *, const char *, const char *, unsigned long *, unsigned long *, RGWObjVersionTracker *, void **, rgw_err *)()
4252         if (cct->_conf->subsys.should_gather(ceph_subsys_rgw, 20)) {
4253           for (iter = attrs->begin(); iter != attrs->end(); ++iter) {
4254             ldout(cct, 20) << "Read xattr: " << iter->first << dendl;
4255           }
4256         }
4257         if (r < 0)
>>>     CID 1128391:  Logically dead code  (DEADCODE)
>>>     Execution cannot reach this statement "goto done_err;".
4258           goto done_err;
4259       }
4260     
4261       /* Convert all times go GMT to make them compatible */
4262       if (mod_ptr || unmod_ptr) {
4263         ctime = astate->mtime;

________________________________________________________________________________________________________
*** CID 1128392:  Division or modulo by zero  (DIVIDE_BY_ZERO)
/mds/MDS.cc: 2119 in MDS::_dispatch(Message *)()
2113     
2114         list<CDir*> ls;
2115         in->get_dirfrags(ls);
2116         if (ls.empty())
2117           continue;                // must be an open dir.
2118         list<CDir*>::iterator p = ls.begin();
>>>     CID 1128392:  Division or modulo by zero  (DIVIDE_BY_ZERO)
>>>     In expression "rand() % ls.size()", modulo by expression "ls.size()" which may be zero has undefined behavior.
2119         int n = rand() % ls.size();
2120         while (n--)
2121           ++p;
2122         CDir *dir = *p;
2123         if (!dir->get_parent_dir()) continue;    // must be linked.
2124         if (!dir->is_auth()) continue;           // must be auth.

________________________________________________________________________________________________________
*** CID 1128395:  Use after close  (USE_AFTER_FREE)
/os/FileJournal.cc: 387 in FileJournal::create()()
381       // static zeroed buffer for alignment padding
382       delete [] zero_buf;
383       zero_buf = new char[header.alignment];
384       memset(zero_buf, 0, header.alignment);
385     
386       bp = prepare_header();
>>>     CID 1128395:  Use after close  (USE_AFTER_FREE)
>>>     Passing closed handle "this->fd" as an argument to "pwrite".
387       if (TEMP_FAILURE_RETRY(::pwrite(fd, bp.c_str(), bp.length(), 0)) < 0) {
388         ret = errno;
389         derr << "FileJournal::create : create write header error "
390              << cpp_strerror(ret) << dendl;
391         goto close_fd;
392       }

________________________________________________________________________________________________________
*** CID 1128396:  Use after free  (USE_AFTER_FREE)
/os/FileJournal.cc: 347 in FileJournal::check()()
341       }
342     
343       dout(1) << "check: header looks ok" << dendl;
344       ret = 0;
345     
346      done:
>>>     CID 1128396:  Use after free  (USE_AFTER_FREE)
>>>     Calling "close(int)" closes handle "this->fd" which has already been closed.
347       VOID_TEMP_FAILURE_RETRY(::close(fd));
348       fd = -1;
349       return ret;
350     }
351     
352     
/os/FileJournal.cc: 332 in FileJournal::check()()
326       int ret;
327     
328       ret = _open(false, false);
329       if (ret < 0)
330         goto done;
331     
>>>     CID 1128396:  Use after free  (USE_AFTER_FREE)
>>>     Passing closed handle "this->fd" as an argument to "read_header".
332       ret = read_header();
333       if (ret < 0)
334         goto done;
335     
336       if (header.fsid != fsid) {
337         derr << "check: ondisk fsid " << header.fsid << " doesn't match expected " << fsid

________________________________________________________________________________________________________
*** CID 1128397:  Use after close  (USE_AFTER_FREE)
/os/FileJournal.cc: 464 in FileJournal::open(unsigned long)()
458     
459       // assume writeable, unless...
460       read_pos = 0;
461       write_pos = get_top();
462     
463       // read header?
>>>     CID 1128397:  Use after close  (USE_AFTER_FREE)
>>>     Passing closed handle "this->fd" as an argument to "read_header".
464       err = read_header();
465       if (err < 0)
466         return err;
467     
468       // static zeroed buffer for alignment padding
469       delete [] zero_buf;


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py




--557981400-187275292-1401458090=:9065--
