From: Sage Weil <sage@inktank.com>
Subject: New Defects reported by Coverity Scan for ceph (fwd)
Date: Thu, 25 Jul 2013 13:31:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307251330580.32741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-887729713-1374784265=:32741"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38562 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab3GYUbG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 16:31:06 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 55C998004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 13:31:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2AB078004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 13:31:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-887729713-1374784265=:32741
Content-Type: TEXT/PLAIN; charset=US-ASCII


--557981400-887729713-1374784265=:32741
Content-Type: MESSAGE/RFC822; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.00.1307251331000.32741@cobra.newdream.net>
Content-Description: Forwarded Message
Content-Disposition: inline

Return-Path: <scan-admin@coverity.com>
X-Original-To: sage@cobra.newdream.net
Delivered-To: sage@cobra.newdream.net
Received: from destro.newdream.net (destro.newdream.net [66.33.216.68])
	by cobra.newdream.net (Postfix) with ESMTP id 242528004F
	for <sage@cobra.newdream.net>; Thu, 25 Jul 2013 13:22:10 -0700 (PDT)
Received: by destro.newdream.net (Postfix)
	id BDD0B120837; Thu, 25 Jul 2013 13:26:23 -0700 (PDT)
Delivered-To: sage@destro.newdream.net
Received: from madmax.dreamhost.com (caiajhbdccac.dreamhost.com
	[208.97.132.202])
	by destro.newdream.net (Postfix) with ESMTP id BAF4212023F
	for <sage@newdream.net>; Thu, 25 Jul 2013 13:26:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by madmax.dreamhost.com (Postfix) with ESMTP id 14976FD699B
	for <sage@newdream.net>; Thu, 25 Jul 2013 13:22:10 -0700 (PDT)
X-DH-Virus-Scanned: Debian amavisd-new at madmax.dreamhost.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level: 
X-Spam-Status: No, score=x tagged_above=-999 required=999 WHITELISTED tests=[]
	autolearn=unavailable
Received: from godfather.dreamhost.com ([208.97.132.119])
	by localhost (madmax.dreamhost.com [208.97.132.139]) (amavisd-new,
	port 10024) with ESMTP id XaWh-805Edjp for <sage@newdream.net>;
	Thu, 25 Jul 2013 13:22:09 -0700 (PDT)
Received: from build-l3.scan.coverity.com (unknown [208.69.177.216])
	by godfather.dreamhost.com (Postfix) with ESMTP id BF7EC1B00A9
	for <sage@newdream.net>; Thu, 25 Jul 2013 13:22:09 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=build-l3.scan.coverity.com)
	by build-l3.scan.coverity.com with esmtp (Exim 4.69)
	(envelope-from <scan-admin@coverity.com>)
	id 1V2S37-0000Aw-Ac; Thu, 25 Jul 2013 13:22:09 -0700
From: scan-admin@coverity.com
To: sage@newdream.net
CC: 
Subject: New Defects reported by Coverity Scan for ceph
Message-Id: <E1V2S37-0000Aw-Ac@build-l3.scan.coverity.com>
Date: Thu, 25 Jul 2013 13:22:09 -0700
X-Spambayes-Classification: ham; 0.00



Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan

Defect(s) Reported-by: Coverity Scan

	
** CID 1057291: Resource leak (RESOURCE_LEAK)
/rgw/rgw_rados.cc: 2643


________________________________________________________________________
CID 1057291: Resource leak (RESOURCE_LEAK)

/rgw/rgw_rados.cc: 2641 ( alloc_arg)
   2638    
   2639        RGWRESTStreamWriteRequest *out_stream_req;
   2640    
>>> "RGWRESTConn::put_obj_init(std::string const &, rgw_obj &, uint64_t, std::map<std::basic_string<char, std::char_traits<char>, std::allocator<char> >, ceph::buffer::list, std::less<std::basic_string<char, std::char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::basic_string<char, std::char_traits<char>, std::allocator<char> > const, ceph::buffer::list> > > &, RGWRESTStreamWriteRequest **)" allocates memory that is stored into "out_stream_req".
   2641        int ret = rest_master_conn->put_obj_init(user_id, dest_obj, astate->size, src_attrs, &out_stream_req);
   2642        if (ret < 0)
   2643          return ret;
   2644    
   2645        ret = get_obj_iterate(ctx, &handle, src_obj, 0, astate->size - 1, out_stream_req->get_out_cb());
  

/rgw/rgw_rados.cc: 2643 ( leaked_storage)
   2640    
   2641        int ret = rest_master_conn->put_obj_init(user_id, dest_obj, astate->size, src_attrs, &out_stream_req);
   2642        if (ret < 0)
>>> CID 1057291: Resource leak (RESOURCE_LEAK)
>>> Variable "out_stream_req" going out of scope leaks the storage it points to.
   2643          return ret;
   2644    
   2645        ret = get_obj_iterate(ctx, &handle, src_obj, 0, astate->size - 1, out_stream_req->get_out_cb());
   2646        if (ret < 0)
   2647          return ret;
  
________________________________________________________________________
To view the defects in Coverity Scan visit, http://scan.coverity.com

To unsubscribe from the email notification for new defects, http://scan5.coverity.com/cgi-bin/unsubscribe.py


--557981400-887729713-1374784265=:32741--
