From: hemant surale <hemant.surale@gmail.com>
Subject: Re: Ho to identify location of Primary Copy Of Obj ?
Date: Wed, 26 Sep 2012 16:29:59 +0530
Message-ID: <CAGfy=6kUd=3xDP1MySigSUV3wVxTVp=dwX_Yh2iCDnkeD4yyBg@mail.gmail.com>
References: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com>
	<50621552.2050900@inktank.com>
	<alpine.DEB.2.00.1209251428570.6215@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63449 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab2IZLAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 07:00:00 -0400
Received: by vbbff1 with SMTP id ff1so437630vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 03:59:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209251428570.6215@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage, Dan ,
       When I tried to execute cmd "  osdmaptool --test-map-object
"anyrandomname" osdmap  " it still shows some random number as mapped
osds. Because I havnt created Object even for that result is shown as
some random numbers/ as osds where that Object is mapped.
      And with replication factor of 3 , I think " osdmaptool
--test-map-object  Objname osdmap" should show 3 nodes at least . But
currently it shows only 1 node .

        Please help me out .

Thanks & Regards,
Hemant Surale.


On Wed, Sep 26, 2012 at 2:59 AM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 25 Sep 2012, Dan Mick wrote:
>> Hemant:
>>
>> Yes, you can.  Use ceph osd getmap -o <file> to get the OSD map, and then use
>> osdmaptool --find-object-map <objectname> <file> to output the
>> PG the object hashes to and the list of OSDs that PG maps to (primary first):
>>
>> $ ceph osd getmap -o osdmap
>> got osdmap epoch 59
>> $ osdmaptool --test-map-object dmick.rbd osdmap
>> osdmaptool: osdmap file 'osdmap'
>>  object 'dmick.rbd' -> 0.69c8 -> [3,1]
>>
>> shows dmick.rbd mapping to pg 0.69c8, which in turn maps to OSDs 3 and 1, 3
>> being the primary.
>
> You can do this more simply with:
>
>  ceph osd map <poolname> <objectname>
>
> sage
>
>>
>> On 09/25/2012 02:30 AM, hemant surale wrote:
>> > Hi Community,
>> >            Is it possible to identify where exactly primary copy of obj
>> > is stored ? I am using crushmaps to use specific osds for data
>> > placement but i want to knw the primary capoy location. Or I need to
>> > replace pseudo random function by some deterministic function to guide
>> > ceph to utilize specific osd?
>> >
>> >
>> > Regards,
>> > Hemant Surale.
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
