From: mowang da <whooya.xxl@gmail.com>
Subject: ceph kernel client cache
Date: Tue, 6 Sep 2011 08:55:34 +0800
Message-ID: <CAMwsgzNY10oX5J7ThthvUT+eiVFZPS6pEwkH=n99iUtvy4mKxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38645 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab1IFAzf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Sep 2011 20:55:35 -0400
Received: by bke11 with SMTP id 11so4948852bke.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Sep 2011 17:55:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
l tested ceph kernel client rereading with the latest version,I found
no effect of cache=A3=ACbut in this case, only one client reading.
 each read, the program is to free up cache=A3=ACThis is correct?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
