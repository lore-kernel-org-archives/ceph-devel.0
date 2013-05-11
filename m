From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: handle images flattened while mapped
Date: Sat, 11 May 2013 12:45:55 -0500
Message-ID: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58701 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3EKRp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:45:56 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so10108603iea.31
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:45:56 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ve9sm6139093igb.3.2013.05.11.10.45.55
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:45:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series detects when a mapped clone image gets flattened,
and if any requests were in flight when that occurs, causes
them to get resubmitted.

					-Alex

[PATCH 1/4] rbd: detect when clone image is flattened
[PATCH 2/4] rbd: re-submit read request for flattened clone
[PATCH 3/4] rbd: re-submit write request for flattened clone
[PATCH 4/4] rbd: re-submit flattened write request (part 2)
