From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/2] rbd: consolidate argument parsing
Date: Fri, 26 Oct 2012 17:52:29 -0500
Message-ID: <508B142D.7080907@inktank.com>
References: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:37100 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZWwc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:52:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4477273iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:52:32 -0700 (PDT)
In-Reply-To: <508B11E3.3040108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series moves some code that handles argument parsing
out of rbd_get_client() and into rbd_add_parse_args().

					-Alex

[PATCH 1/2] rbd: move ceph_parse_options() call up
[PATCH 2/2] rbd: do all argument parsing in one place
