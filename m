From: Tomasz Ku smokers <tom.kusmierz@gmail.com>
Subject: Re: Is anyone aware of bluestor exploding all the time ?
Date: Mon, 25 Sep 2017 14:54:38 +0100
Message-ID: <25160A90-78B2-4B1E-98F5-AD28F8985819@gmail.com>
References: <636422C8-A440-4CA8-A7A2-E7F947EA350D@gmail.com> <alpine.DEB.2.11.1709250237170.16664@piezo.novalocal>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34741 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934254AbdIYNym (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Sep 2017 09:54:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so7218996wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Sep 2017 06:54:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709250237170.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

just updated the bug with my config, with what I disabled in the config and t=
he problem is still there. Now OSD3 is always off.

Sent from my iPhone

> On 25 Sep 2017, at 03:38, Sage Weil <sage@newdream.net> wrote:
>=20
>> On Mon, 25 Sep 2017, Tomasz Kusmierz wrote:
>> hi guys just FYI:
>> http://tracker.ceph.com/issues/21318
>=20
> I just followed up on the bug.  It looks like a bug in the rocksdb caching=
=20
> code...  let's confirm that and see if it's been fixed upstream.
>=20
> Thanks!
> sage
>=20
