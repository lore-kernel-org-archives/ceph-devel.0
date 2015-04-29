From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Wed, 29 Apr 2015 08:08:42 -0500
Message-ID: <5540D7DA.2000503@redhat.com>
References: <554016E2.3000104@redhat.com>	<CAKKTCLX31EBc8oOs6tVVRu4c5prUYD=3G=8fK3pMvLQTM+1iSQ@mail.gmail.com>	<554020DC.6020009@redhat.com> <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070105080807020701000902"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423047AbbD2NIr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 09:08:47 -0400
In-Reply-To: <CAFkUHxe=e+1Hk7ChtF+HHFkQ-RtBNBhzJ=VCu+x_aZF4MyMiRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kernel neophyte <neophyte.hacker001@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070105080807020701000902
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ceph.conf file attached.  It's a little ugly because I've been playing 
with various parameters.  You'll probably want to enable debug newstore 
= 30 if you plan to do any debugging.  Also, the code has been changing 
quickly so performance may have changed if you haven't tested within the 
last week.

Mark

On 04/28/2015 09:59 PM, kernel neophyte wrote:
> Hi Mark,
>
> I am trying to measure 4k RW performance on Newstore, and I am not
> anywhere close to the numbers you are getting!
>
> Could you share your ceph.conf for these test ?
>
> -Neo
>
> On Tue, Apr 28, 2015 at 5:07 PM, Mark Nelson <mnelson@redhat.com> wrote:
>> Nothing official, though roughly from memory:
>>
>> ~1.7GB/s and something crazy like 100K IOPS for the SSD.
>>
>> ~150MB/s and ~125-150 IOPS for the spinning disk.
>>
>> Mark
>>
>>
>> On 04/28/2015 07:00 PM, Venkateswara Rao Jujjuri wrote:
>>>
>>> Thanks for sharing; newstore numbers look lot better;
>>>
>>> Wondering if we have any base line numbers to put things into perspective.
>>> like what is it on XFS or on librados?
>>>
>>> JV
>>>
>>> On Tue, Apr 28, 2015 at 4:25 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>>>
>>>> Hi Guys,
>>>>
>>>> Sage has been furiously working away at fixing bugs in newstore and
>>>> improving performance.  Specifically we've been focused on write
>>>> performance
>>>> as newstore was lagging filestore but quite a bit previously.  A lot of
>>>> work
>>>> has gone into implementing libaio behind the scenes and as a result
>>>> performance on spinning disks with SSD WAL (and SSD backed rocksdb) has
>>>> improved pretty dramatically. It's now often beating filestore:
>>>>
>>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>>
>>>> On the other hand, sequential writes are slower than random writes when
>>>> the
>>>> OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
>>>> In this situation newstore does better with random writes and sometimes
>>>> beats filestore (such as in the everything-on-spinning disk tests, and
>>>> when
>>>> IO sizes are small in the everything-on-ssd tests).
>>>>
>>>> Newstore is changing daily so keep in mind that these results are almost
>>>> assuredly going to change.  An interesting area of investigation will be
>>>> why
>>>> sequential writes are slower than random writes, and whether or not we
>>>> are
>>>> being limited by rocksdb ingest speed and how.
>>>>
>>>> I've also uploaded a quick perf call-graph I grabbed during the "all-SSD"
>>>> 32KB sequential write test to see if rocksdb was starving one of the
>>>> cores,
>>>> but found something that looks quite a bit different:
>>>>
>>>> http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
>>>>
>>>> Mark
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--------------070105080807020701000902
Content-Type: text/plain; charset=UTF-8;
 name="ceph.conf.1osd"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ceph.conf.1osd"

