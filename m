From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Client stuck 'waiting on max_size'
Date: Tue, 6 Dec 2011 21:45:43 -0800
Message-ID: <CAF3hT9Dfp2017j+O2bDw8AG=HT+yviO45P+Gv29NgU9FkdeCXA@mail.gmail.com>
References: <726402583.133585.1323230432339.JavaMail.root@mail-01.cse.ucsc.edu>
	<1340951383.133589.1323230543007.JavaMail.root@mail-01.cse.ucsc.edu>
	<CAF3hT9DHJ6gRxU_d3niH_LrgL=zHcEgaYSXgH+DTq+1ZEOU9+w@mail.gmail.com>
	<4EDEF490.5050606@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58891 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab1LGFpo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 00:45:44 -0500
Received: by ggnr5 with SMTP id r5so237008ggn.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 21:45:44 -0800 (PST)
In-Reply-To: <4EDEF490.5050606@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I see a lot of this:
2011-12-06 19:42:50.401143 7fc8b1850700 mds.0.locker  i want to change
file_max, but lock won't allow it (yet)
2011-12-06 19:42:50.401168 7fc8b1850700 mds.0.locker file_excl (ifile
sync) on [inode 10000000cda [2,head] /noah.bin auth v1600 s=3D0 n(v0
1=3D1+0) (iversion lock) cr=3D{6143=3D0-67108864@1}
caps=3D{6139=3D-/pFscr@2,6143=3DpAsLsXsFc/pFscr@4},l=3D6143 | c
aps dirty 0x1f87c80]

Unfortunately I'm having trouble thinking straight so dealing with it
will have to wait until morning, but it shouldn't be too hard to track
down what's happening.

On Tue, Dec 6, 2011 at 9:07 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrot=
e:
> On 12/6/11 8:49 PM, Gregory Farnum wrote:
>>
>> The client is waiting for the MDS to give it permission to make the
>> file larger. I think this data comes back in a caps message, but it
>> probably got stuck on the MDS for some reason. Try grepping through
>> the MDS and client logs for max_size and see if there's something
>> obvious (or send it our way).
>
>
> Logs are here:
>
> =A0http://piha.soe.ucsc.edu/cephlogs/max_size/
>
> -Noah
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
