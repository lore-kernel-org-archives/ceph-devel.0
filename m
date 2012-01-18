From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: How to remove lost objects.
Date: Wed, 18 Jan 2012 14:55:14 -0800
Message-ID: <CAF3hT9D2yFqt5EKYFce_jmTdjFC_7V9LR-er+F_KuJJ3dyunSA@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
	<CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35520 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab2ARWzO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 17:55:14 -0500
Received: by iagf6 with SMTP id f6so6681246iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 14:55:14 -0800 (PST)
In-Reply-To: <CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 18, 2012 at 12:48 PM, Andrey Stepachev <octo47@gmail.com> w=
rote:
> But still don't know what happens with ceph, so it can't
> respond and hang. It is not a good behavior, because
> such situation leads to unresponsible cluster in case of
> temporal network failure.

I'm a little concerned about this =97=A0I would expect to see hangs of =
up
to ~30 seconds (the timeout period), but for operations to then
continue. Are you putting the MDS down? If so, do you have any
standbys specified?


> 2012/1/18 Andrey Stepachev <octo47@gmail.com>:
>> Hi,
>>
>> I've test ceph against laggy network. (0ms-400ms delays).
>> At some moment i got many messages like:
>> 2012-01-18 16:06:49.184776 7ff134119700 -- 84.201.161.73:6801/25424
>> send_message dropped message osd_op_reply(291 1000000101b.0000001e
>> [write 66734080~37
>> 4784] ondisk =3D 0) v1 because of no pipe on con 0x315e640
>> And ceph don't respond on ls on some of subdirs (via hadoop fs -ls o=
r
>> kernel client)
>> My cluster runs with no debug at that moment, so I can't find what i=
s going on.
>>
>> After restart ceph writes to log
>> 2012-01-18 16:10:39.985509 7f217989d780 osd.1 155 pg[0.155( v 136'37=
3
>> (94'368,136'373]+backlog n=3D3 ec=3D1 les/c 150/145 146/151/58) [] r=
=3D0
>> lpr=3D0 (info mismatch, log(94'368,0'0]+backlog) (log bound mismatch=
,
>> actual=3D[8'124,94'369]) lcod 0'0 mlcod 0'0 inactive] read_log =A0go=
t dup
>> 94'369 (last was 94'369, dropping that one)
>>
>> After such strange hangouts i found, that rm -rf on filesystem
>> (mounted via kernel),
>> fs shows, that 210Gb still in use. Looking at /data/osd.x i found ma=
ny
>> objects inside.
>> So:
>> a) looks like some errors lead us to orphaned objects in rados
>> b) i can't find utility, which can check that orpaned data (and clea=
nup it)
>>
>> Question: how I can identify what objects are, and how I can clean u=
p them.
>>
>> --
>> Andrey.
>
>
>
> --
> Andrey.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
