From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: [ceph-users] PG down & incomplete
Date: Fri, 17 May 2013 00:14:15 -0700
Message-ID: <CAM2gkg4znKDOp-D=z459G2MCQcGzkHrLWF_Ox8uGexZNcMUM3Q@mail.gmail.com>
References: <1368569751.5157.5.camel@localhost>
	<1368768722.22569.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:44125 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab3EQHOQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 03:14:16 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht10so3408936vcb.4
        for <ceph-devel@vger.kernel.org>; Fri, 17 May 2013 00:14:15 -0700 (PDT)
In-Reply-To: <1368768722.22569.1.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

If you can follow the documentation here:
http://ceph.com/docs/master/rados/operations/monitoring-osd-pg/  and
http://ceph.com/docs/master/rados/troubleshooting/  to provide some
additional information, we may be better able to help you.

=46or example, "ceph osd tree" would help us understand the status of
your cluster a bit better.

On Thu, May 16, 2013 at 10:32 PM, Olivier Bonvalet <ceph.list@daevel.fr=
> wrote:
> Le mercredi 15 mai 2013 =C3=A0 00:15 +0200, Olivier Bonvalet a =C3=A9=
crit :
>> Hi,
>>
>> I have some PG in state down and/or incomplete on my cluster, becaus=
e I
>> loose 2 OSD and a pool was having only 2 replicas. So of course that
>> data is lost.
>>
>> My problem now is that I can't retreive a "HEALTH_OK" status : if I =
try
>> to remove, read or overwrite the corresponding RBD images, near all =
OSD
>> hang (well... they don't do anything and requests stay in a growing
>> queue, until the production will be done).
>>
>> So, what can I do to remove that corrupts images ?
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
> Up. Nobody can help me on that problem ?
>
> Thanks,
>
> Olivier
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com



--=20
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
http://inktank.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
