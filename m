From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: simplify incoming message allocation
Date: Mon, 04 Mar 2013 12:10:53 -0600
Message-ID: <5134E3AD.4080906@inktank.com>
References: <5134E25E.4030701@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:55894 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab3CDSKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:10:55 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so5113034iaf.14
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:10:55 -0800 (PST)
In-Reply-To: <5134E25E.4030701@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Simplify the code that allocates a message for incoming data
by having all users of the messenger interface define an
alloc_msg method.

					-Alex

[PATCH 1/3] libceph: drop mutex while allocating a message
[PATCH 2/3] libceph: define mds_alloc_msg() method
[PATCH 3/3] libceph: no need for alignment for mds message
