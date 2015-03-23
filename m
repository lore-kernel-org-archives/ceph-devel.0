From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [ceph-users] How does crush selects different osds using hash(pg)
 in diferent iterations
Date: Mon, 23 Mar 2015 07:09:41 -0700
Message-ID: <CAC6JEv9oFbJ9yY8RtFSYyATPrBCio17MQCTGe35+3m=vEi-ZNg@mail.gmail.com>
References: <CAMxOGo2V+Fn+g3z5qc7oYK40wU_XJuScAdfetQrkjp6izeNULw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35446 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbCWOJn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 10:09:43 -0400
Received: by ieclw3 with SMTP id lw3so36312128iec.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:09:42 -0700 (PDT)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com. [209.85.213.175])
        by mx.google.com with ESMTPSA id nv8sm2481106igb.6.2015.03.23.07.09.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 07:09:42 -0700 (PDT)
Received: by igcqo1 with SMTP id qo1so39314970igc.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2015 07:09:41 -0700 (PDT)
In-Reply-To: <CAMxOGo2V+Fn+g3z5qc7oYK40wU_XJuScAdfetQrkjp6izeNULw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: shylesh kumar <shylesh.mohan@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Sat, Mar 21, 2015 at 10:46 AM, shylesh kumar <shylesh.mohan@gmail.com> wrote:
> Hi ,
>
> I was going through this simplified crush algorithm given in ceph website.
>
> def crush(pg):
>    all_osds = ['osd.0', 'osd.1', 'osd.2', ...]
>    result = []
>    # size is the number of copies; primary+replicas
>    while len(result) < size:
>    --> r = hash(pg)
>        chosen = all_osds[ r % len(all_osds) ]
>        if chosen in result:
>            # OSD can be picked only once
>            continue
>        result.append(chosen)
>    return result
>
> 10:24 PM (51 minutes ago)
> In the line where r = hash(pg) , will it gives the same hash value in every
> iteration ?
> if that is the case we always endup choosing the same osd from the list
> or will the pg number be used as seed for the hashing so that r value
> changes in the next iteration.
>
> Am I missing something really basic ??
> Can somebody please provide me some pointers ?

I'm not sure where this bit of documentation came from, but the
selection process includes the "attempt" number as one of the inputs.
Where the attempt starts at 0 (or 1, I dunno) and increments each time
we try to map a new OSD to the PG.
-Greg

>
>
>
> --
> Thanks,
> Shylesh Kumar M
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
