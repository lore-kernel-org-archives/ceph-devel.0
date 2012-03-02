From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: git repository is gone
Date: Fri, 02 Mar 2012 20:06:00 +0100
Message-ID: <1330715160.2218.2.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:42146 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2CBTGE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:06:04 -0500
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.barcikacomp.hu (Postfix) with ESMTPA id F106A97BDA
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 20:05:58 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've realized that:
git/ceph $ git pull
fatal: The remote end hung up unexpectedly

Which is due to https://github.com/NewDreamNetwork/ceph being 404.
Is the repository moving to somewhere else? The homepage still reference
this address.

Laszlo/GCS

