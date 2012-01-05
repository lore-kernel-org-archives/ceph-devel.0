From: huang jun <hjwsm1989@gmail.com>
Subject: questions about radosgw
Date: Thu, 5 Jan 2012 19:48:38 +0800
Message-ID: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:63524 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755942Ab2AELtm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 06:49:42 -0500
Received: by obcwo16 with SMTP id wo16so465155obc.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jan 2012 03:49:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,all
I'am using the s3+radosgw, there are some questions confused me very much:
first) An object's size is 400MB, then the  whole object will stored
in OSDs as one big single object, but not striped into 4MB objects. so
how can we got workload banlance if we want to store big objects and
small ones?
second) Can we change the number of pgs in a pool that created by S3
clients or just using rados commands?

thanks

-- 
huangjun
