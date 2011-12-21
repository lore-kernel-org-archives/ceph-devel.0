From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how can I achieve HA with ceph?
Date: Tue, 20 Dec 2011 16:03:36 -0800
Message-ID: <CAF3hT9Bq6Nwan2wF54Gz0OpHWoO9pGJE1h2a-ke6=7wW4wBSrA@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
	<CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55637 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1LUADh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 19:03:37 -0500
Received: by ggdk6 with SMTP id k6so5163172ggd.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 16:03:36 -0800 (PST)
In-Reply-To: <CA+o_KfsG=_TvQVNJ1HcUcTvntN5gqKCC3eXFhYwZVj3_fF4wRg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karoly Horvath <rhswdev@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Dec 20, 2011 at 3:42 PM, Karoly Horvath <rhswdev@gmail.com> wro=
te:
> Sorry about the formatting, here it is again, I hope it's readable no=
w
>
> for each test it shows which services I killed on which node. after t=
he test
> I restored all services.
>
> 1. mds @ beta =A0 =A0 =A0 OK
>
> 2. mds @ alpha =A0 =A0 =A0OK
>
>
> 3. mds+osd @ beta =A0FAILED
> =A0 =A0switch ok {0=3Dalpha=3Dup:active}, but FS not readable
> =A0 =A0FS permanently freezed
>
> rebooted the whole cluster
>
> 4. mds+mon @ alpha =A0OK (32 sec)
>
>
> rebooted the whole cluster
>
> 5. mds+osd @ beta =A0 OK (25 sec)
>
> rebooted the whole cluster
>
> 6. mds+osd @ beta =A0 OK (24 sec)
>
> 7. mds+osd @ alpha =A0OK (30 sec)
>
> 8. mds+mon+osd @ beta =A0OK (27 sec)
>
> 9. power unplug @ alpha FAILED
> =A0 =A0stuck in {0=3Dbeta=3Dup:replay} for a long time
> =A0 =A0finally it's switching to {0=3Dalpha=3Dup:active}, but FS not =
readable
> =A0 =A0FS permanently freezed, even when bringing up alpha...
>
> I included all the tests to show what worked and what didn't.
> note that the mds+osd worked most of the time but there was also a
> problematic test.
> also note that the power unplug test FAILED all the time, I included =
only
> one test.
>
>
> On Tue, Dec 20, 2011 at 10:50 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Tue, Dec 20, 2011 at 10:07 AM, Karoly Horvath <rhswdev@gmail.com>
>> wrote:
>>> Hi,
>>> all test were made with kill -9, killing the active mds (and someti=
mes
>>> other processes).I waited a couple of minutes between each test to
>>> make sure that the cluster reached a stable state.(btw: how can I
>>> check this programmatically?)
>> You can run "ceph health", which has only a few different values you
>> can look for. :)
>>
>>> # =A0KILLED =A0 =A0 =A0 =A0 =A0 result1. mds @ beta =A0 =A0 =A0 OK2=
=2E mds @ alpha
>>> OK3. mds+osd @ beta =A0 FAILED=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 switch ok
>>> {0=3Dalpha=3Dup:active}, but FS not readable=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 FS
>>> permanently freezed=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebooted=
 the whole cluster4.
>>> mds+mon @ alpha =A0OK (32 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 rebooted the whole
>>> cluster5. mds+osd @ beta =A0 OK (25 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 rebooted the
>>> whole cluster6. mds+osd @ beta =A0 OK (24 sec)7. mds+osd @ alpha =A0=
OK (30
>>> sec)8. mds+mon+osd @ beta =A0OK (27 sec)9. power unplug @ alpha FAI=
LED
>>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stuck in {0=3Dbeta=3Dup:replay} =
for a long time
>>> =A0=A0 =A0 =A0 =A0 finally it's switching to {0=3Dalpha=3Dup:active=
}, but FS not
>>> readable=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FS permanently free=
zed, even when bringing
>>> up alpha...
>> Your formatting got pretty mangled here, and I'm still not sure what=
's
>> going on. Did you restart all the daemons between each kill attempt?
>> (for instance, it looks like '1' is to kill mds.beta; '2' is to kill
>> mds.alpha, and then '3' is to kill mds.beta =97 but you already did
>> that)
>>
>>> I uploaded test results here:
>>> http://www.4shared.com/file/5nXMw_sM/cephlogs_mds_test.html?
>>> If you need any other configuration options changed, let me know
>> Sorry, I should have been clearer when I said turn on mds logging. A=
dd
>> "debug mds =3D 20" and "debug ms =3D 1" lines to your ceph.conf MDS
>> sections. This will spit out a lot more information about what's goi=
ng
>> on internally, which will help us diagnose this. :)
>
> I had those lines, the log seemed to be quite verbose... let me know =
if it
> didn't work.

It looks like maybe you got it turned on in the mon section rather
than the mds or global sections. :)


However, as I look at these a little more it generally looks good,
even in trial 3. The only alarming thing that's present is a note that
two of your clients failed to reconnect to the MDS in time and were
cut off. Did you try establishing a new connection to the cluster and
seeing if that worked? It's possible there's a client bug, or that
there was some sort of network error that interfered with them.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
