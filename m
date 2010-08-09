From: Xiaoguang Liu <syslxg@gmail.com>
Subject: how to remove/update a RBD device?
Date: Mon, 9 Aug 2010 14:48:22 +0800
Message-ID: <AANLkTinm2C+LrSUPsnf_djAbQS-0VRX8tHw2T1bf2qbR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34244 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab0HIGsY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Aug 2010 02:48:24 -0400
Received: by qyk7 with SMTP id 7so6063315qyk.19
        for <ceph-devel@vger.kernel.org>; Sun, 08 Aug 2010 23:48:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

the following command will add rbd device on Linux
         echo "172.16.12.1 name=admin rbd foo" > /sys/class/rbd/add

but how to remove it or change it (after I resize the image by rbd
resize foo -size=xxx)? the wiki does not say.
