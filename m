From: Thomas Mueller <thomas@chaschperli.ch>
Subject: rbdtool.cc : =?iso-8859-7?b?oXKi?= may be used uninitialized in
 this function
Date: Wed, 30 Jun 2010 05:35:19 +0000 (UTC)
Message-ID: <i0el2n$usb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36854 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab0F3Ff1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jun 2010 01:35:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OTpxG-00036c-Fw
	for ceph-devel@vger.kernel.org; Wed, 30 Jun 2010 07:35:26 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 07:35:26 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 07:35:26 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi

since today there is a new compiler warning:

rbdtool.cc:180: warning: =E2=80=98r=E2=80=99 may be used uninitialized =
in this function

- Thomas

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
