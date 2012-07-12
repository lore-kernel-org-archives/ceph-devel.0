From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH v2 03/16] libceph: define ceph_decode_string()
Date: Thu, 12 Jul 2012 12:13:47 -0500
Message-ID: <4FFF05CB.5000806@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD871B.6020704@inktank.com> <4FFDF9B3.3080909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59996 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161279Ab2GLRNt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 13:13:49 -0400
Received: by gglu4 with SMTP id u4so2657936ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 10:13:48 -0700 (PDT)
In-Reply-To: <4FFDF9B3.3080909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

OK, in a side discussion, Sage convinced me that since the only
user of this function would be ceph_extract_encoded_string()
(introduced in the next patch), and that under normal circumstances
that function most likely implements the most likely legitimate
use of this function, there is really no need for this function
to stand by itself.

So I'm retracting this patch, and am re-posting the next one,
which open-codes the functionality of ceph_decode_string()
directly inside ceph_extract_encoded_string().

					-Alex
