From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] rbd: get rid of the snapshot list
Date: Tue, 30 Apr 2013 07:41:20 -0500
Message-ID: <517FBBF0.9020904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41973 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760235Ab3D3MlW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:41:22 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so504556iej.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:41:22 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id f16sm6912850igt.8.2013.04.30.05.41.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:41:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

An rbd device structure maintains a list of snapshot
structures whose purpose is to cache the name, size,
and features associated with a snapshot id.  The main
reason it was needed was related to the presence of
Linux device information for snapshots, which we
no longer have.  We can look up the name, etc. "on
the fly" about as easily as we can using the list,
and getting rid of this list means we can eliminate
a substantial bit of code.

The final patch in this series gets rid of the snapshot
list and the rbd_snap structure.  The first three put
in place replacement functionality that doesn't require
the list.

					-Alex

[PATCH 1/4] rbd: look up snapshot name in names buffer
[PATCH 2/4] rbd: use snap_id not index to look up snap info
[PATCH 3/4] rbd: define rbd_snap_size() and rbd_snap_features()
[PATCH 4/4] rbd: kill off the snapshot list
