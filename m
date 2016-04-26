From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: RGW Multisite delete wierdness
Date: Tue, 26 Apr 2016 19:37:02 +0200
Message-ID: <87k2jks24h.fsf@suse.com>
References: <87zispoa07.fsf@suse.com> <CADRKj5TpcOzavirV7M-s2s8hg+9yyHm3LUyV_Mw3eCDR3DLzSw@mail.gmail.com> <86oa95lc1h.fsf@linux-stsn.suse> <CADRKj5SUACKOQNXW21OHCE1BOVZ5Bva-czgN4QaeptkP=gbrxg@mail.gmail.com> <CADRKj5SJVMzjbvMt7PkvdDxBq1+b1GoCNo7f23Jsf9434+0O-A@mail.gmail.com> <87a8ki6r1b.fsf@suse.com> <CADRKj5QUA6gki5hy5HYfGej0AdWTV19xVWR8gAWCbHZq4HWzSg@mail.gmail.com> <86k2jllbhs.fsf@linux-stsn.suse>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:36609 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbcDZRhG (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 26 Apr 2016 13:37:06 -0400
In-reply-to: <86k2jllbhs.fsf@linux-stsn.suse>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Ceph Devel <ceph-devel@vger.kernel.org>


Abhishek L writes:

> Yehuda Sadeh-Weinraub writes:
>
>> On Mon, Apr 25, 2016 at 1:17 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>>
>>> Yehuda Sadeh-Weinraub writes:
>>>
>>>> On Tue, Apr 19, 2016 at 11:08 AM, Yehuda Sadeh-Weinraub
>>>> <yehuda@redhat.com> wrote:
>>>>> On Tue, Apr 19, 2016 at 10:54 AM, Abhishek L
>>>>> <abhishek.lekshmanan@gmail.com> wrote:
>>>>>>
>>>>>> Yehuda Sadeh-Weinraub writes:
>>>>>>
>>>>>>> On Tue, Apr 19, 2016 at 9:10 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>>>>>>> Trying deleting objects & buckets from a secondary zone in a RGW
>>>>>>>> multisite configuration leads to some wierdness:
>>>>>>>>
>>>>>>>> 1. On deleting an object and the bucket immediately will mostly lead to
>>>>>>>> object and bucket getting deleted in the secondary zone, but since we
>>>>>>>> forward the bucket deletion to master only after we delete in secondary
>>>>>>>> it will fail with 409 (BucketNotEmpty) and gets reraised as a 500 to the
>>>>>>>> client. This _seems_ simple enough to fix if we forward the bucket
>>>>>>>> deletion request to master zone before attempting deletion locally,
>>>>>>>> (issue: http://tracker.ceph.com/issues/15540, possible fix: https://github.com/ceph/ceph/pull/8655)
>>>>>>>>
>>>>>>>
>>>>>>> Yeah, this looks good. We'll get it through testing.
>>>>>>>
>>>>>>>> 2. Deletion of objects themselves: deletion of objects themselves seems
>>>>>>>> to be a bit racy, deleting an object on a secondary zone succeeds,
>>>>>>>> listing the bucket seems to show an empty list, but gets populated with
>>>>>>>> the object again sometimes (this time with a newer timestamp), this is
>>>>>>>> not always guaranteed to be reproduce, but I've seen this often with
>>>>>>>> multipart uploads, as an eg:
>>>>>>>>
>>>>>>>> $ s3 -u list test-mp
>>>>>>>>                        Key                             Last Modified      Size
>>>>>>>> --------------------------------------------------  --------------------  -----
>>>>>>>> test.img                                            2016-04-19T13:00:17Z    40M
>>>>>>>> $ s3 -u delete test-mp/test.img
>>>>>>>> $ s3 -u list test-mp
>>>>>>>>                        Key                             Last Modified      Size
>>>>>>>> --------------------------------------------------  --------------------  -----
>>>>>>>> test.img                                            2016-04-19T13:00:45Z    40M
>>>>>>>> $ s3 -u delete test-mp/test.img # wait for a  min
>>>>>>>> $ s3 -us list test-mp
>>>>>>>> --------------------------------------------------  --------------------  -----
>>>>>>>> test.img                                            2016-04-19T13:01:52Z    40M
>>>>>>>>
>>>>>>>>
>>>>>>>> Mostly seeing log entries of this form in both the cases ie. where
>>>>>>>> delete object seems to be successfully delete in both master and
>>>>>>>> secondary zone and the case where it succeeds in master and fails in
>>>>>>>> secondary :
>>>>>>>>
>>>>>>>> 20 parsed entry: id=00000000027.27.2 iter->object=foo iter->instance= name=foo instance= ns=
>>>>>>>> 20 [inc sync] skipping object: dkr:d8e0ec3d-b3da-43f8-a99b-38a5b4941b6f.14113.2:-1/foo: non-complete operation
>>>>>>>> 20 parsed entry: id=00000000028.28.2 iter->object=foo iter->instance= name=foo instance= ns=
>>>>>>>> 20 [inc sync] skipping object: dkr:d8e0ec3d-b3da-43f8-a99b-38a5b4941b6f.14113.2:-1/foo: canceled operation
>>>>>>>>
>>>>>>>> Any ideas on this?
>>>>>>>>
>>>>>>>
>>>>>>> Do you have more than 2 zones syncing? Is it an object delete that
>>>>>>> came right after the object creation?
>>>>>>
>>>>>> Only 2 zones ie. one master and one secondary, req, on secondary. The delete came right after the
>>>>>> create though
>>>>>
>>>>> There are two issues that I see here. One is that we sync an object,
>>>>> but end up with different mtime than the object's source. The second
>>>>> issue is that we shouldn't have synced that object.
>>>>>
>>>>> There needs to be a check when syncing objects, to validate that we
>>>>> don't sync an object that originated from the current zone (by
>>>>> comparing the short zone id). We might be missing that.
>>>>>
>>>>
>>>> For the first issue, see:
>>>> https://github.com/ceph/ceph/pull/8685
>>>>
>>>> However, create that follows by a delete will still be a problem, as
>>>> when we sync the object we check it against the source mtime is newer
>>>> than the destination mtime. This is problematic with deletes, as these
>>>> don't have mtime once the object is removed. I think the solution
>>>> would be by using temporary tombstone objects (we already have the olh
>>>> framework that can provide what we need), that we'll garbage collect.
>>>
>>> Further information from logs if it helps:
>>>
>>> 2016-04-19 17:00:45.539356 7fc99effd700  0 _send_request(): deleting obj=test-mp:test.img
>>> 2016-04-19 17:00:45.539902 7fc99effd700 20 _send_request(): skipping object removal obj=test-mp:test.img (obj mtime=2016-04-19 17:00:26.0.098255s, request timestamp=2016-04-19 17:00:17.0.395208s)
>>>
>>> This is what the master zone logs show, however the request timestamp
>>> logged here is the `If-Modified-Since` value from secondary zone when
>>> the actual object write was completed (and not the time when deletion
>>> was completed),  do we set the value of the deletion time anywhere else
>>> in the BI log
>>>
>>>
>>
>> Did you apply PR 8685?
>>
>> Also, take a look at this:
>>
>> https://github.com/ceph/ceph/pull/8709
>>
>> With the new code we do store the object creation time in the delete
>> bucket index entry. That way we make sure we only sync object removal,
>> if the object was the same or older than the one that was actually
>> removed.

Applied both PRs atop of master + 8655, basically now the object doesn't
resync back to the secondary zone after deletion which we observed
before.A create followed by an immediate delete succeeds delete in both the
zones almost every time.

However allowing the object to sync to primary by introducing a delay,
for eg a script on secondary like:

for i in {1..20}; do s3 -us put foobar/foo$i filename=test.img && sleep 3 && s3 -us delete foobar/foo$i;  done

gives a empty list on the secondary zone, on the primary zone however it
looks like very few objects got actually deleted and others are still existing

$ s3 -us list foobar
Content-Type: application/xml
Request-Id: tx000000000000000001db8-00571f9cdb-1015-us-east-1
Content-Length: 4713
                       Key                             Last Modified      Size
--------------------------------------------------  --------------------  -----
foo1                                                2016-04-26T14:24:25Z    87M
foo10                                               2016-04-26T14:27:28Z    87M
foo11                                               2016-04-26T14:27:50Z    87M
foo12                                               2016-04-26T14:28:12Z    87M
foo14                                               2016-04-26T14:28:48Z    87M
foo15                                               2016-04-26T14:29:09Z    87M
foo16                                               2016-04-26T14:29:30Z    87M
foo17                                               2016-04-26T14:29:51Z    87M
foo18                                               2016-04-26T14:30:12Z    87M
foo19                                               2016-04-26T14:30:33Z    87M
foo2                                                2016-04-26T14:24:47Z    87M
foo20                                               2016-04-26T14:30:54Z    87M
foo3                                                2016-04-26T14:25:07Z    87M
foo6                                                2016-04-26T14:26:05Z    87M
foo7                                                2016-04-26T14:26:24Z    87M
foo8                                                2016-04-26T14:26:47Z    87M
foo9                                                2016-04-26T14:27:07Z    87M

Logs show this in case of failed deletes:
2016-04-26 18:31:01.793673 7ff3f1ffb700 10 If-UnModified-Since: 2016-04-26 18:30:54.0.751623s Last-Modified: 0.000000
2016-04-26 18:31:01.793716 7ff3f1ffb700 20 _send_request(): delete_obj() obj=foobar3:foo20 returned ret=-2

In case of an object that succeeded deletion:
2016-04-26 18:28:40.673885 7ff3f27fc700 10 If-UnModified-Since: 2016-04-26 18:28:30.0.510155s Last-Modified: 2016-04-26 18:28:30.510155

More interesting log:
2016-04-26 18:25:52.660674 7ff3cf7fe700 10 If-UnModified-Since: 2016-04-26 18:25:46.0.700052s Last-Modified: 0.000000
2016-04-26 18:25:52.660698 7ff3cf7fe700 20 _send_request(): delete_obj() obj=foobar3:foo5 returned ret=-2
...
2016-04-26 18:25:59.341420 7ff3a67fc700 10 If-UnModified-Since: 2016-04-26 18:25:46.0.700052s Last-Modified: 2016-04-26 18:25:46.700052
[this was object foo5.. which was one of the objects that got deleted]

Let me know if any other log info may be helpful (only debug rgw was
set, debug ms was 0)

Possibly unrelated, a pkill radosgw sometimes used to throw an error
message with segfault, haven't seen this before though:
*** Caught signal (Segmentation fault) **
 in thread 7fdfbddfcb40 thread_name:radosgw

master sha1 before the patches was 25c2f5a793ff726facde236aa0c2dd78cf933c60

Regards
Abhishek
>
> Hadn't applied the PR yet, I'll apply both and see if I can reproduce
> the issue again.
>>
>> Yehuda
>
> Thanks
> --
> Abhishek


