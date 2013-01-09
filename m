From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD memory leaks?
Date: Wed, 9 Jan 2013 23:12:12 +0100
Message-ID: <CAOLwVUmrCXk2qRkBd3G3rB85+=K_y0rc9y6QWEGqKjdwJyUTww@mail.gmail.com>
References: <CAOLwVUkTkm22ndq97O+5ziJF+C+nGpeJwrXhPc2Ls39R+utXVg@mail.gmail.com>
 <2054641.97.1357767776178.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52213 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab3AIWMf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 17:12:35 -0500
Received: by mail-lb0-f181.google.com with SMTP id ge1so1431587lbb.26
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 14:12:34 -0800 (PST)
In-Reply-To: <2054641.97.1357767776178.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

Dave, I share you my little script for now if you want it:

#!/bin/bash

for i in $(ps aux | grep [c]eph-osd | awk '{print $4}')
do
        MEM_INTEGER=3D$(echo $i | cut -d '.' -f1)
        OSD=3D$(ps aux | grep [c]eph-osd | grep "$i " | awk '{print $13=
}')
        if [[ $MEM_INTEGER -ge 25 ]];then
service ceph restart osd.$OSD >> /dev/null
                if [ $? -eq 0 ]; then
logger -t ceph-memory-usage "The OSD number $OSD has been restarted
since it was using $i % of the memory"
                else
                        logger -t ceph-memory-usage "ERROR while
restarting the OSD daemon"
                fi
        else
                logger -t ceph-memory-usage "The OSD number $OSD is
only using $i % of the memory, doing nothing"
        fi
logger -t ceph-memory-usage "Waiting 60 seconds before testing the next=
 OSD..."
sleep 60
done

logger -t ceph-memory-usage "Ceph state after memory check operation
is: $(ceph health)"

Crons run with 10 min interval everyday for each storage node ;-).

Waiting for some Inktank guys now :-).
--
Regards,
S=E9bastien Han.


On Wed, Jan 9, 2013 at 10:42 PM, Dave Spano <dspano@optogenics.com> wro=
te:
> That's very good to know. I'll be restarting ceph-osd right now! Than=
ks for the heads up!
>
> Dave Spano
> Optogenics
> Systems Administrator
>
>
>
> ----- Original Message -----
>
> From: "S=E9bastien Han" <han.sebastien@gmail.com>
> To: "Dave Spano" <dspano@optogenics.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Samuel Just" <sam.jus=
t@inktank.com>
> Sent: Wednesday, January 9, 2013 11:35:13 AM
> Subject: Re: OSD memory leaks?
>
> If you wait too long, the system will trigger OOM killer :D, I alread=
y
> experienced that unfortunately...
>
> Sam?
>
> On Wed, Jan 9, 2013 at 5:10 PM, Dave Spano <dspano@optogenics.com> wr=
ote:
>> OOM killer
>
>
>
> --
> Regards,
> S=E9bastien Han.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