W2dsb2JhbF0KICAgICAgICBvc2QgcG9vbCBkZWZhdWx0IHNpemUgPSAxCgogICAgICAgIG9z
ZCBjcnVzaCBjaG9vc2VsZWFmIHR5cGUgPSAwCiAgICAgICAgZW5hYmxlIGV4cGVyaW1lbnRh
bCB1bnJlY292ZXJhYmxlIGRhdGEgY29ycnVwdGluZyBmZWF0dXJlcyA9IG5ld3N0b3JlIHJv
Y2tzZGIKICAgICAgICBvc2Qgb2JqZWN0c3RvcmUgPSBuZXdzdG9yZQojICAgICAgICBuZXdz
dG9yZSBhaW8gbWF4IHF1ZXVlIGRlcHRoID0gNDA5NiAKIyAgICAgICAgbmV3c3RvcmUgb3Zl
cmxheSBtYXggbGVuZ3RoID0gODM4ODYwOCAKIyAgICAgICAgcm9ja3NkYiB3YWwgZGlyID0g
Ii93YWwiCiMgICAgICAgIG5ld3N0b3JlIGRiIHBhdGggPSAiL3dhbCIKICAgICAgICBuZXdz
dG9yZSBvdmVybGF5IG1heCA9IDAKICAgICAgICBuZXdzdG9yZV93YWxfdGhyZWFkcyA9IDgK
ICAgICAgICByb2Nrc2RiX3dyaXRlX2J1ZmZlcl9zaXplID0gNTM2ODcwOTEyCiAgICAgICAg
cm9ja3NkYl93cml0ZV9idWZmZXJfbnVtID0gNAogICAgICAgIHJvY2tzZGJfbWluX3dyaXRl
X2J1ZmZlcl9udW1iZXJfdG9fbWVyZ2UgPSAyCiAgICAgICAgcm9ja3NkYl9sb2cgPSAvaG9t
ZS9uaG0vdG1wL2NidC9jZXBoL2xvZy9yb2Nrc2RiLmxvZwogICAgICAgIHJvY2tzZGJfbWF4
X2JhY2tncm91bmRfY29tcGFjdGlvbnMgPSA0CiAgICAgICAgcm9ja3NkYl9jb21wYWN0aW9u
X3RocmVhZHMgPSA0CiAgICAgICAgcm9ja3NkYl9sZXZlbDBfZmlsZV9udW1fY29tcGFjdGlv
bl90cmlnZ2VyID0gNAogICAgICAgIHJvY2tzZGJfbWF4X2J5dGVzX2Zvcl9sZXZlbF9iYXNl
ID0gMTA0ODU3NjAwIC8vMTAwTUIKICAgICAgICByb2Nrc2RiX3RhcmdldF9maWxlX3NpemVf
YmFzZSA9IDEwNDg1NzYwICAgICAgLy8xME1CCiAgICAgICAgcm9ja3NkYl9udW1fbGV2ZWxz
ID0gMwogICAgICAgIHJvY2tzZGJfY29tcHJlc3Npb24gPSBub25lCgogICAgICAgIGtleXJp
bmcgPSAvaG9tZS9uaG0vdG1wL2NidC9jZXBoL2tleXJpbmcKICAgICAgICBvc2QgcGcgYml0
cyA9IDggIAogICAgICAgIG9zZCBwZ3AgYml0cyA9IDgKCWF1dGggc3VwcG9ydGVkID0gbm9u
ZQogICAgICAgIGxvZyB0byBzeXNsb2cgPSBmYWxzZQogICAgICAgIGxvZyBmaWxlID0gL2hv
bWUvbmhtL3RtcC9jYnQvY2VwaC9sb2cvJG5hbWUubG9nCiAgICAgICAgZmlsZXN0b3JlIHhh
dHRyIHVzZSBvbWFwID0gdHJ1ZQogICAgICAgIGF1dGggY2x1c3RlciByZXF1aXJlZCA9IG5v
bmUKICAgICAgICBhdXRoIHNlcnZpY2UgcmVxdWlyZWQgPSBub25lCiAgICAgICAgYXV0aCBj
bGllbnQgcmVxdWlyZWQgPSBub25lCgogICAgICAgIHB1YmxpYyBuZXR3b3JrID0gMTkyLjE2
OC4xMC4wLzI0CiAgICAgICAgY2x1c3RlciBuZXR3b3JrID0gMTkyLjE2OC4xMC4wLzI0CiAg
ICAgICAgcmJkIGNhY2hlID0gdHJ1ZQogICAgICAgIG9zZCBzY3J1YiBsb2FkIHRocmVzaG9s
ZCA9IDAuMDEKICAgICAgICBvc2Qgc2NydWIgbWluIGludGVydmFsID0gMTM3NDM4OTUzNDcy
CiAgICAgICAgb3NkIHNjcnViIG1heCBpbnRlcnZhbCA9IDEzNzQzODk1MzQ3MgogICAgICAg
IG9zZCBkZWVwIHNjcnViIGludGVydmFsID0gMTM3NDM4OTUzNDcyCiAgICAgICAgb3NkIG1h
eCBzY3J1YnMgPSAxNgoKICAgICAgICBmaWxlc3RvcmUgbWVyZ2UgdGhyZXNob2xkID0gNDAK
ICAgICAgICBmaWxlc3RvcmUgc3BsaXQgbXVsdGlwbGUgPSA4CiAgICAgICAgb3NkIG9wIHRo
cmVhZHMgPSA4CgogICAgICAgIGRlYnVnIG5ld3N0b3JlID0gIjAvMCIgCgogICAgICAgIGRl
YnVnX2xvY2tkZXAgPSAiMC8wIiAKICAgICAgICBkZWJ1Z19jb250ZXh0ID0gIjAvMCIKICAg
ICAgICBkZWJ1Z19jcnVzaCA9ICIwLzAiCiAgICAgICAgZGVidWdfbWRzID0gIjAvMCIKICAg
ICAgICBkZWJ1Z19tZHNfYmFsYW5jZXIgPSAiMC8wIgogICAgICAgIGRlYnVnX21kc19sb2Nr
ZXIgPSAiMC8wIgogICAgICAgIGRlYnVnX21kc19sb2cgPSAiMC8wIgogICAgICAgIGRlYnVn
X21kc19sb2dfZXhwaXJlID0gIjAvMCIKICAgICAgICBkZWJ1Z19tZHNfbWlncmF0b3IgPSAi
MC8wIgogICAgICAgIGRlYnVnX2J1ZmZlciA9ICIwLzAiCiAgICAgICAgZGVidWdfdGltZXIg
PSAiMC8wIgogICAgICAgIGRlYnVnX2ZpbGVyID0gIjAvMCIKICAgICAgICBkZWJ1Z19vYmpl
Y3RlciA9ICIwLzAiCiAgICAgICAgZGVidWdfcmFkb3MgPSAiMC8wIgogICAgICAgIGRlYnVn
X3JiZCA9ICIwLzAiCiAgICAgICAgZGVidWdfam91cm5hbGVyID0gIjAvMCIKICAgICAgICBk
ZWJ1Z19vYmplY3RjYWNoZXIgPSAiMC8wIgogICAgICAgIGRlYnVnX2NsaWVudCA9ICIwLzAi
CiAgICAgICAgZGVidWdfb3NkID0gIjAvMCIKICAgICAgICBkZWJ1Z19vcHRyYWNrZXIgPSAi
MC8wIgogICAgICAgIGRlYnVnX29iamNsYXNzID0gIjAvMCIKICAgICAgICBkZWJ1Z19maWxl
c3RvcmUgPSAiMC8wIgogICAgICAgIGRlYnVnX2pvdXJuYWwgPSAiMC8wIgogICAgICAgIGRl
YnVnX21zID0gIjAvMCIKICAgICAgICBkZWJ1Z19tb24gPSAiMC8wIgogICAgICAgIGRlYnVn
X21vbmMgPSAiMC8wIgogICAgICAgIGRlYnVnX3BheG9zID0gIjAvMCIKICAgICAgICBkZWJ1
Z190cCA9ICIwLzAiCiAgICAgICAgZGVidWdfYXV0aCA9ICIwLzAiCiAgICAgICAgZGVidWdf
ZmluaXNoZXIgPSAiMC8wIgogICAgICAgIGRlYnVnX2hlYXJ0YmVhdG1hcCA9ICIwLzAiCiAg
ICAgICAgZGVidWdfcGVyZmNvdW50ZXIgPSAiMC8wIgogICAgICAgIGRlYnVnX3JndyA9ICIw
LzAiCiAgICAgICAgZGVidWdfaGFkb29wID0gIjAvMCIKICAgICAgICBkZWJ1Z19hc29rID0g
IjAvMCIKICAgICAgICBkZWJ1Z190aHJvdHRsZSA9ICIwLzAiCgogICAgICAgIG1vbiBwZyB3
YXJuIG1heCBvYmplY3Qgc2tldyA9IDEwMDAwMAogICAgICAgIG1vbiBwZyB3YXJuIG1pbiBw
ZXIgb3NkID0gMAogICAgICAgIG1vbiBwZyB3YXJuIG1heCBwZXIgb3NkID0gMzI3NjgKCgoj
ICAgICAgICBkZWJ1ZyBvcHRyYWNrZXIgPSAzMAojICAgICAgICBkZWJ1ZyB0cCA9IDUKIyAg
ICAgICAgb2JqZWN0ZXIgaW5maWxnaHQgb3AgYnl0ZXMgPSAxMDczNzQxODI0CiMgICAgICAg
IG9iamVjdGVyIGluZmxpZ2h0IG9wcyA9IDgxOTIKIAojICAgICAgICBmaWxlc3RvcmUgd2J0
aHJvdHRsZSBlbmFibGUgPSBmYWxzZQojICAgICAgICBkZWJ1ZyBvc2QgPSAyMAoKIyAgICAg
ICAgZmlsZXN0b3JlIHdidGhyb3R0bGUgeGZzIGlvcyBzdGFydCBmbHVzaGVyID0gNTAwCiMg
ICAgICAgIGZpbGVzdG9yZSB3YnRocm90dGxlIHhmcyBpb3MgaGFyZCBsaW1pdCA9IDUwMDAK
IyAgICAgICAgZmlsZXN0b3JlIHdidGhyb3R0bGUgeGZzIGlub2RlcyBzdGFydCBmbHVzaGVy
ID0gNTAwCiMgICAgICAgIGZpbGVzdG9yZSB3YnRocm90dGxlIHhmcyBpbm9kZXMgaGFyZCBs
aW1pdCA9IDUwMDAKIyAgICAgICAgZmlsZXN0b3JlIHdidGhyb3R0bGUgeGZzIGJ5dGVzIHN0
YXJ0IGZsdXNoZXIgPSA0MTk0MzA0MAojICAgICAgICBmaWxlc3RvcmUgd2J0aHJvdHRsZSB4
ZnMgYnl0ZXMgaGFyZCBsaW1pdCA9IDQxOTQzMDQwMAoKIyAgICAgICAgZmlsZXN0b3JlIHdi
dGhyb3R0bGUgYnRyZnMgaW9zIHN0YXJ0IGZsdXNoZXIgPSA1MDAKIyAgICAgICAgZmlsZXN0
b3JlIHdidGhyb3R0bGUgYnRyZnMgaW9zIGhhcmQgbGltaXQgPSA1MDAwCiMgICAgICAgIGZp
bGVzdG9yZSB3YnRocm90dGxlIGJ0cmZzIGlub2RlcyBzdGFydCBmbHVzaGVyID0gNTAwCiMg
ICAgICAgIGZpbGVzdG9yZSB3YnRocm90dGxlIGJ0cmZzIGlub2RlcyBoYXJkIGxpbWl0ID0g
NTAwMAojICAgICAgICBmaWxlc3RvcmUgd2J0aHJvdHRsZSBidHJmcyBieXRlcyBzdGFydCBm
bHVzaGVyID0gNDE5NDMwNDAKIyAgICAgICAgZmlsZXN0b3JlIHdidGhyb3R0bGUgYnRyZnMg
Ynl0ZXMgaGFyZCBsaW1pdCA9IDQxOTQzMDQwMAoKW21vbl0KCW1vbiBkYXRhID0gL2hvbWUv
bmhtL3RtcC9jYnQvY2VwaC9tb24uJGlkCiAgICAgICAgClttb24uYV0KCWhvc3QgPSBidXJu
dXBpWCAKICAgICAgICBtb24gYWRkciA9IDEyNy4wLjAuMTo2Nzg5Cgpbb3NkLjBdCglob3N0
ID0gYnVybnVwaVgKICAgICAgICBvc2QgZGF0YSA9IC9ob21lL25obS90bXAvY2J0L21udC9v
c2QtZGV2aWNlLTAtZGF0YQogICAgICAgIG9zZCBqb3VybmFsID0gL2Rldi9kaXNrL2J5LXBh
cnRsYWJlbC9vc2QtZGV2aWNlLTAtam91cm5hbAojICAgICAgICBvc2Qgam91cm5hbCA9IC9k
ZXYvc2RzMQoK
--------------070105080807020701000902--
