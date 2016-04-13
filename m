From: Dan van der Ster <dan@vanderster.com>
Subject: MADV_MERGEABLE for osdmaps etc...
Date: Wed, 13 Apr 2016 11:59:41 +0200
Message-ID: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36057 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965799AbcDMKAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 06:00:24 -0400
Received: by mail-lf0-f42.google.com with SMTP id g184so62229719lfb.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 03:00:24 -0700 (PDT)
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com. [209.85.215.51])
        by smtp.gmail.com with ESMTPSA id rd7sm2036187lbb.36.2016.04.13.03.00.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2016 03:00:21 -0700 (PDT)
Received: by mail-lf0-f51.google.com with SMTP id g184so62228647lfb.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 03:00:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi ceph-devel,

Did anyone ever consider using madvise MADV_MERGEABLE to enable kernel
samepage merging for the ceph-osd? Typically this is used on kvm hosts
to dedupe the VM memories, but naively I was thinking that since our
osdmaps are duplicated (a few 100MB per daemon) we might profit as
well. Though, perhaps these maps are changing often enough that KSM
wouldn't help... no idea.

Any thoughts here?

-- Dan
CERN IT
