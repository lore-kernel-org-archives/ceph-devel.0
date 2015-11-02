From: Yuri Weinstein <yweinste@redhat.com>
Subject: giant suites removed from nightlies
Date: Mon, 2 Nov 2015 10:16:31 -0800
Message-ID: <CAMMFjmFfQf3_SxZcYPJ67x4T92yt_swZe4OYaQhrXEF+bJS_EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36288 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbbKBSQc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 13:16:32 -0500
Received: by wmec75 with SMTP id c75so67726734wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 10:16:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-qa <ceph-qa@ceph.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>

As giant was declared EOL all related suites had been removed from the schedule:

#giant EOL 15 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps
-s upgrade/dumpling-firefly-x ~/vps.yaml

#giant EOL 18 18 * * 3,6 teuthology-suite -v -c giant -k distro -m vps
-s upgrade/firefly-x ~/vps.yaml

#giant EOL 05 17 * * 1,5 teuthology-suite -v -c hammer -k distro -m
vps -s upgrade/giant-x ~/vps.yaml

Thx
YuriW
