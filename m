From: huang jun <hjwsm1989@gmail.com>
Subject: why client change "max_size" when writting?
Date: Wed, 27 Apr 2011 17:58:49 +0800
Message-ID: <BANLkTin4dUrh0J6TMjTv=w6bjC=dk7Gppw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33957 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952Ab1D0J6u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 05:58:50 -0400
Received: by wwa36 with SMTP id 36so1696409wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 02:58:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,developers
  when write a file, why did client send a message to mds to change
the variable "max_size" in inode  ? so, if we don't change the
"max_size", what  consequence we  will get? and why the client will
not write if the mds didn't return the changed "max_size" to client?

thanks!
