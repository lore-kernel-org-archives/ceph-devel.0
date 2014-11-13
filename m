From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Thu, 13 Nov 2014 06:21:27 -0800
Message-ID: <5464be6723e1a_1150a9733843453@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:63676 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbaKMOVa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 09:21:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.
7 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1251575:  Dereference after null check  (FORWARD_NULL)
/test/librados/c_read_operations.cc: 106 in CReadOpsTest::compare_xattrs(const char *const *, const char *const *, const unsigned long *, unsigned long, void *)()

** CID 1251577:  Resource leak  (RESOURCE_LEAK)
/tools/cephfs/Dumper.cc: 116 in Dumper::dump(const char *)()

** CID 1251576:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1994 in TestLibRBD_LargeCacheRead_Test::TestBody()()

** CID 717084:  Resource leak  (RESOURCE_LEAK)
/tools/cephfs/Dumper.cc: 192 in Dumper::undump(const char *)()
/tools/cephfs/Dumper.cc: 198 in Dumper::undump(const char *)()


________________________________________________________________________________________________________
*** CID 1251575:  Dereference after null check  (FORWARD_NULL)
/test/librados/c_read_operations.cc: 106 in CReadOpsTest::compare_xattrs(const char *const *, const char *const *, const unsigned long *, unsigned long, void *)()
100         size_t val_len = 0;
101         while (i < len) {
102           ASSERT_EQ(0, rados_getxattrs_next(iter, (const char**) &key,
103     					(const char**) &val, &val_len));
104           if (val_len == 0 && key == NULL && val == NULL)
105     	break;
>>>     CID 1251575:  Dereference after null check  (FORWARD_NULL)
>>>     Passing null pointer "key" to "basic_string", which dereferences it.
106           EXPECT_EQ(std::string(keys[i]), std::string(key));
107           EXPECT_EQ(0, memcmp(vals[i], val, val_len));
108           EXPECT_EQ(lens[i], val_len);
109           ++i;
110         }
111         ASSERT_EQ(i, len);

________________________________________________________________________________________________________
*** CID 1251577:  Resource leak  (RESOURCE_LEAK)
/tools/cephfs/Dumper.cc: 116 in Dumper::dump(const char *)()
110     	    (unsigned long long)journaler.last_committed.stream_format,
111     	    (unsigned long long)journaler.last_committed.trimmed_pos, (unsigned long long)journaler.last_committed.trimmed_pos,
112     	    4);
113         r = safe_write(fd, buf, sizeof(buf));
114         if (r) {
115           derr << "Error " << r << " (" << cpp_strerror(r) << ") writing journal file header" << dendl;
>>>     CID 1251577:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
116           return r;
117         }
118     
119         // write the data
120         off64_t seeked = ::lseek64(fd, start, SEEK_SET);
121         if (seeked == (off64_t)-1) {

________________________________________________________________________________________________________
*** CID 1251576:  Resource leak  (RESOURCE_LEAK)
/test/librbd/test_librbd.cc: 1994 in TestLibRBD_LargeCacheRead_Test::TestBody()()
1988     
1989       uint64_t orig_cache_size = g_conf->rbd_cache_size;
1990       g_conf->set_val("rbd_cache_size", "16777216");
1991       BOOST_SCOPE_EXIT( (orig_cache_size) ) {
1992         g_conf->set_val("rbd_cache_size", stringify(orig_cache_size).c_str());
1993       } BOOST_SCOPE_EXIT_END;
>>>     CID 1251576:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "ioctx" going out of scope leaks the storage it points to.
1994       ASSERT_EQ(16777216, g_conf->rbd_cache_size);
1995     
1996       rbd_image_t image;
1997       int order = 0;
1998       const char *name = "testimg";
1999       uint64_t size = g_conf->rbd_cache_size + 1;

________________________________________________________________________________________________________
*** CID 717084:  Resource leak  (RESOURCE_LEAK)
/tools/cephfs/Dumper.cc: 192 in Dumper::undump(const char *)()
186         trimmed_pos = start - (start % g_default_file_layout.fl_object_size);
187       }
188     
189       if (trimmed_pos > start) {
190         derr << std::hex << "Invalid header (trimmed 0x" << trimmed_pos
191           << " > expire 0x" << start << std::dec << dendl;
>>>     CID 717084:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
192         return -EINVAL;
193       }
194     
195       if (start > write_pos) {
196         derr << std::hex << "Invalid header (expire 0x" << start
197           << " > write 0x" << write_pos << std::dec << dendl;
/tools/cephfs/Dumper.cc: 198 in Dumper::undump(const char *)()
192         return -EINVAL;
193       }
194     
195       if (start > write_pos) {
196         derr << std::hex << "Invalid header (expire 0x" << start
197           << " > write 0x" << write_pos << std::dec << dendl;
>>>     CID 717084:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
198         return -EINVAL;
199       }
200     
201       cout << "start " << start <<
202         " len " << len <<
203         " write_pos " << write_pos <<


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



