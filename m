From: Travis Rhoden <trhoden@gmail.com>
Subject: [ANN] ceph-deploy 1.5.21 released
Date: Wed, 10 Dec 2014 12:02:18 -0500
Message-ID: <CACkq2mqq8_3XGcvXMdHB1iD9EmFNQ2L6qM38k63HonD-UNTLFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:48279 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755312AbaLJRCl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 12:02:41 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so2809685lab.18
        for <ceph-devel@vger.kernel.org>; Wed, 10 Dec 2014 09:02:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-announce@lists.ceph.com

Hi All,

This is a new release of ceph-deploy that defaults to installing the
Giant release of Ceph.

Additionally, there are a couple of bug fixes that makes sure that
calls to 'gatherkeys' returns non-zero upon failure, and that the EPEL
repo is properly enabled as a prerequisite to installation on CentOS
and Scientific Linux distros.

The full changelog can be seen here:
http://ceph.com/ceph-deploy/docs/changelog.html#id1

Please update!

 - Travis
