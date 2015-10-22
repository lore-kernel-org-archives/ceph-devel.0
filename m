From: wangsongbo <songbo1227@gmail.com>
Subject: when an osd is started up, IO will be blocked
Date: Thu, 22 Oct 2015 22:43:42 +0800
Message-ID: <5628F61E.1060708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34915 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbJVOnu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 10:43:50 -0400
Received: by pasz6 with SMTP id z6so88526774pas.2
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 07:43:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

Hi all,

When an osd is started, relative IO will be blocked.
According to the test result,the larger iops the clients send , the 
longer it will take to elapse.
Adjustment on all the parameters associate with recovery operations was 
also found useless.

How to reduce the impact of this process on the IO ?

Thanks and Regards,
WangSongbo

