From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Tue, 20 Jan 2015 17:41:35 -0800
Message-ID: <54bf03cfedbc0_102fd073342267f@scan.coverity.com.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scanrelay.coverity.com ([209.249.196.67]:55966 "EHLO
	scanrelay.coverity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbAUBlg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 20:41:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

3 new defect(s) introduced to ceph found with Coverity Scan.
2 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 3 of 3 defect(s)


** CID 1265561:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()

** CID 1265562:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()

** CID 1265563:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()


________________________________________________________________________________________________________
*** CID 1265561:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()
2056         pc.fail();
2057         if (pd > 2)
2058           unlink(path);
2059       } else
2060         pc.finish();
2061     
>>>     CID 1265561:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
2062       return r;
2063     }
2064     
2065     static int do_copy(librbd::Image &src, librados::IoCtx& dest_pp,
2066     		   const char *destname)
2067     {

________________________________________________________________________________________________________
*** CID 1265562:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()
2056         pc.fail();
2057         if (pd > 2)
2058           unlink(path);
2059       } else
2060         pc.finish();
2061     
>>>     CID 1265562:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "sd" going out of scope leaks the handle.
2062       return r;
2063     }
2064     
2065     static int do_copy(librbd::Image &src, librados::IoCtx& dest_pp,
2066     		   const char *destname)
2067     {

________________________________________________________________________________________________________
*** CID 1265563:  Resource leak  (RESOURCE_LEAK)
/rbd.cc: 2062 in do_merge_diff(const char *, const char *, const char *)()
2056         pc.fail();
2057         if (pd > 2)
2058           unlink(path);
2059       } else
2060         pc.finish();
2061     
>>>     CID 1265563:  Resource leak  (RESOURCE_LEAK)
>>>     Handle variable "pd" going out of scope leaks the handle.
2062       return r;
2063     }
2064     
2065     static int do_copy(librbd::Image &src, librados::IoCtx& dest_pp,
2066     		   const char *destname)
2067     {


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com/projects/25?tab=overview

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click http://scan.coverity.com/subscriptions/edit?email=ceph-devel%40vger.kernel.org&token=018084d671e3cc89d00dd2ccb7eb849c .

