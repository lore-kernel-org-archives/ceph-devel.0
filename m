From: "Jim Schutt" <jaschut@sandia.gov>
Subject: unstable crushtool fails to open log file
Date: Wed, 5 Jan 2011 11:39:06 -0700
Message-ID: <1294252746.4984.154.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:32773 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab1AESjT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jan 2011 13:39:19 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 101D04834BC
	for <ceph-devel@vger.kernel.org>; Wed,  5 Jan 2011 11:39:14 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id p05Ictx1016029 for
 <ceph-devel@vger.kernel.org>; Wed, 5 Jan 2011 11:38:55 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

unstable branch crushtool is failing for me like this:

# crushtool --num_osds 32 -o test.crushmap --build shelf uniform 8 host uniform 1 root straw 0
failed to open log file '/var/log/ceph/': error 21: Is a directory

This error seems to happen at crushtool.cc:925:

925           dout(0) << "layer " << type
926                   << "  " << l.name
927                   << "  bucket type " << l.buckettype
928                   << "  " << l.size 
929                   << dendl;


AFAICS commit 986c2af4aeb switched dout to use DoutStreambuf,
and by default (commit 952111451c3) everything now logs to a
file.

What's the right way to get crushtool to log to stdout or
stderr?  Or, how to I get crushtool to use a log file
of my choice?

Thanks -- Jim



