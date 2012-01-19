From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: How to remove lost objects.
Date: Thu, 19 Jan 2012 12:53:19 +0400
Message-ID: <CAADCt4+u87=Bhukqs5EX6uyzXCL+ug0=_M6DDLQ6oSh1acmTsw@mail.gmail.com>
References: <CAADCt4KfW7JS59ev_T4L3VMvmQm+OquD-8L7NTKS9u2RjNMPKg@mail.gmail.com>
 <CAADCt4+BL6mdrQ5XyMwdNjOMQeBh-aUAxp_8ohR-AeZ4Xd8SOA@mail.gmail.com>
 <CAF3hT9D2yFqt5EKYFce_jmTdjFC_7V9LR-er+F_KuJJ3dyunSA@mail.gmail.com>
 <CAADCt4+X79C+VW30b8MM18FasDFLZtjQacWm=HkBAA-EXAq80g@mail.gmail.com> <CAF3hT9C+TxK01DbwdMBhZX7vKJr3Jaheg1t-G4hWM_gNvdb_Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dd8a6f6097da04b6ddb3e5
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51649 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab2ASIxl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jan 2012 03:53:41 -0500
Received: by werb13 with SMTP id b13so1018639wer.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2012 00:53:40 -0800 (PST)
In-Reply-To: <CAF3hT9C+TxK01DbwdMBhZX7vKJr3Jaheg1t-G4hWM_gNvdb_Qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--0016e6dd8a6f6097da04b6ddb3e5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
> On Wednesday, January 18, 2012, Andrey Stepachev <octo47@gmail.com> wrote=
:
>> 2012/1/19 Gregory Farnum <gregory.farnum@dreamhost.com>:
>>> On Wed, Jan 18, 2012 at 12:48 PM, Andrey Stepachev <octo47@gmail.com>
>>> wrote:
>>>> But still don't know what happens with ceph, so it can't
>>>> respond and hang. It is not a good behavior, because
>>>> such situation leads to unresponsible cluster in case of
>>>> temporal network failure.
>>>
>>> I'm a little concerned about this =E2=80=94=C2=A0I would expect to see =
hangs of up
>>> to ~30 seconds (the timeout period), but for operations to then
>>> continue. Are you putting the MDS down? If so, do you have any
>>> standbys specified?
>>
>> Yes, MDS goes down (I restart it at some point, while changing something
>> in config).
>> Yes, i have 2 standbys.
>> Clients hang more then 10 minutes.
>
> Okay, so it's probably an issue with the MDS not entering recovery when i=
t
> should. Are you also taking down one of the monitor nodes? There's a know=
n
> bug which can cause a standby MDS to wait up to 15 minutes if its monitor
> goes down which is fixed in latest master (and maybe .40; I'd have to
> check).

Yes. I have collocated mon mds and osd on some nodes.
And restart all daemons at once. I use 0.40. (built from my github fork).

> -Greg
>
>
>>
>>>
>>>
>>>> 2012/1/18 Andrey Stepachev <octo47@gmail.com>:
>>>>> Hi,
>>>>>
>>>>> I've test ceph against laggy network. (0ms-400ms delays).
>>>>> At some moment i got many messages like:
>>>>> 2012-01-18 16:06:49.184776 7ff134119700 -- 84.201.161.73:6801/25424
>>>>> send_message dropped message osd_op_reply(291 1000000101b.0000001e
>>>>> [write 66734080~37
>>>>> 4784] ondisk =3D 0) v1 because of no pipe on con 0x315e640
>>>>> And ceph don't respond on ls on some of subdirs (via hadoop fs -ls or
>>>>> kernel client)
>>>>> My cluster runs with no debug at that moment, so I can't find what is
>>>>> going on.
>>>>>
>>>>> After restart ceph writes to log
>>>>> 2012-01-18 16:10:39.985509 7f217989d780 osd.1 155 pg[0.155( v 136'373
>>>>> (94'368,136'373]+backlog n=3D3 ec=3D1 les/c 150/145 146/151/58) [] r=
=3D0
>>>>> lpr=3D0 (info mismatch, log(94'368,0'0]+backlog) (log bound mismatch,
>>>>> actual=3D[8'124,94'369]) lcod 0'0 mlcod 0'0 inactive] read_log =C2=A0=
got dup
>>>>> 94'369 (last was 94'369, dropping that one)
>>>>>
>>>>> After such strange hangouts i found, that rm -rf on filesystem
>>>>> (mounted via kernel),
>>>>> fs shows, that 210Gb still in use. Looking at /data/osd.x i found man=
y
>>>>> objects inside.
>>>>> So:
>>>>> a) looks like some errors lead us to orphaned objects in rados
>>>>> b) i can't find utility, which can check that orpaned data (and clean=
up
>>>>> it)
>>>>>
>>>>> Question: how I can identify what objects are, and how I can clean up
>>>>> them.
>>>>>
>>>>> --
>>>>> Andrey.
>>>>
>>>>
>>>>
>>>> --
>>>> Andrey.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>>
>>
>> --
>> Andrey.
>>



