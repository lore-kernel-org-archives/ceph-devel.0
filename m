From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: Several patches for CEPH
Date: Thu, 23 Sep 2010 10:18:37 +0800
Message-ID: <AANLkTik16jZv9J8tKJT+aX_6H4j34oL--wpNzOkZX_xg@mail.gmail.com>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
	<Pine.LNX.4.64.1009221212110.3172@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58272 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab0IWCSk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 22:18:40 -0400
Received: by qyk33 with SMTP id 33so1640015qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 19:18:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009221212110.3172@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Learned quite a bit of ceph details! Thanks!

Henry

On Thu, Sep 23, 2010 at 3:16 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 22 Sep 2010, Henry C Chang wrote:
>> 2. http://github.com/tcloud/ceph/commit/e3147e8929220997017de8fffa34=
b9d9c2abf9cf
>>
>> We hit this assert fail once. Can you check if this patch is reasona=
ble?
>
> I pushed a different fix for this,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://ceph.newdream.net/git/?p=3Dceph.git=
;a=3Dcommitdiff;h=3Da783f409e5e5524b4f2c15f78c716ca77e8aeb3c
>
> I think the problem was that the state reset (canceling of timer even=
ts,
> etc.) wasn't happening when the election was started due to another n=
ode
> (i.e., didn't come through Monitor::call_election()).
>
> The SafeTimer class (which handles the timeouts) is set up to handle =
mutex
> acquisition for you and let you cancel events without worrying about
> races, and the mutex is held over this whole function, so moving the
> 'state =3D ' bit around doesn't actually change behavior wrt the time=
outs.
>
> Thanks!
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
