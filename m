From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: osd_pool_default_size
Date: Fri, 26 Oct 2012 16:32:11 +0200
Message-ID: <CAOLwVUmR_WcXHeDZJp88eaeZt=TTbOCqk4h-kYNTZ2zrSuskgw@mail.gmail.com>
References: <CAOLwVUkvCQm-_UF=OsykCfw+CH7CPxBaXZrwDtH19M-T5EPrgg@mail.gmail.com>
 <508A92F0.7040007@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41745 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933288Ab2JZOcd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 10:32:33 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1724067lbo.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 07:32:32 -0700 (PDT)
In-Reply-To: <508A92F0.7040007@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> It's the monitor who is preparing the new pool before creating it. I =
had a
> discussion regarding this with Greg some time ago, can't re-call if t=
his was
> on IRC or the ml though.

Well actually I think I was in the conversation and it was on IRC, but
I had completely forget about it. -_-

Thanks the clarification. It may sound weird but if the monitors
handles the pool creation, it makes sense.

Now I'm surprised to see that the admin socket has a different value.
Moreover after changing the configuration and set the default size to
2 and restarted every OSD. It looks like the cluster continue to
create a pool size of 3...

Could be a bug then, any idea?

On Fri, Oct 26, 2012 at 3:41 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> On 10/26/2012 10:17 AM, S=E9bastien Han wrote:
>>
>> Hi Cephers!
>>
>> Some question about this parameter:
>>
>> - Why does this parameter need to be in the [mon] section to work?
>
>
> It's the monitor who is preparing the new pool before creating it. I =
had a
> discussion regarding this with Greg some time ago, can't re-call if t=
his was
> on IRC or the ml though.
>
> It however contradicts what's in the docs:
> http://ceph.com/docs/master/config-cluster/osd-config-ref/
>
> The docs seem to be wrong at this point:
>
> * src/mon/OSDMonitor.cc *
>
> int OSDMonitor::prepare_new_pool(string& name, uint64_t auid, int
> crush_rule,
>                                  unsigned pg_num, unsigned pgp_num)
> {
> ..
> ..
>   pending_inc.new_pools[pool].size =3D g_conf->osd_pool_default_size;
> ..
> ..
> }
>
> This is done by the monitor.
>
> There seems to be some reference for this in src/osd/OSDMap.cc, but t=
hat
> seems to be for initializing the cluster since it creates the data, m=
etadata
> and rbd pool there.
>
> This was fixed in this commit:
> https://github.com/ceph/ceph/commit/1292436b8f88ce203bdba97278ce368b1=
dfa025f
>
> Seems to be because of this message on the ml last year:
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/2983
>
> So yes, it is odd that something prefixed with "osd" should go into t=
he mon
> section.
>
> Wido
>
>> - In my ceph.conf I set a default size of 3:
>>
>> # rados mkpool lol
>> successfully created pool lol
>>
>> # ceph osd dump | grep lol
>> pool 31 'lol' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num=
 8
>> pgp_num 8 last_change 430 owner 18446744073709551615
>>
>> Now if I retrieve the admin daemon I get,
>>
>> # ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok config show | gr=
ep
>> 'osd_pool_default_size'
>> osd_pool_default_size =3D 2
>>
>> Why? Did I something wrong?
>>
>> Thanks :)
>>
>> Cheers!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