--=20
Andrey.

--0016e6dd8a6f6097da04b6ddb3e5
Content-Type: application/octet-stream; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxljkocj0

Owo7IFNhbXBsZSBjZXBoIGNlcGguY29uZiBmaWxlLgo7CjsgVGhpcyBmaWxlIGRlZmluZXMgY2x1
c3RlciBtZW1iZXJzaGlwLCB0aGUgdmFyaW91cyBsb2NhdGlvbnMKOyB0aGF0IENlcGggc3RvcmVz
IGRhdGEsIGFuZCBhbnkgb3RoZXIgcnVudGltZSBvcHRpb25zLgoKOyBJZiBhICdob3N0JyBpcyBk
ZWZpbmVkIGZvciBhIGRhZW1vbiwgdGhlIHN0YXJ0L3N0b3Agc2NyaXB0IHdpbGwKOyB2ZXJpZnkg
dGhhdCBpdCBtYXRjaGVzIHRoZSBob3N0bmFtZSAob3IgZWxzZSBpZ25vcmUgaXQpLiAgSWYgaXQg
aXMKOyBub3QgZGVmaW5lZCwgaXQgaXMgYXNzdW1lZCB0aGF0IHRoZSBkYWVtb24gaXMgaW50ZW5k
ZWQgdG8gc3RhcnQgb24KOyB0aGUgY3VycmVudCBob3N0IChlLmcuLCBpbiBhIHNldHVwIHdpdGgg
YSBzdGFydHVwLmNvbmYgb24gZWFjaAo7IG5vZGUpLgoKOyBUaGUgdmFyaWFibGVzICR0eXBlLCAk
aWQgYW5kICRuYW1lIGFyZSBhdmFpbGFibGUgdG8gdXNlIGluIHBhdGhzCjsgJHR5cGUgPSBUaGUg
dHlwZSBvZiBkYWVtb24sIHBvc3NpYmxlIHZhbHVlczogbW9uLCBtZHMgYW5kIG9zZAo7ICRpZCA9
IFRoZSBJRCBvZiB0aGUgZGFlbW9uLCBmb3IgbW9uLmFscGhhLCAkaWQgd2lsbCBiZSBhbHBoYQo7
ICRuYW1lID0gJHR5cGUuJGlkCgo7IEZvciBleGFtcGxlOgo7IG9zZC4wCjsgICR0eXBlID0gb3Nk
CjsgICRpZCA9IDAKOyAgJG5hbWUgPSBvc2QuMAoKOyBtb24uYmV0YQo7ICAkdHlwZSA9IG1vbgo7
ICAkaWQgPSBiZXRhCjsgICRuYW1lID0gbW9uLmJldGEKCjsgZ2xvYmFsCltnbG9iYWxdCgk7IGVu
YWJsZSBzZWN1cmUgYXV0aGVudGljYXRpb24KCTthdXRoIHN1cHBvcnRlZCA9IGNlcGh4CgogICAg
ICAgIDsgYWxsb3cgb3Vyc2VsdmVzIHRvIG9wZW4gYSBsb3Qgb2YgZmlsZXMKICAgICAgICBtYXgg
b3BlbiBmaWxlcyA9IDEzMTA3MgoKICAgICAgICA7IHNldCBsb2cgZmlsZQogICAgICAgIGxvZyBm
aWxlID0gL3Zhci9sb2cvY2VwaC8kbmFtZS5sb2cKICAgICAgICA7IGxvZ190b19zeXNsb2cgPSB0
cnVlICAgICAgICA7IHVuY29tbWVudCB0aGlzIGxpbmUgdG8gbG9nIHRvIHN5c2xvZwoKICAgICAg
ICA7IHNldCB1cCBwaWQgZmlsZXMKICAgICAgICBwaWQgZmlsZSA9IC92YXIvcnVuL2NlcGgvJG5h
bWUucGlkCgogICAgICAgIDsgSWYgeW91IHdhbnQgdG8gcnVuIGEgSVB2NiBjbHVzdGVyLCBzZXQg
dGhpcyB0byB0cnVlLiBEdWFsLXN0YWNrIGlzbid0IHBvc3NpYmxlCiAgICAgICAgO21zIGJpbmQg
aXB2NiA9IHRydWUKCjsgbW9uaXRvcnMKOyAgWW91IG5lZWQgYXQgbGVhc3Qgb25lLiAgWW91IG5l
ZWQgYXQgbGVhc3QgdGhyZWUgaWYgeW91IHdhbnQgdG8KOyAgdG9sZXJhdGUgYW55IG5vZGUgZmFp
bHVyZXMuICBBbHdheXMgY3JlYXRlIGFuIG9kZCBudW1iZXIuClttb25dCiAgICAgICAgbW9uIGRh
dGEgPSAvZGF0YS8kbmFtZQoKICAgICAgICA7IElmIHlvdSBhcmUgdXNpbmcgZm9yIGV4YW1wbGUg
dGhlIFJBRE9TIEdhdGV3YXkgYW5kIHdhbnQgdG8gaGF2ZSB5b3VyIG5ld2x5IGNyZWF0ZWQKICAg
ICAgICA7IHBvb2xzIGEgaGlnaGVyIHJlcGxpY2F0aW9uIGxldmVsLCB5b3UgY2FuIHNldCBhIGRl
ZmF1bHQKICAgICAgICA7b3NkIHBvb2wgZGVmYXVsdCBzaXplID0gMwoKICAgICAgICA7IFlvdSBj
YW4gYWxzbyBzcGVjaWZ5IGEgQ1JVU0ggcnVsZSBmb3IgbmV3IHBvb2xzCiAgICAgICAgOyBXaWtp
OiBodHRwOi8vY2VwaC5uZXdkcmVhbS5uZXQvd2lraS9DdXN0b21fZGF0YV9wbGFjZW1lbnRfd2l0
aF9DUlVTSAogICAgICAgIDtvc2QgcG9vbCBkZWZhdWx0IGNydXNoIHJ1bGUgPSAwCgogICAgICAg
IDsgVGltaW5nIGlzIGNyaXRpY2FsIGZvciBtb25pdG9ycywgYnV0IGlmIHlvdSB3YW50IHRvIGFs
bG93IHRoZSBjbG9ja3MgdG8gZHJpZnQgYQogICAgICAgIDsgYml0IG1vcmUsIHlvdSBjYW4gc3Bl
Y2lmeSB0aGUgbWF4IGRyaWZ0LgogICAgICAgIDttb24gY2xvY2sgZHJpZnQgYWxsb3dlZCA9IDEK
CiAgICAgICAgOyBUZWxsIHRoZSBtb25pdG9yIHRvIGJhY2tvZmYgZnJvbSB0aGlzIHdhcm5pbmcg
Zm9yIDMwIHNlY29uZHMKICAgICAgICA7bW9uIGNsb2NrIGRyaWZ0IHdhcm4gYmFja29mZiA9IDMw
CgoJOyBsb2dnaW5nLCBmb3IgZGVidWdnaW5nIG1vbml0b3IgY3Jhc2hlcywgaW4gb3JkZXIgb2YK
CTsgdGhlaXIgbGlrZWxpaG9vZCBvZiBiZWluZyBoZWxwZnVsIDopCgk7ZGVidWcgbXMgPSAxCgk7
ZGVidWcgbW9uID0gMjAKCTtkZWJ1ZyBwYXhvcyA9IDIwCgk7ZGVidWcgYXV0aCA9IDIwCgpbbW9u
LmNlcGgwMWddCglob3N0ID0gY2VwaDAxZwoJbW9uIGFkZHIgPSA4NC4yMDEuMTYxLjczOjY3ODkK
Clttb24uY2VwaDAyZ10KCWhvc3QgPSBjZXBoMDJnCgltb24gYWRkciA9IDg0LjIwMS4xNjEuNzQ6
Njc4OQoKW21vbi5jZXBoMDNnXQoJaG9zdCA9IGNlcGgwM2cKCW1vbiBhZGRyID0gODQuMjAxLjE2
MS43NTo2Nzg5Cgo7IG1kcwo7ICBZb3UgbmVlZCBhdCBsZWFzdCBvbmUuICBEZWZpbmUgdHdvIHRv
IGdldCBhIHN0YW5kYnkuClttZHNdCgk7IHdoZXJlIHRoZSBtZHMga2VlcHMgaXQncyBzZWNyZXQg
ZW5jcnlwdGlvbiBrZXlzCglrZXlyaW5nID0gL2RhdGEva2V5cmluZy4kbmFtZQoKCTsgbWRzIGxv
Z2dpbmcgdG8gZGVidWcgaXNzdWVzLgoJO2RlYnVnIG1zID0gMQoJO2RlYnVnIG1kcyA9IDIwCgpb
bWRzLmNlcGgwMWddCglob3N0ID0gY2VwaDAxZwpbbWRzLmNlcGgwM2ddCglob3N0ID0gY2VwaDAz
ZwoKOyBvc2QKOyAgWW91IG5lZWQgYXQgbGVhc3Qgb25lLiAgVHdvIGlmIHlvdSB3YW50IGRhdGEg
dG8gYmUgcmVwbGljYXRlZC4KOyAgRGVmaW5lIGFzIG1hbnkgYXMgeW91IGxpa2UuCltvc2RdCgk7
IFRoaXMgaXMgd2hlcmUgdGhlIGJ0cmZzIHZvbHVtZSB3aWxsIGJlIG1vdW50ZWQuCglvc2QgZGF0
YSA9IC9kYXRhLyRuYW1lCgoJOyBJZGVhbGx5LCBtYWtlIHRoaXMgYSBzZXBhcmF0ZSBkaXNrIG9y
IHBhcnRpdGlvbi4gIEEgZmV3CiAJOyBodW5kcmVkIE1CIHNob3VsZCBiZSBlbm91Z2g7IG1vcmUg
aWYgeW91IGhhdmUgZmFzdCBvciBtYW55CiAJOyBkaXNrcy4gIFlvdSBjYW4gdXNlIGEgZmlsZSB1
bmRlciB0aGUgb3NkIGRhdGEgZGlyIGlmIG5lZWQgYmUKIAk7IChlLmcuIC9kYXRhLyRuYW1lL2pv
dXJuYWwpLCBidXQgaXQgd2lsbCBiZSBzbG93ZXIgdGhhbiBhCiAJOyBzZXBhcmF0ZSBkaXNrIG9y
IHBhcnRpdGlvbi4KCiAgICAgICAgOyBUaGlzIGlzIGFuIGV4YW1wbGUgb2YgYSBmaWxlLWJhc2Vk
IGpvdXJuYWwuCglvc2Qgam91cm5hbCA9IC9kYXRhLyRuYW1lL2pvdXJuYWwKCW9zZCBqb3VybmFs
IHNpemUgPSAxMDAwIDsgam91cm5hbCBzaXplLCBpbiBtZWdhYnl0ZXMKCiAgICAgICAgOyBJZiB5
b3Ugd2FudCB0byBydW4gdGhlIGpvdXJuYWwgb24gYSB0bXBmcywgZGlzYWJsZSBEaXJlY3RJTwog
ICAgICAgIDtqb3VybmFsIGRpbyA9IGZhbHNlCgogICAgICAgIDsgWW91IGNhbiBjaGFuZ2UgdGhl
IG51bWJlciBvZiByZWNvdmVyeSBvcGVyYXRpb25zIHRvIHNwZWVkIHVwIHJlY292ZXJ5CiAgICAg
ICAgOyBvciBzbG93IGl0IGRvd24gaWYgeW91ciBtYWNoaW5lcyBjYW4ndCBoYW5kbGUgaXQKICAg
ICAgICA7IG9zZCByZWNvdmVyeSBtYXggYWN0aXZlID0gMwoKCTsgb3NkIGxvZ2dpbmcgdG8gZGVi
dWcgb3NkIGlzc3VlcywgaW4gb3JkZXIgb2YgbGlrZWxpaG9vZCBvZiBiZWluZwoJOyBoZWxwZnVs
Cgk7ZGVidWcgbXMgPSAxCgk7ZGVidWcgb3NkID0gMjAKCTtkZWJ1ZyBmaWxlc3RvcmUgPSAyMAoJ
O2RlYnVnIGpvdXJuYWwgPSAyMAoKW29zZC4xXQoJaG9zdCA9IGNlcGgwMWcKW29zZC4yXQoJaG9z
dCA9IGNlcGgwMmcKW29zZC4zXQoJaG9zdCA9IGNlcGgwM2cKW29zZC40XQoJaG9zdCA9IGNlcGgw
NGcKW29zZC41XQoJaG9zdCA9IGNlcGgwNWcK
--0016e6dd8a6f6097da04b6ddb3e5--
