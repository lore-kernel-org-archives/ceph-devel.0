From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: LOCK_SYNC_MIX state makes "getattr" operations extremely slow
 when there are lots of clients issue writes or reads to the same file
Date: Tue, 6 Feb 2018 12:23:56 +0800
Message-ID: <CAJACTudLZr3Nu9uEU-S_1t-Ew=U8ROrU0G5Sr_+SJvbkMUCpoQ@mail.gmail.com>
References: <CAJACTudeJCqQiEOxuSxfFsH2KdnSeors-6cCvx9jh-Nn8u6huA@mail.gmail.com>
 <CAJACTueKfKUDBjU+j9UpXjdXrv0_HxGLvc06GUCh0ZyCzK5uRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:43487 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFEX5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Feb 2018 23:23:57 -0500
Received: by mail-oi0-f46.google.com with SMTP id 4so408609ois.10
        for <ceph-devel@vger.kernel.org>; Mon, 05 Feb 2018 20:23:57 -0800 (PST)
In-Reply-To: <CAJACTueKfKUDBjU+j9UpXjdXrv0_HxGLvc06GUCh0ZyCzK5uRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 6 February 2018 at 12:21, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> On 6 February 2018 at 12:19, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> Hi, everyone.
>>
>> Recently, in our online Luminous Cephfs clusters, we found that there
>> are occasionally lots of slow requests:
>>
>> 2018-01-16 15:16:53.233925 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : 49 slow requests, 5 included below; oldest blocked for >
>> 89.995722 secs
>> 2018-01-16 15:16:53.233934 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 39.966171 seconds old, received at 2018-01-16
>> 15:16:13.267686: client_request(client.4925109:3759 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.176343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:53.233938 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 39.949899 seconds old, received at 2018-01-16
>> 15:16:13.283958: client_request(client.4925109:3772 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.193343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:53.233942 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 39.899975 seconds old, received at 2018-01-16
>> 15:16:13.333882: client_request(client.4925109:3785 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.242344 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:53.233946 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 39.965588 seconds old, received at 2018-01-16
>> 15:16:13.268269: client_request(client.4925109:3760 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.177343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:53.233949 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 39.964976 seconds old, received at 2018-01-16
>> 15:16:13.268881: client_request(client.4925109:3761 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.178343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:58.233997 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : 49 slow requests, 5 included below; oldest blocked for >
>> 94.995785 secs
>> 2018-01-16 15:16:58.234006 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 60.080351 seconds old, received at 2018-01-16
>> 15:15:58.153569: client_request(client.4925109:3742 getattr pAsLsXsFs
>> #0x10000003e7d 2018-01-16 15:15:58.062900 caller_uid=99,
>> caller_gid=99{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:58.234010 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 44.929603 seconds old, received at 2018-01-16
>> 15:16:13.304317: client_request(client.4925109:3778 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.213344 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:58.234014 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 44.964894 seconds old, received at 2018-01-16
>> 15:16:13.269026: client_request(client.4925109:3762 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.178343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:58.234017 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 44.948258 seconds old, received at 2018-01-16
>> 15:16:13.285662: client_request(client.4925109:3773 getattr pAsLsXsFs
>> #0x10000000fcf 2018-01-16 15:16:13.194343 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>> 2018-01-16 15:16:58.234020 7fa59f7fe700  0 log_channel(cluster) log
>> [WRN] : slow request 44.817911 seconds old, received at 2018-01-16
>> 15:16:13.416009: client_request(client.4925109:3796 getattr pAsLsXsFs
>> #0x10000000fe0 2018-01-16 15:16:13.325347 caller_uid=33,
>> caller_gid=33{}) currently failed to rdlock, waiting
>>
>> Our use case is like this:
>>        There are one client issuing writes to a file while tens of
>> other clients issue reads and stat to the same file.
>>
>> After a series of test, we found that these slow requests are all
>> "getattr" operations, and they are all blocked by CInode::filelock in
>> LOCK_SYNC_MIX state in which rdlock cannot be acquired. Further
>> analysis showed that, in our use case, due tothe writing client's
>> continuous "wants"  of CEPH_CAP_GWR   , nearly every "getattr"
>> operation's finish would lead to the inode's filelock go into
>> LOCK_SYNC_MIX state in which the mds must wait for all clients holding
>> caps other than the allowed "rwl" to release their unallowed caps and
>> blocks all requests to acquire "rdlock" of the inode's filelock. Due
>> to the massive number of reading clients, the wait could lasts for
>> about 950ms, which means, for every 950 ms, there can nearly be only
>> one getattr operation gets finished.
>>
>> Why must the acquisition of "rdlock" of an inode's filelock be blocked
>> when the inode's filelock is in LOCK_SYNC_MIX state? And why must the
>> mds wait for all clients to release their unallowed caps?
>>
>> Thanks:-)
>

On the other hand, I found that the source code related to
capabilities is very hard to understand, is there any document that I
can resort to?

Thanks:-)
