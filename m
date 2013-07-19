From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Fri, 19 Jul 2013 11:04:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307191104240.795@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1697561686-1374257082=:795"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54637 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759982Ab3GSSEn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 14:04:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yehuda@inktank.com
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1697561686-1374257082=:795
Content-Type: TEXT/PLAIN; charset=US-ASCII

Several new rgw issues from the recent merge...
--557981400-1697561686-1374257082=:795
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1307191104250.795@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 057778004F
	for <sage@cobra.newdream.net>; Fri, 19 Jul 2013 11:03:18 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id C94FC12089F; Fri, 19 Jul 2013 11:05:46 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from alc-junkmail-backend3.dreamhost.com (mailbigip.dreamhost.com
	[208.97.132.5])
	by destro.newdream.net (Postfix) with ESMTP id C7B0112023C
	for <sage@newdream.net>; Fri, 19 Jul 2013 11:05:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by alc-junkmail-backend3.dreamhost.com (Postfix) with ESMTP id
	EFCC3161613F
	for <sage@newdream.net>; Fri, 19 Jul 2013 11:03:17 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at alc-junkmail-backend3.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
Received: from terminator.dreamhost.com ([208.97.132.145])
	by localhost (alc-junkmail-backend3.dreamhost.com [208.97.132.104])
	(amavisd-new, port 10024)
	with ESMTP id HkYSZqDocSB9 for <sage@newdream.net>;
	Fri, 19 Jul 2013 11:03:17 -0700 (PDT)
Received: from build-l3.scan.coverity.com (unknown [208.69.177.216])
	by terminator.dreamhost.com (Postfix) with ESMTP id 95BE22884065
	for <sage@newdream.net>; Fri, 19 Jul 2013 11:03:17 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=build-l3.scan.coverity.com)
	by build-l3.scan.coverity.com with esmtp (Exim 4.69)
	(envelope-from <scan-admin@coverity.com>)
	id 1V0F1Q-00022u-Fe; Fri, 19 Jul 2013 11:03:17 -0700
From: scan-admin@coverity.com
To: sage@newdream.net
CC: 
Subject: New Defects reported by Coverity Scan for ceph
Message-Id: <E1V0F1Q-00022u-Fe@build-l3.scan.coverity.com>
Date: Fri, 19 Jul 2013 11:03:16 -0700
X-Spambayes-Classification: ham; 0.00



Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan

Defect(s) Reported-by: Coverity Scan
Showing 7 of 61 defects
	
** CID 1049252: Wrapper object use after free (WRAPPER_ESCAPE)
/rgw/rgw_rest_replica_log.h: 79

** CID 1049251: Wrapper object use after free (WRAPPER_ESCAPE)
/rgw/rgw_rest_replica_log.h: 59

** CID 1049250: Wrapper object use after free (WRAPPER_ESCAPE)
/rgw/rgw_rest_replica_log.h: 39

** CID 1049249: Missing varargs init or cleanup (VARARGS)
/test/librbd/test_librbd.cc: 315

** CID 1049248: Use after free (USE_AFTER_FREE)
/test/test_rgw_admin_log.cc: 782

** CID 1049247: Use after free (USE_AFTER_FREE)
/test/cls_version/test_cls_version.cc: 79

** CID 1049246: Use after free (USE_AFTER_FREE)
/rgw/rgw_rest_s3.cc: 415


________________________________________________________________________
CID 1049252: Wrapper object use after free (WRAPPER_ESCAPE)

/rgw/rgw_rest_replica_log.h: 79 ( escape)
   76        string s = "replica";
   77        s.append(obj_type);
   78        s.append("_deletebound");
>>> CID 1049252: Wrapper object use after free (WRAPPER_ESCAPE)
>>> The internal representation of "s" escapes, but is destroyed when it exits scope.
   79        return s.c_str();
   80      }
   81    };
   82    
   83    class RGWOp_BILog_GetBounds : public RGWRESTOp {
  
________________________________________________________________________
CID 1049251: Wrapper object use after free (WRAPPER_ESCAPE)

/rgw/rgw_rest_replica_log.h: 59 ( escape)
   56        string s = "replica";
   57        s.append(obj_type);
   58        s.append("_updatebounds");
>>> CID 1049251: Wrapper object use after free (WRAPPER_ESCAPE)
>>> The internal representation of "s" escapes, but is destroyed when it exits scope.
   59        return s.c_str();
   60      }
   61    };
   62    
   63    class RGWOp_OBJLog_DeleteBounds : public RGWRESTOp {
  
________________________________________________________________________
CID 1049250: Wrapper object use after free (WRAPPER_ESCAPE)

/rgw/rgw_rest_replica_log.h: 39 ( escape)
   36        string s = "replica";
   37        s.append(obj_type);
   38        s.append("_getbounds");
>>> CID 1049250: Wrapper object use after free (WRAPPER_ESCAPE)
>>> The internal representation of "s" escapes, but is destroyed when it exits scope.
   39        return s.c_str();
   40      }
   41    };
   42    
   43    class RGWOp_OBJLog_SetBounds : public RGWRESTOp {
  
________________________________________________________________________
CID 1049249: Missing varargs init or cleanup (VARARGS)

/test/librbd/test_librbd.cc: 305 ( va_init)
   302        cout << "image: " << names[i] << endl;
   303      }
   304    
