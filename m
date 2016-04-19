From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: RGW Multisite delete wierdness
Date: Tue, 19 Apr 2016 19:54:18 +0200
Message-ID: <86oa95lc1h.fsf@linux-stsn.suse>
References: <87zispoa07.fsf@suse.com> <CADRKj5TpcOzavirV7M-s2s8hg+9yyHm3LUyV_Mw3eCDR3DLzSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:55512 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933560AbcDSRy3 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 19 Apr 2016 13:54:29 -0400
In-reply-to: <CADRKj5TpcOzavirV7M-s2s8hg+9yyHm3LUyV_Mw3eCDR3DLzSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Ceph Devel <ceph-devel@vger.kernel.org>


Yehuda Sadeh-Weinraub writes:

> On Tue, Apr 19, 2016 at 9:10 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>> Trying deleting objects & buckets from a secondary zone in a RGW
>> multisite configuration leads to some wierdness:
>>
>> 1. On deleting an object and the bucket immediately will mostly lead to
>> object and bucket getting deleted in the secondary zone, but since we
>> forward the bucket deletion to master only after we delete in secondary
>> it will fail with 409 (BucketNotEmpty) and gets reraised as a 500 to the
>> client. This _seems_ simple enough to fix if we forward the bucket
>> deletion request to master zone before attempting deletion locally,
>> (issue: http://tracker.ceph.com/issues/15540, possible fix: https://github.com/ceph/ceph/pull/8655)
>>
>
> Yeah, this looks good. We'll get it through testing.
>
>> 2. Deletion of objects themselves: deletion of objects themselves seems
>> to be a bit racy, deleting an object on a secondary zone succeeds,
>> listing the bucket seems to show an empty list, but gets populated with
>> the object again sometimes (this time with a newer timestamp), this is
>> not always guaranteed to be reproduce, but I've seen this often with
>> multipart uploads, as an eg:
>>
>> $ s3 -u list test-mp
>>                        Key                             Last Modified      Size
>> --------------------------------------------------  --------------------  -----
>> test.img                                            2016-04-19T13:00:17Z    40M
>> $ s3 -u delete test-mp/test.img
>> $ s3 -u list test-mp
>>                        Key                             Last Modified      Size
>> --------------------------------------------------  --------------------  -----
>> test.img                                            2016-04-19T13:00:45Z    40M
>> $ s3 -u delete test-mp/test.img # wait for a  min
>> $ s3 -us list test-mp
>> --------------------------------------------------  --------------------  -----
>> test.img                                            2016-04-19T13:01:52Z    40M
>>
>>
>> Mostly seeing log entries of this form in both the cases ie. where
>> delete object seems to be successfully delete in both master and
>> secondary zone and the case where it succeeds in master and fails in
>> secondary :
>>
>> 20 parsed entry: id=00000000027.27.2 iter->object=foo iter->instance= name=foo instance= ns=
>> 20 [inc sync] skipping object: dkr:d8e0ec3d-b3da-43f8-a99b-38a5b4941b6f.14113.2:-1/foo: non-complete operation
>> 20 parsed entry: id=00000000028.28.2 iter->object=foo iter->instance= name=foo instance= ns=
>> 20 [inc sync] skipping object: dkr:d8e0ec3d-b3da-43f8-a99b-38a5b4941b6f.14113.2:-1/foo: canceled operation
>>
>> Any ideas on this?
>>
>
> Do you have more than 2 zones syncing? Is it an object delete that
> came right after the object creation?

Only 2 zones ie. one master and one secondary, req, on secondary. The delete came right after the
create though 
>
> Yehuda


-- 
Abhishek
