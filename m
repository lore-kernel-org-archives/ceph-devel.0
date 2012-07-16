From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: ceph init script does not start
Date: Mon, 16 Jul 2012 10:09:07 +0800
Message-ID: <500377C3.3030407@gmail.com>
References: <50012AF1.4040300@gmail.com> <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net> <3046989.AgMSmANe5F@mranderson> <alpine.DEB.2.00.1207151601240.16828@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45419 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2GPCKX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jul 2012 22:10:23 -0400
Received: by pbbrp8 with SMTP id rp8so9231759pbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 19:10:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207151601240.16828@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?UTF-8?B?U3rDqWtlbHlpIFN6YWJvbGNz?= <szekelyi@niif.hu>, ceph-devel@vger.kernel.org

On 07/16/2012 07:06 AM, Sage Weil wrote:
> On Sun, 15 Jul 2012, Sz?kelyi Szabolcs wrote:
>> On 2012. July 14. 07:42:34 Sage Weil wrote:
>>> On Sat, 14 Jul 2012, Xiaopong Tran wrote:
>>>> I'm getting this funny issue. I had setup two test clusters, and
>>>> mkcephfs and the ceph start up script worked just fine. We are
>>>> now ready to go production, we have 6 nodes, with 10 disks
>>>> each, and one osd per disk, with 3 mds and 3 mons.
>>>>
>>>> The script mkcephfs ran without problem, everything was created
>>>> properly. See attached log file. However, when I run
>>>>
>>>> /etc/init.d/ceph start
>>>>
>>>> nothing happens, not even a line of message, not on concole,
>>>> neither in system log.
>>>>
>>>> But can I manually start up each individual osd, mds, and mon.
>>>
>>> This is usually related to the 'host = ...' lines in ceph.conf.  They need
>>> to match the output of the `hostname` command in order for that daemon to
>>> be automatically started or stopped.
>>
>> Just a humble remark here: actually the host= setting has to match the
>> hostname *until the first dot*. If your hostname contains a dot, this will not
>> work. This can be useful in a number of cases, like setting the hostname to
>> indicate the group of a hierarchy level in the name so that the administrator
>> can extactly know what he's working on after logging in (I mean hostnames like
>> node<X>.rack<Y>  in a datacenter or node<X>.<site>  when running a
>> geographically distributed cluster).
>>
>>  From this comes my request: do you think it's possible to change (I mean, in
>> the repository) ceph_common.sh not to cut the output of `hostname` at the first
>> dot? I'm running a cluster with hostnames like that, and now I have to edit
>> that file after each upgrade.
>
> I think the trick here is keeping things compatible with both methods.
> Maybe it should match any prefix of the host fqdn?  e.g., for a host
> a.b.c.d, any of host = a, host = a.b, host = a.b.c, or host = a.b.c.d will
> match, but host = x.a will not.
>

It would be great if it can handle fqdn. I tried to use fqdn, along
with an internal DNS, and the /etc/hostname and /etc/hosts file set,
and it still does not start.

host = a.b.c

does not do, so far, only

host = a

works for me.

Thanks

Xiaopong

