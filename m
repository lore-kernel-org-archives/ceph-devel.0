From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: coefficients
Date: Fri, 11 Jul 2014 12:48:41 +0200
Message-ID: <CACUN8h2ixhb_yDq2mY=zMW=GPUV-wDEzkGLG9LVh-d3VT-2Hxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:65061 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbaGKKsl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 06:48:41 -0400
Received: by mail-ie0-f170.google.com with SMTP id lx4so745980iec.1
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jul 2014 03:48:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,

If you still need to calculate more coefficients there is an
explanation of how to construct the coding equations in the paper
Erasure coding in Windows Azure Storage (unless you will keep your LRC
implementation simple and do only the LRC (10,6,5) ). I undertand that
the codes LRC in the mentioned paper are not exactly the same but at
least the paper explains the coefficients. I think in Azure they used
functional repair instead of exact repair as you wish.

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema
