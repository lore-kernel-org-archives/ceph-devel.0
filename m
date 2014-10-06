From: =?UTF-8?Q?Patrycja_Szab=C5=82owska?=
	<szablowska.patrycja@gmail.com>
Subject: 2 questions about bucket index log
Date: Mon, 6 Oct 2014 10:25:53 +0200
Message-ID: <CAKz8Jya3FtzpUWHhY4yw8RnDuG5JeNqok+YPmnADx6hOATF8PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64607 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaJFIZy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Oct 2014 04:25:54 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so3744846wib.17
        for <ceph-devel@vger.kernel.org>; Mon, 06 Oct 2014 01:25:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,


I've got a few questions about the bucket index log implementation.

1. Where the bucket index logs are stored?
My guess was that it is in .log pool, but when I've removed it the
logs kept being written.

2. How often are they cleared?


Any help would be appreciated.

Thanks,

Patrycja Szab=C5=82owska
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
