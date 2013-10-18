From: "hjwsm1989-gmail" <hjwsm1989@gmail.com>
Subject: git clone from ceph missig files and dirs under src/libs3/
Date: Fri, 18 Oct 2013 17:20:47 +0800
Message-ID: <002201cecbe3$5cdec0c0$169c4240$@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36385 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3JRJVG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Oct 2013 05:21:06 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so4209950pab.25
        for <ceph-devel@vger.kernel.org>; Fri, 18 Oct 2013 02:21:05 -0700 (PDT)
Received: from huangjun ([111.173.83.95])
        by mx.google.com with ESMTPSA id xe9sm2908314pab.0.2013.10.18.02.21.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2013 02:21:03 -0700 (PDT)
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,all
I get ceph from git@github.com:ceph/ceph.git
But when I try to build rpm package from the master branch,
It runs error like : No target to Make.
I found there are no file or dirs under src/libs3/ in my mater and next
branch.(all my branchs are uptodate)
But those files exists from the ceph-0.71.tar.gz download from ceph.com.

Thanks!

