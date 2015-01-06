From: Gregory Farnum <greg@gregs42.com>
Subject: deprecated rbd functions and warnings
Date: Tue, 6 Jan 2015 10:35:25 -0800
Message-ID: <CAC6JEv8ciKc1X2rHWs3dpjAnTX72GJEfQV58a0tdu50CJmYyCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54671 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbAFSf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 13:35:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so4262358iec.5
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:35:26 -0800 (PST)
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com. [209.85.223.178])
        by mx.google.com with ESMTPSA id kt1sm5308605igb.20.2015.01.06.10.35.25
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 10:35:26 -0800 (PST)
Received: by mail-ie0-f178.google.com with SMTP id vy18so4250852iec.9
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jan 2015 10:35:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, jdurgin@redhat.com, Sage Weil <sweil@redhat.com>

So last month a bunch of librados functions around watch-notify were
marked as deprecated, and because RBD still uses them everything went
yellow on the gitbuilders. I believe we're expecting a patch series to
move to the new APIs pretty soon, but was wondering when.

In particular, a spot check determines that the FS quota code we
merged in produced a signed/unsigned warning which nobody spotted,
presumably because we are no longer green-and-clean when scanning the
page. :(
-Greg
