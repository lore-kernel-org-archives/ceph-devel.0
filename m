From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: differents ip/network link for osd replication and client->osd ?
Date: Thu, 31 May 2012 17:21:20 +0200 (CEST)
Message-ID: <e816b4c6-b8fe-4050-b72d-32d69e75e686@mailpro>
References: <a66b92df-f82d-4f3b-a9df-5dfe3b25f869@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:45005 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab2EaPcT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 11:32:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 1907D1805B5FA
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 17:21:26 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kg-0SK1srNdx for <ceph-devel@vger.kernel.org>;
	Thu, 31 May 2012 17:21:20 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id DF28318063BC5
	for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 17:21:20 +0200 (CEST)
In-Reply-To: <a66b92df-f82d-4f3b-a9df-5dfe3b25f869@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
Is it possible to use differents ip / network link for 

- replication between osd
- network between client and osd 

?

I would like to use differents swichs/network card for osd replication.

Regards,

Alexandre
