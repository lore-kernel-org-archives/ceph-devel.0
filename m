From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW Multisite delete wierdness
Date: Fri, 3 Jun 2016 02:00:21 -0700
Message-ID: <CADRKj5SMz1xe+9yQuc71g4+OiQ_qC=TC3srW8LrKBF_GmmFPvQ@mail.gmail.com>
References: <87zispoa07.fsf@suse.com>
	<CADRKj5TpcOzavirV7M-s2s8hg+9yyHm3LUyV_Mw3eCDR3DLzSw@mail.gmail.com>
	<86oa95lc1h.fsf@linux-stsn.suse>
	<CADRKj5SUACKOQNXW21OHCE1BOVZ5Bva-czgN4QaeptkP=gbrxg@mail.gmail.com>
	<CADRKj5SJVMzjbvMt7PkvdDxBq1+b1GoCNo7f23Jsf9434+0O-A@mail.gmail.com>
	<87a8ki6r1b.fsf@suse.com>
	<CADRKj5QUA6gki5hy5HYfGej0AdWTV19xVWR8gAWCbHZq4HWzSg@mail.gmail.com>
	<86k2jllbhs.fsf@linux-stsn.suse>
	<87k2jks24h.fsf@suse.com>
	<CADRKj5T5LCcskumQpLN4KGDgV4p50r9v9X=TaYVFODeR7mdFhQ@mail.gmail.com>
	<CADRKj5T8hDWeSsK=u8sjRthokD+kN3B+uuKiwpRSdR7KvY-fQQ@mail.gmail.com>
	<86inz2lt0t.fsf@linux-stsn.suse>
	<CADRKj5TOucJhNt5zcVsKjRQVfrqQwhY2TuHq=uUF9EB-SeukkQ@mail.gmail.com>
	<CADRKj5Rjd9kKQqxKwhJnnJhuE0aHfRL_ytYuNS4uxbW336hQAw@mail.gmail.com>
	<878tyq7fcu.fsf@suse.com>
	<CADRKj5RRcV=iw2hTSMRWsK+GShCnygwJEMWcA36v-jnKRDahdg@mail.gmail.com>
	<877fe77nih.fsf@suse.com>
	<CADRKj5Rd6pqGRA7fN=xR1eFKJzpf7f-X-ZMm-frrZMp_3FAf1w@mail.gmail.com>
	<87k2i6ad7q.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35952 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcFCJAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 05:00:24 -0400
Received: by mail-vk0-f41.google.com with SMTP id a6so105929608vkg.3
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 02:00:23 -0700 (PDT)
In-Reply-To: <87k2i6ad7q.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Lekshmanan <abhishek@suse.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Fri, Jun 3, 2016 at 1:28 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>
> Yehuda Sadeh-Weinraub writes:
>
>> On Thu, Jun 2, 2016 at 6:01 AM, Abhishek Lekshmanan <abhishek@suse.com> wrote:
>>> [..]
>>> Yehuda Sadeh-Weinraub writes:
>>>>
>>>> Yes, that would be a normal behaviour. The primary should not have
>>>> concurrent sync operations on the same object if object has not
>>>> completed previous sync operations. Looking at the log it really seems
>>>> that we don't identify the concurrent sync operation on the same
>>>> object. This should have been fixed by commit
>>>> edea6d58dd25995bcc1ed4fc5be6f72ce4a6835a. Can you try to verify what
>>>> went wrong there (whether can_do_op() returned true and why)?
>>>
>>> Looked into this a bit, can_do_op() has returned true for the case when
>>> primary issues a Fetch (or GET) and when a delete is issued,(even though
>>> the Fetch is still not complete yet) by putting a debug log around when
>>> we clear the keys, both the delete op and the get op creates and deletes
>>> the same key successfully.
>>>
>>> Which makes me suspect, that different instances of
>>> RGWBucketIncSyncShardMarkerTrack are at play here, leading to different
>>> independent values for key_to_marker. Is that possible?
>>>
>> Shouldn't happen, but maybe something went wrong. Try adding some more
>> info to the log message to see if that's the case.
>
> I just added a debug log whenever a new instance of
> RGWBucketIncSyncShardMarkerTrack was created, and when we check/delete
> keys, in all cases, ie. when a GET was called and/or when a DELETE was
> called, it was a newer instance of marker_tracker that was being invoked.
> Also a few lines before always showed this:
>
> incremental_sync(): async update notification: mybucket:62bc922d-f295-4067-ae36-e23e2f231aad.24099.1:-1
>
> which seems to be called whenever we're creating a new SingleEntry CR?
> (the value of modified_iter was the same in every case)
>
> Also looking at the cases where the deletion succeeded in the secondary
> zone, it seemed here too can_do_op had succeeded every time, the
> difference was in this case either the Object GET came from the remote
> site after original site had already processed the DELETE or in other
> cases, the GET in remote site was processed in time before the DELETE.
>
>

Can you provide the log? I'm still not sure how you'd have different
tracker markers for the same bucket instance, as we take a lease to
prevent concurrent updates to the same bucket shard. This should
happen in the async updates too.

Yehuda
