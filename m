From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: OSD Weights
Date: Wed, 13 Feb 2013 09:23:22 -0600
Message-ID: <CAB7xdi=7Eod6KgXb3X1LtbViYzhG5nCL2puW1ez=5QbXDCkCAA@mail.gmail.com>
References: <C4049E4484F13747B672D64B9C12C31328E13918@PWMAILM01.cscinfo.com>
	<CAPYLRzh2+S8ijuRGs+Nv7rRaN2e7k-RH8HSr-qHeSSXWr+TQYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:63908 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934145Ab3BMPXZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 10:23:25 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so1782518iea.35
        for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 07:23:22 -0800 (PST)
In-Reply-To: <CAPYLRzh2+S8ijuRGs+Nv7rRaN2e7k-RH8HSr-qHeSSXWr+TQYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Holcombe, Christopher" <cholcomb@cscinfo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Gregory,

once running ceph online, will ceph change the weight dynamically (if
not set properly) or it can only be changed by the user through
command line or it cannot be changed online?

Thanks,
Sheng

On Mon, Feb 11, 2013 at 3:31 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Mon, Feb 11, 2013 at 12:43 PM, Holcombe, Christopher
> <cholcomb@cscinfo.com> wrote:
>> Hi Everyone,
>>
>> I just wanted to confirm my thoughts on the ceph osd weightings.  My understanding is they are a statistical distribution number.  My current setup has 3TB hard drives and they all have the default weight of 1.  I was thinking that if I mixed in 4TB hard drives in the future it would only put 3TB of data on them.  I thought if I changed the weight to 3 for the 3TB hard drives and 4 for the 4TB hard drives it would correctly use the larger storage disks.  Is that correct?
>
> Yep, looks good.
> -Greg
> PS: This is a good question for the new ceph-users list.
> (http://ceph.com/community/introducing-ceph-users/)
> :)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
