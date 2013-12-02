From: Lipeng Wan <lipengwan86@gmail.com>
Subject: question about the data structure of crush_map
Date: Sun, 1 Dec 2013 22:20:10 -0500
Message-ID: <CAJqA8gvBkq7F=nJBvSaVjwXJQYguHQjp4zQOPSgpvYbwOza=kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51830 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab3LBDUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Dec 2013 22:20:11 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so4145968wib.14
        for <ceph-devel@vger.kernel.org>; Sun, 01 Dec 2013 19:20:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

I am reading the source code of ceph and trying to understand the data
structure of crush_map. Now I am confused by the use of "struct
crush_bucket **buckets" in function "int crush_do_rule(...)" in
src/crush/mapper.c. It seems that the index of array "map->buckets[]"
could be negative (see line 551, src/crush/mapper.c). I was wondering
if anyone could explain why the index of this array can be negative
and how those buckets were added into this array. Thanks.

Best,
L. Wan
