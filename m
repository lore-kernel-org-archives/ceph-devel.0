From: Dan van der Ster <dan@vanderster.com>
Subject: CDS blueprint: strong auth for cephfs
Date: Wed, 13 Nov 2013 17:05:40 +0100
Message-ID: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:34963 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab3KMQGX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 11:06:23 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so470441bkz.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 08:06:22 -0800 (PST)
Received: from mail-la0-x232.google.com (mail-la0-x232.google.com [2a00:1450:4010:c03::232])
        by mx.google.com with ESMTPSA id w9sm23746977bkn.12.2013.11.13.08.06.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 08:06:21 -0800 (PST)
Received: by mail-la0-f50.google.com with SMTP id el20so540682lab.9
        for <ceph-devel@vger.kernel.org>; Wed, 13 Nov 2013 08:06:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, andrea.ieri@cern.ch, Arne Wiebalck <Arne.Wiebalck@cern.ch>

Hi all,
This mail is just to let you know that we've prepared a draft
blueprint related to adding strong(er) authn/authz to cephfs:

http://wiki.ceph.com/01Planning/02Blueprints/Firefly/Strong_AuthN_and_AuthZ_for_CephFS

The main goal of the idea is that we'd like to be able to use CephFS
from untrusted clients:
  - the CephX key gives full rw access to pools (e.g. data/metadata)
via rados; we cannot distribute this key to untrusted hosts.
  - root on untrusted clients can forge their uid/gid and rm -rf /cephfs/*.

In the doc we've proposed one way to add authn/authz to the ceph
server side, but perhaps there is a simpler (more feasible in the
short term) solution which would enable us to allow untrusted cephfs
clients.

Best Regards,
Arne & Andreas & Andrea & Dan
CERN IT
