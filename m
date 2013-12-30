From: Justin Erenkrantz <justin@erenkrantz.com>
Subject: Apache httpd directives for rgw
Date: Mon, 30 Dec 2013 15:19:10 -0500
Message-ID: <CAOGLoJPPiaRRYvJ8ZaDr5LevBBtOZyz=6CFiinx8bG2hEX9Hzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53943 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab3L3UTM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 15:19:12 -0500
Received: by mail-ee0-f41.google.com with SMTP id t10so5273458eei.14
        for <ceph-devel@vger.kernel.org>; Mon, 30 Dec 2013 12:19:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi ceph-devel@,

As a note, I've upstreamed functionality similar to the ones in the
ceph/apache2 repository.  In particular, you'd use:

HttpContentLengthHeadZero on
HttpExpectStrict off

For the upstream commit:
http://svn.apache.org/viewvc?view=revision&revision=1554303

And, for those that only like GitHub URLs:
https://github.com/apache/httpd/commit/1a950459084dbbceeff441f7fff1d03bdadddd03

On dev@httpd, we're still discussing whether the default
HttpContentLengthHeadZero functionality should be on or off.  I think
it should be "on"...

After that conversation dies down, I'll probably propose it for
backport to 2.4...but, it changes the MMN (in theory), so it may not
be able to be properly released until 2.6.  We'll see.

Cheers.  -- justin
