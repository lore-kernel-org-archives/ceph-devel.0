From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: SimpleMessenger dispatching: cause of performance problems?
Date: Tue, 21 Aug 2012 11:49:16 +0200
Message-ID: <5033599C.70504@itxperts.de>
References: <502D1B07.3030101@itxperts.de> <alpine.DEB.2.00.1208160951190.26904@cobra.newdream.net> <50323001.5050300@itxperts.de> <alpine.DEB.2.00.1208201320160.26904@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040500000903010609060303"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:50861 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab2HUJtU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 05:49:20 -0400
In-Reply-To: <alpine.DEB.2.00.1208201320160.26904@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040500000903010609060303
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sage,

as mentioned, the workload is a single sequential write on
the client. The write is not O_DIRECT; and consequently
the messages arrive at the OSD with 124 KByte per write request.

The attached pdf shows a timing diagram of two concurrent
write operations (one primary and one replication / secondary).

The time spent on the primary write to get the OSD.:osd_lock
releates nicely with the time when this lock is released by the
secondary write.


Hope this helps

Andreas



Sage Weil wrote:
> On Mon, 20 Aug 2012, Andreas Bluemle wrote:
>   
>> Hi Sage,
>>
>> Sage Weil wrote:
>>     
>>> Hi Andreas,
>>>
>>> On Thu, 16 Aug 2012, Andreas Bluemle wrote:
>>>   
>>>       
>>>> Hi,
>>>>
>>>> I have been trying to migrate a ceph cluster (ceph-0.48argonaut)
>>>> to a high speed cluster network and encounter scalability problems:
>>>> the overall performance of the ceph cluster does not scale well
>>>> with an increase in the underlying networking speed.
>>>>
>>>> In short:
>>>>
>>>> I believe that the dispatching from SimpleMessenger to
>>>> OSD worker queues causes that scalability issue.
>>>>
>>>> Question: is it possible that this dispatching is causing performance
>>>> problems?
>>>>     
>>>>         
>>> There is a single 'dispatch' thread that's processing this queue, and
>>> conveniently perf lets you break down its profiling data on a per-thread
>>> basis.  Once you've ruled out the throttler as the culprit, you might try
>>> running the daemon with 'perf record -g -- ceph-osd ...' and then look
>>> specifically at where that thread is spending its time.  We shouldn't be
>>> burning that much CPU just doing the sanity checks and then handing requests
>>> off to PGs...
>>>
>>> sage
>>>
>>>
>>>       
>>   
>> The effect, which I am seeing, may be related to some locking issue.
>> As I read the code, there are multiple dispatchers running: one per
>> SimpleMessenger.
>>
>> On a typical OSD node, there is
>>
>> - the instance of the SimpleMessenger processing input from the client
>> (primary writes)
>> - other instances of SimpleMessenger, which process input from neighbor OSD
>> nodes
>>
>> the latter generate replication writes to the OSD I am looking at.
>>
>> On the other hand, there is a single instance of the OSD object within the
>> ceph-osd daemon.
>> When dispatching messages to the OSD, then the OSD::osd_lock is held for the
>> complete
>> process of dispatching; see code below.
>>
>> When the write load increases, then multiple SimpleMessenger instances start
>> to
>> congest on the OSD::osd_lock.
>> And this may cause delays in the individual dispatch process.
>>     
>
> This is definitely possible, yes, although it would surprise me if it's 
> happening here (unless your workload is all small writes).  Just to 
> confirm, are you actually observing osd_lock contention, or speculating 
> about what is causing the delays you're seeing?
>
> I'm not sure what the best tool is to measure lock contention.  Mark was 
> playing with a 'poor man's wall clock profiler' using stack trace sampling 
> from gdb.  That would tell us whether threads were really blocking while 
> obtaining the osd_lock...
>
> Can you tell us a bit more about what your workload is?
>
> sage
>
>
>   
>> bool OSD::ms_dispatch(Message *m)
>> {
>> // lock!
>> osd_lock.Lock();
>>
>> while (dispatch_running) {
>> dout(10) << "ms_dispatch waiting for other dispatch thread to complete" <<
>> dendl;
>> dispatch_cond.Wait(osd_lock);
>> }
>> dispatch_running = true;
>>
>> do_waiters();
>> _dispatch(m);
>> do_waiters();
>>
>> dispatch_running = false;
>> dispatch_cond.Signal();
>>
>> osd_lock.Unlock();
>> return true;
>> }
>>
>>
>>     
>>>> In detail:
>>>>
>>>> In order to find out more about this problem, I have added profiling to
>>>> the ceph code in various place; for write operations to the primary or the
>>>> secondary, timestamps are recorded for OSD object, offset and length of
>>>> the such a write request.
>>>>
>>>> Timestamps record:
>>>>  - receipt time at SimpleMessenger
>>>>  - processing time at osd
>>>>  - for primary write operations: wait time until replication operation
>>>>    is acknowledged.
>>>>
>>>> What I believe is happening: dispatching requests from SimpleMessenger to
>>>> OSD worker threads seems to consume a fair amount of time. This ends
>>>> up in a widening gap between subsequent receipts of requests and the start
>>>> of OSD processing them.
>>>>
>>>> A primary write suffers twice from this problem: first because
>>>> the delay happens on the primary OSD and second because the replicating
>>>> OSD also suffers from the same problem - and hence causes additional
>>>> delays
>>>> at the primary OSD when it waits for the commit from the replicating OSD.
>>>>
>>>> In the attached graphics, the x-axis shows the time (in seconds)
>>>> The y-axis shows the offset where a request to write happened.
>>>>
>>>> The red bar represents the SimpleMessenger receive, i.e. from reading
>>>> the message header until enqueuing the completely decoded message into
>>>> the SImpleMessenger dispatch queue.
>>>>
>>>> The green bar represents the time required for local processing, i.e.
>>>> dispatching the the OSD worker, writing to filesystem and journal, send
>>>> out the replication operation to the replicating OSD. It right
>>>> end of the green bar is the time when locally everything has finished
>>>> and a commit could happen.
>>>>
>>>> The blue bar represents the time until the replicating OSD has sent a
>>>> commit
>>>> back to the primary OSD and the original write request can be committed to
>>>> the client.
>>>>
>>>> The green bar is interrupted by a black bar: the left end represents
>>>> the time when the request has been enqueued on the OSD worker queue. The
>>>> right end gives the time when the request is taken off the OSD worker
>>>> queue and actual OSD processing starts.
>>>>
>>>> The test was a simple sequential write to a rados block device.
>>>>
>>>> Receiption of the write requests at the OSD is also sequential in the
>>>> graphics: the bar to the bottom of the graphics shows an earlier write
>>>> request.
>>>>
>>>> Note that the dispatching of a later request in all cases relates to the
>>>> enqueue time at the OSD worker queue of the previous write request: the
>>>> left
>>>> end of a black bar relates nicely to the beginning of a green bar above
>>>> it.
>>>>
>>>>
>>>>
>>>> -- 
>>>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>>>> ITXperts GmbH                       http://www.itxperts.de
>>>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>>>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>>>
>>>> Company details: http://www.itxperts.de/imprint.htm
>>>>
>>>>
>>>>     
>>>>         
>>>   
>>>       
>> -- 
>> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
>> ITXperts GmbH                       http://www.itxperts.de
>> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
>> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>>
>> Company details: http://www.itxperts.de/imprint.htm
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>     
>
>
>
>   


