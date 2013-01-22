From: Nick Bartos <nick@pistoncloud.com>
Subject: Consistently reading/writing rados objects via command line
Date: Mon, 21 Jan 2013 17:01:19 -0800
Message-ID: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:41026 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3AVBBU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 20:01:20 -0500
Received: by mail-qa0-f43.google.com with SMTP id cr7so7183881qab.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 17:01:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I would like to store some objects in rados, and retrieve them in a
consistent manor.  In my initial tests, if I do a 'rados -p foo put
test /tmp/test', while it is uploading I can do a 'rados -p foo get
test /tmp/blah' on another machine, and it will download a partially
written file without returning an error code, so the downloader cannot
tell the file is corrupt/incomplete.

My question is, how do I read/write objects in rados via the command
line in such a way where the downloader does not get a corrupt or
incomplete file?  It's fine if it just returns an error on the client
and I can try again, I just need to be notified on error.
