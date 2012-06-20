From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: filestore flusher = false  , correct my problem of constant write (need info on this parameter)
Date: Wed, 20 Jun 2012 07:20:23 +0200 (CEST)
Message-ID: <29b3d930-1b60-4a88-a98b-ae4cd7e10c21@mailpro>
References: <48b5f93e-fe36-458f-a05e-9f9fd2293249@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55995 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab2FTFUp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 01:20:45 -0400
In-Reply-To: <48b5f93e-fe36-458f-a05e-9f9fd2293249@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe <s.priebe@profihost.ag>

Hi, 
I have tried to disabe filestore flusher 

filestore flusher = false 
filestore max sync interval = 30 
filestore min sync interval = 29 


in osd config. 


now, I see correct sync each 30s when doing rados bench 

rados -p pool3 bench 60 write -t 16


seekwatcher movie: 


before 
------ 
http://odisoweb1.odiso.net/seqwrite-radosbench-flusherenable.mpg 

after 
----- 
http://odisoweb1.odiso.net/seqwrite-radosbench-flusherdisable.mpg 


Shouldn't it be the normal behaviour ? What's exactly is filestore flusher vs syncfs ?



This seem to works fine with rados bench,
But when I launch benchmark with fio from my guest vm, I see again constant write.
(I'll try to debug that today)


My target is to be able to handle small random write and write them each 30s.

Regards,

Alexandre
