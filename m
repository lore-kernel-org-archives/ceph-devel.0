From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: RadosGW storage format
Date: Thu, 7 Aug 2014 11:11:00 +0200
Message-ID: <CAF6-1L5XC+dFeOAx3bV34qL8T=cFif1xPg=o_L=NotZO4ehx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:53234 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbaHGJLB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Aug 2014 05:11:01 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so5042957pad.7
        for <ceph-devel@vger.kernel.org>; Thu, 07 Aug 2014 02:11:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


Is there a document somewhere describing the mapping from S3 to RADOS
? (things like how files are cut, what manifest are, what rados
features are used ....)

Reading the source code, it is not always obvious how things are
organized internally and you're never sure if you're understanding is
correct or not (which can be dangerous when you try to build stuff
based on that).


Cheers,

    Sylvain
