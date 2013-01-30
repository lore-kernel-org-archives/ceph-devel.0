From: Martin B Nielsen <martin@unity3d.com>
Subject: Weight and reweight
Date: Wed, 30 Jan 2013 21:30:23 +0100
Message-ID: <CAD3n6hG+dOG7eiSHS=U0Qu=T8d3J3DyWyFnz52R4qWW5xGwArQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:44633 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3A3UaY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 15:30:24 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so2044097obc.40
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 12:30:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm just curious and I can't seem to find the answer anywhere in the docs.

When doing a 'ceph osd tree' one will get something like:

# id    weight  type name       up/down reweight
[...]
0       1                               osd.0   up      1
[...]

What is the difference between weight and reweight?

How would two identical disks of 1TB behave if say one was set to
weight = 1, reweight = 1 and the other to weight = 1, reweight = 0.5
(or weight = 0.5, reweight = 1)?

Thanks in advance!

Cheers,
/Martin
