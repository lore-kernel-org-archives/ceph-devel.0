From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/6] rbd: miscellaneous cleanups
Date: Mon, 06 May 2013 20:36:23 -0500
Message-ID: <51885A97.9070005@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39352 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab3EGBgZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:36:25 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so52544iec.34
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:36:24 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ha2sm5241262igb.1.2013.05.06.18.36.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:36:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is just some odds and ends, cleaning up code mostly.
One might be considered a minor bug, but it's not serious.

					-Alex

[PATCH 1/6] rbd: update capacity in rbd_dev_refresh()
[PATCH 2/6] rbd: kill rbd_update_mapping_size()
[PATCH 3/6] rbd: don't print warning if not mapping a parent
[PATCH 4/6] rbd: don't look up snapshot id in rbd_dev_mapping_set()
[PATCH 5/6] rbd: kill rbd_dev_clear_mapping()
[PATCH 6/6] rbd: always set read-only flag in rbd_add()
