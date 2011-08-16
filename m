From: =?ISO-8859-2?Q?Maciej_Ga=B3kiewicz?=
	<maciejgalkiewicz@ragnarson.com>
Subject: Separating clients data
Date: Tue, 16 Aug 2011 14:35:09 +0200
Message-ID: <CAGqxmDOGnrRPgyRFBW28f6zm7Fy-mrhSbBERceZD=KeU3P4GvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59937 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab1HPMfK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Aug 2011 08:35:10 -0400
Received: by ywf7 with SMTP id 7so3720320ywf.19
        for <ceph-devel@vger.kernel.org>; Tue, 16 Aug 2011 05:35:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a storage cluster based on glusterfs. Each client have its own
volume and his is not able to mount any other. Is it possible to
implement such separation with ceph? I have read about authentication
and mounting subdirectories. I am not sure if I can configure
different login/pass for selected directories stored in ceph. All
clients are running on Xen's domU (virtual machine). Maybe there is
some other way to achieve this?

-- 
Regards
Maciej Galkiewicz