-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm


--------------040500000903010609060303
Content-Type: application/pdf;
 name="osd.0.prim.detail.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="osd.0.prim.detail.pdf"

JVBERi0xLjQKJcOkw7zDtsOfCjIgMCBvYmoKPDwvTGVuZ3RoIDMgMCBSL0ZpbHRlci9GbGF0
ZURlY29kZT4+CnN0cmVhbQp4nM1VTW/TQBC976/YcyW787VfkmWJ0hbBrRCJA+IEFA4JiF74
+8yMnThxVJVDJSpLk9317Htvx/M20GP8E35H0Ce11EtMIPHhW/h4EX8GjPY8fA/gy7uwpGzn
dNARzHFa/xHuLxQxce2zvxKCvkSqtlP6FL/swuXbncTrX/HOqHsEbPnsV2mvNoGrKIwwxs3X
eHmreiBu7j8NgGPXBqAxD8AgY8cDJJtkC8VCHTuNbWQY4NVYBrgakfbLr318PXZkIJ8378LN
JjwtB5lUTrOw0nPjEurIhq2gt2OHayXiSozyGaQUq68gr4UUE4KgvIjjAX6i8nK5AiSPbGmi
ejFphTSYCLGsqb5WTfRQxv0bxvrvKknAZELq60ooNq+YQ17b53lMVzere1ZdXIr2o+lK6wIu
pZrA6dBRRz1nDfWo1qWIe6H2SYp/iEmqAR3LBXfK+zcBC/WslkG1zC5gzVo3YdC1bfwwp+kJ
sNmSaDcmT0t9M5PobBux+tGo2fgob7bmgcqsVbSDxDE4Z/tQZPGEijPrJSHq3zal6Ti5Hs7F
txSFsdmSt6ayLlioiKvnySkRcTGA+UzEeQY3OOLmZ6p+juPMw4XzhHGx9hRRQc9ukhdmmAom
1Mv4kgwjWFzV2cX3X+1CiFonVIOg9wzYDOq6sVgbBUG8g0ltUnXWdIu2EjU9EkLRoltjLZnr
Hp7shWoQa08h0oZEvT/wlGz6t9PKqUUsjZ1M3CJma/RN1WdL5pk3k10DezLOTn1ONnluT8aZ
nGyC5wz+To7ceUJ2F/8ClVaniAplbmRzdHJlYW0KZW5kb2JqCgozIDAgb2JqCjU5NgplbmRv
YmoKCjQgMCBvYmoKPDwvVHlwZS9YT2JqZWN0L1N1YnR5cGUvSW1hZ2UvV2lkdGggMTAyNC9I
ZWlnaHQgODAwL0JpdHNQZXJDb21wb25lbnQgOC9MZW5ndGggNSAwIFIKL0ZpbHRlci9GbGF0
ZURlY29kZS9Db2xvclNwYWNlWyAvSW5kZXhlZC9EZXZpY2VSR0IgOTUKPEZGRkZGRjAwMDAw
MEEwQTBBMEZGMDAwMDAwQzAwMDAwODBGRkMwMDBGRjAwRUVFRUMwNDAwMEM4QzgwMDQxNjlF
MUZGQzAyMDAwODA0MEMwODBGRjMwNjA4MDhCMDAwMDQwODAwMEZGODBGRjdGRkZENEE1MkEy
QUZGRkYwMDQwRTBEMDAwMDAwMDFBMUExQTMzMzMzMzRENEQ0RDY2NjY2NjdGN0Y3Rjk5OTk5
OUIzQjNCM0MwQzBDMENDQ0NDQ0U1RTVFNUZGRkZGRkYwMzIzMjkwRUU5MEFERDhFNkYwNTVG
MEUwRkZGRkVFREQ4MkZGQjZDMUFGRUVFRUZGRDcwMDAwRkYwMDAwNjQwMDAwRkY3RjIyOEIy
MjJFOEI1NzAwMDBGRjAwMDA4QjE5MTk3MDAwMDA4MDAwMDBDRDg3Q0VFQjAwRkZGRkZGMDBG
RjAwQ0VEMUZGMTQ5M0ZGN0Y1MEYwODA4MEZGNDUwMEZBODA3MkU5OTY3QUYwRTY4Q0JEQjc2
QkI4ODYwQkY1RjVEQ0EwODAyMEZGQTUwMEVFODJFRTk0MDBEM0REQTBERDkwNTA0MDU1NkIy
RjgwMTQwMDgwMTQxNDgwNDAxNDgwNDA4MDgwNjBDMDgwNjBGRjgwODAwMEZGODA0MEZGQTA0
MEZGQTA2MEZGQTA3MEZGQzBDMEZGRkY4MEZGRkZDMENEQjc5RUYwRkZGMEEwQjZDREMxRkZD
MUNEQzBCMDdDRkY0MEEwRkYyMEJFQkVCRT4KXQo+PgpzdHJlYW0KeJzt3GtaIskWhlGwhlI/
HUDPf2Zdyi0zSbZAhESy91rPOSqo+JX6ClGX3u0AAAAAAAAAAAAAAAAAAADq2O9/882feL/9
sx9i5QMtbqvtlpcfZ9/9NuHVJt+/+zvSa+v/jvf+9yZPfYzTO0XFr93w6ge7Z0HQ//Kjfl3e
7y/Pf75xeI3Ld+Phu3P3m3dp9/Xf8aaf/IG2uPLRnxGLxyDTH2rnTzIMcLz7mTy76n92DzW5
1zq+w+7y7Tx73fw7+/xdP3+/q4++suynufOdqwPPN712Glj79c0/0OzTcmPn+RHN5Db3a+8+
f5ygfwaa3BlNSjq/7jrB5VteOtxf3mn9xq7fb/L09jvc/ujRs+vH/6s/TeYf6PJ+N25st7jN
3eTV066jdz+/3cpPSXip+bfgssCVo/fkO/t8edLO5H1u9n95v8t95n41k+s4Zu+wDH/xaODq
PXart3aj/9mkoNDFr2j2CYn7X/kswUtdt3+V7Oo7XN+rznu8evf97GfD9f3/9NrZuy8XLKq8
+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
Ci9GbGFncyA0Ci9Gb250QkJveFstNjY0IC0zMjQgMTk5OSAxMDA1XS9JdGFsaWNBbmdsZSAw
Ci9Bc2NlbnQgOTA1Ci9EZXNjZW50IC0yMTEKL0NhcEhlaWdodCAxMDA1Ci9TdGVtViA4MAov
Rm9udEZpbGUyIDcgMCBSCj4+CmVuZG9iagoKMTAgMCBvYmoKPDwvTGVuZ3RoIDMzNi9GaWx0
ZXIvRmxhdGVEZWNvZGU+PgpzdHJlYW0KeJxdkk1vgzAMhu/8ihy7QwWhfKwSQmppkTjsQ2P7
AZCYDmmEKKQH/v3imG3SDqDHzmvnlZ2wai6NGm34ambRgmXDqKSBZb4bAayH26gCHjM5CrtF
/i+mTgehq23XxcLUqGEuiiB8c2eLNSvbneTcw0MQvhgJZlQ3tvuoWhe3d62/YAJlWRSUJZMw
uD5PnX7uJgh91b6R7ni0696V/AneVw0s9jEnK2KWsOhOgOnUDYIiikpW1HUZgJL/zuKUSvpB
fHbGSbmTRlF+KB3HnrMU+UDs8wlxjZwSX5Ez4gQ5J+bIj9QzRj4SH5FPnuMI+Uz5HLmiWq+5
UN73vBJ7fU2ai2MeUR7v4pt/9MzJf4I+OflP0T8n/wn25OT/cEIm/6nXb/4rZPKfnZHJf5b7
YW5Tw7Hi3n/WxcTdGLcq/zj8jnA7o4Lf96NnjVX++wa33aXGCmVuZHN0cmVhbQplbmRvYmoK
CjExIDAgb2JqCjw8L1R5cGUvRm9udC9TdWJ0eXBlL1RydWVUeXBlL0Jhc2VGb250L0JBQUFB
QStBcmlhbE1UCi9GaXJzdENoYXIgMAovTGFzdENoYXIgMjUKL1dpZHRoc1s3NTAgNTAwIDU1
NiA1MDAgNTU2IDU1NiA1NTYgNTU2IDMzMyA1MDAgMjc3IDcyMiAyMjIgMjc3IDU1NiA4MzMK
NTU2IDU1NiA3NzcgNjY2IDcyMiAyNzcgNTU2IDIyMiA1MDAgNTU2IF0KL0ZvbnREZXNjcmlw
dG9yIDkgMCBSCi9Ub1VuaWNvZGUgMTAgMCBSCj4+CmVuZG9iagoKMTIgMCBvYmoKPDwvRjEg
MTEgMCBSCj4+CmVuZG9iagoKMTMgMCBvYmoKPDwvRm9udCAxMiAwIFIKL1hPYmplY3Q8PC9J
bTQgNCAwIFI+PgovUHJvY1NldFsvUERGL1RleHQvSW1hZ2VDL0ltYWdlSS9JbWFnZUJdCj4+
CmVuZG9iagoKMSAwIG9iago8PC9UeXBlL1BhZ2UvUGFyZW50IDYgMCBSL1Jlc291cmNlcyAx
MyAwIFIvTWVkaWFCb3hbMCAwIDU5NSA1MDRdL0dyb3VwPDwvUy9UcmFuc3BhcmVuY3kvQ1Mv
RGV2aWNlUkdCL0kgdHJ1ZT4+L0NvbnRlbnRzIDIgMCBSPj4KZW5kb2JqCgoxNCAwIG9iago8
PC9Db3VudCAxL0ZpcnN0IDE1IDAgUi9MYXN0IDE1IDAgUgo+PgplbmRvYmoKCjE1IDAgb2Jq
Cjw8L0NvdW50IDAvVGl0bGU8RkVGRjAwNTMwMDZDMDA2OTAwNjQwMDY1MDAyMDAwMzE+Ci9E
ZXN0WzEgMCBSL1hZWiAwIDUwNCAwXS9QYXJlbnQgMTQgMCBSPj4KZW5kb2JqCgo2IDAgb2Jq
Cjw8L1R5cGUvUGFnZXMKL1Jlc291cmNlcyAxMyAwIFIKL01lZGlhQm94WyAwIDAgNTk1IDUw
NCBdCi9LaWRzWyAxIDAgUiBdCi9Db3VudCAxPj4KZW5kb2JqCgoxNiAwIG9iago8PC9UeXBl
L0NhdGFsb2cvUGFnZXMgNiAwIFIKL09wZW5BY3Rpb25bMSAwIFIgL1hZWiBudWxsIG51bGwg
MF0KL091dGxpbmVzIDE0IDAgUgo+PgplbmRvYmoKCjE3IDAgb2JqCjw8L0NyZWF0b3I8RkVG
RjAwNDQwMDcyMDA2MTAwNzc+Ci9Qcm9kdWNlcjxGRUZGMDA0QzAwNjkwMDYyMDA3MjAwNjUw
MDRGMDA2NjAwNjYwMDY5MDA2MzAwNjUwMDIwMDAzMzAwMkUwMDM1PgovQ3JlYXRpb25EYXRl
KEQ6MjAxMjA4MjExMTQyMDIrMDInMDAnKT4+CmVuZG9iagoKeHJlZgowIDE4CjAwMDAwMDAw
MDAgNjU1MzUgZiAKMDAwMDAyMjk1OSAwMDAwMCBuIAowMDAwMDAwMDE5IDAwMDAwIG4gCjAw
MDAwMDA2ODYgMDAwMDAgbiAKMDAwMDAwMDcwNiAwMDAwMCBuIAowMDAwMDA3OTYwIDAwMDAw
IG4gCjAwMDAwMjMyNjcgMDAwMDAgbiAKMDAwMDAwNzk4MSAwMDAwMCBuIAowMDAwMDIxOTU2
IDAwMDAwIG4gCjAwMDAwMjE5NzggMDAwMDAgbiAKMDAwMDAyMjE2NyAwMDAwMCBuIAowMDAw
MDIyNTczIDAwMDAwIG4gCjAwMDAwMjI4MjcgMDAwMDAgbiAKMDAwMDAyMjg2MCAwMDAwMCBu
IAowMDAwMDIzMTAyIDAwMDAwIG4gCjAwMDAwMjMxNTggMDAwMDAgbiAKMDAwMDAyMzM2NiAw
MDAwMCBuIAowMDAwMDIzNDY3IDAwMDAwIG4gCnRyYWlsZXIKPDwvU2l6ZSAxOC9Sb290IDE2
IDAgUgovSW5mbyAxNyAwIFIKL0lEIFsgPDEwNTU1REVGODQyMzcyMEMzQzgyNDc5RTc1QjQ5
RTM4Pgo8MTA1NTVERUY4NDIzNzIwQzNDODI0NzlFNzVCNDlFMzg+IF0KL0RvY0NoZWNrc3Vt
IC9CMkRBOTY0N0MyQzA2QkY4N0JEMUVFODhCRkNFQUNCMQo+PgpzdGFydHhyZWYKMjM2MzQK
JSVFT0YK
--------------040500000903010609060303--
