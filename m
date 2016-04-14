From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [ceph-users] v10.1.2 Jewel release candidate release
Date: Thu, 14 Apr 2016 10:51:10 -0400
Message-ID: <CANP1eJEPo5_64qx=r=YuXxWbkbSyYjpnQEx7SBZD6XZdqvSYsA@mail.gmail.com>
References: <alpine.DEB.2.11.1604131753570.31812@cpach.fuggernut.com>
	<CAJ4mKGa_APTdJzXR86_GjN141igBft=4JvY79EkS_ZkPbgcAVQ@mail.gmail.com>
	<A3CAA6F7-8759-4C19-9DA1-0C6D066A3A8E@teralytics.ch>
	<CALe9h7fS1KR87HK4h03fvDEGp6jF7w1g+8bCA2R0KwopzcdLGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35002 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcDNOvM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2016 10:51:12 -0400
Received: by mail-lf0-f49.google.com with SMTP id c126so111784505lfb.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2016 07:51:11 -0700 (PDT)
In-Reply-To: <CALe9h7fS1KR87HK4h03fvDEGp6jF7w1g+8bCA2R0KwopzcdLGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Vincenzo Pii <vincenzo.pii@teralytics.ch>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, Sage Weil <sage@redhat.com>, ceph-announce@ceph.com

On Thu, Apr 14, 2016 at 6:32 AM, John Spray <jspray@redhat.com> wrote:
> On Thu, Apr 14, 2016 at 8:31 AM, Vincenzo Pii
> <vincenzo.pii@teralytics.ch> wrote:
>>
>> On 14 Apr 2016, at 00:09, Gregory Farnum <gfarnum@redhat.com> wrote:
>>
>> On Wed, Apr 13, 2016 at 3:02 PM, Sage Weil <sage@redhat.com> wrote:
>>
>> Hi everyone,
>>
>> The third (and likely final) Jewel release candidate is out.  We hav=
e a
>> very small number of remaining blocker issues and a bit of final pol=
ish
>> before we publish Jewel 10.2.0, probably next week.
>>
>> There are no known issues with this release that are serious enough =
to
>> warn about here.  Greg is adding some CephFS checks so that admins d=
on't
>> accidentally start using less-stable features,
>>
>>
>> s/is adding/has added/
>>
>>        http://docs.ceph.com/docs/master/release-notes/
>>
>>
>> As noted in another thread, there's still a big CephFS warning in th=
e
>> online docs. We'll be cleaning those up, since we now have the
>> recovery tools we desire! Some things are known to still be slow or
>> sub-optimal, but we consider CephFS stable and safe at this time whe=
n
>> run in the default single-MDS configuration. (It won't let you do
>> anything bad without very explicitly setting flags and acknowledging
>> they're dangerous.)
>> :)
>> -Greg
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>> Hi Greg,
>>
>> A clarification:
>>
>> When you say that things will be safe in =E2=80=9Csingle-MDS=E2=80=9D=
 configuration, do you
>> also exclude the HA setup with one active MDS and some passive (stan=
dby)
>> ones? Or this would be safe as well?
>
> Yes, having standbys is fine (including "standby replay" daemons).  W=
e
> should really say "single active MDS configuration", but it's a bit o=
f
> a mouthful!

master - hot standby(s) is okay
multi-master is not supported

I feel like this is terminology that's more familiar (to me) from
other systems (eg. databases).

>
> John
>
>>
>> Vincenzo Pii | TERALYTICS
>> DevOps Engineer
>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
