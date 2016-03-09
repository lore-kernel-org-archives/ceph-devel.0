From: Dan van der Ster <dan@vanderster.com>
Subject: default min_size for erasure pools
Date: Wed, 9 Mar 2016 15:25:32 +0100
Message-ID: <CABZ+qqnLbXY97REQOMRuNc2n+-f_g21bwU2E39XN6tCVfM_nJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33813 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719AbcCIO0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 09:26:16 -0500
Received: by mail-lb0-f177.google.com with SMTP id xr8so65505156lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 06:26:15 -0800 (PST)
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com. [209.85.217.173])
        by smtp.gmail.com with ESMTPSA id l5sm1332187lfd.22.2016.03.09.06.26.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 06:26:13 -0800 (PST)
Received: by mail-lb0-f173.google.com with SMTP id xr8so65503660lbb.1
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 06:26:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

For replicated pools we default to min_size=2 when size=3
(size-size/2) in order to avoid the split brain scenario, for example
as described here:
http://www.spinics.net/lists/ceph-devel/msg27008.html

But for erasure pools we default to min_size=k which I think is a
recipe for similar problems.

Shouldn't we default to at least min_size=k+1??

diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 77e26de..5d51686 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -4427,7 +4427,7 @@ int OSDMonitor::prepare_pool_size(const unsigned
pool_type,
       err = get_erasure_code(erasure_code_profile, &erasure_code, ss);
       if (err == 0) {
        *size = erasure_code->get_chunk_count();
-       *min_size = erasure_code->get_data_chunk_count();
+       *min_size = erasure_code->get_data_chunk_count() + 1;
       }
     }
     break;


Cheers, Dan
