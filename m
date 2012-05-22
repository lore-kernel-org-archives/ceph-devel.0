From: Yehuda Sadeh <yehuda@inktank.com>
Subject: RGW, future directions
Date: Tue, 22 May 2012 11:07:53 -0700
Message-ID: <CAC-hyiHQ1oy6cyB-sQHd5b6XQhCgQxHrLDcvzWO0OOwGWfFsRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45389 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab2EVSHy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 14:07:54 -0400
Received: by bkcji2 with SMTP id ji2so5244801bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 11:07:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

RGW is maturing. Beside looking at performance, which highly ties into
RADOS performance, we'd like to hear whether there are certain pain
points or future directions that you (you as in the ceph community)
would like to see us taking.

There are a few directions that we were thinking about:

1. Extend Object Storage API

Swift and S3 has some features that we don't currently support. We can
certainly extend our functionality, however, is there any demand for
more features? E.g., self destructing objects, web site, user logs,
etc.

2. Better OpenStack interoperability

Keystone support? Other?

3. New features

Some examples:

=A0- multitenancy: api for domains and user management
=A0- snapshots
=A0- computation front end: upload object, then do some data
transformation/calculation.
=A0- simple key-value api

4. CDMI

Sage brought up the CDMI support question to ceph-devel, and I don't
remember him getting any response. Is there any intereset in CDMI?


5. Native apache/nginx module or embedded web server

We still need to prove that the web server is a bottleneck, or poses
scaling issues. Writing a correct native nginx module will require
turning rgw process model into event driven, which is not going to be
easy.

6. Improve garbage collection

Currently rgw generates intent logs for garabage removal that require
running an external tool later, which is an administrative pain. We
can implement other solutions (OSD side garbage collection,
integrating cleanup process into the gateway, etc.) but we need to
understand the priority.

7. libradosgw

We have had this in mind for some time now. Creating a programming api
for rgw, not too different from librados and librbd. It'll hopefully
make code much cleaner. It will allow users to write different front
ends for the rgw backend, and it will make it easier for users to
write applications that interact with the backend, e.g., do processing
on objects that users uploaded, FUSE for rgw without S3 as an
intermediate, etc.

8. Administration tools improvement

We can always do better there.

9. Other ideas?


Any comments are welcome!

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
