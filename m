From: Andrey Korolyov <andrey@xdel.ru>
Subject: misdirected client messages
Date: Wed, 12 Dec 2012 20:42:33 +0300
Message-ID: <CABYiri_OH5+Cu5nAnS9KHOT3Xw=fjD6HPfZ8k=ko=_8vgED2cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:57138 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366Ab2LLRmy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 12:42:54 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1037872oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 09:42:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Today during planned kernel upgrade one of osds (which I have not
touched yet), started to claim about ``misdirected client'':

2012-12-12 21:22:59.107648 osd.20 [WRN] client.2774043
10.5.0.33:0/1013711 misdirected client.2774043.0:114 pg 5.ad140d42 to
osd.20 in e23834, client e23834 pg 5.542 features 67108863 (remained
the same except timestamp for at least ten minutes and then
disappeared)


Last two of three nodes have been rebooted to this time and primary
still not rebooted yet, osd.20 not rebooted too to this moment:

5.542   124     0       0       0       511705106       142753  142753
 active+clean    2012-12-12 17:07:05.761509      23834'1022923
23409'2958324 [7,11,5]        [7,11,5]        23452'839524
2012-12-08 21:08:42.076364      23452'839524    2012-12-08
21:08:42.076365


As I can see by looking to bugtracker, those message shouldn`t appear,
at least in recent versions. I`m using nondefault TCP congestion algo,
so it is clearly not a result of TCP mistuning between kernel
versions. I`m running 0.55 gf9d090e and kernel was upgraded inside 3.6
branch. Unfortunately message disappeared too soon before I point it
and change logging level on all involved OSD daemons. Since there is
absolutely no harm, may I ask on suggestions on repeating / raising
probability of this bug and do an appropriate logging?
