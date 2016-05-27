From: Oleksiy Molchanov <omolchanov@mirantis.com>
Subject: [Radosgw-keystone] NSS with non-PKI keystone
Date: Fri, 27 May 2016 15:57:43 +0300
Message-ID: <CA+GJb23Or64vxp8ePBabM9ydBCoVwpZ4wXmg2864fzZ1bfd9ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36128 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcE0M5q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2016 08:57:46 -0400
Received: by mail-lb0-f179.google.com with SMTP id h1so31588635lbj.3
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2016 05:57:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Documentation related to radosdgw-keystone integration [0] contain
part related to configuring NSS. AFAIK PKI tokens will be deprecated
soon (security issues).

Does it mean I cannot use this feature when non-PKI tokens are used on
keystone (e.g. fernet tokens)?
Or should I configure keystone to handle pki for radosgw?

[0] http://docs.ceph.com/docs/jewel/radosgw/keystone/

Best Regards,
Oleksiy.