>>> Initializing va_list "ap".
   305      va_start(ap, num_expected);
   306      for (i = num_expected; i > 0; i--) {
   307        char *expected = va_arg(ap, char *);
   308        cout << "expected = " << expected << endl;
   309        vector<string>::iterator listed_name = find(names.begin(), names.end(), string(expected));
  

/test/librbd/test_librbd.cc: 315 ( missing_va_end)
   312      }
   313      assert(names.empty());
   314    
>>> CID 1049249: Missing varargs init or cleanup (VARARGS)
>>> va_end was not called for "ap".
   315      return num;
   316    }
   317    
   318    TEST(LibRBD, TestCreateLsDeletePP)
   319    {
  
________________________________________________________________________
CID 1049248: Use after free (USE_AFTER_FREE)

/test/test_rgw_admin_log.cc: 750 ( freed_arg)
   747      char *bucket_obj = (char *)malloc(TEST_BUCKET_OBJECT_SIZE);
   748      ASSERT_TRUE(bucket_obj != NULL);
   749      EXPECT_EQ(put_bucket_obj(TEST_BUCKET_OBJECT, bucket_obj, TEST_BUCKET_OBJECT_SIZE), 0);
>>> "free(void *)" frees "bucket_obj".
   750      free(bucket_obj);
   751      sleep(1); 
   752      ss << "/admin/log?type=data&id=" << shard_id << "&start-time=" << start_time;
   753      rest_req = ss.str();
   754      g_test->send_request(string("GET"), rest_req);
  

/test/test_rgw_admin_log.cc: 782 ( pass_freed_arg)
   779      }
   780    
   781      sleep(1);
>>> CID 1049248: Use after free (USE_AFTER_FREE)
>>> Passing freed pointer "bucket_obj" as an argument to function "put_bucket_obj(char const *, char *, unsigned int)".
   782      EXPECT_EQ(put_bucket_obj(TEST_BUCKET_OBJECT, bucket_obj, TEST_BUCKET_OBJECT_SIZE), 0);
   783      sleep(20);
   784      ss.str("");
   785      ss << "/admin/log?type=data&id=" << shard_id << "&start-time=" << start_time;
   786      rest_req = ss.str();
  
________________________________________________________________________
CID 1049247: Use after free (USE_AFTER_FREE)

/test/cls_version/test_cls_version.cc: 68 ( freed_arg)
   65      ASSERT_GT((long long)ver2.ver, (long long)ver.ver);
   66      ASSERT_EQ(0, (int)ver2.tag.compare(ver.tag));
   67    
>>> "operator delete(void *)" frees "op".
   68      delete op;
   69    
   70      obj_version ver3;
   71    
   72      librados::ObjectReadOperation *rop = new_rop();
  

/test/cls_version/test_cls_version.cc: 79 ( deref_arg)
   76      ASSERT_EQ(ver2.ver, ver3.ver);
   77      ASSERT_EQ(1, (long long)ver2.compare(&ver3));
   78    
>>> CID 1049247: Use after free (USE_AFTER_FREE)
>>> Calling "librados::ObjectWriteOperation::~ObjectWriteOperation()" dereferences freed pointer "op". (The dereference happens because this is a virtual function call.)
   79      delete op;
   80    }
   81    
   82    
   83    TEST(cls_rgw, test_version_set)
  
________________________________________________________________________
CID 1049246: Use after free (USE_AFTER_FREE)

/rgw/rgw_rest_s3.cc: 412 ( freed_arg)
   409    
   410        bool success = parser.parse(data, len, 1);
   411        ldout(s->cct, 20) << "create bucket input data=" << data << dendl;
>>> "free(void *)" frees "data".
   412        free(data);
   413    
   414        if (!success) {
   415          ldout(s->cct, 0) << "failed to parse input: " << data << dendl;
   416          return -EINVAL;
  

/rgw/rgw_rest_s3.cc: 415 ( deref_arg)
   412        free(data);
   413    
   414        if (!success) {
>>> CID 1049246: Use after free (USE_AFTER_FREE)
>>> Calling "std::operator << <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> > &, char const *)" dereferences freed pointer "data".
   415          ldout(s->cct, 0) << "failed to parse input: " << data << dendl;
   416          return -EINVAL;
   417        }
   418    
   419        if (!parser.get_location_constraint(location_constraint)) {
  
________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py


--557981400-1697561686-1374257082=:795--
