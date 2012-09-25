From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Ho to identify location of Primary Copy Of Obj ?
Date: Tue, 25 Sep 2012 13:34:26 -0700
Message-ID: <50621552.2050900@inktank.com>
References: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60650 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517Ab2IYUea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 16:34:30 -0400
Received: by pbbrr4 with SMTP id rr4so706100pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 13:34:30 -0700 (PDT)
In-Reply-To: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hemant:

Yes, you can.  Use ceph osd getmap -o <file> to get the OSD map, and 
then use osdmaptool --find-object-map <objectname> <file> to output the
PG the object hashes to and the list of OSDs that PG maps to (primary 
first):

$ ceph osd getmap -o osdmap
got osdmap epoch 59
$ osdmaptool --test-map-object dmick.rbd osdmap
osdmaptool: osdmap file 'osdmap'
  object 'dmick.rbd' -> 0.69c8 -> [3,1]

shows dmick.rbd mapping to pg 0.69c8, which in turn maps to OSDs 3 and 
1, 3 being the primary.

On 09/25/2012 02:30 AM, hemant surale wrote:
> Hi Community,
>            Is it possible to identify where exactly primary copy of obj
> is stored ? I am using crushmaps to use specific osds for data
> placement but i want to knw the primary capoy location. Or I need to
> replace pseudo random function by some deterministic function to guide
> ceph to utilize specific osd?
>
>
> Regards,
> Hemant Surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
