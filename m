From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: eliminate object version tracking
Date: Tue, 30 Apr 2013 07:28:57 -0500
Message-ID: <517FB909.40309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:58231 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235Ab3D3M3A (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:29:00 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so386891iae.34
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:28:59 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id b6sm24384792igv.5.2013.04.30.05.28.57
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:28:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As of this patch:
    rbd: set up watch in rbd_dev_image_probe()
there is no longer any need to keep track of the
object version for an rbd header object.  Getting
rid of it allows quite a bit of code to get
simplified, and the patches after the first in
this series do just that.

					-Alex

[PATCH 1/5] rbd: stop tracking header object version
[PATCH 2/5] rbd: get rid of some version parameters
[PATCH 3/5] rbd: more version parameter removal
[PATCH 4/5] rbd: drop rbd_obj_method_sync() version parameter
[PATCH 5/5] rbd: drop obj_request->version
