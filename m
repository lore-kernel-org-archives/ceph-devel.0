From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: mSHEC r35 release
Date: Sat, 24 Jan 2015 05:45:28 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA64E5A@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:47423 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbAXFpc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jan 2015 00:45:32 -0500
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7D43E3EE0B6
	for <ceph-devel@vger.kernel.org>; Sat, 24 Jan 2015 14:45:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 932C1AC0721
	for <ceph-devel@vger.kernel.org>; Sat, 24 Jan 2015 14:45:30 +0900 (JST)
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3A3C4E08004
	for <ceph-devel@vger.kernel.org>; Sat, 24 Jan 2015 14:45:30 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

Hi Loic,

We are sorry that test errors bothered you.
We have released mSHEC r35 just now.

https://github.com/t-miyamae/ceph

NOTABLE CHANGES
  - remove test errors
  - remove compile warnings

LIMITATION
  - only TestErasureCodeShec364.cc is still not available.
    We will fix it by 1/26(mon)

Best regards,
Takeshi Miyamae

