From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Sun, 14 Dec 2014 06:17:39 -0800
Message-ID: <548d9c03e9841_461ad8932049755@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:56136 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaLNORk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Dec 2014 09:17:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

4 new defect(s) introduced to ceph found with Coverity Scan.


New defect(s) Reported-by: Coverity Scan
Showing 4 of 4 defect(s)


** CID 1258437:  Wrong size argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 956 in TestLibRBD_TestIOPP_Test::TestBody()()

** CID 1258438:  Wrong size argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 955 in TestLibRBD_TestIOPP_Test::TestBody()()

** CID 1258439:  Copy into fixed size buffer  (STRING_OVERFLOW)
/common/blkdev.cc: 60 in get_block_device_base(const char *, char *, unsigned long)()

** CID 1258440:  Time of check time of use  (TOCTOU)
/common/blkdev.cc: 75 in get_block_device_base(const char *, char *, unsigned long)()


________________________________________________________________________________________________________
*** CID 1258437:  Wrong size argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 956 in TestLibRBD_TestIOPP_Test::TestBody()()
950         
951         for (i = 5; i < 10; ++i)
952           ASSERT_PASSED(aio_read_test_data, image, test_data, strlen(test_data) * i, TEST_IO_SIZE);
953     
954         // discard 2nd, 4th sections.
955         ASSERT_PASSED(discard_test_data, image, TEST_IO_SIZE, TEST_IO_SIZE);
>>>     CID 1258437:  Wrong size argument  (SIZEOF_MISMATCH)
>>>     Passing argument "&passed" of type "bool *" and argument "512UL" to function "aio_discard_test_data" is suspicious because "sizeof (bool)" /*1*/ is expected.
956         ASSERT_PASSED(aio_discard_test_data, image, TEST_IO_SIZE*3, TEST_IO_SIZE);
957         
958         ASSERT_PASSED(read_test_data, image, test_data,  0, TEST_IO_SIZE);
959         ASSERT_PASSED(read_test_data, image,  zero_data, TEST_IO_SIZE, TEST_IO_SIZE);
960         ASSERT_PASSED(read_test_data, image, test_data,  TEST_IO_SIZE*2, TEST_IO_SIZE);
961         ASSERT_PASSED(read_test_data, image,  zero_data, TEST_IO_SIZE*3, TEST_IO_SIZE);

________________________________________________________________________________________________________
*** CID 1258438:  Wrong size argument  (SIZEOF_MISMATCH)
/test/librbd/test_librbd.cc: 955 in TestLibRBD_TestIOPP_Test::TestBody()()
949           ASSERT_PASSED(read_test_data, image, test_data, strlen(test_data) * i, TEST_IO_SIZE);
950         
951         for (i = 5; i < 10; ++i)
952           ASSERT_PASSED(aio_read_test_data, image, test_data, strlen(test_data) * i, TEST_IO_SIZE);
953     
954         // discard 2nd, 4th sections.
>>>     CID 1258438:  Wrong size argument  (SIZEOF_MISMATCH)
>>>     Passing argument "&passed" of type "bool *" and argument "512UL" to function "discard_test_data" is suspicious because "sizeof (bool)" /*1*/ is expected.
955         ASSERT_PASSED(discard_test_data, image, TEST_IO_SIZE, TEST_IO_SIZE);
956         ASSERT_PASSED(aio_discard_test_data, image, TEST_IO_SIZE*3, TEST_IO_SIZE);
957         
958         ASSERT_PASSED(read_test_data, image, test_data,  0, TEST_IO_SIZE);
959         ASSERT_PASSED(read_test_data, image,  zero_data, TEST_IO_SIZE, TEST_IO_SIZE);
960         ASSERT_PASSED(read_test_data, image, test_data,  TEST_IO_SIZE*2, TEST_IO_SIZE);

________________________________________________________________________________________________________
*** CID 1258439:  Copy into fixed size buffer  (STRING_OVERFLOW)
/common/blkdev.cc: 60 in get_block_device_base(const char *, char *, unsigned long)()
54       char devname[PATH_MAX], fn[PATH_MAX];
55       char *p;
56     
57       if (strncmp(dev, "/dev/", 5) != 0)
58         return -EINVAL;
59     
>>>     CID 1258439:  Copy into fixed size buffer  (STRING_OVERFLOW)
>>>     You might overrun the 4096 byte fixed-size string "devname" by copying "dev + 5" without checking the length.
60       strcpy(devname, dev + 5);
61       for (p = devname; *p; ++p)
62         if (*p == '/')
63           *p = '!';
64     
65       snprintf(fn, sizeof(fn), "%s/sys/block/%s", sandbox_dir, devname);

________________________________________________________________________________________________________
*** CID 1258440:  Time of check time of use  (TOCTOU)
/common/blkdev.cc: 75 in get_block_device_base(const char *, char *, unsigned long)()
69         }
70         strncpy(out, devname, out_len);
71         return 0;
72       }
73     
74       snprintf(fn, sizeof(fn), "%s/sys/block", sandbox_dir);
>>>     CID 1258440:  Time of check time of use  (TOCTOU)
>>>     Calling function "opendir" that uses "fn" after a check function. This can cause a time-of-check, time-of-use race condition.
75       dir = opendir(fn);
76       if (!dir)
77         return -errno;
78     
79       while (!::readdir_r(dir, reinterpret_cast<struct dirent*>(buf), &de)) {
80         if (!de) {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

