From: huang jun <hjwsm1989@gmail.com>
Subject: async+direct IO in osd journal write
Date: Sat, 20 Aug 2011 11:03:38 +0800
Message-ID: <CABAwU-bcnVUn3d3HytywkEYdzZySxtBFT6=-nXOGA+ppNhCg0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38489 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab1HTDDj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2011 23:03:39 -0400
Received: by vws1 with SMTP id 1so2846771vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2011 20:03:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
Recently,we have a test to compare  async i/o and sync i/o in OSD.
The osd jounral was written in sync + direct io mode now, that heavily
infuluenced the write performance.
we use linux aio API. test file size is 40MB,and disk isn't busy.
here is the test result:
          type                  ext3
sync write+direct io      4.441s

async write +direct io   0.462s

we are glad to see that, so we want to affirm that :
1) can we use async+direct io to achieve better write performance if
we used osd journal?
2) does this  bring some problems?

thank you in advance!
