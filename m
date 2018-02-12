From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Can I omit acquire_locks in getattr handler of mds?
Date: Mon, 12 Feb 2018 07:43:53 -0800
Message-ID: <CAJ4mKGbjHjGYMaFa_Xcy3R3YNcfL7DpUEB3rLdJ1QHTNrSPMbw@mail.gmail.com>
References: <2073248911.84014.1518250545543.ref@mail.yahoo.com>
 <2073248911.84014.1518250545543@mail.yahoo.com> <CALe9h7c=zUm5GLnKoXCX1atAnu4d6doOcFHJU=mVYna4VHzU7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:50888 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeBLPnz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 10:43:55 -0500
Received: by mail-it0-f66.google.com with SMTP id x128so7183800ite.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 07:43:54 -0800 (PST)
In-Reply-To: <CALe9h7c=zUm5GLnKoXCX1atAnu4d6doOcFHJU=mVYna4VHzU7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Mark Meyers <MarkMeyers.MMY@gmail.com>, Ceph-devel <ceph-devel@vger.kernel.org>

Even more than that, the locks also control metadata trimming and
things. You might actually crash the server, not "merely" get
inconsistent results back!
-Greg

On Sat, Feb 10, 2018 at 9:53 AM, John Spray <jspray@redhat.com> wrote:
> (cut down CC list to ceph-devel)
>
> If you skip taking locks, then you will be serving the client stale
> metadata, and breaking the ordinary consistency rules for POSIX file
> IO.  That might be what you want if you have a special application and
> you want a specially hacked MDS to run it faster, but if you are
> running an application that expects a filesystem to behave correctly
> then it would be hard to predict the ways in which it could break.
>
> John
>
> On Sat, Feb 10, 2018 at 8:15 AM, Mark Meyers <MarkMeyers.MMY@gmail.com> wrote:
>> I found ls command costs extremely long time (form 30s to 3mins).
>> So I tried to remove acquire_locks in mds's getattr handler: handle_clinet_getattr.
>> Everything looks just good:
>> First, the size of files get updated in time.
>> Second, the read and write to file from clinets works ok.
>>
>> So, please, can I just omiit acquire_locks in mds getattr handler?(if client request doesn't requier or have Fwb caps)
>>
>> Code:
>>
>> diff -- git a/src/mds/Server.cc n/src/mds/Server.cc
>>
>> --- a/src/mds/Server.cc
>> +++ b/src/mds/Server.cc
>> @@ -3021,7 +3021,10 @@ void Server::handler_client_getattr(MDRequestRef& mdr, bool is_lookup)
>>     if ((mask & CEPH_CAP_FILE_SHARED) && (issued & CEPH_CAP_FILE_EXCL) == 0) rdlocks.insert(&ref->filelock);
>>     if ((mask & CEPH_CAP_XATTR_SHARED) && (issued & CEPH_CAP_XATTR_EXCL) == 0) rdlocks.insert(&ref->xattrlock);
>> -   if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
>> +   dout(20) << __func__ << " mask " << ccap_string(mask) << " issued " <<
>> ccap_string(issued) << " " << !is_lookup << " ." << dendl;
>> +   if(!(mask & CEPH_CAP_FILE_WR) && !(mask & CEPH_CAP_FILE_BUFFER) && !(issued & CEPH_CAP_FILE_WR) && !(iissued & CEPH_CAP_FILE_BUFFER) && !is_lookup)
>> +     dout(10) << "no Fw/b in mask " << ccap_string(mask) << " or issued " << ccap_string(issued) << " " << !is_lookup << " ." << dendl;+   else if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
>>       return;
>>
>>
>>     if (!check_access(mdr, ref, MAY_READ))
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
