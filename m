From: yue longguang <yuelongguang@gmail.com>
Subject: Fwd: question about object replication theory
Date: Thu, 25 Sep 2014 09:03:05 +0800
Message-ID: <CAPaK2r-dmpGaO6Y7HHC+CCBocyw9WskvaqKufMNwKTfvA5YH5Q@mail.gmail.com>
References: <CAPaK2r9eWn=GaEsMabtepjCOtBpvjOyE3vnpcFsUpuC2YJ_XJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41903 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaIYBDG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Sep 2014 21:03:06 -0400
Received: by mail-ie0-f172.google.com with SMTP id rp18so10709381iec.17
        for <ceph-devel@vger.kernel.org>; Wed, 24 Sep 2014 18:03:05 -0700 (PDT)
In-Reply-To: <CAPaK2r9eWn=GaEsMabtepjCOtBpvjOyE3vnpcFsUpuC2YJ_XJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sweil@redhat.com, ceph-devel@vger.kernel.org

---------- Forwarded message ----------
From: yue longguang <yuelongguang@gmail.com>
Date: Tue, Sep 23, 2014 at 5:37 PM
Subject: question about object replication theory
To: ceph-devel@vger.kernel.org


hi,all
   take a look at the link ,
http://www.ceph.com/docs/master/architecture/#smart-daemons-enable-hyperscale
could you explain  point 2, 3 in that picture.

1.
at point 2,3, before primary writes data  to next osd, where is the
data?  it is in momory or on disk already?

2. where is the  code of point 2 or 3,  at there  primary distributes
data to others?

thanks
