From: Dan Mick <dmick@redhat.com>
Subject: python setuptools is broken again "No module named six"
Date: Wed, 31 May 2017 20:22:33 -0700
Message-ID: <80a14874-c79c-4d39-2780-e61befa9e3d4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751033AbdFADWd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 May 2017 23:22:33 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>

python setuptools is broken again:

https://github.com/pypa/setuptools/issues/1042

This probably breaks nearly everything.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
