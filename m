From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: proposed C API for librados
Date: Thu, 24 Feb 2011 10:43:10 -0800
Message-ID: <AANLkTimY1y=XBAXwo1oBccMoXrU1W-V2WzCtMBQDJBHs@mail.gmail.com>
References: <AANLkTi=qvZjPOHkZbPem0TPjovGiqNo7Arq=q2YqEWDS@mail.gmail.com>
	<4D65FCD6.1070100@ormod.com>
	<AANLkTikhrQkwMaEf_4495KZn22QrQ7u4hxVo8Mn4tx1R@mail.gmail.com>
	<Pine.LNX.4.64.1102240720440.28922@cobra.newdream.net>
	<AANLkTinbGKZHZpd+5c9DeEtSr2Vd2859py8oLrhS2C1=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51427 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab1BXSpM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Feb 2011 13:45:12 -0500
Received: by fxm17 with SMTP id 17so850395fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Feb 2011 10:45:11 -0800 (PST)
In-Reply-To: <AANLkTinbGKZHZpd+5c9DeEtSr2Vd2859py8oLrhS2C1=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Hannu Valtonen <me@ormod.com>, ceph-devel@vger.kernel.org

Updated librados C API at

http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/include/rad=
os/librados.h;h=3Deda83d462d4763b9083efadd6890ae9b744b28ae;hb=3Dlibrado=
s_api

C.


On Thu, Feb 24, 2011 at 9:56 AM, Colin McCabe <cmccabe@alumni.cmu.edu> =
wrote:
> On Thu, Feb 24, 2011 at 7:25 AM, Sage Weil <sage@newdream.net> wrote:
>> On Wed, 23 Feb 2011, Colin McCabe wrote:
>>> Yeah, should add something like that. Maybe something like this:
>>>
>>> int rados_pool_list(rados_t cluster, char ***pools)
>>> void rados_pool_list_free(char **pools)
>>>
>>> Also should rename
>>> rados_snap_set_read -> rados_snap_set_read_context for consistency.
>>
>> Well, on the read side, it's not actually a context. =A0You just nee=
d to
>> specify a snapid. =A0On the write side, the context tells the OSDs w=
hich
>> snapshots to keep/cow when doing a write. =A0You can't write to a sn=
apshot.
>> I'm not sure the details are relevant to API users, but at the very =
least
>> I don't think there is a clear symmetry between the read/write side =
to
>> make the calls look consistent. =A0This way it's clear they're not..=
=2E
>>
>
> How about:
> void rados_pool_snap_set_read(rados_pool_t pool, rados_snap_t snap);
> int rados_pool_selfmanaged_snap_set_write_ctx(rados_pool_t pool,
> rados_snap_t seq, rados_snap_t *snaps, int num_snaps);
>
> The second one is getting long, but it ought to be clear that setting
> the write context can only be done with selfmanaged snaps.
>
>> ...
>>
>> The argument order for these is weird... not quite sure what I was
>> thinking. =A0Let's do whatever pread and pwrite do?
>
> pwrite has buf, count, offset, so we could go with that.
>
> C.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
