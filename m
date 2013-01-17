From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph from poc to production
Date: Thu, 17 Jan 2013 10:29:57 -0600
Message-ID: <50F82705.50502@inktank.com>
References: <50F6F471.7030108@profihost.ag> <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:64589 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab3AQQ3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:29:55 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so571054iaf.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 08:29:54 -0800 (PST)
In-Reply-To: <CAOLwVU=1vjeoFBa84doczbEeJ5nAasBLE2z9YAR-oUd5+wANrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/17/2013 10:24 AM, S=E9bastien Han wrote:
> Hi Stephan,
>
>> - Increase the osdmax value
>
> Well actually this doesn't seem to be necessary because when you issu=
e
> a "ceph osd create" the osdmax value is automatically incremented. It
> just that a while ago I saw on the ML or IRC that it was a good
> practice to do this. And this documentation
> http://ceph.com/docs/master/rados/operations/control/ says:
>
> "Set the max_osd parameter in the osd map. This is necessary when
> expanding the storage cluster."
>
> Maybe the doc is outdated on this option, I don't know.
>
>> - Set =93filestore flusher=94 option to false, in your [osd] section
>
> During my benchmarks sessions I noticed that disabling this option
> brought way better performance, at least for old hardware. Fo recent
> hardware I haven't seen any difference, but I kept the habit to
> disable it. There are some discussions about this option on the ML. A=
s
> far as I can remember, it's harmless to disable it.
>  From the doc here
> http://ceph.com/docs/master/rados/configuration/filestore-config-ref/=
:

I actually have been doing parametric sweeps over the various ceph=20
tunables to try to see what affects performance.  I'll have an article=20
coming out soonish documenting some of the findings.  Typically=20
disabling the flusher seems to be beneficial on XFS and BTRFS, but it=20
seems to be the opposite on EXT4.

>
> "The filestore flusher forces data from large writes to be written ou=
t
> using sync file range before the sync in order to (hopefully) reduce
> the cost of the eventual sync. In practice, disabling =91filestore
> flusher=92 seems to improve performance in some cases."
>
> Cheers,
>
> --
> Regards,
> S=E9bastien Han.
>
>
> On Wed, Jan 16, 2013 at 7:41 PM, Stefan Priebe <s.priebe@profihost.ag=
> wrote:
>>
>> Hello Sebastien,
>>    hello list,
>>
>> first nice article sebastien ;-) thanks for contributing.
>>
>> I've two question regarding the tips:
>>
>> Can somebody explain me why i should do this?:
>> - Increase the osdmax value
>> - Set =93filestore flusher=94 option to false, in your [osd] section
>>
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
