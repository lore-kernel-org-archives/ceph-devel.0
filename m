From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 14:03:04 -0500
Message-ID: <5331D2E8.6060002@ieee.org>
References: <1395736765.2823.29.camel@localhost>			 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>			 <53316D18.7040103@ieee.org>			 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>			 <53317BC2.9010700@ieee.org>			 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>		 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>		 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:37755 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaCYTCq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 15:02:46 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so1091914veb.32
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 12:02:45 -0700 (PDT)
In-Reply-To: <1395773582.2076.10.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 01:53 PM, Olivier Bonvalet wrote:
> Le mardi 25 mars 2014 =C3=A0 12:43 -0500, Alex Elder a =C3=A9crit :
>> Please try applying this, on top of the previous patch.
>> If you can then reproduce the problem we'll have a bunch
>> of new information about the particular request that's
>> leading to the failure.  That might tell us what more we
>> can do to find the root cause.  Thank you.
>>
>> 					-Alex
>>
>> PS  I hope my mailer doesn't botch the long lines.  It might.
>>
>=20
> Here the execution will continue, no more kernel panic after this
> debugging display. Is it wanted ?


I guess it should panic.  I'm glad you mentioned this.

I'm sorry to have it reproducing on a production cluster.
Unfortunately at this point it's the only place we've
been able to reproduce it (and with any luck we'll find
the problem soon).

					-Alex
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
