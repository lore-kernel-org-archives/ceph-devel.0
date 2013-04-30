From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] libceph: define ceph_create_snap_context()
Date: Tue, 30 Apr 2013 07:17:33 -0500
Message-ID: <517FB65D.5040309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:40274 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543Ab3D3MRg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:17:36 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so379165iag.14
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:17:35 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id f16sm6814350igt.8.2013.04.30.05.17.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:17:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

While reviewing a recent rbd change Josh suggested that a
function I created for creating a snapshot context really
belonged in libceph.  These patches do that.  The first
defines the function in a new source file, and the second
puts it to work.

					-Alex

[PATCH 1/2] libceph: create source file "net/ceph/snapshot.c"
[PATCH 2/2] ceph: use ceph_create_snap_context()
