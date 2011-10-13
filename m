From: mowang da <whooya.xxl@gmail.com>
Subject: Re: osd deployment affects samba read performance
Date: Thu, 13 Oct 2011 09:11:10 +0800
Message-ID: <CAMwsgzN3bR1wtVG1snpEY_gUT6Dgy2uCxYWQu-VtwOgpmGg_-g@mail.gmail.com>
References: <CABAwU-afNz4NDyKAGz+9OiFH57WQ0AsPi4HCOTM6B+OjAnsoYg@mail.gmail.com>
	<Pine.LNX.4.64.1110110830050.20977@cobra.newdream.net>
	<CABAwU-ZoDeF9rChNtooUa1Mpt21MuhP07DMfQdtQvQ8zNToCLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51879 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1JMBLL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 21:11:11 -0400
Received: by qyk30 with SMTP id 30so5427241qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2011 18:11:10 -0700 (PDT)
In-Reply-To: <CABAwU-ZoDeF9rChNtooUa1Mpt21MuhP07DMfQdtQvQ8zNToCLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

the samba read performance can reach 110MB/s,it's an exciting news. I
have tested of it with kernel client, the read performance is 60M/s,
the write performance is 80M/s.
but, Can we only put together all of the OSDs on the same machine?
What is the difference in both cases=A3=BF
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
