From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Data replication not working
Date: Thu, 28 Apr 2011 09:41:40 -0700
Message-ID: <BANLkTi=wcxddJTS_yk+7_UEU+_JGEh4qPA@mail.gmail.com>
References: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33608 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581Ab1D1Qln convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 12:41:43 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id C9700C065
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 09:41:42 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 78CBBC068
	for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 09:41:42 -0700 (PDT)
Received: by eyx24 with SMTP id 24so882790eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Apr 2011 09:41:40 -0700 (PDT)
In-Reply-To: <1303980121.11285.3.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2011 at 1:42 AM, Ajit K Jena <ajit@iitb.ac.in> wrote:
> =A0We have a one mon, one mds, and two osd setup. The data
> =A0stored goes to both the osds. We introduce a third osd.
> =A0the ceph status shows "osd: 3 up, 3 in" but no data goes
> =A0into the third osd. This remains the case even if we
> =A0power off one of the original osds.
What are you looking at to measure this? Just the OSD diskspace used,
or something else?

Did you follow the instructions on the wiki page carefully? Specifying
the new max_osd?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
