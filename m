From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: [ceph-users] OSD Weights
Date: Thu, 14 Feb 2013 10:22:18 +0100
Message-ID: <CAOLwVUnHOZ_M_Pvik_qJcNf6iGDNtUYMCSWPZutMh_bhTL+9+w@mail.gmail.com>
References: <C4049E4484F13747B672D64B9C12C31328E13918@PWMAILM01.cscinfo.com>
 <CAPYLRzh2+S8ijuRGs+Nv7rRaN2e7k-RH8HSr-qHeSSXWr+TQYw@mail.gmail.com> <CAB7xdi=7Eod6KgXb3X1LtbViYzhG5nCL2puW1ez=5QbXDCkCAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:59752 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab3BNJWj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 04:22:39 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so2323999oag.29
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 01:22:38 -0800 (PST)
In-Reply-To: <CAB7xdi=7Eod6KgXb3X1LtbViYzhG5nCL2puW1ez=5QbXDCkCAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

As far as I know Ceph won't attempt to do any weight modifications. If
you use the default CRUSH map, every devices get a default weight of
1. However this value can be modified while the cluster runs. Simply
update the CRUSH map like so:

# ceph osd crush reweight {name} {weight}

If you need more input, have a look at the documentation ;-)

http://ceph.com/docs/master/rados/operations/crush-map/?highlight=3Dcru=
sh#adjust-an-osd-s-crush-weight

Cheers,
--
Regards,
S=E9bastien Han.


On Wed, Feb 13, 2013 at 4:23 PM, sheng qiu <herbert1984106@gmail.com> w=
rote:
> Hi Gregory,
>
> once running ceph online, will ceph change the weight dynamically (if
> not set properly) or it can only be changed by the user through
> command line or it cannot be changed online?
>
> Thanks,
> Sheng
>
> On Mon, Feb 11, 2013 at 3:31 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>> On Mon, Feb 11, 2013 at 12:43 PM, Holcombe, Christopher
>> <cholcomb@cscinfo.com> wrote:
>>> Hi Everyone,
>>>
>>> I just wanted to confirm my thoughts on the ceph osd weightings.  M=
y understanding is they are a statistical distribution number.  My curr=
ent setup has 3TB hard drives and they all have the default weight of 1=
=2E  I was thinking that if I mixed in 4TB hard drives in the future it=
 would only put 3TB of data on them.  I thought if I changed the weight=
 to 3 for the 3TB hard drives and 4 for the 4TB hard drives it would co=
rrectly use the larger storage disks.  Is that correct?
>>
>> Yep, looks good.
>> -Greg
>> PS: This is a good question for the new ceph-users list.
>> (http://ceph.com/community/introducing-ceph-users/)
>> :)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
