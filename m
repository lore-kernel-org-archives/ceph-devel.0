From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: parent probe cleanup
Date: Sat, 27 Apr 2013 07:35:20 -0500
Message-ID: <517BC608.5030008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:61767 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0MfV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 08:35:21 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so1040827iay.4
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 05:35:21 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id q3sm8512104igw.0.2013.04.27.05.35.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 05:35:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series cleans up some code in the are of probing
for parent images.

					-Alex

[PATCH 1/6] rbd: encapsulate probing for parent devices
[PATCH 2/6] rbd: encapsulate removing parent devices
[PATCH 3/6] rbd: kill __rbd_remove()
[PATCH 4/6] rbd: fix rbd_dev_remove_parent()
[PATCH 5/6] rbd: remove parent devices on probe error
[PATCH 6/6] rbd: probe for the parent earlier
