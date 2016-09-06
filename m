From: Wido den Hollander <wido@42on.com>
Subject: librados.h version numbers
Date: Tue, 6 Sep 2016 21:18:47 +0200 (CEST)
Message-ID: <1843378866.3701.1473189527273@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:53086 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755902AbcIFTSw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Sep 2016 15:18:52 -0400
Received: from 109.72.87.221 (ox01.pcextreme.nl [109.72.87.221])
        by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 1DA0F761E8
        for <ceph-devel@vger.kernel.org>; Tue,  6 Sep 2016 21:18:47 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

wido@wido-laptop:~$ python -c "import rados; r = rados.Rados(); print(r.version())"
0.69.1
wido@wido-laptop:~$ dpkg -l|grep rados|awk '{print $2" "$3}'
librados-dev 10.2.2-1trusty
librados2 10.2.2-1trusty
libradosstriper1 10.2.2-1trusty
python-rados 10.2.2-1trusty
wido@wido-laptop:~$

Looking at librados.h in master I see:

#define LIBRADOS_VER_MAJOR 0
#define LIBRADOS_VER_MINOR 69
#define LIBRADOS_VER_EXTRA 1

Is this something which has just been forgotten to update?

Looking at the 'ceph' tool I see:

CEPH_GIT_NICE_VER="10.2.2"

This is updated during packaging/build it seems.

Should we maybe do that for librados.h as well?

Is there any other way (other then executing 'ceph -v') to get the version of the local librados?

Wido
