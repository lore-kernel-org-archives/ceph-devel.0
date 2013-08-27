From: Sage Weil <sage@inktank.com>
Subject: Re: is it possible to set up debug env for ceph?
Date: Tue, 27 Aug 2013 08:14:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308270812500.2000@cobra.newdream.net>
References: <2013082717200507206612@163.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1652583222-1377616467=:2000"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49743 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3H0PO2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 11:14:28 -0400
In-Reply-To: <2013082717200507206612@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-2022-JP?Q?=1B$BP$=3FM=1B=28J?= <ylyy-1985@163.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1652583222-1377616467=:2000
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[adding ceph-devel]

On Tue, 27 Aug 2013, ?? wrote:
> hi, sage,
> =A0
> Sorry to trouble you, recently I started to use ceph to deploy a TB clu=
ster,
> and it works with 10 osds and I love the S3=A0APIs! Thank god for your =
job and
> hope this project long live!
> I wonder if it is possible to set up a env to debug the source code? fi=
rst I
> am not so familiar with c++, can you point me out to some solutions wit=
h
> tools=A0or some docs, or some blogs? :)

You can build from source and get a test cluster going with

 git clone git://github.com/ceph/ceph
 cd ceph
 git submodule update --init
 ./do_autogen.sh
 make
 cd src
 mkdir out dev
 ./vstart.sh -d -n

vstart sets up a simple cluster in the current directory which is suitabl=
e=20
for development and testing.  Commands like

 ./init-ceph restart osd
 ./ceph -s

all work.

Good luck!
sage


--557981400-1652583222-1377616467=:2000--
