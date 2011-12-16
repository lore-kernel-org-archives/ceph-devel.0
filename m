From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Python packages status
Date: Fri, 16 Dec 2011 11:43:35 -0800
Message-ID: <CAORUGqBqvRmk9200+kmOPDnWG61usbTEgk8uU6g+JONkae=bzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33493 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab1LPTn5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 14:43:57 -0500
Received: by faar15 with SMTP id r15so3212392faa.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 11:43:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Jay Pipes <jaypipes@gmail.com>

Hi. Jay brought up the state of Ceph's Python bindings in a
conversation, and I wanted to share this reasoning with the whole
list.

Note, I'm talking about debs, rpm etc case is similar but separate.

- The python bindings we have are not currently pip-installable.
- We could make them pip-installable. The easiest way to that would be
to split them out to a separate source package. This is not as useful
as it seems, as they'll require the underlying librados / librbd /
librgw etc libraries to be available. And if we find ctypes
insufficient for the bindings, then "pip install" will start needing
the -dev packages also installed.
- If you can't just take a base OS and do "pip install rbd", but need
to install the Ceph library packages, you might as well get the python
modules from the "python-ceph" package at the same time.
- We want to use the Python bindings internally, to test Ceph, as part
of automated tests. Splitting them out to separate source is in
conflict with this desire.

For Debian-based systems, here's how to get usable Python libraries for Ceph:
1. Follow the installation guide at
http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/
2. Run "sudo apt-get install python-ceph"

You can quickly check that they work with python -c 'import rbd'

API docs, as much as they exist currently, are at
http://ceph.newdream.net/docs/latest/api/librbdpy/ and more will come
as siblings of that document later.
