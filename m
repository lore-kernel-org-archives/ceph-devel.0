From: Sage Weil <sage@inktank.com>
Subject: new pgp key for release debs
Date: Sun, 20 May 2012 21:42:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205202138250.843@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56267 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab2EUEmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 00:42:40 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7FA62BC7C1
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 21:42:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 35307BC7C1
	for <ceph-devel@vger.kernel.org>; Sun, 20 May 2012 21:42:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I generated a new PGP key to sign releases with, instead of using my 
personal key.  The new key is signed by my key and is available at

	https://github.com/ceph/ceph/raw/master/keys/release.asc

or from a public keyserver.  The fingerprint is

pub   4096R/17ED316D 2012-05-20
      Key fingerprint = 7F6C 9F23 6D17 0493 FCF4  04F2 7EBF DD5D 17ED 316D
uid                  Ceph Release Key <sage@newdream.net>

You can add it to your APT keyring with

	wget -q -O- https://raw.github.com/ceph/ceph/master/keys/release.asc | sudo apt-key add -

(as per the instructions at http://ceph.com/docs/master/install/debian/).  
If you had my key in there from before, you can remove it with

	apt-key del 288995c8

sage
