From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: RE: hammer is frozen
Date: Fri, 6 Feb 2015 12:25:17 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA6BE81@g01jpexmbyt24>
References: <alpine.DEB.2.00.1502041242400.27042@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168]:46505 "EHLO
	mgwkm01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838AbbBFMfu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 07:35:50 -0500
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id D7903AC074E
	for <ceph-devel@vger.kernel.org>; Fri,  6 Feb 2015 21:25:20 +0900 (JST)
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 408121DB803A
	for <ceph-devel@vger.kernel.org>; Fri,  6 Feb 2015 21:25:20 +0900 (JST)
In-Reply-To: <alpine.DEB.2.00.1502041242400.27042@cobra.newdream.net>
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

Hi Sage,

> If there is something exceptional that hasn't made it in yet and is low-risk,
> plea your case,

We would like to contribute our following code to the nearest stable release
Hammer, and we believe that our code has sufficiently low risk.

 mSHEC : multiple Shingled Erasure Code #3534
 https://github.com/ceph/ceph/pull/3534

One of the reasons why we think it has low risk is that we have already
finished extended tests shown below assuming a product use case.

 Test items done:
  * erasure code plugin I/F tests (TestErasureCodeShec.cc)
  * exhaustive parity layouts tests (TestErasureCodeShec_all.cc)
  * thread safety tests (TestErasureCodeShec_thread.cc)
  * tests on a real ceph cluster
     - pool creation/deletion
     - read/write
     - recovery (up to N multiple failures)

Another reason is that the code is just a plugin, which is completely
isolated from the core of Ceph and has no risks for users who do not
need to use it.

Best regards,
Takeshi Miyamae

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, February 5, 2015 5:51 AM
To: ceph-devel@vger.kernel.org
Subject: hammer is frozen

I created the branch on Monday, but am traveling and forgot to send an email.  This means we're not merging new features until we have a handle on the testing and the QA results are looking good.

Specifically:

- There is a 'hammer' ceph.git branch.  Please target any bug fixes at
  this.

- The 'next' branch is deleted for the time being (see above)

- Do not merge any new features to master; not yet.  It's too confusing
  and we have enough work to do stabilizing things.

- There are still several pull requests open that are bug fixes and target
  master that should get merged once they are tested, so we will probably
  merge hammer and master together periodically to avoid doing all the
  merged manually.  (Another reason not to merge any new code into master
  that does not target hammer.)

- We're using the 'hammer' milestone on github to track what to pay
  attention to.  Please help keep it in sync with the open pull
  requests that are hammer-bound vs future work for infernalis.

If there is something exceptional that hasn't made it in yet and is low-risk, plea your case, but no promises.  Bribery in the form of fixes for open bugs can be effective.  :)

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
