From: hemant surale <hemant.surale@gmail.com>
Subject: Ho to identify location of Primary Copy Of Obj ?
Date: Tue, 25 Sep 2012 15:00:30 +0530
Message-ID: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:40531 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2IYJab (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 05:30:31 -0400
Received: by vbbff1 with SMTP id ff1so7119536vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 02:30:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Community,
          Is it possible to identify where exactly primary copy of obj
is stored ? I am using crushmaps to use specific osds for data
placement but i want to knw the primary capoy location. Or I need to
replace pseudo random function by some deterministic function to guide
ceph to utilize specific osd?


Regards,
Hemant Surale.
