From: Nick Bartos <nick@pistoncloud.com>
Subject: python examples for librados
Date: Wed, 23 Jan 2013 13:09:23 -0800
Message-ID: <CAPud5_49XgVGva0J9XJT-pysCo4nxCXJDDUGkT-BmxHNYsNr5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:47309 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWVJY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 16:09:24 -0500
Received: by mail-qa0-f42.google.com with SMTP id hg5so870157qab.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 13:09:24 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I just recently found out that ceph has some python bindings (yay!).
I see there are a couple of examples for using the rbd bindings here:
http://ceph.com/docs/master/rbd/librbdpy/

But that doesn't really include much about the librados bindings.  Are
there any examples for that?  For example I'm interested in converting
the following commands into python:

rados -p foo put test.tmp test --object-locator test
rados -p foo clonedata test.tmp test --object-locator test
rados -p foo rm test.tmp --object-locator test
rados -p foo get test test.downloaded
