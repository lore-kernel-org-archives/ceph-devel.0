From: Simon Leinen <simon.leinen@switch.ch>
Subject: "Hybrid SMR" drive spec proposal for OCP
Date: Mon, 13 Nov 2017 17:08:06 +0100
Message-ID: <aa375igo0p.fsf@switch.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from teruel.switch.ch ([130.59.193.63]:59650 "EHLO teruel.switch.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753034AbdKMQOB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Nov 2017 11:14:01 -0500
Received: from surlej.switch.ch (surlej.switch.ch [IPv6:2001:620:0:1001::69])
        by teruel.switch.ch (8.14.4/8.14.4/Debian-4+deb7u1) with ESMTP id vADG868n031481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <ceph-devel@vger.kernel.org>; Mon, 13 Nov 2017 17:08:08 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ted Ts'o from Google wrote a small spec for a new kind of disk drive
that could be partly "traditional" and partly SMR (Shingled Magnetic
Recording), and you could convert parts of the disk (at 100GB
granularity) between traditional and SMR (and back):

https://www.blog.google/topics/google-cloud/dynamic-hybrid-smr-ocp-proposal-improve-data-center-disk-drives/

SMR is supposed to "lower the cost per byte of an HDD by up to 10-20
percent".

The spec is being proposed to the Open Compute Project (OCP).

Maybe this is something that a future version of Ceph could leverage.
Seems easier (though not "easy") with Bluestore than with Filestore.
-- 
Simon.
