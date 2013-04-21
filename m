From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: void buffer pointer types
Date: Sun, 21 Apr 2013 16:16:12 -0500
Message-ID: <5174571C.4010203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:39242 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab3DUVQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Apr 2013 17:16:14 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so650970iae.20
        for <ceph-devel@vger.kernel.org>; Sun, 21 Apr 2013 14:16:14 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ua6sm12936070igb.0.2013.04.21.14.16.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:16:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series just makes the buffer pointer parameters
for two rbd functions be type (void *) rather than
(char *).

					-Alex

[PATCH 1/2] rbd: give rbd_obj_read_sync() buffer void type
[PATCH 2/2] rbd: void data pointers for rbd_obj_method_sync()
