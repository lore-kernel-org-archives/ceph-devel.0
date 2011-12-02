From: <Eric_YH_Chen@wistron.com>
Subject: No function to list the pool in rados.py
Date: Fri, 2 Dec 2011 13:33:08 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D8EB4D1@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:50793 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1LBFdM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2011 00:33:12 -0500
Received: from twnhufe3.whq.wistron (unverified [10.37.31.103]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta10b649a31c0a816711984@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Fri, 2 Dec 2011 13:34:37 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Hi, ceph developments:

  Could we add one more function in rados.py to list the pool?

  I had already implemented the function. Thanks a lot!

class Rados(object):
    def list(self):
        size = c_size_t(512)
        while True:
            c_names = create_string_buffer(size.value)
            ret = self.librados.rados_pool_list(self.cluster,
byref(c_names), size)
            if ret > size.value:
                size = ret
            else:
                break
        return filter(lambda name: name != '', c_names.raw.split('\0'))


