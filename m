From: Nick Bartos <nick@pistoncloud.com>
Subject: Statically binding ports for ceph-osd
Date: Mon, 9 Apr 2012 17:27:10 -0700
Message-ID: <CAPud5_4Fhjxwb2AjznBNPif8gLUrsJYqtkLX5OzBLMA1JAvw3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55394 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab2DJA1L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Apr 2012 20:27:11 -0400
Received: by yenl12 with SMTP id l12so2103647yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Apr 2012 17:27:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm trying to get ceph-osd's listening ports to be set statically for
firewall reasons.  I am able to get 2 of the 3 ports set statically,
however the 3rd one is still getting set dynamically.

I am using:

[osd.48]
    host = 172.16.0.13
    cluster addr = 172.16.0.13:6944
    public addr = 172.16.0.13:6945

The daemon will successfully bind to 6944 and 6945, but also binds to
6800.  What additional option do I need?  I started looking at the
code and thought "hb addr = 172.16.0.13:6946" would do it, but
specifying that option seems to have no effect (or at least does not
achieve the desired result).
