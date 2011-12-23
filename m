From: <Eric_YH_Chen@wistron.com>
Subject: Why only support odd number monitors in ceph cluster?
Date: Fri, 23 Dec 2011 15:21:18 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49DABFBE6@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw5.wistron.com ([220.128.89.25]:51365 "EHLO
	TWNHUMSW5.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab1LWHVU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Dec 2011 02:21:20 -0500
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW5.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta177ed7929c0a816731438@TWNHUMSW5.wistron.com> for <ceph-devel@vger.kernel.org>;
 Fri, 23 Dec 2011 15:23:06 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

Hi, all:

=A0=A0=A0=A0 I am curious about why ceph cluster only support odd numbe=
r monitors.

=A0=A0=A0=A0 If we lose 1 monitor (becomes odd number),=20

      would it cause any problem if we do not handle this situation in =
short time?=20

=A0=A0=A0=A0 Thanks!

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
