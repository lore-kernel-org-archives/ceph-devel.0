From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: [rgw] Multi-tenancy support in radosgw
Date: Sat, 12 Sep 2015 00:24:27 +0200
Message-ID: <CA+H5UW0Y2Yc7jSG=iZ5bFpSEFsPpb50tgG1FUxRZFihf904yiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35099 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbIKWY2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 18:24:28 -0400
Received: by wicge5 with SMTP id ge5so78872708wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 15:24:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>

Hello,

It's a well-known trait of radosgw that an user cannot create new
bucket with a given name if the name is already occupied by other
user's bucket (request to do that will be rejected with 409 Conflict).
This behaviour is entirely expected in S3. However, when it comes
to Swift API, it turns into huge limitation.

In my opinion the root cause lies in how radosgw actually handles
bucket entry points. They might be seen as symlinks which must
be resolved in order to map bucket names exposed to users into
concrete bucket instances:

  bucket name -> unique bucket instance ID

It's completely clear we need to preserve backward compatibility.
Thus we cannot simply append ID of user who owns a given
bucket to argument list of mapping function. We would have to
introduce an indirection layer - bucket namespaces:

  bucket namespace, bucket name -> unique bucket instance ID

Each already existing user would obtain empty bucket namespace
by default. It will be possible to create user  with his own, unique
namespace.

Generally this looks to me as stupidly simple solution. Of course,
it has limitations. At the moment I see following things:

1. We may need to develop a new mechanism for moving buckets
    between namespaces in radosgw-admin. The already existing
    one for linking/unlinking might be not enough.

2. We will always need ID of namespace in order to access proper
    bucket entry points. This is not a problem for requests authorized
    through Keystone/TempAuth because user ID is known and thus
    BNS may be easily calculated.
    Anonymous access/TempURL for bucket with non-empty namespace
    is a different story. In this case BNS must be provided explicitly.
    Swift resolves the problem by having account name as a part of URL.
    We could go the same way. This would be extended by decoupling
    rgw_user used for storage access purposes from the one for
    authorizing a given operation (RGWOp::verify_permission() method).


I would like to ask for reviews of the idea and feedback.

Best regards,
Radoslaw Zarzynski
