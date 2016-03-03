From: =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCo0LjRiNC10L3QutC+?=
	<gamepad64@gmail.com>
Subject: Recovering OSD from secondary replica
Date: Thu, 3 Mar 2016 18:12:48 +0300
Message-ID: <CALaEUKbJ9FvLkU+ftFWUNFV0EC_BZYpu8bH3RZRN2Ye99U+Y4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37430 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbcCCPNJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2016 10:13:09 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so35676136wmp.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2016 07:13:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a development cluster of three OSD's. One of the OSD got down.
My aim is to change ceph code, so OSD could recover itself from
secondary replica. Is it possible without rewriting entire src/osd?
