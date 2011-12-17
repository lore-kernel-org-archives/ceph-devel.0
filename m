From: <Eric_YH_Chen@wistron.com>
Subject: Hang when mapping a long name rbd image
Date: Sat, 17 Dec 2011 10:21:03 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49DA2ECA6@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:52949 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab1LQCVI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 21:21:08 -0500
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta157f7016bc0a81672bec@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Sat, 17 Dec 2011 10:25:40 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Hi, all:

My ceph version is
ceph version 0.39 (commit:321ecdaba2ceeddb0789d8f4b7180a8ea5785d83)

When I try to map a long name rbd image to device, it would hang for
long time.

For example:
sudo rbd map iqn.2012-01.com.sample:storage.ttttttt --secret
/etc/ceph/secretfile sudo rbd map iqn.2012-01.com.sample:storage.abcdef
--secret /etc/ceph/secretfile

It would not hang at every long name image, however, it only happens
when the image name is very long.

Is it a known issue? 

Thanks!

