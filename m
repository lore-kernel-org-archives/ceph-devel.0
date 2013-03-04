From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: a few cleanups
Date: Mon, 04 Mar 2013 12:08:14 -0600
Message-ID: <5134E30E.2090400@inktank.com>
References: <5134E25E.4030701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:49142 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab3CDSIO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:08:14 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so6450020iea.24
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:08:14 -0800 (PST)
In-Reply-To: <5134E25E.4030701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Three small cleanups in the libceph code.	-Alex

[PATCH 1/3] libceph: use (void *) for untyped data in osd ops
[PATCH 2/3] libceph: kill ceph_msg->pagelist_count
[PATCH 3/3] libceph: rename ceph_calc_object_layout()

