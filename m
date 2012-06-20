From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd crush add - uknown command crush
Date: Wed, 20 Jun 2012 14:59:47 -0700
Message-ID: <CAPYLRzhTzMwORq75WJ81Lx6dTow=RFwFb4D57Z=e1wDVGYnXEQ@mail.gmail.com>
References: <CAMwB3TjS_r-U55py7WPu1RZmNob78nodB6a=i9sb1sx3mxvXDw@mail.gmail.com>
	<271B7E7C4B014BFE86FC17F9AF863BD8@inktank.com>
	<CACkq2moDXngPxLZ3Tb36SW_R+E-P-aE1vGELsK7mWa2XHBPJqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46150 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab2FTV7t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 17:59:49 -0400
Received: by lbbgm6 with SMTP id gm6so1202856lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 14:59:48 -0700 (PDT)
In-Reply-To: <CACkq2moDXngPxLZ3Tb36SW_R+E-P-aE1vGELsK7mWa2XHBPJqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Jun 20, 2012 at 2:53 PM, Travis Rhoden <trhoden@gmail.com> wrot=
e:
> This incorrect syntax is still published in the docs at
> http://ceph.com/docs/master/ops/manage/crush/#adjusting-crush
>
> Are the docs that end up on that page in GitHub?  I'd be happy to
> start making fixes and issuing pull-request.  I've run into a few
> gotchas when following the commands on those pages.
Yes, they are in git! All the docs are generated from the sources in
doc/ under the same hierarchy as on the website. The page you're
interested in is at "{ceph_root}/doc/ops/manage/crush.rst".


>
>  - Travis
>
> On Tue, May 22, 2012 at 4:27 PM, Greg Farnum <greg@inktank.com> wrote=
:
>> On Tuesday, May 22, 2012 at 1:15 PM, S=F9awomir Skowron wrote:
>>> /usr/bin/ceph -v
>>> ceph version 0.47.1 (commit:f5a9404445e2ed5ec2ee828aa53d73d4a002f7a=
5)
>>>
>>> root@obs-10-177-66-4:/# /usr/bin/ceph osd crush add 1 osd.1 1.0
>>> pool=3Ddefault rack=3Dunknownrack host=3Dobs-10-177-66-4
>>> root@obs-10-177-66-4:/# unknown command crush
>>>
>>> Something has changed (there is no change in doc) or it's bug ??
>> Gah, something changed.
>>
>> Use "ceph osd crush set..."
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
