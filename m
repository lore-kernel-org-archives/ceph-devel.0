From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:18:37 +0200
Message-ID: <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<53316D18.7040103@ieee.org>
	<CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	<53317BC2.9010700@ieee.org>
	<CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	<1395753516.2823.37.camel@localhost>
	<533184AF.9050101@ieee.org>
	<5331853D.40408@ieee.org>
	<1395767705.9967.5.camel@localhost>
	<5331C05D.1060008@ieee.org>
	<1395773582.2076.10.camel@localhost>
	<5331D2E8.6060002@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:53449 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545AbaCYUSi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 16:18:38 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so1406821qcx.34
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 13:18:38 -0700 (PDT)
In-Reply-To: <5331D2E8.6060002@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 9:03 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/25/2014 01:53 PM, Olivier Bonvalet wrote:
>> Le mardi 25 mars 2014 =E0 12:43 -0500, Alex Elder a =E9crit :
>>> Please try applying this, on top of the previous patch.
>>> If you can then reproduce the problem we'll have a bunch
>>> of new information about the particular request that's
>>> leading to the failure.  That might tell us what more we
>>> can do to find the root cause.  Thank you.
>>>
>>>                                      -Alex
>>>
>>> PS  I hope my mailer doesn't botch the long lines.  It might.
>>>
>>
>> Here the execution will continue, no more kernel panic after this
>> debugging display. Is it wanted ?
>
>
> I guess it should panic.  I'm glad you mentioned this.

Just in case, if you haven't done it already: stick rbd_assert(0);
after the last printk in that if statement, so it looks like this:

if (which !=3D img_request->next_completion) {
        printk("%s: bad image object request information:\n", __func__)=
;
        printk("obj_request %p\n", obj_request);
        printk("    ->object_name <%s>\n", obj_request->object_name);
        ...

        printk("img_request %p\n", img_request);
        printk("    ->snap 0x%016llx\n", img_request->snap_id);
        ...
        printk("    ->result %d\n", img_request->result);

        rbd_assert(0);
}

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
