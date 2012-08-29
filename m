From: hemant surale <hemant.surale@gmail.com>
Subject: Unable to set pg_num property of pool "data"
Date: Wed, 29 Aug 2012 15:12:07 +0530
Message-ID: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47183 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2H2JmH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 05:42:07 -0400
Received: by vcbfk26 with SMTP id fk26so363011vcb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 02:42:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph Community ,
     I am facing problem while I am explicitly  trying to set
"pg_number" of "data" pool.

--------------------------------------------------------------------------------------------------------------------
root@third-virtual-machine:~# ceph osd pool set data pg_num 100
2012-08-29 15:08:52.388446 mon <- [osd,pool,set,data,pg_num,100]
2012-08-29 15:08:52.388924 mon0 -> 'specified pg_num 100 <= current 200' (-22)


root@third-virtual-machine:~# ceph osd pool get data pg_num
2012-08-29 15:09:04.788365 mon <- [osd,pool,get,data,pg_num]
2012-08-29 15:09:04.788833 mon0 -> 'PG_NUM: 200' (0)

-----------------------------------------------------------------------------------------------------------------
Why is it not working to set pg_number to 100. The cmd is executed
while ceph is running.
(ceph v. 0.36, ubuntu 11.10)


Regards,
hemant surale.
