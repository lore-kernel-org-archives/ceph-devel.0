From: Dan Mick <dan.mick@inktank.com>
Subject: include/ and -I
Date: Fri, 02 Nov 2012 14:14:57 -0700
Message-ID: <509437D1.9080105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37517 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2KBVPB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 17:15:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2706507pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 14:15:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I was somewhat surprised to note that we don't build with -I include, so 
that files that userland programs would find with 
relative-to-/usr/include paths have to be modified for building in the tree.

Was this conscious, or does anyone else think it would be smoother to
-I include/ so that outside-the-tree and inside-the-tree #includes are 
more similar?
