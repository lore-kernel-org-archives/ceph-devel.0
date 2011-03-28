From: huang jun <hjwsm1989@gmail.com>
Subject: a problem related to stray directory
Date: Mon, 28 Mar 2011 10:19:40 +0800
Message-ID: <AANLkTik+SrDTRi06ioOnitOgvZRYSFpnD3SLaOPrTmGe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38247 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab1C1CTl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2011 22:19:41 -0400
Received: by vws1 with SMTP id 1so1956124vws.19
        for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2011 19:19:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi
  i just have another question.when a file is unlinked it goes into
the stray directory.eval_stray() will be called, in the eval_stray()
will check dirfrags is empty or no,
  but i look log  file , the source exits after checked the dirfrag. i
can't find the trim_dirfrags() or close_dirfrags() be called in the
log file
  so  i have a problem, when trim_dirfrags() or close_dirfrags() will be called.
 thanks
