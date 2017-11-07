From: "Brennecke, Simon" <simon.brennecke@sap.com>
Subject: Fw: XFS on RBD deadlock
Date: Tue, 7 Nov 2017 10:10:41 +0000
Message-ID: <5f20f87b0ee243d9a61e852fe72aaf3f@sap.com>
References: <199f2d4449ab4445a2fc9bd366a7f472@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpgw02.sap-ag.de ([155.56.66.97]:24028 "EHLO smtpgw.sap-ag.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756152AbdKGKKm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Nov 2017 05:10:42 -0500
In-Reply-To: <199f2d4449ab4445a2fc9bd366a7f472@sap.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Schneider, Robert" <robert.schneider03@sap.com>

Hi guys,

I have a question regarding an old email which I found via google on the mailling list:

https://www.spinics.net/lists/ceph-devel/msg33806.html

The issue described there is pretty much what we are seeing on some of our servers.
As it appears the kernel runs out of memory while writing back data to a XFS formatted RBD (actually the root volume).
The kernel version we are using is 4.1.42 - outdated, I know, but we plan on upgrading if it helps the issue.


Now my question is: Was the issue fixed? Or is disabling the signature still the only option?
Also it would be interessting if it only affects XFS, or if other filesystems suffer from the same issue.

Thanks & Rregards
Simon