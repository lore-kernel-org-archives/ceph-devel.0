From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: avoid dropping extra reference in rbd_free_disk()
Date: Fri, 26 Apr 2013 09:54:21 -0500
Message-ID: <517A951D.8010105@inktank.com>
References: <517A944C.1090503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:37681 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3DZOyY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 10:54:24 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so2725868iag.39
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 07:54:23 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id m4sm3633744igd.0.2013.04.26.07.54.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 07:54:23 -0700 (PDT)
In-Reply-To: <517A944C.1090503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch, and the series of 4 that I also just posted,
are available in the "review/wip-rbd-cleanup-1" branch of
the ceph-client git repository.  That branch is based on
the branch "review/wip-rbd-cleanup".

					-Alex
