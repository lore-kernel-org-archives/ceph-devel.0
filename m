From: Kevin Cox <kevincox@kevincox.ca>
Subject: Wireshark Dissector and the Future
Date: Sun, 10 Aug 2014 08:22:32 -0400
Message-ID: <53E76408.9050000@kevincox.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:38246 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaHJMWe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Aug 2014 08:22:34 -0400
Received: by mail-qa0-f41.google.com with SMTP id j7so7185312qaq.28
        for <ceph-devel@vger.kernel.org>; Sun, 10 Aug 2014 05:22:34 -0700 (PDT)
Received: from [192.168.2.3] (bas1-ottawa11-1176224243.dsl.bell.ca. [70.27.193.243])
        by mx.google.com with ESMTPSA id 103sm1589738qgh.39.2014.08.10.05.22.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 05:22:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

This summer as a GSOC project I have implemented a Wireshark dissector
for Ceph.  It has been committed to Wireshark master and will be
available in the next release.

I have been talking with Sage and we have been identifying a couple of
next steps that need to be discussed about how the dissector will be
kept up to date and related issues.

Firstly there is the issue of the two existing dissectors sitting in the
Ceph tree.  Neither compile with a modern Wireshark and the new one is
far more complete.  The current plan is simply to delete them unless
anyone has objections or a better idea.

Secondly there is the issue of keeping the dissector up to date.  The
way it is written it should be fairly resilient to new messages and
encodings but of course to be the most useful it would understand the
latest version of the protocol.

There is documentation coming to both the Ceph tree and the top of the
Wireshark dissector (both mostly written but uncommitted) describing how
to update the dissector.  However we were wondering how updating the
dissector could become part of the regular workflow when updating Ceph.
 I have a couple of ideas myself but wanted to pitch it to the community
to see what we could come up with in addition to my thoughts which are
below.

1. Make if part of the review process. "Hey, I noticed you updated the
encoding of 'x' could you update the wireshark dissector as well."

2. Create a "static analysis" tool to check for current encoding
versions and warn if they are newer then what is supported by the
dissector.

3. Run the network traffic of automated tests (such as teuthology)
through Wireshark and check the warnings/errors.

I think number 3 is particularly interesting because it can catch more
then encoding mismatches and possibly other errors in the traffic.
However it needs much more integration and requires that the new
encodings are properly tested (although they should be anyway).

I would appreciate ideas and feedback about how this can/should be
handled and integrated into the pipeline.

Cheers,
Kevin

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlPnZAcACgkQwHWKOzTVLnTV/AD8D+ASjEYM4QEZY7LeP3hwFIaO
icK8icddehuxgqYL2qcA/jyHz8gKlQXu7uvjx/qHp0Crd3i8OohTyMbD2DkVMO/c
=Vzto
-----END PGP SIGNATURE-----
