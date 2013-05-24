From: Travis Rhoden <trhoden@gmail.com>
Subject: [doc] strange navigation error
Date: Fri, 24 May 2013 13:05:59 -0400
Message-ID: <CACkq2mo6nRDYxDYEEbWJYGmVfiKcEEL8dMKrEYz_Yqx9MbVR1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:59150 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab3EXRGU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 13:06:20 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so2020305qea.7
        for <ceph-devel@vger.kernel.org>; Fri, 24 May 2013 10:06:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I stumbled across a weird TOC/navigation error in the docs.

On the page: http://ceph.com/docs/master/rados/deployment/ceph-deploy-mds/,
if you hover over "next" on the top right, it wants to go to
mds-config-ref, even though the TOC on the left says the next entry
should be ceph-deploy-purge.  You can get to ceph-deploy-purge by
clicking the link in the left-hand TOC, but you can't navigate to it
by going "next, next, next" through all docs.  I find this to be a
little weird, as I was trying to read through all the ceph-deploy docs

Weirdly, once on ceph-deploy-purge, the navigation is fine --
including that "previous" takes you to ceph-deploy-mds.  Weird.  I
looked at all the .rst files and didn't see anything obvious.

I finally tracked down the issue to doc/cephfs/index.rst, which has
this in its TOC.  From my perspective, this makes the navigation
confusing, and I would remove it.  But I figured I'd bring it to
John's attention first before submitting a pull-request.

And that came in with commit:
decf342c (John Wilkins 2013-05-17 15:56:59 -0700 46), with the comment
doc: Minor improvements to Ceph FS landing page.

While it may help the CephFS landing page, I think it makes navigation
through the ceph-deploy docs not very intuitive.

 - Travis
