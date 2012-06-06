From: <Eric_YH_Chen@wiwynn.com>
Subject: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 09:16:36 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:61311 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab2FFBQx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 21:16:53 -0400
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta4cd82189dc0a8167216b0@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Wed, 6 Jun 2012 09:21:31 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear All:

=A1@=A1@My ceph cluster is installed on Ubuntu 12.04 with kernel 3.2.0.
=A1@=A1@
    But I have a situation that I may need to mount cephfs on centos 5.=
7, which with kernel 2.6.18.

    (that is to say , I only need to execute mount.ceph on the centos 5=
=2E7, not the whole ceph system)

    I want to find a solution that can provide reliable and high availa=
bility share file system.=20

    Is it possible to do this? Or any other recommend way?  Ex:  export=
 NFS=A1K

    Thanks!


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
