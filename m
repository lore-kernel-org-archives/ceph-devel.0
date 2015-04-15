From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: [rgw][Swift API] Reusing WSGI middleware of Swift
Date: Wed, 15 Apr 2015 17:31:22 +0200
Message-ID: <CA+H5UW1oCwFQ9E_2hTn-tDn2CP6AVY+Dij5xzMRogStsOW9dNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vn0-f46.google.com ([209.85.216.46]:43697 "EHLO
	mail-vn0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbbDOPbX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 11:31:23 -0400
Received: by vnbg7 with SMTP id g7so16359692vnb.10
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2015 08:31:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hello Guys,

Swift -- besides implementing the OpenStack Object Storage API v1 -- provides
a bunch of huge extensions like SLO/DLO (static/dynamic large objects), bulk
operations (inc. server-side archive extraction), staticweb and many more.
Full list is available in Swift's source code [1]. I'm pretty sure it would
be nice to have at least some degree of compatibility with them.

Reimplementing those features could be painful. Maintaining them would be
another challenge. Even after accomplishing that we still would not provide
users with ability to use (and easily create) a third party extensions like
ClamAV-based virus scanner [2]. However, maybe there is another solution.

Swift internally utilizes a pipeline-based architecture. Component delivering
the base of OSOS API (the "proxy-server" WSGI application) could be seen
as the last stage of such pipeline. Between it and user a lot of additional
middleware modules exist. All of them are interconnected with the WSGI
interface. In a pure theory, if we provide a WSGI-RGW bridge, we would be able
to reuse them and save a lot of efforts.

I created a really stupid proof of concept [3] built on top of wsgiproxy [4]
and civetweb frontend of RGW. Its primary role is a WSGI-HTTP mediator.
The code is terrible, definitely needs rework but already allowed to pass
a few middleware-related API tests from Tempest.

What would be necessary on the RGW's side? Basically:
* support for extraction of account (aka tenant) name from URL;
* good conformance with OSOS API;
* optionally: a configuration parameter to disable auth mechanisms inside RGW
  and delegate the work to Swift middleware.

What's your opinion? I would like to start a discussion to verify the concept.

Regards,
Radoslaw Zarzynski

[1] https://github.com/openstack/swift/tree/master/swift/common/middleware
[2] https://julien.danjou.info/blog/2013/extending-swift-with-a-middleware-clamav
[3] https://github.com/rzarzynski/rgwift
[4] http://pythonpaste.org/wsgiproxy/
