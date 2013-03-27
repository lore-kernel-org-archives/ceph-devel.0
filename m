From: Lorieri <lorieri@gmail.com>
Subject: radosgw S3 api
Date: Wed, 27 Mar 2013 20:03:03 -0300
Message-ID: <CAPHxCcSX7CRS2+-CWA7hGYAZKSm2PDn+hYd6+EtqHtSm+8fN3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:34188 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3C0XDF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 19:03:05 -0400
Received: by mail-ia0-f169.google.com with SMTP id j5so7820322iaf.14
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 16:03:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

There is a behavior in AWS S3 I could not reproduce in radosgw.

If you create an empty bucket and makes it public, any object you put
there will be public too, and will automatically be possible to access
it by its http url.
It is very helpful when people use some tools and browsers plugins to
upload content or do a bulk sync.

am I missing something ?

thanks,
-lorieri
