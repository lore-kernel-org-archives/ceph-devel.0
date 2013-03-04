From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: distinguish osd request read and write data
Date: Mon, 04 Mar 2013 12:16:53 -0600
Message-ID: <5134E515.6010006@inktank.com>
References: <5134E25E.4030701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33313 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDSQw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:16:52 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so6408559ieb.20
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:16:52 -0800 (PST)
In-Reply-To: <5134E25E.4030701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Encapsulate information about osd request data into a
separate data structure, and define separate instances of
that structure for incoming and outgoing data.

					-Alex

[PATCH 1/3] libceph: separate osd request data info
[PATCH 2/3] libceph: distinguish page and bio requests
[PATCH 3/3] libceph: separate read and write data
