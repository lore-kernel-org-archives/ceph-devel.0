From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [ceph-users] CephFS Slow writes with 1MB files
Date: Fri, 3 Apr 2015 10:12:50 +0800
Message-ID: <CAAM7YA=Bf+q6Bp2X3zyZ9LF7q1iUeP77htr9DPesS81bhjr5Qw@mail.gmail.com>
References: <CAMzumdZo2jdHEnB55g1XOVTxc4JLq-+6JFFZSwjgox=9LOUdZA@mail.gmail.com>
	<CAMzumdbezcb-p1_MpcSL-h8tTR0RKATt93Om6NPejtn1G6yPeQ@mail.gmail.com>
	<CAC6JEv-G_s3gRNmn3MHPiuFP6ODiOgvhX_J02KEo=Dd0X-JLGg@mail.gmail.com>
	<CAMzumdb8S77aYqNUyhwzZDCGp6KBFc8OueZ0pCKrkSP=hDNFPg@mail.gmail.com>
	<CAC6JEv-4D2kF7rrnGMncbE-_63+hdDzecqpB+HrMOKp1YGwv_w@mail.gmail.com>
	<CAMzumda7VserizM5PEoT8mwYnTHeE4CFiUiLjnjqN2xXaeNVQQ@mail.gmail.com>
	<CAAM7YAkwtFLnFea3fNT_CaeA2R+_xdZONVN_s21k7_Rbd27H+Q@mail.gmail.com>
	<CAMzumdZG4Zqv5SWGTRTS_FTEUe3EwVbbBThjXVTP2gQadMhFsw@mail.gmail.com>
	<CAAM7YA=hz1E+HJtDKoh-vzwyrGU=O3S822jOWSJzViWG-0-L=w@mail.gmail.com>
	<CAMzumdYdeTv0qF9VdNHb4CM=DNV_HC2nQ7sVnqJ+5w6=TrvCiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1136dc9e3862cd0512c87c3e
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33208 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbDCCMw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Apr 2015 22:12:52 -0400
Received: by lajy8 with SMTP id y8so71904182laj.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2015 19:12:50 -0700 (PDT)
In-Reply-To: <CAMzumdYdeTv0qF9VdNHb4CM=DNV_HC2nQ7sVnqJ+5w6=TrvCiQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

--001a1136dc9e3862cd0512c87c3e
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 2, 2015 at 11:18 PM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> I am using the Giant release. The OSDs and MON/MDS are using default
> RHEL 7 kernel. Client is using elrepo 3.19 kernel. I am also using
> cephaux.

I reproduced this issue by using giant release. It's a bug in the MDS
code. Could you try the newest development version ceph (It includes
the fix). Or apply the attached patch to source of  giant release.

Regards
Yan, Zheng

