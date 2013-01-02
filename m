From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Ceph logging level
Date: Wed, 2 Jan 2013 14:28:24 +0100
Message-ID: <CAOLwVU=sxV3U81b3j-r-2=sEruFkOryhv46toPeRgT1Pqj19Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:50711 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3ABN2q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 08:28:46 -0500
Received: by mail-la0-f44.google.com with SMTP id fr10so6074534lab.31
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 05:28:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

I've been struggling with Ceph logging.

As far as I saw we can log to syslog but we can't specify any
facility. So my question is: which facility does ceph use by default?

Second thing is, I'm sick of all those "log [INF]" messages from the
ceph-mon, like:

Jan  2 13:27:07 ceph02 ceph-mon: 2013-01-02 13:27:07.749511
7f227b2fa700  0 log [INF] : pgmap v74529: 80 pgs: 80 active+clean;
9753 MB data, 17012 MB used, 383 GB / 399 GB avail

Is there a way to disable them? Which level is that? INFO? DEBUG?

Ideally I'd like to disable all INFO logs, I only want to see ERROR log=
s.

Thanks you in advance :-)

--
Regards,
S=E9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
