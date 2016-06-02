From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: RGW Multisite delete wierdness
Date: Thu, 02 Jun 2016 15:01:42 +0200
Message-ID: <877fe77nih.fsf@suse.com>
References: <87zispoa07.fsf@suse.com> <CADRKj5TpcOzavirV7M-s2s8hg+9yyHm3LUyV_Mw3eCDR3DLzSw@mail.gmail.com> <86oa95lc1h.fsf@linux-stsn.suse> <CADRKj5SUACKOQNXW21OHCE1BOVZ5Bva-czgN4QaeptkP=gbrxg@mail.gmail.com> <CADRKj5SJVMzjbvMt7PkvdDxBq1+b1GoCNo7f23Jsf9434+0O-A@mail.gmail.com> <87a8ki6r1b.fsf@suse.com> <CADRKj5QUA6gki5hy5HYfGej0AdWTV19xVWR8gAWCbHZq4HWzSg@mail.gmail.com> <86k2jllbhs.fsf@linux-stsn.suse> <87k2jks24h.fsf@suse.com> <CADRKj5T5LCcskumQpLN4KGDgV4p50r9v9X=TaYVFODeR7mdFhQ@mail.gmail.com> <CADRKj5T8hDWeSsK=u8sjRthokD+kN3B+uuKiwpRSdR7KvY-fQQ@mail.gmail.com> <86inz2lt0t.fsf@linux-stsn.suse> <CADRKj5TOucJhNt5zcVsKjRQVfrqQwhY2TuHq=uUF9EB-SeukkQ@mail.gmail.com> <CADRKj5Rjd9kKQqxKwhJnnJhuE0aHfRL_ytYuNS4uxbW336hQAw@mail.gmail.com> <878tyq7fcu.fsf@suse.com> <CADRKj5RRcV=iw2hTSMRWsK+GShCnygw
 JEMWcA36v-jnKRDahdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:59104 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbcFBNBq (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 2 Jun 2016 09:01:46 -0400
In-reply-to: <CADRKj5RRcV=iw2hTSMRWsK+GShCnygwJEMWcA36v-jnKRDahdg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

[..]
Yehuda Sadeh-Weinraub writes:
>
> Yes, that would be a normal behaviour. The primary should not have
> concurrent sync operations on the same object if object has not
> completed previous sync operations. Looking at the log it really seems
> that we don't identify the concurrent sync operation on the same
> object. This should have been fixed by commit
> edea6d58dd25995bcc1ed4fc5be6f72ce4a6835a. Can you try to verify what
> went wrong there (whether can_do_op() returned true and why)?

Looked into this a bit, can_do_op() has returned true for the case when
primary issues a Fetch (or GET) and when a delete is issued,(even though
the Fetch is still not complete yet) by putting a debug log around when
we clear the keys, both the delete op and the get op creates and deletes
the same key successfully.

Which makes me suspect, that different instances of
RGWBucketIncSyncShardMarkerTrack are at play here, leading to different
independent values for key_to_marker. Is that possible?

Regards
Abhishek
