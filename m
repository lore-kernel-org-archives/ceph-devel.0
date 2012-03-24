From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: How to read CRUSH source code efficiently?
Date: Sat, 24 Mar 2012 15:35:12 +0800
Message-ID: <CALwGbP+9N8Ygzbqn9QxPENwcm4_ZeU0BGCYzE_kJvH3GrEX=EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33568 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2CXHfN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Mar 2012 03:35:13 -0400
Received: by iagz16 with SMTP id z16so5737869iag.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Mar 2012 00:35:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After reading the thesis about CRUSH, I proceed to read the related
source code in order to understand it more deeply and thoroughly.

But it's seems not to be efficient to read the source code files in
src/crush one by one.

I'd like to know where should I start? I think the pseudo code
"Algorithm 1" described in the thesis is quite important, but where
can I find the implementation of this algorithm?

Thanks.

Regards,
Sam
