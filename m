From: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Subject: Deadline of Github pull request for Hammer release (question)
Date: Tue, 6 Jan 2015 11:49:09 +0000
Message-ID: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:42280 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054AbbAFLtN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 06:49:13 -0500
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 3D0F73EE16B
	for <ceph-devel@vger.kernel.org>; Tue,  6 Jan 2015 20:49:12 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 50333AC04F7
	for <ceph-devel@vger.kernel.org>; Tue,  6 Jan 2015 20:49:11 +0900 (JST)
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id EC722E08003
	for <ceph-devel@vger.kernel.org>; Tue,  6 Jan 2015 20:49:10 +0900 (JST)
Content-Language: ja-JP
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

Dear Loic,

I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.

Shingled Erasure Code (SHEC)
https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code_(SHEC)

We have revised our blueprint shown in the last CDS to extend our erasure code
layouts and describe the guideline for choosing SHEC among various EC plugins.
We believe the blueprint now answers all the comments given at the CDS.

In addition, we would like to ask for your advice on the schedule of our github
pull request. More specifically, we would like to know its deadline for Hammer
release.
(As we have not really completed our verification of SHEC, we are wondering if
we should make it open for early preview.)

Thank you in advance,
Takeshi Miyamae

