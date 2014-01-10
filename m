From: Lipeng Wan <lipengwan86@gmail.com>
Subject: Question about the test() function in CrushTester class
Date: Fri, 10 Jan 2014 15:37:18 -0500
Message-ID: <CAJqA8gvhmsrC5kOw3L+sG5zLUDZcW9ym3C=vvnhKNRLaNbjz1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43138 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaAJUhT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jan 2014 15:37:19 -0500
Received: by mail-wg0-f54.google.com with SMTP id x13so1604961wgg.33
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jan 2014 12:37:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi guys,

I am now trying to use crushtool.cc to test crush algorithm. First, I
build a new crush map using crushtool.cc and all the devices have the
maximum weight (0x10000). Then I assign different weights to devices
using the "--weight" option and run the test() function. It seems that
during the execution of test() function, the crush map was not
modified based on the new device weights I gave, which means the
bucket selection was still based on the initial device weight rather
than the weights I gave. Dose this make sense?

L. Wan
