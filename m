From: huang jun <hjwsm1989@gmail.com>
Subject: radosgw:s3 create doesn't work
Date: Thu, 25 Aug 2011 21:51:05 +0800
Message-ID: <CABAwU-ZxPeQu1b=EbBjxWeNSn7X7+jOwiywO5hPOnsAxUe0Pvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57283 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab1HYNvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 09:51:07 -0400
Received: by vws1 with SMTP id 1so1990986vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 06:51:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
i try to use radosgw in ceph 0.30.
but i always got error in "s3 -u create alpha"
steps below:
bsd02:/data#ceph -s
2011-08-25 21:47:33.256884    pg v149: 230 pgs: 230
active+clean+degraded; 29 KB data, 7868 MB used, 6481 MB / 15118 MB
avail; 29/58 degraded (50.000%)
2011-08-25 21:47:33.257330   mds e4: 1/1/1 up {0=0=up:active}
2011-08-25 21:47:33.257355   osd e6: 1 osds: 1 up, 1 in
2011-08-25 21:47:33.257399   log 2011-08-25 21:32:26.114013 osd0
192.168.1.102:6801/5163 230 : [INF] 6.7 scrub ok
2011-08-25 21:47:33.257454   mon e1: 1 mons at {0=192.168.1.102:6789/0}

bsd02:/data#  radosgw_admin -m 192.168.1.102:6789 -c
/etc/ceph/ceph.conf user create --display-name="chuyunhanzhi"
--email=service_wh@chinfotech.com.cn -i 0
User ID: 0
RADOS UID: 0
Keys:
 User: 0
  Access Key: 669L0E71AIIGD5GZL4EJ
  Secret Key: IwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
Users:
Display Name: chuyunhanzhi
Email: service_wh@chinfotech.com.cn
OpenStack User: <undefined>
OpenStack Key: <undefined>

bsd02:/data# export S3_ACCESS_KEY_ID=669L0E71AIIGD5GZL4EJ
bsd02:/data# export
S3_SECRET_ACCESS_KEY=IwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
bsd02:/data# export S3_HOSTNAME=192.168.1.102

bsd02:/data# s3 create alpha

ERROR: ErrorInvalidAccessKeyId
  Message: The AWS Access Key Id you provided does not exist in our records.
  Extra Details:
    RequestId: 006D8781356B1B00
    HostId: d6lXuxT+ospDfgMYayaz7YjTzB5If4Q9s9mkoZno9fgyGe0shHrhfGGv3y3WGCAb
    AWSAccessKeyId: 669L0E71AIIGD5GZL4EJ

and i tried another two times,but the error always occur.
so what should i do to avoid this problem?

thanks in advance!
