From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in function
	replay mds/journal.cc
Date: Tue, 29 Apr 2014 14:12:00 +0800
Message-ID: <CAAM7YAn5G-sEMOkZY+D4mOSaXbZb6NEx4A11DbRUhdMJfmC_fQ@mail.gmail.com>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
	<CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ@mail.gmail.com>
	<CAAM7YAnQBwj=KSSfATeepbWyhOMAVwfoiC2AvkCEZrdPwkY2Ug@mail.gmail.com>
	<CAEDpR-vBVOqPYnMW=VxnAcPygJBKOvaQaWSrCw3XP9aKQi1MRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEDpR-vBVOqPYnMW=VxnAcPygJBKOvaQaWSrCw3XP9aKQi1MRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Apr 29, 2014 at 11:24 AM, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> We had applied the patch and recompile ceph as well as updated the
> ceph.conf as per suggested, when we re-run ceph-mds we noticed the
> following:
>
>
> 2014-04-29 10:45:22.260798 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366457,12681393 no session for client.324186
> 2014-04-29 10:45:22.262419 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366475,12681393 no session for client.324186
> 2014-04-29 10:45:22.267699 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366665,12681393 no session for client.324186
> 2014-04-29 10:45:22.271664 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366724,12681393 no session for client.324186
> 2014-04-29 10:45:22.281050 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366945,12681393 no session for client.324186
> 2014-04-29 10:45:22.283196 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51366996,12681393 no session for client.324186
> 2014-04-29 10:45:22.287801 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367043,12681393 no session for client.324186
> 2014-04-29 10:45:22.289967 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367082,12681393 no session for client.324186
> 2014-04-29 10:45:22.291026 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367110,12681393 no session for client.324186
> 2014-04-29 10:45:22.294459 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367192,12681393 no session for client.324186
> 2014-04-29 10:45:22.297228 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367257,12681393 no session for client.324186
> 2014-04-29 10:45:22.297477 7f90b971d700  0 log [WRN] :  replayed op
> client.324186:51367264,12681393 no session for client.324186
>
> tcmalloc: large alloc 1136660480 bytes == 0xb2019000 @  0x7f90c2564da7
> 0x5bb9cb 0x5ac8eb 0x5b32f7 0x79ecd8 0x58cbed 0x7f90c231de9a
> 0x7f90c0cca3fd
> tcmalloc: large alloc 2273316864 bytes == 0x15d73d000 @
> 0x7f90c2564da7 0x5bb9cb 0x5ac8eb 0x5b32f7 0x79ecd8 0x58cbed
> 0x7f90c231de9a 0x7f90c0cca3fd
>
> ceph -s shows that MDS up:replay,
>
> Also the messages above seemed to be repeating again after a while but
> with a different session number. Is there a way for us to determine
> that we are on the right track? Thanks.
>

It's on the right track as long as the MDS doesn't crash.

> Regards,
> Luke
>
> On Sun, Apr 27, 2014 at 12:04 PM, Yan, Zheng <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Sat, Apr 26, 2014 at 9:56 AM, Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Hi Greg,
>>>
>>> Actually our cluster is pretty empty, but we suspect we had a temporary
>>> network disconnection to one of our OSD, not sure if this caused the
>>> problem.
>>>
>>> Anyway we don't mind try the method you mentioned, how can we do that?
>>>
>>
>> compile ceph-mds with the attached patch. add a line "mds
>> wipe_sessions = 1" to the ceph.conf,
>>
>> Yan, Zheng
>>
>>> Regards,
>>> Luke
>>>
>>>
>>> On Saturday, April 26, 2014, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>>>>
>>>> Hmm, it looks like your on-disk SessionMap is horrendously out of
>>>> date. Did your cluster get full at some point?
>>>>
>>>> In any case, we're working on tools to repair this now but they aren't
>>>> ready for use yet. Probably the only thing you could do is create an
>>>> empty sessionmap with a higher version than the ones the journal
>>>> refers to, but that might have other fallout effects...
>>>> -Greg
>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>>
>>>>
>>>> On Fri, Apr 25, 2014 at 2:57 AM, Mohd Bazli Ab Karim
>>>> <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org> wrote:
>>>> > More logs. I ran ceph-mds  with debug-mds=20.
>>>> >
>>>> > -2> 2014-04-25 17:47:54.839672 7f0d6f3f0700 10 mds.0.journal
>>>> > EMetaBlob.replay inotable tablev 4316124 <= table 4317932
>>>> > -1> 2014-04-25 17:47:54.839674 7f0d6f3f0700 10 mds.0.journal
>>>> > EMetaBlob.replay sessionmap v8632368 -(1|2) == table 7239603 prealloc
>>>> > [1000041df86~1] used 1000041db9e
>>>> >   0> 2014-04-25 17:47:54.840733 7f0d6f3f0700 -1 mds/journal.cc: In
>>>> > function 'void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)' thread
>>>> > 7f0d6f3f0700 time 2014-04-25 17:47:54.839688 mds/journal.cc: 1303: FAILED
>>>> > assert(session)
>>>> >
>>>> > Please look at the attachment for more details.
>>>> >
>>>> > Regards,
>>>> > Bazli
>>>> >
>>>> > From: Mohd Bazli Ab Karim
>>>> > Sent: Friday, April 25, 2014 12:26 PM
>>>> > To: 'ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'; ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> > Subject: Ceph mds laggy and failed assert in function replay
>>>> > mds/journal.cc
>>>> >
>>>> > Dear Ceph-devel, ceph-users,
>>>> >
>>>> > I am currently facing issue with my ceph mds server. Ceph-mds daemon
>>>> > does not want to bring up back.
>>>> > Tried running that manually with ceph-mds -i mon01 -d but it shows that
>>>> > it stucks at failed assert(session) line 1303 in mds/journal.cc and aborted.
>>>> >
>>>> > Can someone shed some light in this issue.
>>>> > ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
>>>> >
>>>> > Let me know if I need to send log with debug enabled.
>>>> >
>>>> > Regards,
>>>> > Bazli
>>>> >
