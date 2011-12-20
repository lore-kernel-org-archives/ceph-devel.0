From: Karoly Horvath <rhswdev@gmail.com>
Subject: Re: how can I achieve HA with ceph?
Date: Tue, 20 Dec 2011 23:45:29 +0000
Message-ID: <CA+o_Kfux2TRpd7_gomNgTX+ZMgwe6bzgUu9oFWJ9Rkv2YHJbmA@mail.gmail.com>
References: <CA+o_KftAGMjT8+z1xet7BsPai8UEsQQv074dQExY_WOFrzZAgw@mail.gmail.com>
	<CAF3hT9C_gMsYSbe7L5KeYGqGkPaDxeNV8bdfD7EZPbKDE8pjQQ@mail.gmail.com>
	<CA+o_KftLn70adfmD7FGFoVq6YNfOUaFddGdw--9KTsPL12f8pQ@mail.gmail.com>
	<CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39356 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab1LTXpa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2011 18:45:30 -0500
Received: by wibhm6 with SMTP id hm6so1672601wib.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2011 15:45:29 -0800 (PST)
In-Reply-To: <CAF3hT9BuP7AbSVC89VLngQMrwYztMx-p77Cj3sO_Pu1GTN6ayA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Sorry about the formatting, here it is again, I hope it's readable now.

for each test it shows which services I killed on which node. after
each tests I restored all services.

1. mds @ beta =A0 =A0 =A0 OK

2. mds @ alpha =A0 =A0 =A0OK


3. mds+osd @ beta =A0FAILED
=A0 =A0switch ok {0=3Dalpha=3Dup:active}, but FS not readable
=A0 =A0FS permanently freezed

rebooted the whole cluster

4. mds+mon @ alpha =A0OK (32 sec)


rebooted the whole cluster

5. mds+osd @ beta =A0 OK (25 sec)

rebooted the whole cluster

6. mds+osd @ beta =A0 OK (24 sec)

7. mds+osd @ alpha =A0OK (30 sec)

8. mds+mon+osd @ beta =A0OK (27 sec)

9. power unplug @ alpha FAILED
=A0 =A0stuck in {0=3Dbeta=3Dup:replay} for a long time
=A0 =A0finally it's switching to {0=3Dalpha=3Dup:active}, but FS not re=
adable
=A0 =A0FS permanently freezed, even when bringing up alpha...

I included all the tests to show what worked and what didn't.
note that the mds+osd kill worked most of the time but there was also
a problematic test.
also note that the power unplug test FAILED all the time, I included
only one test.


On Tue, Dec 20, 2011 at 10:50 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Tue, Dec 20, 2011 at 10:07 AM, Karoly Horvath <rhswdev@gmail.com> =
wrote:
>> Hi,
>> all test were made with kill -9, killing the active mds (and sometim=
es
>> other processes).I waited a couple of minutes between each test to
>> make sure that the cluster reached a stable state.(btw: how can I
>> check this programmatically?)
> You can run "ceph health", which has only a few different values you
> can look for. :)
>
>> # =A0KILLED =A0 =A0 =A0 =A0 =A0 result1. mds @ beta =A0 =A0 =A0 OK2.=
 mds @ alpha
>> OK3. mds+osd @ beta =A0 FAILED=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 switch ok
>> {0=3Dalpha=3Dup:active}, but FS not readable=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 FS
>> permanently freezed=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rebooted =
the whole cluster4.
>> mds+mon @ alpha =A0OK (32 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 rebooted the whole
>> cluster5. mds+osd @ beta =A0 OK (25 sec)=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 rebooted the
>> whole cluster6. mds+osd @ beta =A0 OK (24 sec)7. mds+osd @ alpha =A0=
OK (30
>> sec)8. mds+mon+osd @ beta =A0OK (27 sec)9. power unplug @ alpha FAIL=
ED
>> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stuck in {0=3Dbeta=3Dup:replay} f=
or a long time
>> =A0=A0 =A0 =A0 =A0 finally it's switching to {0=3Dalpha=3Dup:active}=
, but FS not
>> readable=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FS permanently freez=
ed, even when bringing
>> up alpha...
> Your formatting got pretty mangled here, and I'm still not sure what'=
s
> going on. Did you restart all the daemons between each kill attempt?
> (for instance, it looks like '1' is to kill mds.beta; '2' is to kill
> mds.alpha, and then '3' is to kill mds.beta =97 but you already did
> that)
>
>> I uploaded test results here:
>> http://www.4shared.com/file/5nXMw_sM/cephlogs_mds_test.html?
>> If you need any other configuration options changed, let me know
> Sorry, I should have been clearer when I said turn on mds logging. Ad=
d
> "debug mds =3D 20" and "debug ms =3D 1" lines to your ceph.conf MDS
> sections. This will spit out a lot more information about what's goin=
g
> on internally, which will help us diagnose this. :)

I had those lines, the log seemed to be quite verbose... let me know
if it didn't work.

--=20
Karoly Horvath
rhswdev@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
