From: Gregory Farnum <greg@inktank.com>
Subject: Quantal gitbuilder is broken
Date: Fri, 8 Feb 2013 14:51:25 -0800
Message-ID: <CAPYLRzjEk88NEX3HmBoEuWtgsMsY5iMYU0X6YD6b1NtVaGTNAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47626 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab3BHWv0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 17:51:26 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so1596586qcs.20
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 14:51:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm not sure who's responsible for this, but I see everything is red
on our i386 Quantal gitbuilder. Probably just needs
libboost-program-options installed, based on the error I'm seeing in
one of my branches? Although there are some warnings I'm not too used
to seeing in there as well.
-Greg
