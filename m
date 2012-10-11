From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: separating mapping info from rbd_device
Date: Thu, 11 Oct 2012 08:42:07 -0700
Message-ID: <5076E8CF.1060108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50666 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab2JKPmL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 11:42:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1973310pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 08:42:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rbd device structure has up to now contained information about
the rbd image (and possibly snapshot id) that backs it as well as
the device interface it represents in Linux when it is mapped.  In
order to add layering support we're going to want to separate the
mapping information from the image information more clearly.  This
was begun recently but these two patches do the bulk of the movement
of the rest of the mapping-related fields.

					-Alex

[PATCH 1/2] rbd: move dev_id and list links into mapping
[PATCH 2/2] rbd: move more stuff into mapping
