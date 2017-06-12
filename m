From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: ceph-mds crash v12.0.3
Date: Mon, 12 Jun 2017 20:58:41 +0800
Message-ID: <CAAM7YA=dJRvjog8QOObzNEt3uqD+gPLqCuTSP8TTq=_Os2WE9g@mail.gmail.com>
References: <eaf869fc-892f-a8e1-fea3-2661ce7f401e@unixsol.org>
 <CALe9h7c9bBMc4qd55sHx_T1jRrsHqWn+RksvQ=pzDFDKUYEwPw@mail.gmail.com> <73168653-b8c8-1f43-e505-0d1f3e3612df@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35533 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdFLM6n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jun 2017 08:58:43 -0400
Received: by mail-vk0-f48.google.com with SMTP id 191so47472886vko.2
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jun 2017 05:58:42 -0700 (PDT)
In-Reply-To: <73168653-b8c8-1f43-e505-0d1f3e3612df@unixsol.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Georgi Chorbadzhiyski <gf@unixsol.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 12, 2017 at 6:56 PM, Georgi Chorbadzhiyski <gf@unixsol.org> wro=
te:
> On 6/12/17 1:22 PM, John Spray wrote:
>> On Mon, Jun 12, 2017 at 5:13 AM, Georgi Chorbadzhiyski <gf@unixsol.org> =
wrote:
>>> We started getting these on all of our 3 MDS-es. Any idea how to fix it=
 or at least debug
>>> it and remove the dir entries that are causing the problem?
>>
>> Assuming it's easy to reproduce, set "debug mds =3D 20", "debug ms =3D 1=
"
>> and gather the logs in the run up to the crash.
>
> After turning up debug as you suggested here are the logs before the cras=
h.
>
>    -10> 2017-06-12 05:46:05.808399 7fc8038d2700 10 MDSInternalContextBase=
::complete: 18C_MDS_RetryRequest
>     -9> 2017-06-12 05:46:05.808401 7fc8038d2700  7 mds.0.server dispatch_=
client_request client_request(client.467465:121280822 readdir #1000007d3e8 =
sess_umos5jqii50rttcag852lros73 2017-06-12 03:36:19.073284 RETRY=3D115 call=
er_uid=3D1838, caller_gid=3D1838{}) v2
>     -8> 2017-06-12 05:46:05.808407 7fc8038d2700 10 mds.0.server rdlock_pa=
th_pin_ref request(client.467465:121280822 cr=3D0x7fc819988f00) #1000007d3e=
8
>     -7> 2017-06-12 05:46:05.808410 7fc8038d2700 10 mds.0.locker acquire_l=
ocks request(client.467465:121280822 cr=3D0x7fc819988f00) - done locking
>     -6> 2017-06-12 05:46:05.808416 7fc8038d2700 20 Session check_access p=
ath /client/shared/site.com/oc-content/uploads/session
>     -5> 2017-06-12 05:46:05.808418 7fc8038d2700 10 MDSAuthCap is_capable =
inode(path /client/shared/site.com/oc-content/uploads/session owner 1838:18=
38 mode 040755) by caller 1838:1838 mask 1 new 1024:524288 cap: MDSAuthCaps=
[allow *]
>
>     -4> 2017-06-12 05:46:05.808423 7fc8038d2700 10 mds.0.server  frag 1* =
offset 'sess_umos5jqii50rttcag852lros73' offset_hash 13141348 flags 0
>     -3> 2017-06-12 05:46:05.808426 7fc8038d2700 10 mds.0.server  adjust f=
rag 1* -> 1000* fragtree_t(*^1 0*^1 1*^3)
>     -2> 2017-06-12 05:46:05.808430 7fc8038d2700 10 mds.0.server handle_cl=
ient_readdir on [dir 1000007d3e8.1000* /client/shared/site.com/oc-content/u=
ploads/session/ [2,head] auth pv=3D1077482 v=3D1077481 cv=3D0/0 ap=3D1+2+2 =
state=3D1610612738|complete f(v86 218=3D218+0) n(v10 b67671 218=3D218+0) hs=
=3D218+6,ss=3D0+0 dirty=3D10 | child=3D1 dirty=3D1 waiter=3D0 authpin=3D1 0=
x7fc828eae340]
>     -1> 2017-06-12 05:46:05.808447 7fc8038d2700 10 mds.0.server snapid he=
ad
>      0> 2017-06-12 05:46:05.843735 7fc8038d2700 -1 *** Caught signal (Seg=
mentation fault) **
>  in thread 7fc8038d2700 thread_name:ms_dispatch
>

The log doesn't contain useful information for this issue. Could you
please enable coredump try again. Besides, please install debug info
for ceph-mds or re-compile ceph with debug info. After got coredump,
using gdb to debug this issue is convenient.

Regards
Yan, Zheng


> I've looked at mds code but nothing caught my eye and after "snapid head"=
 debug
> message unfortunately there is not a lot debug printing going on to get a=
 better
> idea what's going on.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
