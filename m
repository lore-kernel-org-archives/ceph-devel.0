From: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens@shadow.gt.owl.de>
Subject: how to remove laggy mds ?
Date: Fri, 03 Feb 2012 20:48:32 +0100
Message-ID: <4F2C3A10.1040605@shadow.gt.owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:59354 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2BCTzP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 14:55:15 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List,

one of my test mds servers died a few days ago. (hardware crash) I will
not buy a new one.

Is there any chance to remove this laggy mds ?

2012-02-03 20:38:53.801623   mds e86436: 2/2/1 up
{0=0=up:resolve,1=0=up:resolve(laggy or crashed)}
2012-02-03 20:39:08.943880   mds e86437: 2/2/1 up
{0=0=up:resolve,1=0=up:resolve(laggy or crashed)}
2012-02-03 20:39:24.094926   mds e86438: 2/2/1 up
{0=0=up:resolve,1=0=up:resolve(laggy or crashed)}
2012-02-03 20:39:39.236560   mds e86439: 2/2/1 up
{0=0=up:resolve,1=0=up:resolve(laggy or crashed)}

Thanks !!

Jens
