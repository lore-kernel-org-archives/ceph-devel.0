From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: mapping structure changes
Date: Fri, 26 Oct 2012 17:48:07 -0500
Message-ID: <508B1327.3090008@inktank.com>
References: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48132 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966874Ab2JZWsK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:48:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4473932iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:48:09 -0700 (PDT)
In-Reply-To: <508B11E3.3040108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This small series just affects the rbd_mapping structure.  It
moves a few fields out of it and back into the rbd_device
structure.  The second one also modifies the interpretation
of the "exists" flag for a mapped image.

					-Alex

[PATCH 1/2] rbd: move snap info out of rbd_mapping struct
[PATCH 2/2] rbd: rename snap_exists field
