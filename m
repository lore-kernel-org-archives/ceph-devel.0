From: Andrey Korolyov <andrey@xdel.ru>
Subject: XFS preallocation with lot of small objects
Date: Wed, 11 Dec 2013 11:24:23 +0400
Message-ID: <52A81327.1000402@xdel.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:45932 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab3LKHZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 02:25:39 -0500
Received: by mail-bk0-f43.google.com with SMTP id mz12so148222bkb.16
        for <ceph-devel@vger.kernel.org>; Tue, 10 Dec 2013 23:25:38 -0800 (PST)
Received: from [192.168.1.34] (95-31-29-125.broadband.corbina.ru. [95.31.29.125])
        by mx.google.com with ESMTPSA id no2sm13779559bkb.15.2013.12.10.23.25.36
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 23:25:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

Due to lot of reports of ENOSPC for xfs-based stores may be it worth to
introduce an option to, say, ceph-deploy which will pass allocsize=
param to the mount effectively disabling Dynamic Preallocation? Of
course not every case really worth it because of related performance
impact. If there is any method to calculate 'real' allocation on such
volumes, it can be put to the docs as a measurement suggestion too.