>
> I may have found something.
> I did the build manually as such I did _NOT_ set up these config settings:
> filestore xattr use omap = false
> filestore max inline xattr size = 65536,
> filestore_max_inline_xattr_size_xfs = 65536
> filestore_max_inline_xattr_size_other = 512
> filestore_max_inline_xattrs_xfs = 10
>
> I just changed these settings to see if it will make a difference.
> I copied data from one directory that had files I created before I set
> these values ( time cp small1/* small2/.) and it takes 2 min 30 secs
> to copy 1600 files.
> If I took the files I just copied from small2 and copy them to a
> different directory ( time cp small2/* small3/.) it only takes 5 mins
> to copy 10000 files!
>
> Could this be part of the problem?
>
>
> On Thu, Apr 2, 2015 at 6:03 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Wed, Apr 1, 2015 at 12:31 AM, Barclay Jameson
>> <almightybeeij@gmail.com> wrote:
>>> Here is the mds output from the command you requested. I did this
>>> during the small data run . ( time cp small1/* small2/ )
>>> It is 20MB in size so I couldn't find a place online that would accept
>>> that much data.
>>>
>>> Please find attached file.
>>>
>>> Thanks,
>>
>> In the log file, each 'create' request is followed by several
>> 'getattr' requests. I guess these 'getattr' requests resulted from
>> some kinds of permission check, but I can't reproduce this situation
>> locally.
>>
>> which version of ceph/kernel are you using? do you use ceph-fuse or
>> kernel client, what's the mount options?
>>
>> Regards
>> Yan, Zheng
>>
>>
>>>
>>> Beeij
>>>
>>>
>>> On Mon, Mar 30, 2015 at 10:59 PM, Yan, Zheng <ukernel@gmail.com> wrote:
>>>> On Sun, Mar 29, 2015 at 1:12 AM, Barclay Jameson
>>>> <almightybeeij@gmail.com> wrote:
>>>>> I redid my entire Ceph build going back to to CentOS 7 hoping to the
>>>>> get the same performance I did last time.
>>>>> The rados bench test was the best I have ever had with a time of 740
>>>>> MB wr and 1300 MB rd. This was even better than the first rados bench
>>>>> test that had performance equal to PanFS. I find that this does not
>>>>> translate to my CephFS. Even with the following tweaking it still at
>>>>> least twice as slow as PanFS and my first *Magical* build (that had
>>>>> absolutely no tweaking):
>>>>>
>>>>> OSD
>>>>>  osd_op_treads 8
>>>>>  /sys/block/sd*/queue/nr_requests 4096
>>>>>  /sys/block/sd*/queue/read_ahead_kb 4096
>>>>>
>>>>> Client
>>>>>  rsize=16777216
>>>>>  readdir_max_bytes=16777216
>>>>>  readdir_max_entries=16777216
>>>>>
>>>>> ~160 mins to copy 100000 (1MB) files for CephFS vs ~50 mins for PanFS.
>>>>> Throughput on CephFS is about 10MB/s vs PanFS 30 MB/s.
>>>>>
>>>>> Strange thing is none of the resources are taxed.
>>>>> CPU, ram, network, disks, are not even close to being taxed on either
>>>>> the client,mon/mds, or the osd nodes.
>>>>> The PanFS client node was a 10Gb network the same as the CephFS client
>>>>> but you can see the huge difference in speed.
>>>>>
>>>>> As per Gregs questions before:
>>>>> There is only one client reading and writing (time cp Small1/*
>>>>> Small2/.) but three clients have cephfs mounted, although they aren't
>>>>> doing anything on the filesystem.
>>>>>
>>>>> I have done another test where I stream data info a file as fast as
>>>>> the processor can put it there.
>>>>> (for (i=0; i < 1000000001; i++){ fprintf (out_file, "I is : %d\n",i);}
>>>>> ) and it is faster than the PanFS. CephFS 16GB in 105 seconds with the
>>>>> above tuning vs 130 seconds for PanFS. Without the tuning it takes 230
>>>>> seconds for CephFS although the first build did it in 130 seconds
>>>>> without any tuning.
>>>>>
>>>>> This leads me to believe the bottleneck is the mds. Does anybody have
>>>>> any thoughts on this?
>>>>> Are there any tuning parameters that I would need to speed up the mds?
>>>>
>>>> could you enable mds debugging for a few seconds (ceph daemon mds.x
>>>> config set debug_mds 10; sleep 10; ceph daemon mds.x config set
>>>> debug_mds 0). and upload /var/log/ceph/mds.x.log to somewhere.
>>>>
>>>> Regards
>>>> Yan, Zheng
>>>>
>>>>>
>>>>> On Fri, Mar 27, 2015 at 4:50 PM, Gregory Farnum <greg@gregs42.com> wrote:
>>>>>> On Fri, Mar 27, 2015 at 2:46 PM, Barclay Jameson
>>>>>> <almightybeeij@gmail.com> wrote:
>>>>>>> Yes it's the exact same hardware except for the MDS server (although I
>>>>>>> tried using the MDS on the old node).
>>>>>>> I have not tried moving the MON back to the old node.
>>>>>>>
>>>>>>> My default cache size is "mds cache size = 10000000"
>>>>>>> The OSDs (3 of them) have 16 Disks with 4 SSD Journal Disks.
>>>>>>> I created 2048 for data and metadata:
>>>>>>> ceph osd pool create cephfs_data 2048 2048
>>>>>>> ceph osd pool create cephfs_metadata 2048 2048
>>>>>>>
>>>>>>>
>>>>>>> To your point on clients competing against each other... how would I check that?
>>>>>>
>>>>>> Do you have multiple clients mounted? Are they both accessing files in
>>>>>> the directory(ies) you're testing? Were they accessing the same
>>>>>> pattern of files for the old cluster?
>>>>>>
>>>>>> If you happen to be running a hammer rc or something pretty new you
>>>>>> can use the MDS admin socket to explore a bit what client sessions
>>>>>> there are and what they have permissions on and check; otherwise
>>>>>> you'll have to figure it out from the client side.
>>>>>> -Greg
>>>>>>
>>>>>>>
>>>>>>> Thanks for the input!
>>>>>>>
>>>>>>>
>>>>>>> On Fri, Mar 27, 2015 at 3:04 PM, Gregory Farnum <greg@gregs42.com> wrote:
>>>>>>>> So this is exactly the same test you ran previously, but now it's on
>>>>>>>> faster hardware and the test is slower?
>>>>>>>>
>>>>>>>> Do you have more data in the test cluster? One obvious possibility is
>>>>>>>> that previously you were working entirely in the MDS' cache, but now
>>>>>>>> you've got more dentries and so it's kicking data out to RADOS and
>>>>>>>> then reading it back in.
>>>>>>>>
>>>>>>>> If you've got the memory (you appear to) you can pump up the "mds
>>>>>>>> cache size" config option quite dramatically from it's default 100000.
>>>>>>>>
>>>>>>>> Other things to check are that you've got an appropriately-sized
>>>>>>>> metadata pool, that you've not got clients competing against each
>>>>>>>> other inappropriately, etc.
>>>>>>>> -Greg
>>>>>>>>
>>>>>>>> On Fri, Mar 27, 2015 at 9:47 AM, Barclay Jameson
>>>>>>>> <almightybeeij@gmail.com> wrote:
>>>>>>>>> Opps I should have said that I am not just writing the data but copying it :
>>>>>>>>>
>>>>>>>>> time cp Small1/* Small2/*
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>> BJ
>>>>>>>>>
>>>>>>>>> On Fri, Mar 27, 2015 at 11:40 AM, Barclay Jameson
>>>>>>>>> <almightybeeij@gmail.com> wrote:
>>>>>>>>>> I did a Ceph cluster install 2 weeks ago where I was getting great
>>>>>>>>>> performance (~= PanFS) where I could write 100,000 1MB files in 61
>>>>>>>>>> Mins (Took PanFS 59 Mins). I thought I could increase the performance
>>>>>>>>>> by adding a better MDS server so I redid the entire build.
>>>>>>>>>>
>>>>>>>>>> Now it takes 4 times as long to write the same data as it did before.
>>>>>>>>>> The only thing that changed was the MDS server. (I even tried moving
>>>>>>>>>> the MDS back on the old slower node and the performance was the same.)
>>>>>>>>>>
>>>>>>>>>> The first install was on CentOS 7. I tried going down to CentOS 6.6
>>>>>>>>>> and it's the same results.
>>>>>>>>>> I use the same scripts to install the OSDs (which I created because I
>>>>>>>>>> can never get ceph-deploy to behave correctly. Although, I did use
>>>>>>>>>> ceph-deploy to create the MDS and MON and initial cluster creation.)
>>>>>>>>>>
>>>>>>>>>> I use btrfs on the OSDS as I can get 734 MB/s write and 1100 MB/s read
>>>>>>>>>> with rados bench -p cephfs_data 500 write --no-cleanup && rados bench
>>>>>>>>>> -p cephfs_data 500 seq (xfs was 734 MB/s write but only 200 MB/s read)
>>>>>>>>>>
>>>>>>>>>> Could anybody think of a reason as to why I am now getting a huge regression.
>>>>>>>>>>
>>>>>>>>>> Hardware Setup:
>>>>>>>>>> [OSDs]
>>>>>>>>>> 64 GB 2133 MHz
>>>>>>>>>> Dual Proc E5-2630 v3 @ 2.40GHz (16 Cores)
>>>>>>>>>> 40Gb Mellanox NIC
>>>>>>>>>>
>>>>>>>>>> [MDS/MON new]
>>>>>>>>>> 128 GB 2133 MHz
>>>>>>>>>> Dual Proc E5-2650 v3 @ 2.30GHz (20 Cores)
>>>>>>>>>> 40Gb Mellanox NIC
>>>>>>>>>>
>>>>>>>>>> [MDS/MON old]
>>>>>>>>>> 32 GB 800 MHz
>>>>>>>>>> Dual Proc E5472  @ 3.00GHz (8 Cores)
>>>>>>>>>> 10Gb Intel NIC
>>>>>>>>> _______________________________________________
>>>>>>>>> ceph-users mailing list
>>>>>>>>> ceph-users@lists.ceph.com
>>>>>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users@lists.ceph.com
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--001a1136dc9e3862cd0512c87c3e
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i80yhot60

Y29tbWl0IDMwNmZiMmY1ZTk2NjFhOGI4NTIzOGYwNjVhMGRlZGNmMDZjNGU3MjUKQXV0aG9yOiBZ
YW4sIFpoZW5nIDx6eWFuQHJlZGhhdC5jb20+CkRhdGU6ICAgTW9uIFNlcCAxNSAyMTozOToyNiAy
MDE0ICswODAwCgogICAgbWRzOiBzZXQgbmV3IGlub2RlJ3MgeGF0dHIgdmVyc2lvbiB0byAxCiAg
ICAKICAgIHNldCBuZXcgaW5vZGUncyB4YXR0ciB2ZXJzaW9uIHRvIDEgZXZlbiBpZiBpdCBoYXMg
bm8geGF0dHIuIFRoaXMgYWxsb3cKICAgIGNsaWVudCB0byBkaWZmZXJlbnRpYXRlIG5vIHhhdHRy
IGluIGlub2RlIGZyb20gTURTIHNraXBzIHNlbmRpbmcgeGF0dHIKICAgIHRvIGNsaWVudCAoYmVj
YXVzZSBNRFMgdGhpbmsgY2xpZW50IGFscmVhZHkgaGFzIHVwdG9kYXRlIHhhdHRyKS4KICAgIAog
ICAgU2lnbmVkLW9mZi1ieTogWWFuLCBaaGVuZyA8enlhbkByZWRoYXQuY29tPgoKZGlmZiAtLWdp
dCBhL3NyYy9tZHMvTURDYWNoZS5jYyBiL3NyYy9tZHMvTURDYWNoZS5jYwppbmRleCBlYTViYjM2
Li42YjlkNmM3IDEwMDY0NAotLS0gYS9zcmMvbWRzL01EQ2FjaGUuY2MKKysrIGIvc3JjL21kcy9N
RENhY2hlLmNjCkBAIC0zMzIsNiArMzMyLDcgQEAgQ0lub2RlICpNRENhY2hlOjpjcmVhdGVfc3lz
dGVtX2lub2RlKGlub2Rlbm9fdCBpbm8sIGludCBtb2RlKQogICBDSW5vZGUgKmluID0gbmV3IENJ
bm9kZSh0aGlzKTsKICAgaW4tPmlub2RlLmlubyA9IGlubzsKICAgaW4tPmlub2RlLnZlcnNpb24g
PSAxOworICBpbi0+aW5vZGUueGF0dHJfdmVyc2lvbiA9IDE7CiAgIGluLT5pbm9kZS5tb2RlID0g
MDUwMCB8IG1vZGU7CiAgIGluLT5pbm9kZS5zaXplID0gMDsKICAgaW4tPmlub2RlLmN0aW1lID0g
CmRpZmYgLS1naXQgYS9zcmMvbWRzL1NlcnZlci5jYyBiL3NyYy9tZHMvU2VydmVyLmNjCmluZGV4
IGJlYjQ2OTYuLmJmNWI5OGEgMTAwNjQ0Ci0tLSBhL3NyYy9tZHMvU2VydmVyLmNjCisrKyBiL3Ny
Yy9tZHMvU2VydmVyLmNjCkBAIC0yMDA1LDYgKzIwMDUsNyBAQCBDSW5vZGUqIFNlcnZlcjo6cHJl
cGFyZV9uZXdfaW5vZGUoTURSZXF1ZXN0UmVmJiBtZHIsIENEaXIgKmRpciwgaW5vZGVub190IHVz
ZWlubwogICB9CiAKICAgaW4tPmlub2RlLnZlcnNpb24gPSAxOworICBpbi0+aW5vZGUueGF0dHJf
dmVyc2lvbiA9IDE7CiAgIGluLT5pbm9kZS5ubGluayA9IDE7ICAgLy8gRklYTUUKIAogICBpbi0+
aW5vZGUubW9kZSA9IG1vZGU7Cg==
--001a1136dc9e3862cd0512c87c3e--
