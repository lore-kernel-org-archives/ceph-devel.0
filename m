From: wangsongbo <songbo1227@gmail.com>
Subject: failed to open http://apt-mirror.front.sepia.ceph.com
Date: Wed, 23 Sep 2015 18:29:49 +0800
Message-ID: <56027F1D.90508@gmail.com>
References: <56027EE3.5080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35377 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbbIWK3y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 06:29:54 -0400
Received: by pacfv12 with SMTP id fv12so37704984pac.2
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2015 03:29:53 -0700 (PDT)
In-Reply-To: <56027EE3.5080909@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

Hi Loic and other Cephers,

I am running teuthology-suites in our testing, because the connection to 
"apt-mirror.front.sepia.ceph.com" timed out , "ceph-cm-ansible" failed.
And from a web-browser, I got the response like this : "502 Bad Gateway".
"64.90.32.37 apt-mirror.front.sepia.ceph.com" has been added to /etc/hosts.
Did the resources have been removed ?


Thanks and Regards,
WangSongbo
