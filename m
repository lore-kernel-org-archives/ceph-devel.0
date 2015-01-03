From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Fwd: radosgw RX much more than TX
Date: Sat, 3 Jan 2015 15:11:04 +0300
Message-ID: <CAMWPydRzMzuAdpvi1rkJ0KasoMJRWdVR6U0WpSeaTa0B22KMmw@mail.gmail.com>
References: <CAMWPydQu4Yc3zeOpG2=Zm33ov=-ZP0tdDMO1H48kj=+5YOZCdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53838 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbbACMRi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jan 2015 07:17:38 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so760356wiw.15
        for <ceph-devel@vger.kernel.org>; Sat, 03 Jan 2015 04:17:36 -0800 (PST)
In-Reply-To: <CAMWPydQu4Yc3zeOpG2=Zm33ov=-ZP0tdDMO1H48kj=+5YOZCdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I am having a problem with radosgw, RX is much more than TX, sometimes
more than 10x.
This happens with apache and with civetweb.
I couldn't find anything wrong in the logs (only
"RGWObjManifest::operator++"), what should I do? I didn't know where
to ask (here or dev)

Regards
Mustafa Muhammad


P.S. I sent this message to ceph-users and got no response.
