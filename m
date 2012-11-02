From: Travis Rhoden <trhoden@gmail.com>
Subject: python-ceph
Date: Fri, 2 Nov 2012 15:53:48 -0400
Message-ID: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63224 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab2KBTyJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 15:54:09 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so4105280vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 12:54:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

Are there any plans to release python-ceph to pypi?  It would be nice
to see it packaged up in distutils/egg format and added to pypi, that
way other python packages can list it as a dependency.

I know there is currently a python-ceph package in Debian, but that
doesn't allow me to list it as a dependency in a setup.py file and
have it installed in a virtualenv, for example.  Right now I have to
copy rbd.py into my virtualenv.

Curious to know if this is something you would consider.  Perhaps it
is something I could help with.

Thanks,

 - Travis
