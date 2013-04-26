From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: cleanup and leaks #2
Date: Fri, 26 Apr 2013 09:51:07 -0500
Message-ID: <517A945B.9040304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54481 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab3DZOvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:51:09 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so5046403ied.33
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:51:09 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id hi4sm3513869igc.6.2013.04.26.07.51.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:51:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Cleanup related to spec ids.  This one fixes a small leak
of the version 2 image id.

					-Alex

[PATCH 1/4] rbd: have rbd_dev_image_id() set format 1 image id
[PATCH 2/4] rbd: fix image id leak in initial probe
[PATCH 3/4] rbd: have snap_by_name() return a snapshot
[PATCH 4/4] rbd: set snapshot id in rbd_dev_probe_update_spec()
