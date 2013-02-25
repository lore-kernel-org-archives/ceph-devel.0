From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/4] libceph: abstract setting message data info
Date: Mon, 25 Feb 2013 17:40:51 -0600
Message-ID: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:59189 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759584Ab3BYXky (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:40:54 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so3823975iea.12
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:40:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This series makes the fields related to the data portion of
a ceph message not get manipulated by code outside the ceph
messenger.  It implements some interface functions that can
be used to assign data-related fields.  Doing this will allow
the way message data is managed to be changed independent
of the users of the messenger module.

					-Alex

[PATCH 1/4] libceph: distinguish page array and pagelist count
[PATCH 2/4] libceph: set page alignment in start_request()
[PATCH 3/4] libceph: isolate message page field manipulation
[PATCH 4/4] libceph: isolate other message data fields
