From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: jewel debian package : wrong /etc/default/ceph/ceph file location
Date: Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Message-ID: <1752231615.399259087.1461427008299.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:42119 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbcDWP4v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Apr 2016 11:56:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id C72BA4CF25784
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9zcF3b-nbU59 for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id A02A04CF25791
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JTYhpjER3l1o for <ceph-devel@vger.kernel.org>;
	Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 619024CF2578D
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 17:56:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

debian package install default file in /etc/default/ceph/ceph

rules :
  install -d -m0755 debian/ceph-common/etc/default/ceph
  install -m0644 etc/default/ceph debian/ceph-common/etc/default/ceph


it should be
/etc/default/ceph

as systemd unit use it

  /lib/systemd/system/ceph-mon@.service:EnvironmentFile=-/etc/default/ceph
  /lib/systemd/system/ceph-osd@.service:EnvironmentFile=-/etc/default/ceph
  /lib/systemd/system/ceph-create-keys@.service:EnvironmentFile=-/etc/default/ceph


