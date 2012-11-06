From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: python-ceph
Date: Mon, 5 Nov 2012 21:22:35 -0500
Message-ID: <CACkq2mo7HoB49voxVs-NehA9YC3xARa42Zay5qmYeDm4wF1LYw@mail.gmail.com>
References: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
 <alpine.DEB.2.00.1211031158120.25450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61371 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933504Ab2KFCW4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 21:22:56 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6619276vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 18:22:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211031158120.25450@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 3, 2012 at 2:59 PM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 2 Nov 2012, Travis Rhoden wrote:
>> Hi folks,
>>
>> Are there any plans to release python-ceph to pypi?  It would be nice
>> to see it packaged up in distutils/egg format and added to pypi, that
>> way other python packages can list it as a dependency.
>
> This is definitely something we want to work.

Glad to hear it!
>
>> I know there is currently a python-ceph package in Debian, but that
>> doesn't allow me to list it as a dependency in a setup.py file and
>> have it installed in a virtualenv, for example.  Right now I have to
>> copy rbd.py into my virtualenv.
>>
>> Curious to know if this is something you would consider.  Perhaps it
>> is something I could help with.
>
> That would be great!

I'll see what I can work on...  It's going to be a couple of weeks
before I could give it a good look. I'm under the gun right now to
finish some projects (they involve Ceph!) that we will be demo'ing at
SC'12.  Which is, as you know, 1 week away!  Speaking of SC'12, I'd
love to hear about any plans that InkTank has for that conference.
I've heard you will be there (and you have a booth).  One way or
another, I plan to swing by and meet whoever I can.  Feel free
(anyone) to email me off list if you are going to be in Salt Lake City
at SC'12 next week.
>
> sage
