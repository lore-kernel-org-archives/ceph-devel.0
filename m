From: Samuel Just <sam.just@inktank.com>
Subject: Re: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Sat, 12 Jul 2014 18:48:52 -0700
Message-ID: <CA+4uBUZwuh5t28jU5jfQb3ApdUKx8t88hg6m8CXS+0ztpi6OTw@mail.gmail.com>
References: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
	<20140713012624.GS4453@dastard>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bdca91e6acdc904fe096079
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:55481 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaGMBsx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Jul 2014 21:48:53 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so2207338qaq.1
        for <ceph-devel@vger.kernel.org>; Sat, 12 Jul 2014 18:48:52 -0700 (PDT)
In-Reply-To: <20140713012624.GS4453@dastard>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: xfs@oss.sgi.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Ilya Dryomov <ilya.dryomov@inktank.com>

--047d7bdca91e6acdc904fe096079
Content-Type: text/plain; charset=UTF-8

Actually, on this ubuntu kernel (3.13.0-24-generic), it doesn't seem
to give an error.  I'll attach my test case for that.  We don't yet
have a way of reproducing the corruption -- the ext_size change in the
osd simply seemed like a promising lead.
-Sam

On Sat, Jul 12, 2014 at 6:26 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Sat, Jul 12, 2014 at 06:16:54PM -0700, Samuel Just wrote:
>> Hi,
>>
>> We are seeing reports of ceph-osd stores on xfs of files with some
>> garbage data (possibly misplaced from data elsewhere in the
>> filesystem).  There was a bug for a while where the ceph-osd process
>> would set a value for fsx_extsize on a non-empty (possibly sparse)
>> file using XFS_IOC_FSSETXATTR.  Could that plausibly result in a file
>> with garbage data?
>
> No, setting an extent size on a non-empty file will simply fail
> with EINVAL.
>
> Do you have any method of reproducing the bad data in files?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

--047d7bdca91e6acdc904fe096079
Content-Type: text/x-c++src; charset=US-ASCII; name="xfs_extsize_test.cc"
Content-Disposition: attachment; filename="xfs_extsize_test.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hxjpc6z90

LyoqCiAqIFRyeSBjaGFuZ2luZyBleHRzaXplIG9uIGEgbm9uLWVtcHR5IHNwYXJzZSBvYmplY3QK
ICovCgojaW5jbHVkZSA8eGZzL3hmcy5oPgojaW5jbHVkZSA8Y3N0ZGlvPgojaW5jbHVkZSA8dW5p
c3RkLmg+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPHN0cmluZy5oPgoKaW50IG1haW4o
KSB7CiAgY2hhciBidWZbMjU2XTsKICBtZW1zZXQoYnVmLCAxLCBzaXplb2YoYnVmKSk7CgogIGlu
dCBmZCA9IG9wZW4oInRlc3QiLCBPX1JEV1J8T19DUkVBVHxPX0VYQ0wsIDA2NjYpOwogIGFzc2Vy
dChmZCA+PSAwKTsKCiAgaW50IHIgPSBwd3JpdGUoZmQsIGJ1ZiwgMSwgMjQ8PDEwKTsKICBhc3Nl
cnQociA9PSAxKTsKCiAgY2xvc2UoZmQpOwoKICBmZCA9IG9wZW4oInRlc3QiLCBPX1JEV1IpOwog
IGFzc2VydChmZCA+PSAwKTsKCiAgc3RydWN0IGZzeGF0dHIgZnN4OwogIHIgPSBpb2N0bChmZCwg
WEZTX0lPQ19GU0dFVFhBVFRSLCAmZnN4KTsKICBpZiAociA8IDApIHsKICAgIGludCByZXQgPSAt
ZXJybm87CiAgICBzdGQ6OmNlcnIgPDwgIkZTR0VUWEFUVFI6ICIgPDwgcmV0IDw8IHN0ZDo6ZW5k
bDsKICAgIHJldHVybiByZXQ7CiAgfQoKICAvLyBhbHJlYWR5IHNldD8KICBpZiAoZnN4LmZzeF94
ZmxhZ3MgJiBYRlNfWEZMQUdfRVhUU0laRSkgewogICAgc3RkOjpjZXJyIDw8ICJhbHJlYWR5IHNl
dCIgPDwgc3RkOjplbmRsOwogICAgcmV0dXJuIDA7CiAgfQoKICBzdGQ6OmNlcnIgPDwgZnN4LmZz
eF9uZXh0ZW50cyA8PCAiIGV4ZW50cywgZXh0c2l6ZSBpcyAiIDw8IGZzeC5mc3hfZXh0c2l6ZSA8
PCBzdGQ6OmVuZGw7CgogIHVuc2lnbmVkIHZhbCA9IDQ8PDIwOwogIGZzeC5mc3hfeGZsYWdzIHw9
IFhGU19YRkxBR19FWFRTSVpFOwogIGZzeC5mc3hfZXh0c2l6ZSA9IHZhbDsKICAKICBpZiAoaW9j
dGwoZmQsIFhGU19JT0NfRlNTRVRYQVRUUiwgJmZzeCkgPCAwKSB7CiAgICBpbnQgcmV0ID0gLWVy
cm5vOwogICAgc3RkOjpjZXJyIDw8ICJGU1NFVFhBVFRSOiAiIDw8IHJldCA8PCBzdGQ6OmVuZGw7
CiAgICByZXR1cm4gcmV0OwogIH0KCiAgc3RydWN0IGZzeGF0dHIgZnN4MjsKICByID0gaW9jdGwo
ZmQsIFhGU19JT0NfRlNHRVRYQVRUUiwgJmZzeDIpOwogIGlmIChyIDwgMCkgewogICAgaW50IHJl
dCA9IC1lcnJubzsKICAgIHN0ZDo6Y2VyciA8PCAiRlNHRVRYQVRUUjogIiA8PCByZXQgPDwgc3Rk
OjplbmRsOwogICAgcmV0dXJuIHJldDsKICB9CgogIGlmIChmc3gyLmZzeF94ZmxhZ3MgJiBYRlNf
WEZMQUdfRVhUU0laRSkgewogICAgc3RkOjpjZXJyIDw8ICJzdWNjZXNzZnVsbHkgc2V0IHRvICIg
PDwgZnN4Mi5mc3hfZXh0c2l6ZSA8PCBzdGQ6OmVuZGw7CiAgfQoKICBjbG9zZShmZCk7CgojaWYg
MAogIGZkID0gb3BlbigidGVzdCIsIE9fUkRPTkxZKTsKICBhc3NlcnQoZmQgPj0gMCk7CgogIGNo
YXIgemJ1ZlsyNDw8MTBdOwogIG1lbXNldCh6YnVmLCAwLCBzaXplb2YoemJ1ZikpOwogIGNoYXIg
b2J1ZlsyNDw8MTBdOwogIHIgPSByZWFkKGZkLCBvYnVmLCBzaXplb2Yob2J1ZikpOwogIGFzc2Vy
dChyID09IHNpemVvZihvYnVmKSk7CgogIHIgPSBtZW1jbXAoemJ1Ziwgb2J1Ziwgc2l6ZW9mKHpi
dWYpKTsKICBhc3NlcnQociA9PSAwKTsKICBjbG9zZShmZCk7CiNlbmRpZgp9Cg==
--047d7bdca91e6acdc904fe096079--
