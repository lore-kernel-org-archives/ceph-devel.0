From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: RGW Blocking on 1-2 PG's - argonaut
Date: Mon, 4 Mar 2013 17:13:25 +0100
Message-ID: <CAMwB3ThWcpWNOp03tCv1vG1OckH0Nw0moKYnPDytNya2Hhv+XA@mail.gmail.com>
References: <CAMwB3ThhN036aBHP+29fVJ47E=PxOnj+fTiKJrB2dANFn1-Q1w@mail.gmail.com>
	<CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d0402ac45015e1604d71ba335
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34175 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3CDQN0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 11:13:26 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so6263324iea.26
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 08:13:25 -0800 (PST)
In-Reply-To: <CAC-hyiGG+f7R1jCY8CPR2HKTa7bSetnGWs+ERii6iTdEAXpWMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--f46d0402ac45015e1604d71ba335
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Ok, thanks for response. But if i have crush map like this in attachment.

All data should be balanced equal, not including hosts with 0.5 weight.

How make data auto balanced ?? when i know that some pq's have too
much data ?? I have 4800 pg's on RGW only with 78 OSD, it is quite
enough.

pool 3 '.rgw.buckets' rep size 3 crush_ruleset 0 object_hash rjenkins
pg_num 4800 pgp_num 4800 last_change 908 owner 0

When will bee possible to expand number of pg's ??

Best Regards

Slawomir Skowron

On Mon, Mar 4, 2013 at 3:16 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
> On Mon, Mar 4, 2013 at 3:02 AM, S=B3awomir Skowron <szibis@gmail.com> wro=
te:
>> Hi,
>>
>> We have a big problem with RGW. I don't know what is the initial
>> trigger, but i have theory.
>>
>> 2-3 osd, from 78 in cluster (6480 PG on RGW pool), have 3x time more
>> RAM usage, they have much more operations in journal, and much bigger
>> latency.
>>
>> When we PUT some objects then in some cases, there are so many
>> operations in triple replication on this osd (one PG). Then this
>> triple can't handle this load, and goes down, drives on backend of
>> this osd are getting fire with big wait-io, and big response times.
>> RGW waiting for this PG, and eventually block all the others
>> operations when makes 1024 operations blocked in queue.
>> Then whole cluster have problems, and we have an outage.
>>
>> When RGW block operations there is only one PG that have >1000
>> operations in queue -
>> ceph pg map 3.9447554d
>> osdmap e11404 pg 3.9447554d (3.54d) -> up [53,45,23] acting [53,45,23]
>>
>> now this osd are migrated, with ratio 0.5 on, but before it was
>>
>> ceph pg map 3.9447554d
>> osdmap e11404 pg 3.9447554d (3.54d) -> up [71,45,23] acting [71,45,23]
>>
>> and this three osd's have such a problems. Under this osd's are only 3
>> drive, one drive per osd, that's why this have such a big impact.
>>
>> What i done. I gave 50% smaller ratio in CRUSH for this osd's, but
>> data move to other osd, and this osd, have half of possible capacity.
>> I think it won't help in long term, and it's not a solution.
>>
>> I have second cluster, with only replication on it, and there are same
>> case. Attachment explain everything. Every parameter on this bad osd
>> is much higher than on others. There are 2-3 osd with such high
>> counters.
>>
>> Is this a bug ?? maybe there is no problems in bobtail ?? I can't
>> switch quick into bobtail that's why i need some answers, which way i
>> need to go.
>>
>
> Not sure if bobtail is going to help much here, although there were a
> few performance fixes that went in. If your cluster is unbalanced (in
> terms of performance) then requests are going to be accumulated on the
> weakest link. Reweighting the osd like what you did is a valid way to
> go. You need to make sure that on the steady state, there's no one osd
> that starts holding all the traffic.
> Also, make sure that your pools have enough pgs so that the placement
> distribution is uniform.
>
> Yehuda



--
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron

--f46d0402ac45015e1604d71ba335
Content-Type: text/plain; charset=US-ASCII; name="crush.txt"
Content-Disposition: attachment; filename="crush.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hdvttpez0

