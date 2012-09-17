From: hemant surale <hemant.surale@gmail.com>
Subject: How to use ruleset
Date: Mon, 17 Sep 2012 15:12:44 +0530
Message-ID: <CAGfy=6=6P1zA-0gkBqEowuuiP0qqCjnFpGCSM-R0xKBL13W7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39292 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab2IQJmo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 05:42:44 -0400
Received: by vcbfo13 with SMTP id fo13so5967841vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 02:42:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Community,

         I have read the documentation to know crush map as well as
inserting new crushmap, But I have qn that even after writing own rule
for data placement how we can apply it for data placement? in short
how to utilize newly specified rule when new data insertion is
executed.

        Currently I am using "rados -p <poolname> put/get Objname
filename" cmd to put/get data into ceph.

Thanks for helping me out till now.



Regards,
Hemant Surale.
