From: Travis Rhoden <trhoden@gmail.com>
Subject: snapshot storage use
Date: Tue, 17 Jul 2012 14:11:56 -0400
Message-ID: <CACkq2motpiYUmTNNJjFe-H0ZS95CaArz16MXMFxuqGHZ24Kt5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53923 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab2GQSMR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Jul 2012 14:12:17 -0400
Received: by bkwj10 with SMTP id j10so674466bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 Jul 2012 11:12:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey folks,

Sorry if this info is covered elsewhere -- I searched but was unable
to find a description of what I wanted.

Roughly how much storage is used by snapshots?  Is it really just
marking the version of certain objects, such that multiple snapshots
of the same (unchanged) object consume essentially no new space?
Correspondingly, once that object is finally modified, it is copied
and the snapshots still point to the original (old) copy?  Is this
done by using hardlinks or some other method?

Just wanted the 10,000 foot view explanation.  =)

Thanks,

 - Travis
