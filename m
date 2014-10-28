From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 28 Oct 2014 06:16:12 -0700
Message-ID: <544f971cf59b_77e15cb3187793@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:50471 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbaJ1NQN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 09:16:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

2 new defect(s) introduced to ceph found with Coverity Scan.
5 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 2 of 2 defect(s)


** CID 1249779:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 56 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 59 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 52 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 55 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 47 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 50 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 51 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 45 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 46 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()

** CID 1249780:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 95 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 97 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 100 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 103 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
/test/libradosstriper/striping.cc: 145 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()


________________________________________________________________________________________________________
*** CID 1249779:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 56 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(object_size, exp_object_size);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
56         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.size", xattrbl));
57         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
58         uint64_t xa_size = strtoll(s_xattr.c_str(), NULL, 10);
59         ASSERT_EQ(xa_size, size);
60         // checking object content from rados point of view
61         // we will go stripe by stripe, read the content of each of them and
/test/libradosstriper/striping.cc: 59 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(object_size, exp_object_size);
56         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.size", xattrbl));
57         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
58         uint64_t xa_size = strtoll(s_xattr.c_str(), NULL, 10);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
59         ASSERT_EQ(xa_size, size);
60         // checking object content from rados point of view
61         // we will go stripe by stripe, read the content of each of them and
62         // check with expectations
63         uint64_t stripe_per_object = object_size / stripe_unit;
64         uint64_t stripe_per_objectset = stripe_per_object * stripe_count;
/test/libradosstriper/striping.cc: 52 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(object_size, exp_object_size);
56         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.size", xattrbl));
57         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
/test/libradosstriper/striping.cc: 55 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
55         ASSERT_EQ(object_size, exp_object_size);
56         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.size", xattrbl));
57         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
58         uint64_t xa_size = strtoll(s_xattr.c_str(), NULL, 10);
59         ASSERT_EQ(xa_size, size);
60         // checking object content from rados point of view
/test/libradosstriper/striping.cc: 47 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
41         char* firstOid = getObjName(soid, 0);
42         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_unit", xattrbl));
43         std::string s_xattr(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
44         uint64_t stripe_unit = strtoll(s_xattr.c_str(), NULL, 10);
45         ASSERT_LT((unsigned)0, stripe_unit);
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
/test/libradosstriper/striping.cc: 50 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
44         uint64_t stripe_unit = strtoll(s_xattr.c_str(), NULL, 10);
45         ASSERT_LT((unsigned)0, stripe_unit);
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(object_size, exp_object_size);
/test/libradosstriper/striping.cc: 51 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
45         ASSERT_LT((unsigned)0, stripe_unit);
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
51         ASSERT_EQ(stripe_count, exp_stripe_count);
52         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.object_size", xattrbl));
53         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
54         uint64_t object_size = strtoll(s_xattr.c_str(), NULL, 10);
55         ASSERT_EQ(object_size, exp_object_size);
56         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.size", xattrbl));
/test/libradosstriper/striping.cc: 45 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
39         // checking first object's rados xattrs
40         bufferlist xattrbl;
41         char* firstOid = getObjName(soid, 0);
42         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_unit", xattrbl));
43         std::string s_xattr(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
44         uint64_t stripe_unit = strtoll(s_xattr.c_str(), NULL, 10);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
45         ASSERT_LT((unsigned)0, stripe_unit);
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
/test/libradosstriper/striping.cc: 46 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
40         bufferlist xattrbl;
41         char* firstOid = getObjName(soid, 0);
42         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_unit", xattrbl));
43         std::string s_xattr(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
44         uint64_t stripe_unit = strtoll(s_xattr.c_str(), NULL, 10);
45         ASSERT_LT((unsigned)0, stripe_unit);
>>>     CID 1249779:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "firstOid" going out of scope leaks the storage it points to.
46         ASSERT_EQ(stripe_unit, exp_stripe_unit);
47         ASSERT_LT(0, ioctx.getxattr(firstOid, "striper.layout.stripe_count", xattrbl));
48         s_xattr = std::string(xattrbl.c_str(), xattrbl.length()); // adds 0 byte at the end
49         uint64_t stripe_count = strtoll(s_xattr.c_str(), NULL, 10);
50         ASSERT_LT(0U, stripe_count);
51         ASSERT_EQ(stripe_count, exp_stripe_count);

________________________________________________________________________________________________________
*** CID 1249780:  Resource leak  (RESOURCE_LEAK)
/test/libradosstriper/striping.cc: 95 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
89           int rc = ioctx.read(oid, stripe_data, len, start);
90           if (actual_size_if_sparse < size and
91               (actual_size_if_sparse+stripe_unit-1)/stripe_unit <= stripe_nb) {
92             // sparse object case : the stripe does not exist, but the rados object may
93             uint64_t object_start = (object_in_set + objectset*stripe_per_objectset) * stripe_unit;
94             if (actual_size_if_sparse <= object_start) {
>>>     CID 1249780:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "oid" going out of scope leaks the storage it points to.
95               ASSERT_EQ(rc, -ENOENT);
96             } else {
97               ASSERT_EQ(rc, 0);
98             }
99           } else {
100             ASSERT_EQ((uint64_t)rc, len);
/test/libradosstriper/striping.cc: 97 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
91               (actual_size_if_sparse+stripe_unit-1)/stripe_unit <= stripe_nb) {
92             // sparse object case : the stripe does not exist, but the rados object may
93             uint64_t object_start = (object_in_set + objectset*stripe_per_objectset) * stripe_unit;
94             if (actual_size_if_sparse <= object_start) {
95               ASSERT_EQ(rc, -ENOENT);
96             } else {
>>>     CID 1249780:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "oid" going out of scope leaks the storage it points to.
97               ASSERT_EQ(rc, 0);
98             }
99           } else {
100             ASSERT_EQ((uint64_t)rc, len);
101             bufferlist original_data;
102             original_data.substr_of(bl, stripe_nb*stripe_unit, len);
/test/libradosstriper/striping.cc: 100 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
94             if (actual_size_if_sparse <= object_start) {
95               ASSERT_EQ(rc, -ENOENT);
96             } else {
97               ASSERT_EQ(rc, 0);
98             }
99           } else {
>>>     CID 1249780:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "oid" going out of scope leaks the storage it points to.
100             ASSERT_EQ((uint64_t)rc, len);
101             bufferlist original_data;
102             original_data.substr_of(bl, stripe_nb*stripe_unit, len);
103             ASSERT_EQ(0, memcmp(original_data.c_str(), stripe_data.c_str(), len));
104           }
105           free(oid);
/test/libradosstriper/striping.cc: 103 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
97               ASSERT_EQ(rc, 0);
98             }
99           } else {
100             ASSERT_EQ((uint64_t)rc, len);
101             bufferlist original_data;
102             original_data.substr_of(bl, stripe_nb*stripe_unit, len);
>>>     CID 1249780:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "oid" going out of scope leaks the storage it points to.
103             ASSERT_EQ(0, memcmp(original_data.c_str(), stripe_data.c_str(), len));
104           }
105           free(oid);
106         }
107         // checking rados object sizes; we go object by object
108         uint64_t nb_full_object_sets = nb_stripes_in_object / stripe_per_objectset;
/test/libradosstriper/striping.cc: 145 in StriperTestRT::checkObjectFromRados(const std::basic_string<char, std::char_traits<char>, std::allocator<char>>&, ceph::buffer::list &, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long)()
139           free(oid);
140         }
141         // check we do not have an extra object behind
142         uint64_t rados_size;
143         time_t mtime;
144         char* oid = getObjName(soid, nb_objects);
>>>     CID 1249780:  Resource leak  (RESOURCE_LEAK)
>>>     Variable "oid" going out of scope leaks the storage it points to.
145         ASSERT_EQ(-ENOENT, ioctx.stat(oid, &rados_size, &mtime));
146         free(oid);
147         free(firstOid);
148       }
149     };
150       


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py



