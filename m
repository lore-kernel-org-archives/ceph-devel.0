From: Greg Chavez <greg.chavez@gmail.com>
Subject: Enabling http proxy for ceph-deploy installation
Date: Mon, 6 May 2013 14:16:21 -0400
Message-ID: <CAMTcKhbgjM8SLX1X08nsL4xFj-JSYET38J70EsSTi+hCYinpYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:55969 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab3EFSQW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 14:16:22 -0400
Received: by mail-we0-f172.google.com with SMTP id s10so3258336wey.17
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 11:16:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

My first post here.

I'm going to put together a pull request to force the ceph-deploy
bootstrap process to utilize the shell environment's http_proxy
variable, such that installations can occur smoothly behind a Web
proxy.  However, my python fu is terrible outside of a writing single
script, so I was hoping somebody might offer a suggestion for the
simplest way to accomplish this.

Right now, I'm looking at adding the following to the bootstrap script
(line 41):

BEFORE:

    ./virtualenv/bin/pip install -r requirements.txt -r requirements-dev.txt

AFTER:

    ./virtualenv/bin/pip install --proxy=${http_proxy#http://} -r
requirements.txt -r requirements-dev.txt

That would pull the env variable $http_proxy out and chop off the "http://".

What is going to be more difficult is figuring how to get line 40 to
incorporate the proxy:

    ./virtualenv/bin/python setup.py develop

Will I have to edit all the pulls to use something like ururllib2, or
is there something simpler I can do?

Thanks for any suggestions!

--
\*..+.-
--Greg Chavez
+//..;};
