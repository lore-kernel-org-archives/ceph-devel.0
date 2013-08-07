From: huangjun <hjwsm1989@gmail.com>
Subject: /etc/init.d/ceph script will restart stop start the daemon twice
Date: Wed, 07 Aug 2013 23:14:45 +0800
Message-ID: <52026465.2020905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:38779 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab3HGPO7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 11:14:59 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so2269817pad.22
        for <ceph-devel@vger.kernel.org>; Wed, 07 Aug 2013 08:14:58 -0700 (PDT)
Received: from [192.168.1.104] ([58.51.149.217])
        by mx.google.com with ESMTPSA id s5sm8743846pbo.38.2013.08.07.08.14.54
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 08:14:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
we use the ceph 0.613, write all the and when
operate(restart|start|stop) the cluster daemon(osd|mds|mon), it will
excecute the operation twice.
from the code init-ceph.in:
get_localname_list
get_name_list "$@"
for name in $what; do
.....
done
so the result $what will include twice the local daemons, shall we only
use the get_name_list? what's get_localname_list do here?


thanks!
huangjun
