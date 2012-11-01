From: Gregory Farnum <greg@inktank.com>
Subject: Re: Cephfs losing files and corrupting others
Date: Fri, 2 Nov 2012 00:02:56 +0100
Message-ID: <CAPYLRzjR_Z8mOG8ePwTUpJ4aSV1yENabZ3DtK8QWJ207OpBSyQ@mail.gmail.com>
References: <CAD84eiF1dcE5buvTyFctXTSvB4bgEYXtpxwX7yJWiOEASmNvJA@mail.gmail.com>
	<5092F860.7040708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64621 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992576Ab2KAXC5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 19:02:57 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4297138iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 16:02:56 -0700 (PDT)
In-Reply-To: <5092F860.7040708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Howell <nathan.d.howell@gmail.com>, Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 1, 2012 at 11:32 PM, Sam Lang <sam.lang@inktank.com> wrote:
> On Thu 01 Nov 2012 11:22:59 AM CDT, Nathan Howell wrote:
>>
>> We have a small (3 node) Ceph cluster that occasionally has issues. It
>> loses files and directories, truncates them or fills the contents with
>> NULL bytes. So far we haven't been able to build a repro case but it
>> seems to happen when bulk loading data into the cluster, a process
>> that is run each evening by a cron job. We've gone about a month
>> without any issues but had it happen again yesterday during a larger
>> bulk load.  The data is backed up outside of ceph and can be reloaded
>> but finding the corrupt files takes quite a while.
>>
>> Has anyone heard of similar issues before? Should I try upgrading to
>> 0.48.2 or a newer kernel?
>
>
> Hi Nathan,
>
> Do the writes succeed?  I.e. the programs creating the files don't get
> errors back?  Are you seeing any problems with the ceph mds or osd processes
> crashing?  Can you describe your I/O workload during these bulk loads?  How
> many files, how much data, multiple clients writing, etc.
>
> As far as I know, there haven't been any fixes to 0.48.2 to resolve problems
> like yours.  You might try the ceph fuse client to see if you get the same
> behavior.  If not, then at least we have narrowed down the problem to the
> ceph kernel client.

Are you using hard links, by any chance? Do you have one or many MDS
systems? What filesystem are you using on your OSDs?
-Greg
