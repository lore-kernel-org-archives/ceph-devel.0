From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/8] rbd: have rbd_add_parse_args() only parse args
Date: Fri, 26 Oct 2012 17:56:05 -0500
Message-ID: <508B1505.20209@inktank.com>
References: <508B11E3.3040108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49629 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934127Ab2JZW4M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:56:12 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4479692iea.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 15:56:12 -0700 (PDT)
In-Reply-To: <508B11E3.3040108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

rbd_add_parse_args() parses options written to the "add" entry in
/sys/bus/rbd/, but it does a mix of other things as well.  This
series rearranges things such that the only thing that function
does is parse arguments, and encode the information found into
some data structures that are used later for configuration and
setting up new mapped rbd images.

					-Alex

[PATCH 1/8] rbd: get rid of snap_name_len
[PATCH 2/8] rbd: remove options args from rbd_add_parse_args()
[PATCH 3/8] rbd: remove snap_name arg from rbd_add_parse_args()
[PATCH 4/8] rbd: pass and populate rbd_options structure
[PATCH 5/8] rbd: have rbd_add_parse_args() return error
[PATCH 6/8] rbd: define image specification structure
[PATCH 7/8] rbd: add reference counting to rbd_spec
[PATCH 8/8] rbd: fill rbd_spec in rbd_add_parse_args()
