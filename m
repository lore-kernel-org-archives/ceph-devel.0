From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: rbd unmap deadlock
Date: Fri, 2 May 2014 18:09:01 +0200
Message-ID: <CABt9es8sEPBgg+CHypYKyPO+Reuzb8roe2b5c0CRGG91WmK1Fg@mail.gmail.com>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:40174 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaEBQJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:09:03 -0400
Received: by mail-lb0-f175.google.com with SMTP id p9so3210988lbv.6
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:09:01 -0700 (PDT)
In-Reply-To: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Correction: I just realized that the other hanged unmaps does not have
the same parent. They are actually in different pools and unrelated.

Thank you for your time,
--
Hannes Landeholm
