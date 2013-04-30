From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: a few small issues
Date: Tue, 30 Apr 2013 07:22:08 -0500
Message-ID: <517FB770.1070500@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41644 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401Ab3D3MWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:22:10 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so486748iec.14
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:22:09 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm6874514igb.10.2013.04.30.05.22.08
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:22:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series has two patches that fix two annoyances
and a third that makes snapshot names be treated
consistently as constant data.

					-Alex

[PATCH 1/3] rbd: fix up the layering warning message
[PATCH 2/3] rbd: don't revalidate so much
[PATCH 3/3] rbd: snap names are pointer to constant data