IyBiZWdpbiBjcnVzaCBtYXAKCiMgZGV2aWNlcwpkZXZpY2UgMCBvc2QuMApkZXZpY2UgMSBvc2Qu
MQpkZXZpY2UgMiBvc2QuMgpkZXZpY2UgMyBvc2QuMwpkZXZpY2UgNCBvc2QuNApkZXZpY2UgNSBv
c2QuNQpkZXZpY2UgNiBvc2QuNgpkZXZpY2UgNyBvc2QuNwpkZXZpY2UgOCBvc2QuOApkZXZpY2Ug
OSBvc2QuOQpkZXZpY2UgMTAgb3NkLjEwCmRldmljZSAxMSBvc2QuMTEKZGV2aWNlIDEyIG9zZC4x
MgpkZXZpY2UgMTMgb3NkLjEzCmRldmljZSAxNCBvc2QuMTQKZGV2aWNlIDE1IG9zZC4xNQpkZXZp
Y2UgMTYgb3NkLjE2CmRldmljZSAxNyBvc2QuMTcKZGV2aWNlIDE4IG9zZC4xOApkZXZpY2UgMTkg
b3NkLjE5CmRldmljZSAyMCBvc2QuMjAKZGV2aWNlIDIxIG9zZC4yMQpkZXZpY2UgMjIgb3NkLjIy
CmRldmljZSAyMyBvc2QuMjMKZGV2aWNlIDI0IG9zZC4yNApkZXZpY2UgMjUgb3NkLjI1CmRldmlj
ZSAyNiBvc2QuMjYKZGV2aWNlIDI3IG9zZC4yNwpkZXZpY2UgMjggb3NkLjI4CmRldmljZSAyOSBv
c2QuMjkKZGV2aWNlIDMwIG9zZC4zMApkZXZpY2UgMzEgb3NkLjMxCmRldmljZSAzMiBvc2QuMzIK
ZGV2aWNlIDMzIG9zZC4zMwpkZXZpY2UgMzQgb3NkLjM0CmRldmljZSAzNSBvc2QuMzUKZGV2aWNl
IDM2IG9zZC4zNgpkZXZpY2UgMzcgb3NkLjM3CmRldmljZSAzOCBvc2QuMzgKZGV2aWNlIDM5IG9z
ZC4zOQpkZXZpY2UgNDAgb3NkLjQwCmRldmljZSA0MSBvc2QuNDEKZGV2aWNlIDQyIG9zZC40Mgpk
ZXZpY2UgNDMgb3NkLjQzCmRldmljZSA0NCBvc2QuNDQKZGV2aWNlIDQ1IG9zZC40NQpkZXZpY2Ug
NDYgb3NkLjQ2CmRldmljZSA0NyBvc2QuNDcKZGV2aWNlIDQ4IG9zZC40OApkZXZpY2UgNDkgb3Nk
LjQ5CmRldmljZSA1MCBvc2QuNTAKZGV2aWNlIDUxIG9zZC41MQpkZXZpY2UgNTIgb3NkLjUyCmRl
dmljZSA1MyBvc2QuNTMKZGV2aWNlIDU0IG9zZC41NApkZXZpY2UgNTUgb3NkLjU1CmRldmljZSA1
NiBvc2QuNTYKZGV2aWNlIDU3IG9zZC41NwpkZXZpY2UgNTggb3NkLjU4CmRldmljZSA1OSBvc2Qu
NTkKZGV2aWNlIDYwIG9zZC42MApkZXZpY2UgNjEgb3NkLjYxCmRldmljZSA2MiBvc2QuNjIKZGV2
aWNlIDYzIG9zZC42MwpkZXZpY2UgNjQgb3NkLjY0CmRldmljZSA2NSBvc2QuNjUKZGV2aWNlIDY2
IG9zZC42NgpkZXZpY2UgNjcgb3NkLjY3CmRldmljZSA2OCBvc2QuNjgKZGV2aWNlIDY5IG9zZC42
OQpkZXZpY2UgNzAgb3NkLjcwCmRldmljZSA3MSBvc2QuNzEKZGV2aWNlIDcyIG9zZC43MgpkZXZp
Y2UgNzMgb3NkLjczCmRldmljZSA3NCBvc2QuNzQKZGV2aWNlIDc1IG9zZC43NQpkZXZpY2UgNzYg
b3NkLjc2CmRldmljZSA3NyBvc2QuNzcKCiMgdHlwZXMKdHlwZSAwIG9zZAp0eXBlIDEgaG9zdAp0
eXBlIDIgcmFjawp0eXBlIDMgcm93CnR5cGUgNCByb29tCnR5cGUgNSBkYXRhY2VudGVyCnR5cGUg
NiBwb29sCgojIGJ1Y2tldHMKaG9zdCBzMy0xMC0xNzctNjQtNCB7CglpZCAtMgkJIyBkbyBub3Qg
Y2hhbmdlIHVubmVjZXNzYXJpbHkKCSMgd2VpZ2h0IDI1LjUwMAoJYWxnIHN0cmF3CgloYXNoIDAJ
IyByamVua2luczEKCWl0ZW0gb3NkLjEgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4yIHdlaWdodCAx
LjAwMAoJaXRlbSBvc2QuMyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjQgd2VpZ2h0IDEuMDAwCglp
dGVtIG9zZC41IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNiB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3Nk
Ljcgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC44IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuOSB3ZWln
aHQgMS4wMDAKCWl0ZW0gb3NkLjEwIHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMTEgd2VpZ2h0IDEu
MDAwCglpdGVtIG9zZC4xMyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjE0IHdlaWdodCAxLjAwMAoJ
aXRlbSBvc2QuMTUgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4xNiB3ZWlnaHQgMS4wMDAKCWl0ZW0g
b3NkLjE3IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMTggd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4x
OSB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjIwIHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMjEgd2Vp
Z2h0IDEuMDAwCglpdGVtIG9zZC4yMiB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjIzIHdlaWdodCAw
LjUwMAoJaXRlbSBvc2QuMjQgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4yNSB3ZWlnaHQgMS4wMDAK
CWl0ZW0gb3NkLjEyIHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMCB3ZWlnaHQgMS4wMDAKfQpyYWNr
IHJhY2sxIHsKCWlkIC0zCQkjIGRvIG5vdCBjaGFuZ2UgdW5uZWNlc3NhcmlseQoJIyB3ZWlnaHQg
MjUuNTAwCglhbGcgc3RyYXcKCWhhc2ggMAkjIHJqZW5raW5zMQoJaXRlbSBzMy0xMC0xNzctNjQt
NCB3ZWlnaHQgMjUuNTAwCn0KaG9zdCBzMy0xMC0xNzctNjQtNiB7CglpZCAtNAkJIyBkbyBub3Qg
Y2hhbmdlIHVubmVjZXNzYXJpbHkKCSMgd2VpZ2h0IDI1LjUwMAoJYWxnIHN0cmF3CgloYXNoIDAJ
IyByamVua2luczEKCWl0ZW0gb3NkLjI2IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMjcgd2VpZ2h0
IDEuMDAwCglpdGVtIG9zZC4yOCB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjMxIHdlaWdodCAxLjAw
MAoJaXRlbSBvc2QuMzIgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4zMyB3ZWlnaHQgMS4wMDAKCWl0
ZW0gb3NkLjM0IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMzUgd2VpZ2h0IDEuMDAwCglpdGVtIG9z
ZC4zNyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjM4IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMzkg
d2VpZ2h0IDEuMDAwCglpdGVtIG9zZC40MCB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjQxIHdlaWdo
dCAxLjAwMAoJaXRlbSBvc2QuNDIgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC40MyB3ZWlnaHQgMS4w
MDAKCWl0ZW0gb3NkLjQ1IHdlaWdodCAwLjUwMAoJaXRlbSBvc2QuNDYgd2VpZ2h0IDEuMDAwCglp
dGVtIG9zZC40NyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjQ4IHdlaWdodCAxLjAwMAoJaXRlbSBv
c2QuNDkgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC41MCB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjUx
IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNDQgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC4yOSB3ZWln
aHQgMS4wMDAKCWl0ZW0gb3NkLjM2IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuMzAgd2VpZ2h0IDEu
MDAwCn0KcmFjayByYWNrMiB7CglpZCAtNQkJIyBkbyBub3QgY2hhbmdlIHVubmVjZXNzYXJpbHkK
CSMgd2VpZ2h0IDI1LjUwMAoJYWxnIHN0cmF3CgloYXNoIDAJIyByamVua2luczEKCWl0ZW0gczMt
MTAtMTc3LTY0LTYgd2VpZ2h0IDI1LjUwMAp9Cmhvc3QgczMtMTAtMTc3LTY0LTggewoJaWQgLTYJ
CSMgZG8gbm90IGNoYW5nZSB1bm5lY2Vzc2FyaWx5CgkjIHdlaWdodCAyNS41MDAKCWFsZyBzdHJh
dwoJaGFzaCAwCSMgcmplbmtpbnMxCglpdGVtIG9zZC41MiB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3Nk
LjUzIHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNTQgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC41NSB3
ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjU2IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNTcgd2VpZ2h0
IDEuMDAwCglpdGVtIG9zZC41OCB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjU5IHdlaWdodCAxLjAw
MAoJaXRlbSBvc2QuNjAgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC42MSB3ZWlnaHQgMS4wMDAKCWl0
ZW0gb3NkLjYyIHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNjMgd2VpZ2h0IDEuMDAwCglpdGVtIG9z
ZC42NCB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjY1IHdlaWdodCAxLjAwMAoJaXRlbSBvc2QuNjYg
d2VpZ2h0IDEuMDAwCglpdGVtIG9zZC42NyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjY4IHdlaWdo
dCAxLjAwMAoJaXRlbSBvc2QuNjkgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC43MCB3ZWlnaHQgMS4w
MDAKCWl0ZW0gb3NkLjcxIHdlaWdodCAwLjUwMAoJaXRlbSBvc2QuNzIgd2VpZ2h0IDEuMDAwCglp
dGVtIG9zZC43MyB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjc0IHdlaWdodCAxLjAwMAoJaXRlbSBv
c2QuNzUgd2VpZ2h0IDEuMDAwCglpdGVtIG9zZC43NiB3ZWlnaHQgMS4wMDAKCWl0ZW0gb3NkLjc3
IHdlaWdodCAxLjAwMAp9CnJhY2sgcmFjazMgewoJaWQgLTcJCSMgZG8gbm90IGNoYW5nZSB1bm5l
Y2Vzc2FyaWx5CgkjIHdlaWdodCAyNS41MDAKCWFsZyBzdHJhdwoJaGFzaCAwCSMgcmplbmtpbnMx
CglpdGVtIHMzLTEwLTE3Ny02NC04IHdlaWdodCAyNS41MDAKfQpwb29sIGRlZmF1bHQgewoJaWQg
LTEJCSMgZG8gbm90IGNoYW5nZSB1bm5lY2Vzc2FyaWx5CgkjIHdlaWdodCA3Ni41MDAKCWFsZyBz
dHJhdwoJaGFzaCAwCSMgcmplbmtpbnMxCglpdGVtIHJhY2sxIHdlaWdodCAyNS41MDAKCWl0ZW0g
cmFjazIgd2VpZ2h0IDI1LjUwMAoJaXRlbSByYWNrMyB3ZWlnaHQgMjUuNTAwCn0KCiMgcnVsZXMK
cnVsZSBkYXRhIHsKCXJ1bGVzZXQgMAoJdHlwZSByZXBsaWNhdGVkCgltaW5fc2l6ZSAxCgltYXhf
c2l6ZSAxMAoJc3RlcCB0YWtlIGRlZmF1bHQKCXN0ZXAgY2hvb3NlbGVhZiBmaXJzdG4gMCB0eXBl
IHJhY2sKCXN0ZXAgZW1pdAp9CnJ1bGUgbWV0YWRhdGEgewoJcnVsZXNldCAxCgl0eXBlIHJlcGxp
Y2F0ZWQKCW1pbl9zaXplIDEKCW1heF9zaXplIDEwCglzdGVwIHRha2UgZGVmYXVsdAoJc3RlcCBj
aG9vc2VsZWFmIGZpcnN0biAwIHR5cGUgcmFjawoJc3RlcCBlbWl0Cn0KcnVsZSByYmQgewoJcnVs
ZXNldCAyCgl0eXBlIHJlcGxpY2F0ZWQKCW1pbl9zaXplIDEKCW1heF9zaXplIDEwCglzdGVwIHRh
a2UgZGVmYXVsdAoJc3RlcCBjaG9vc2VsZWFmIGZpcnN0biAwIHR5cGUgcmFjawoJc3RlcCBlbWl0
Cn0KCiMgZW5kIGNydXNoIG1hcA==
--f46d0402ac45015e1604d71ba335--
